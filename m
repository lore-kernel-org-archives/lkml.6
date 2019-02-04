Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E8F9C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 18:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 154DF217D6
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 18:57:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729742AbfBDS5y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 13:57:54 -0500
Received: from mga12.intel.com ([192.55.52.136]:51928 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726585AbfBDS5y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 13:57:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Feb 2019 10:57:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,560,1539673200"; 
   d="scan'208";a="119915369"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 04 Feb 2019 10:57:53 -0800
Received: from [10.254.84.37] (kliang2-mobl1.ccr.corp.intel.com [10.254.84.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id F33F75800E0;
        Mon,  4 Feb 2019 10:57:51 -0800 (PST)
Subject: Re: [PATCH V6 2/5] perf/x86/kvm: Avoid unnecessary work in guest
 filtering
To:     Borislav Petkov <bp@alien8.de>
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        ak@linux.intel.com, eranian@google.com
References: <1548106951-4811-1-git-send-email-kan.liang@linux.intel.com>
 <1548106951-4811-2-git-send-email-kan.liang@linux.intel.com>
 <20190204153827.GG17528@hirez.programming.kicks-ass.net>
 <20190204154411.GC17582@hirez.programming.kicks-ass.net>
 <90e071c0-cdf4-3a31-4e44-2c5b84af5fa3@linux.intel.com>
 <20190204162312.GJ17528@hirez.programming.kicks-ass.net>
 <2c429bbd-00fb-2e3a-7d58-27123400b722@linux.intel.com>
 <20190204181504.GH29639@zn.tnic>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <134894ac-a43b-7ec7-f313-b5d8de357a7e@linux.intel.com>
Date:   Mon, 4 Feb 2019 13:57:49 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190204181504.GH29639@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/4/2019 1:15 PM, Borislav Petkov wrote:
> On Mon, Feb 04, 2019 at 11:55:27AM -0500, Liang, Kan wrote:
> 
>> We cannot apply X86_STEPPING_ANY to ignore the stepping. There will be
>> problems for 0-8 stepping for KABYLAKE_MOBILE.
> 
> So why are we even doing this new "interface"
> x86_cpu_has_min_microcode_rev() if even at the conversion stage it shows
> that it is inadequate?
> 
>> I think what we need is x86_match_cpu_with_stepping_range().
>> But I don't think it is worth enabling it just for this rare case.
> 
> Sounds to me like you wanna go back to the drawing board after having
> evaluated all the use cases.
> 
> And yes, I can imagine:
> 
> +struct x86_cpu_desc {
> +       __u8    x86;            /* CPU family */
> +       __u8    x86_vendor;     /* CPU vendor */
> +       __u8    x86_model;
> +       __u8    x86_min_stepping;
> +       __u8    x86_max_stepping;
> +       __u32   x86_microcode_rev;
> +};
> 
> along with the usage:
> 
> INTEL_CPU_DESC(mod, min_step, max_step, rev)
> 
> to make it more elegant.
> 
> Question is, can you have a given microcode revision X applying to
> multiple revisions?
> 
> If yes, the above should work...
> 

You mean a given microcode revision X applying to multiple stepping,
right?
I don't think so. I still think the KABYLAKE case is an uncommon case.


Can we do something as below just for this case?

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 3eacdf6..d5fba67 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3745,6 +3745,12 @@ static __init void intel_clovertown_quirk(void)
  	x86_pmu.pebs_constraints = NULL;
  }

+#define INTEL_CPU_DESC_FOUR(mod, start, rev)			\
+	INTEL_CPU_DESC(mod, start, rev),			\
+	INTEL_CPU_DESC(mod, start + 1, rev),			\
+	INTEL_CPU_DESC(mod, start + 2, rev),			\
+	INTEL_CPU_DESC(mod, start + 3, rev)
+
  static const struct x86_cpu_desc isolation_ucodes[] = {
  	INTEL_CPU_DESC(INTEL_FAM6_HASWELL_CORE,		 3, 0x0000001f),
  	INTEL_CPU_DESC(INTEL_FAM6_HASWELL_ULT,		 1, 0x0000001e),
@@ -3763,15 +3769,8 @@ static const struct x86_cpu_desc 
isolation_ucodes[] = {
  	INTEL_CPU_DESC(INTEL_FAM6_SKYLAKE_MOBILE,	 3, 0x0000007c),
  	INTEL_CPU_DESC(INTEL_FAM6_SKYLAKE_DESKTOP,	 3, 0x0000007c),
  	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE_DESKTOP,	 9, 0x0000004e),
-	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE_MOBILE,	 9, 0x0000004e),
-	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE_MOBILE,	10, 0x0000004e),
-	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE_MOBILE,	11, 0x0000004e),
-	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE_MOBILE,	12, 0x0000004e),
-	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE_DESKTOP,	10, 0x0000004e),
-	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE_DESKTOP,	11, 0x0000004e),
-	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE_DESKTOP,	12, 0x0000004e),
-	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE_DESKTOP,	13, 0x0000004e),
-	INTEL_CPU_DESC(INTEL_FAM6_CANNONLAKE_MOBILE,	 3, 0x00000000),
+	INTEL_CPU_DESC_FOUR(INTEL_FAM6_KABYLAKE_MOBILE,	 9, 0x0000004e),
+	INTEL_CPU_DESC_FOUR(INTEL_FAM6_KABYLAKE_DESKTOP,10, 0x0000004e),
  	{}
  };

Thanks,
Kan
