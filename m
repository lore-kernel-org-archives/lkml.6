Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 1C174C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 11:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D04C020896
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 11:36:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D04C020896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965857AbeFOLgP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 07:36:15 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41534 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965701AbeFOLgO (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 07:36:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A7CEA1529;
        Fri, 15 Jun 2018 04:36:13 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2D1B33F557;
        Fri, 15 Jun 2018 04:36:11 -0700 (PDT)
Date:   Fri, 15 Jun 2018 12:36:08 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        me@kylehuey.com, Linux-kernel@vger.kernel.org,
        vincent.weaver@maine.edu, will.deacon@arm.com, eranian@google.com,
        namhyung@kernel.org, ak@linux.intel.com, kan.liang@intel.com,
        yao.jin@intel.com
Subject: Re: [PATCH v1 1/2] perf/core: Use sysctl to turn on/off dropping
 leaked kernel samples
Message-ID: <20180615113608.6m74sm7gpl5p6oqe@lakrids.cambridge.arm.com>
References: <1529057003-2212-1-git-send-email-yao.jin@linux.intel.com>
 <1529057003-2212-2-git-send-email-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529057003-2212-2-git-send-email-yao.jin@linux.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2018 at 06:03:22PM +0800, Jin Yao wrote:
> When doing sampling, for example:
> 
> perf record -e cycles:u ...
> 
> On workloads that do a lot of kernel entry/exits we see kernel
> samples, even though :u is specified. This is due to skid existing.
> 
> This might be a security issue because it can leak kernel addresses even
> though kernel sampling support is disabled.
> 
> One patch "perf/core: Drop kernel samples even though :u is specified"
> was posted in last year but it was reverted because it introduced a
> regression issue that broke the rr-project, which used sampling
> events to receive a signal on overflow. These signals were critical
> to the correct operation of rr.
> 
> See '6a8a75f32357 ("Revert "perf/core: Drop kernel samples even
> though :u is specified"")' for detail.
> 
> Now the idea is to use sysctl to control the dropping of leaked
> kernel samples.
> 
> /sys/devices/cpu/perf_allow_sample_leakage:
> 
> 0 - default, drop the leaked kernel samples.
> 1 - don't drop the leaked kernel samples.

Does this need to be conditional at all?

At least for sampling the GPRs, we could do something like below
unconditionally, which seems sufficient for my test cases.

Mark.

---->8----
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 67612ce359ad..79a21531d57c 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6359,6 +6359,24 @@ perf_callchain(struct perf_event *event, struct pt_regs *regs)
        return callchain ?: &__empty_callchain;
 }
 
+static struct pt_regs *perf_get_sample_regs(struct perf_event *event, struct pt_regs *regs)
+{
+       /*
+        * Due to interrupt latency (AKA "skid"), we may enter the kernel
+        * before taking an overflow, even if the PMU is only counting user
+        * events.
+        *
+        * If we're not counting kernel events, always use the user regs when
+        * sampling.
+        *
+        * TODO: how does this interact with guest sampling?
+        */
+       if (event->attr.exclude_kernel && !user_mode(regs))
+               return task_pt_regs(current);
+
+       return regs;
+}
+
 void perf_prepare_sample(struct perf_event_header *header,
                         struct perf_sample_data *data,
                         struct perf_event *event,
@@ -6366,6 +6384,8 @@ void perf_prepare_sample(struct perf_event_header *header,
 {
        u64 sample_type = event->attr.sample_type;
 
+       regs = perf_get_sample_regs(event, regs);
+
        header->type = PERF_RECORD_SAMPLE;
        header->size = sizeof(*header) + event->header_size;
 

