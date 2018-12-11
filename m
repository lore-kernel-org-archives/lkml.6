Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 235E3C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD03520855
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:57:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD03520855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbeLKR5E convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 12:57:04 -0500
Received: from mga03.intel.com ([134.134.136.65]:61843 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726411AbeLKR5E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 12:57:04 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Dec 2018 09:57:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,343,1539673200"; 
   d="scan'208";a="127013498"
Received: from schen9-mobl3.jf.intel.com ([10.24.9.33])
  by fmsmga004.fm.intel.com with ESMTP; 11 Dec 2018 09:57:03 -0800
Subject: Re: [PATCH v4 2/2] proc: add AVX-512 usage to /proc/pid/status
To:     Aubrey Li <aubrey.li@intel.com>, tglx@linutronix.de,
        mingo@redhat.com, peterz@infradead.org, hpa@zytor.com
Cc:     ak@linux.intel.com, dave.hansen@intel.com, arjan@linux.intel.com,
        linux-kernel@vger.kernel.org, Aubrey Li <aubrey.li@linux.intel.com>
References: <20181211002448.3520-1-aubrey.li@intel.com>
 <20181211002448.3520-2-aubrey.li@intel.com>
From:   Tim Chen <tim.c.chen@linux.intel.com>
Message-ID: <6d6af89a-4490-ffc3-9c16-90cbec2b1300@linux.intel.com>
Date:   Tue, 11 Dec 2018 09:57:03 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181211002448.3520-2-aubrey.li@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/10/18 4:24 PM, Aubrey Li wrote:
> AVX-512 components usage could cause core turbo frequency drop. So
> it's useful to expose AVX-512 components usage as a heuristic hint
> for the user space job scheduler to cluster the AVX-512 using tasks
> together.
> 
> Example:
> $ cat /proc/pid/status | grep AVX512_hint
> AVX512_hint:   1
> 
> The hint number '0' indicates the task recently didn't use AVX-512
> components thus unlikely has frequency drop issue. And the number '1'
> indicates the task recently used AVX-512 components thus could cause
> core frequency drop. User space tools may want to further check by:
> 
> $ perf stat --pid <pid> -e core_power.lvl2_turbo_license -- sleep 1
> 
>  Performance counter stats for process id '3558':
> 
>      3,251,565,961      core_power.lvl2_turbo_license
> 
>        1.004031387 seconds time elapsed
> 
> Non-zero counter value confirms that the task causes frequency drop.
> 
> Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Tim Chen <tim.c.chen@linux.intel.com>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Cc: Arjan van de Ven <arjan@linux.intel.com>
> ---
>  arch/x86/kernel/fpu/xstate.c | 19 +++++++++++++++++++
>  fs/proc/array.c              |  5 +++++
>  2 files changed, 24 insertions(+)
> 
> diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
> index 87a57b7642d3..98baa47c97b0 100644
> --- a/arch/x86/kernel/fpu/xstate.c
> +++ b/arch/x86/kernel/fpu/xstate.c
> @@ -7,6 +7,7 @@
>  #include <linux/cpu.h>
>  #include <linux/mman.h>
>  #include <linux/pkeys.h>
> +#include <linux/seq_file.h>
>  
>  #include <asm/fpu/api.h>
>  #include <asm/fpu/internal.h>
> @@ -1245,3 +1246,21 @@ int copy_user_to_xstate(struct xregs_state *xsave, const void __user *ubuf)
>  
>  	return 0;
>  }
> +
> +/*
> + * Report CPU specific thread state
> + */
> +void arch_task_state(struct seq_file *m, struct task_struct *task)
> +{
> +	/*
> +	 * Check the processor and build option if AVX512 is supported.
> +	 */
> +	if (!cpu_feature_enabled(X86_FEATURE_AVX512F))
> +		return;
> +	/*
> +	 * Report AVX-512 components usage:
> +	 */
> +	seq_put_decimal_ull(m, "AVX512_hint:\t",
> +				task->thread.fpu.avx512_usage ? 1 : 0);

I believe you need some kind of documentation of this new interface
in kernel's Documentation.  So an admin doesn't need to look into the
kernel code to figure out what this /proc/pid/status is supposed to do.

Tim


