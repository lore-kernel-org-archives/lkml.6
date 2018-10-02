Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E01D5C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 08:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D59420645
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 08:21:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxbox.cz header.i=@linuxbox.cz header.b="BXdImC//"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D59420645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxbox.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbeJBPDr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 11:03:47 -0400
Received: from gwu.lbox.cz ([62.245.111.132]:43476 "EHLO gwu.lbox.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727285AbeJBPDq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 11:03:46 -0400
X-Greylist: delayed 721 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Oct 2018 11:03:45 EDT
Received: from linuxbox.linuxbox.cz (linuxbox.linuxbox.cz [10.76.66.10])
        by gwu.lbox.cz (Sendmail) with ESMTPS id w9286wUw002506
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 2 Oct 2018 10:06:58 +0200
DKIM-Filter: OpenDKIM Filter v2.11.0 gwu.lbox.cz w9286wUw002506
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxbox.cz;
        s=default; t=1538467620;
        bh=mtmBl/oPSqPwMP1oK9NVgfaYZouquMQnZ3M0a/bkXH8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BXdImC//9xqpCqewXDFdVrEDNXTgSkOdm8dB9vP03vXOGjGPPWrSaBhzZbCyKf6ID
         VVGPHHX6fFTxW5X0Rc9vJp+jiOTwHeHVCcDr6cx4oe5VEC0TrR4rtkHkw3Q8/Hd7Ch
         PKeJQDTK1aMuziFPzvymVByCBrCFH/6bV4rHsllQ=
Received: from pcnci.linuxbox.cz (pcnci.linuxbox.cz [10.76.3.14])
        by linuxbox.linuxbox.cz (Sendmail) with ESMTPS id w9286v4w020948
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 2 Oct 2018 10:06:57 +0200
Received: from pcnci.linuxbox.cz (localhost [127.0.0.1])
        by pcnci.linuxbox.cz (8.15.2/8.15.2) with SMTP id w9286tWj019974;
        Tue, 2 Oct 2018 10:06:55 +0200
Date:   Tue, 2 Oct 2018 10:06:55 +0200
From:   Nikola Ciprich <nikola.ciprich@linuxbox.cz>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matt Rickard <matt@softrans.com.au>,
        Borislav Petkov <bp@alien8.de>,
        Jason Vas Dias <jason.vas.dias@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>,
        Nikola Ciprich <nikola.ciprich@linuxbox.cz>
Subject: Re: [PATCH 4.14 114/165] x86/vdso: Fix vDSO build if a retpoline is
 emitted
Message-ID: <20181002080655.GV31855@pcnci.linuxbox.cz>
References: <20180903165655.003605184@linuxfoundation.org>
 <20180903165701.245301231@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180903165701.245301231@linuxfoundation.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Antivirus: on proxybox by F-Secure antivirus, database version 2018-10-02_02
X-Scanned-By: MIMEDefang v2.74/SpamAssassin v3.004001 on proxybox (nik)
X-Milter-Copy-Status: O
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg and others,

sorry for reporting this so late, but still...

this breaks build on older compilers, since it requires
-mindirect-branch=thunk-inline -mindirect-branch-register even though
retpoline support is disabled in kernel config.. is this expected?

BR

nik


On Mon, Sep 03, 2018 at 06:56:40PM +0200, Greg Kroah-Hartman wrote:
> 4.14-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Andy Lutomirski <luto@kernel.org>
> 
> commit 2e549b2ee0e358bc758480e716b881f9cabedb6a upstream.
> 
> Currently, if the vDSO ends up containing an indirect branch or
> call, GCC will emit the "external thunk" style of retpoline, and it
> will fail to link.
> 
> Fix it by building the vDSO with inline retpoline thunks.
> 
> I haven't seen any reports of this triggering on an unpatched
> kernel.
> 
> Fixes: commit 76b043848fd2 ("x86/retpoline: Add initial retpoline support")
> Signed-off-by: Andy Lutomirski <luto@kernel.org>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Acked-by: Matt Rickard <matt@softrans.com.au>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Jason Vas Dias <jason.vas.dias@gmail.com>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: stable@vger.kernel.org
> Link: https://lkml.kernel.org/r/c76538cd3afbe19c6246c2d1715bc6a60bd63985.1534448381.git.luto@kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> ---
>  Makefile                     |    4 ++++
>  arch/x86/entry/vdso/Makefile |    6 ++++--
>  2 files changed, 8 insertions(+), 2 deletions(-)
> 
> --- a/Makefile
> +++ b/Makefile
> @@ -490,9 +490,13 @@ KBUILD_AFLAGS += $(CLANG_TARGET) $(CLANG
>  endif
>  
>  RETPOLINE_CFLAGS_GCC := -mindirect-branch=thunk-extern -mindirect-branch-register
> +RETPOLINE_VDSO_CFLAGS_GCC := -mindirect-branch=thunk-inline -mindirect-branch-register
>  RETPOLINE_CFLAGS_CLANG := -mretpoline-external-thunk
> +RETPOLINE_VDSO_CFLAGS_CLANG := -mretpoline
>  RETPOLINE_CFLAGS := $(call cc-option,$(RETPOLINE_CFLAGS_GCC),$(call cc-option,$(RETPOLINE_CFLAGS_CLANG)))
> +RETPOLINE_VDSO_CFLAGS := $(call cc-option,$(RETPOLINE_VDSO_CFLAGS_GCC),$(call cc-option,$(RETPOLINE_VDSO_CFLAGS_CLANG)))
>  export RETPOLINE_CFLAGS
> +export RETPOLINE_VDSO_CFLAGS
>  
>  ifeq ($(config-targets),1)
>  # ===========================================================================
> --- a/arch/x86/entry/vdso/Makefile
> +++ b/arch/x86/entry/vdso/Makefile
> @@ -74,9 +74,9 @@ $(obj)/vdso-image-%.c: $(obj)/vdso%.so.d
>  CFL := $(PROFILING) -mcmodel=small -fPIC -O2 -fasynchronous-unwind-tables -m64 \
>         $(filter -g%,$(KBUILD_CFLAGS)) $(call cc-option, -fno-stack-protector) \
>         -fno-omit-frame-pointer -foptimize-sibling-calls \
> -       -DDISABLE_BRANCH_PROFILING -DBUILD_VDSO
> +       -DDISABLE_BRANCH_PROFILING -DBUILD_VDSO $(RETPOLINE_VDSO_CFLAGS)
>  
> -$(vobjs): KBUILD_CFLAGS := $(filter-out $(GCC_PLUGINS_CFLAGS),$(KBUILD_CFLAGS)) $(CFL)
> +$(vobjs): KBUILD_CFLAGS := $(filter-out $(GCC_PLUGINS_CFLAGS) $(RETPOLINE_CFLAGS),$(KBUILD_CFLAGS)) $(CFL)
>  
>  #
>  # vDSO code runs in userspace and -pg doesn't help with profiling anyway.
> @@ -147,11 +147,13 @@ KBUILD_CFLAGS_32 := $(filter-out -mcmode
>  KBUILD_CFLAGS_32 := $(filter-out -fno-pic,$(KBUILD_CFLAGS_32))
>  KBUILD_CFLAGS_32 := $(filter-out -mfentry,$(KBUILD_CFLAGS_32))
>  KBUILD_CFLAGS_32 := $(filter-out $(GCC_PLUGINS_CFLAGS),$(KBUILD_CFLAGS_32))
> +KBUILD_CFLAGS_32 := $(filter-out $(RETPOLINE_CFLAGS),$(KBUILD_CFLAGS_32))
>  KBUILD_CFLAGS_32 += -m32 -msoft-float -mregparm=0 -fpic
>  KBUILD_CFLAGS_32 += $(call cc-option, -fno-stack-protector)
>  KBUILD_CFLAGS_32 += $(call cc-option, -foptimize-sibling-calls)
>  KBUILD_CFLAGS_32 += -fno-omit-frame-pointer
>  KBUILD_CFLAGS_32 += -DDISABLE_BRANCH_PROFILING
> +KBUILD_CFLAGS_32 += $(RETPOLINE_VDSO_CFLAGS)
>  $(obj)/vdso32.so.dbg: KBUILD_CFLAGS = $(KBUILD_CFLAGS_32)
>  
>  $(obj)/vdso32.so.dbg: FORCE \
> 
> 

-- 
-------------------------------------
Ing. Nikola CIPRICH
LinuxBox.cz, s.r.o.
28.rijna 168, 709 00 Ostrava

tel.:   +420 591 166 214
fax:    +420 596 621 273
mobil:  +420 777 093 799
www.linuxbox.cz

mobil servis: +420 737 238 656
email servis: servis@linuxbox.cz
-------------------------------------
