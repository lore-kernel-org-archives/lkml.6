Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0168C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 15:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 902EE2075D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 15:32:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 902EE2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727597AbeJaA0i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 20:26:38 -0400
Received: from mga11.intel.com ([192.55.52.93]:3850 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbeJaA0h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 20:26:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Oct 2018 08:32:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,444,1534834800"; 
   d="scan'208";a="276902351"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.130]) ([10.237.72.130])
  by fmsmga006.fm.intel.com with ESMTP; 30 Oct 2018 08:32:38 -0700
Subject: Re: [PATCH] perf cs-etm: Correct CPU mode for samples
To:     Arnaldo Carvalho de Melo <acme@kernel.org>, leo.yan@linaro.org
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Coresight ML <coresight@lists.linaro.org>
References: <1540883908-17018-1-git-send-email-leo.yan@linaro.org>
 <20181030143226.GA23310@kernel.org>
 <20181030150449.GB8344@leoy-ThinkPad-X240s>
 <20181030151137.GF23310@kernel.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <b00357d2-10ab-e75e-6748-13341641f107@intel.com>
Date:   Tue, 30 Oct 2018 17:30:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181030151137.GF23310@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/10/18 5:11 PM, Arnaldo Carvalho de Melo wrote:
> Em Tue, Oct 30, 2018 at 11:04:49PM +0800, leo.yan@linaro.org escreveu:
>> Hi Arnaldo,
>>
>> On Tue, Oct 30, 2018 at 11:32:26AM -0300, Arnaldo Carvalho de Melo wrote:
>>> Em Tue, Oct 30, 2018 at 03:18:28PM +0800, Leo Yan escreveu:
>>>> Since commit 9042f5e3539e ("perf tools: Stop fallbacking to kallsyms
>>>> for vdso symbols lookup"), the kernel address cannot be properly parsed
>>>> to kernel symbol with command 'perf script -k vmlinux'.  The reason is
>>>> CoreSight samples is always to set CPU mode as PERF_RECORD_MISC_USER,
>>>> thus it fails to find corresponding map/dso in below flows:
>>>>
>>>>   process_sample_event()
>>>>     `-> machine__resolve()
>>>> 	  `-> thread__find_map(thread, sample->cpumode, sample->ip, al);
>>>>
>>>> In this flow it needs to pass argument 'sample->cpumode' to tell what's
>>>> the CPU mode, before it always passed PERF_RECORD_MISC_USER but without
>>>> any failure until the commit 9042f5e3539e ("perf tools: Stop fallbacking
>>>> to kallsyms for vdso symbols lookup") has been merged.  The reason is
>>>> even with the wrong CPU mode the function thread__find_map() firstly
>>>> fails to find map but it will rollback to find kernel map for vdso
>>>> symbols lookup.  In the latest code it has removed the fallback code,
>>>> thus if CPU mode is PERF_RECORD_MISC_USER then it cannot find map
>>>> anymore with kernel address.
>>>>
>>>> This patch is to correct samples CPU mode setting, it creates a new
>>>> helper function cs_etm__cpu_mode() to tell what's the CPU mode based on
>>>> the address with the info from machine structure; this patch has a bit
>>>> extension to check not only kernel and user mode, but also check for
>>>> host/guest and hypervisor mode.  Finally this patch uses the function
>>>> in instruction and branch samples and also apply in cs_etm__mem_access()
>>>> for a minor polishing.
>>>
>>> Mathieu, can I have your Acked-by, please? Leo, thanks for acting so
>>> quickly on this one! 
>>
>> Thanks for reivewing.  Yeah, let's wait for Mathieu reviewing as well,
>> as I know he is travelling so might be delay a bit.
> 
> I'm tentatively applying the patch, as this needs fixing ASAP, and I
> take that you have tested it and it cured the problem for you, so should
> be a good indication for the acceptance of the patch.
> 
> We can always fix some detail later.
>  
>> Just remind, we might need the similiar change for util/intel-pt.c and
>> util/intel-bts.c when generate samples, otherwise they might have the
>> same regression for kernel symbols.  I am not the best person to change
>> these two files, but bring up this for attention.
> 
> Right, I think Adrian is working on it, Adrian?

Yes although I am more concerned with branches from user space to kernel
space and vice versa, which this patch doesn't deal with.  Also there are
many cpumode issues in perf tools, and really the only way to deal with
them simply at the moment is to put back the fallback for arches other
than sparc i.e.

diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index bc646185f8d9..b7a79cf490ad 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -1561,9 +1561,18 @@ struct map *thread__find_map(struct thread *thread, u8 cpumode, u64 addr,
 
 		return NULL;
 	}
-
+try_again:
 	al->map = map_groups__find(mg, al->addr);
-	if (al->map != NULL) {
+	if (al->map == NULL) {
+		if (cpumode == PERF_RECORD_MISC_USER && machine &&
+		    strcmp(perf_env__arch(machine->env), "sparc") &&
+		    mg != &machine->kmaps &&
+		    machine__kernel_ip(machine, al->addr)) {
+			mg = &machine->kmaps;
+			load_map = true;
+			goto try_again;
+		}
+	} else {
 		/*
 		 * Kernel maps might be changed when loading symbols so loading
 		 * must be done prior to using kernel maps.


