Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8570C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 01:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B45A220693
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 01:39:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B45A220693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937024AbeFSBjI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 21:39:08 -0400
Received: from mga06.intel.com ([134.134.136.31]:6000 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934880AbeFSBjG (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 21:39:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jun 2018 18:39:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,241,1526367600"; 
   d="scan'208";a="58771875"
Received: from yjin15-mobl.ccr.corp.intel.com (HELO [10.239.161.30]) ([10.239.161.30])
  by fmsmga002.fm.intel.com with ESMTP; 18 Jun 2018 18:39:03 -0700
Subject: Re: [PATCH v1 1/2] perf/core: Use sysctl to turn on/off dropping
 leaked kernel samples
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, acme@kernel.org,
        jolsa@kernel.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, me@kylehuey.com,
        Linux-kernel@vger.kernel.org, vincent.weaver@maine.edu,
        will.deacon@arm.com, eranian@google.com, namhyung@kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
References: <1529057003-2212-1-git-send-email-yao.jin@linux.intel.com>
 <1529057003-2212-2-git-send-email-yao.jin@linux.intel.com>
 <20180615113608.6m74sm7gpl5p6oqe@lakrids.cambridge.arm.com>
 <52c75f12-1f91-405d-0b05-0aa6a9c09306@linux.intel.com>
 <20180618104522.GI2458@hirez.programming.kicks-ass.net>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <f66f6738-c612-1535-3661-dcc654750fa8@linux.intel.com>
Date:   Tue, 19 Jun 2018 09:39:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180618104522.GI2458@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/18/2018 6:45 PM, Peter Zijlstra wrote:
> On Mon, Jun 18, 2018 at 02:55:32PM +0800, Jin, Yao wrote:
>> Thanks for providing the patch. I understand this approach.
>>
>> In my opinion, the skid window is from counter overflow to interrupt
>> delivered. While if the skid window is too *big* (e.g. user -> kernel), it
>> should be not very useful. So personally, I'd prefer to drop the samples.
> 
> I really don't get your insitence on dropping the sample. Dropping
> samples is bad. Furthermore, doing what Mark suggests actually improves
> the result by reducing the skid, if the event happened before we entered
> (as it damn well should) then the user regs, which point at the entry
> site, are a better approximation than our in-kernel set.
> 
> So not only do you not loose the sample, you actually get a better
> sample.
> 

OK, that's fine, thanks!

I guess Mark will post this patch, right?

Anyway looks we don't need following patch (0-stuffing sample->ip to 
indicate perf tool that it is a leak sample), right?

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 80cca2b..628b515 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6361,6 +6361,21 @@ perf_callchain(struct perf_event *event, struct 
pt_regs *regs)
         return callchain ?: &__empty_callchain;
  }

+static bool sample_is_leaked(struct perf_event *event, struct pt_regs 
*regs)
+{
+       /*
+        * Due to interrupt latency (AKA "skid"), we may enter the
+        * kernel before taking an overflow, even if the PMU is only
+        * counting user events.
+        * To avoid leaking information to userspace, we must always
+        * reject kernel samples when exclude_kernel is set.
+       */
+       if (event->attr.exclude_kernel && !user_mode(regs))
+               return true;
+
+       return false;
+}
+
  void perf_prepare_sample(struct perf_event_header *header,
                          struct perf_sample_data *data,
                          struct perf_event *event,
@@ -6480,6 +6495,9 @@ void perf_prepare_sample(struct perf_event_header 
*header,

         if (sample_type & PERF_SAMPLE_PHYS_ADDR)
                 data->phys_addr = perf_virt_to_phys(data->addr);
+
+       if (sample_is_leaked(event, regs))
+               data->ip = 0;
  }

  static void __always_inline
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index bfa60bc..1bfb697 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -404,6 +404,7 @@ struct events_stats {
         u64 total_aux_lost;
         u64 total_aux_partial;
         u64 total_invalid_chains;
+       u64 total_dropped_samples;
         u32 nr_events[PERF_RECORD_HEADER_MAX];
         u32 nr_non_filtered_samples;
         u32 nr_lost_warned;
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 8b93693..ec923f1 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1269,6 +1269,12 @@ static int machines__deliver_event(struct 
machines *machines,
                         ++evlist->stats.nr_unprocessable_samples;
                         return 0;
                 }
+
+               if (sample->ip == 0) {
+                       /* Drop the leaked kernel samples */
+                       ++evlist->stats.total_dropped_samples;
+                       return 0;
+               }
                 return perf_evlist__deliver_sample(evlist, tool, event, 
sample, evsel, machine);
         case PERF_RECORD_MMAP:
                 return tool->mmap(tool, event, sample, machine);

Thanks
Jin Yao
