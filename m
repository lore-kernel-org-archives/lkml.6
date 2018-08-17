Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96429C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 03:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A01821867
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 03:17:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A01821867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=softrans.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbeHQGSr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 02:18:47 -0400
Received: from mail110.syd.optusnet.com.au ([211.29.132.97]:50343 "EHLO
        mail110.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726094AbeHQGSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 02:18:47 -0400
X-Greylist: delayed 1870 seconds by postgrey-1.27 at vger.kernel.org; Fri, 17 Aug 2018 02:18:45 EDT
Received: from smtp.starsoftware.com.au (n175-33-133-183.meb2.vic.optusnet.com.au [175.33.133.183])
        by mail110.syd.optusnet.com.au (Postfix) with ESMTP id 04B34106617;
        Fri, 17 Aug 2018 12:45:58 +1000 (AEST)
Received: from [192.168.0.7] (unknown [192.168.0.1])
        by smtp.starsoftware.com.au (Postfix) with ESMTP id 49D3D677E164;
        Fri, 17 Aug 2018 12:45:58 +1000 (AEST)
Subject: Re: [PATCH] x86/vdso: Fix vDSO build if a retpoline is emitted
To:     Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Jason Vas Dias <jason.vas.dias@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>
References: <c76538cd3afbe19c6246c2d1715bc6a60bd63985.1534448381.git.luto@kernel.org>
From:   Matthew Rickard <matt@softrans.com.au>
Message-ID: <8ab1691e-64a1-66a4-f7e8-877affa68751@softrans.com.au>
Date:   Fri, 17 Aug 2018 12:45:51 +1000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <c76538cd3afbe19c6246c2d1715bc6a60bd63985.1534448381.git.luto@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=DZtnkrlW c=1 sm=1 tr=0
        a=0SUgGFgJIhXJJGNlngNSLg==:117 a=0SUgGFgJIhXJJGNlngNSLg==:17
        a=IkcTkHD0fZMA:10 a=dapMudl6Dx4A:10 a=PIVNZ80yAAAA:8 a=pGLkceISAAAA:8
        a=JfrnYn6hAAAA:8 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=FGZurq2FBI-lWE-zRfwA:9
        a=QEXdDO2ut3YA:10 a=3YJQTRF3V1zcZZCg0gjL:22 a=1CNFftbPRP8L7MoqJWF3:22
        a=AjGcO6oz07-iQ99wixmX:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/08/2018 5:41 AM, Andy Lutomirski wrote:
> Currently, if the vDSO ends up containing an indirect branch or
> call, GCC will emit the "external thunk" style of retpoline, and it
> will fail to link.
> 
> Fix it by building the vDSO with inline retpoline thunks.
> 
> I haven't seen any reports of this triggering on an unpatched
> kernel.
> 
> Cc: Matt Rickard <matt@softrans.com.au>
> Cc: Jason Vas Dias <jason.vas.dias@gmail.com>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Andi Kleen <ak@linux.intel.com>
> Fixes: commit 76b043848fd2 ("x86/retpoline: Add initial retpoline support")
> Signed-off-by: Andy Lutomirski <luto@kernel.org>
> ---
> 
> This is a bit of a marginal candidate for the merge window.  There are
> a couple of reports of people hitting this while hacking on the vDSO,
> but I haven't seen any report of anyone hitting this on a stock kernel.
> 
> Feel free to tell me to buzz of and send it later :)
> 
>   Makefile                     | 4 ++++
>   arch/x86/entry/vdso/Makefile | 6 ++++--
>   2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index a0650bf79606..7bab2e90e4e1 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -507,9 +507,13 @@ KBUILD_AFLAGS += $(call cc-option, -no-integrated-as)
>   endif
>   
>   RETPOLINE_CFLAGS_GCC := -mindirect-branch=thunk-extern -mindirect-branch-register
> +RETPOLINE_VDSO_CFLAGS_GCC := -mindirect-branch=thunk-inline -mindirect-branch-register
>   RETPOLINE_CFLAGS_CLANG := -mretpoline-external-thunk
> +RETPOLINE_VDSO_CFLAGS_CLANG := -mretpoline
>   RETPOLINE_CFLAGS := $(call cc-option,$(RETPOLINE_CFLAGS_GCC),$(call cc-option,$(RETPOLINE_CFLAGS_CLANG)))
> +RETPOLINE_VDSO_CFLAGS := $(call cc-option,$(RETPOLINE_VDSO_CFLAGS_GCC),$(call cc-option,$(RETPOLINE_VDSO_CFLAGS_CLANG)))
>   export RETPOLINE_CFLAGS
> +export RETPOLINE_VDSO_CFLAGS
>   
>   KBUILD_CFLAGS	+= $(call cc-option,-fno-PIE)
>   KBUILD_AFLAGS	+= $(call cc-option,-fno-PIE)
> diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
> index 9f695f517747..fa3f439f0a92 100644
> --- a/arch/x86/entry/vdso/Makefile
> +++ b/arch/x86/entry/vdso/Makefile
> @@ -68,9 +68,9 @@ $(obj)/vdso-image-%.c: $(obj)/vdso%.so.dbg $(obj)/vdso%.so $(obj)/vdso2c FORCE
>   CFL := $(PROFILING) -mcmodel=small -fPIC -O2 -fasynchronous-unwind-tables -m64 \
>          $(filter -g%,$(KBUILD_CFLAGS)) $(call cc-option, -fno-stack-protector) \
>          -fno-omit-frame-pointer -foptimize-sibling-calls \
> -       -DDISABLE_BRANCH_PROFILING -DBUILD_VDSO
> +       -DDISABLE_BRANCH_PROFILING -DBUILD_VDSO $(RETPOLINE_VDSO_CFLAGS)
>   
> -$(vobjs): KBUILD_CFLAGS := $(filter-out $(GCC_PLUGINS_CFLAGS),$(KBUILD_CFLAGS)) $(CFL)
> +$(vobjs): KBUILD_CFLAGS := $(filter-out $(GCC_PLUGINS_CFLAGS) $(RETPOLINE_CFLAGS),$(KBUILD_CFLAGS)) $(CFL)
>   
>   #
>   # vDSO code runs in userspace and -pg doesn't help with profiling anyway.
> @@ -132,11 +132,13 @@ KBUILD_CFLAGS_32 := $(filter-out -mcmodel=kernel,$(KBUILD_CFLAGS_32))
>   KBUILD_CFLAGS_32 := $(filter-out -fno-pic,$(KBUILD_CFLAGS_32))
>   KBUILD_CFLAGS_32 := $(filter-out -mfentry,$(KBUILD_CFLAGS_32))
>   KBUILD_CFLAGS_32 := $(filter-out $(GCC_PLUGINS_CFLAGS),$(KBUILD_CFLAGS_32))
> +KBUILD_CFLAGS_32 := $(filter-out $(RETPOLINE_CFLAGS),$(KBUILD_CFLAGS_32))
>   KBUILD_CFLAGS_32 += -m32 -msoft-float -mregparm=0 -fpic
>   KBUILD_CFLAGS_32 += $(call cc-option, -fno-stack-protector)
>   KBUILD_CFLAGS_32 += $(call cc-option, -foptimize-sibling-calls)
>   KBUILD_CFLAGS_32 += -fno-omit-frame-pointer
>   KBUILD_CFLAGS_32 += -DDISABLE_BRANCH_PROFILING
> +KBUILD_CFLAGS_32 += $(RETPOLINE_VDSO_CFLAGS)
>   $(obj)/vdso32.so.dbg: KBUILD_CFLAGS = $(KBUILD_CFLAGS_32)
>   
>   $(obj)/vdso32.so.dbg: FORCE \
> 

That solves my issue, thanks.
Acked-by: Matt Rickard <matt@softrans.com.au>
