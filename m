Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 503E5ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 02:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F213A20882
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 02:11:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="J4lGf/8n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F213A20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388339AbeGXDPx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 23:15:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:55028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388245AbeGXDPx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 23:15:53 -0400
Received: from [192.168.0.217] (c-71-202-137-17.hsd1.ca.comcast.net [71.202.137.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DA3D20685;
        Tue, 24 Jul 2018 02:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532398308;
        bh=flhat2VGstBlP0vvWeosZtRxTb0K1ETCYI3nHR5JQfA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=J4lGf/8nIYlOBVlk+ArTPS7Wc2E+lM7fF0aUiKFTvyA4LiikLxv2b/nB/NnbXVIhr
         IpC2IPNOkYDJBmdo9zCheTFHM1IbdhrmWZYQb7TAti2CI7M/NfIi1JmdOZx69NT9u5
         1ARy9Y/z8pbBGg3MObEnlIY0/XY8NaWMxNSr5NGg=
Subject: Re: [PATCH 6/7] x86/vdso: Add vDSO functions for user wait
 instructions
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>
Cc:     Ashok Raj <ashok.raj@intel.com>, Alan Cox <alan@linux.intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
References: <1532350557-98388-1-git-send-email-fenghua.yu@intel.com>
 <1532350557-98388-7-git-send-email-fenghua.yu@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Message-ID: <2267fbe6-37e8-7063-d48f-1879f31d3258@kernel.org>
Date:   Mon, 23 Jul 2018 19:11:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1532350557-98388-7-git-send-email-fenghua.yu@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/23/2018 05:55 AM, Fenghua Yu wrote:
> User wants to query if user wait instructions (umonitor, umwait, and
> tpause) are supported and use the instructions. The vDSO functions
> provides fast interface for user to check the support and use the
> instructions.
> 
> waitpkg_supported and its alias __vdso_waitpkg_supported check if
> user wait instructions (a.k.a. wait package feature) are supported
> 
> umonitor and its alias __vdso_umonitor provide user APIs for calling
> umonitor instruction.
> 
> umwait and its alias __vdso_umwait provide user APIs for calling
> umwait instruction.
> 
> tpause and its alias __vdso_tpause provide user APIs for calling
> tpause instruction.
> 
> nsec_to_tsc and its alias __vdso_nsec_to_tsc converts nanoseconds
> to TSC counter if TSC frequency is known. It will fail if TSC frequency
> is unknown.
> 
> The instructions can be implemented in intrinsic functions in future
> GCC. But the vDSO interfaces are available to user without the
> intrinsic functions support in GCC and the API waitpkg_supported and
> nsec_to_tsc cannot be implemented as GCC functions.
> 
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> ---
>   arch/x86/entry/vdso/Makefile           |   2 +-
>   arch/x86/entry/vdso/vdso.lds.S         |  10 ++
>   arch/x86/entry/vdso/vma.c              |   9 ++
>   arch/x86/entry/vdso/vuserwait.c        | 233 +++++++++++++++++++++++++++++++++
>   arch/x86/include/asm/vdso_funcs_data.h |   3 +
>   5 files changed, 256 insertions(+), 1 deletion(-)
>   create mode 100644 arch/x86/entry/vdso/vuserwait.c
> 
> diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
> index af4fcae5de83..fb0062b09b3c 100644
> --- a/arch/x86/entry/vdso/Makefile
> +++ b/arch/x86/entry/vdso/Makefile
> @@ -17,7 +17,7 @@ VDSO32-$(CONFIG_X86_32)		:= y
>   VDSO32-$(CONFIG_IA32_EMULATION)	:= y
>   
>   # files to link into the vdso
> -vobjs-y := vdso-note.o vclock_gettime.o vgetcpu.o vdirectstore.o
> +vobjs-y := vdso-note.o vclock_gettime.o vgetcpu.o vdirectstore.o vuserwait.o
>   
>   # files to link into kernel
>   obj-y				+= vma.o
> diff --git a/arch/x86/entry/vdso/vdso.lds.S b/arch/x86/entry/vdso/vdso.lds.S
> index 097cdcda43a5..0942710608bf 100644
> --- a/arch/x86/entry/vdso/vdso.lds.S
> +++ b/arch/x86/entry/vdso/vdso.lds.S
> @@ -35,6 +35,16 @@ VERSION {
>   		__vdso_movdir64b_supported;
>   		movdir64b;
>   		__vdso_movdir64b;
> +		waitpkg_supported;
> +		__vdso_waitpkg_supported;
> +		umonitor;
> +		__vdso_umonitor;
> +		umwait;
> +		__vdso_umwait;
> +		tpause;
> +		__vdso_tpause;
> +		nsec_to_tsc;
> +		__vdso_nsec_to_tsc;
>   	local: *;
>   	};
>   }
> diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
> index edbe5e63e5c2..006dfb5e5003 100644
> --- a/arch/x86/entry/vdso/vma.c
> +++ b/arch/x86/entry/vdso/vma.c
> @@ -372,10 +372,19 @@ static int vgetcpu_online(unsigned int cpu)
>   
>   static void __init init_vdso_funcs_data(void)
>   {
> +	struct system_counterval_t sys_counterval;
> +
>   	if (static_cpu_has(X86_FEATURE_MOVDIRI))
>   		vdso_funcs_data.movdiri_supported = true;
>   	if (static_cpu_has(X86_FEATURE_MOVDIR64B))
>   		vdso_funcs_data.movdir64b_supported = true;
> +	if (static_cpu_has(X86_FEATURE_WAITPKG))
> +		vdso_funcs_data.waitpkg_supported = true;
> +	if (static_cpu_has(X86_FEATURE_TSC_KNOWN_FREQ)) {
> +		vdso_funcs_data.tsc_known_freq = true;
> +		sys_counterval = convert_art_ns_to_tsc(1);
> +		vdso_funcs_data.tsc_per_nsec = sys_counterval.cycles;
> +	}

You're losing a ton of precision here.  You might even be losing *all* 
of the precision and malfunctioning rather badly.

The correct way to do this is:

tsc_counts = ns * mul >> shift;

and the vclock code illustrates it.  convert_art_ns_to_tsc() is a bad 
example because it uses an expensive division operation for no good 
reason except that no one bothered to optimize it.

> +notrace int __vdso_nsec_to_tsc(unsigned long nsec, unsigned long *tsc)
> +{
> +	if (!_vdso_funcs_data->tsc_known_freq)
> +		return -ENODEV;
> +
> +	*tsc = _vdso_funcs_data->tsc_per_nsec * nsec;
> +
> +	return 0;
> +}

Please don't expose this one at all.  It would be nice for programs that 
use waitpkg to be migratable using CRIU-like tools, and this export 
actively harms any such effort.  If you omit this function, then the 
kernel could learn to abort an in-progress __vdso_umwait if preempted 
(rseq-style) and CRIU would just work.  It would be a bit of a hack, but 
it solves a real problem.

> +notrace int __vdso_umwait(int state, unsigned long nsec)

__vdso_umwait_relative(), please.  Because some day (possibly soon) 
someone will want __vdso_umwait_absolute() and its friend 
__vdso_read_art_ns() so they can do:

u64 start = __vdso_read_art_ns();
__vdso_umonitor(...);
... do something potentially slow or that might fault ...
__vdso_umwait_absolute(start + timeout);

Also, this patch appears to have a subtle but show-stopping race.  Consider:

1. Task A does UMONITOR on CPU 1
2. Task A is preempted.
3. Task B does UMONITOR on CPU 1 at a different address
4. Task A resumes
5. Task A does UMWAIT

Now task A hangs, at least until the next external wakeup happens.

It's not entirely clear to me how you're supposed to fix this without 
some abomination that's so bad that it torpedoes the entire feature. 
Except that there is no chicken bit to turn this thing off.  Sigh.
