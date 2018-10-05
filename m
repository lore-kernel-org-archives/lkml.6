Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB96C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 22:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E9D9208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 22:03:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Agx2kubD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E9D9208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728583AbeJFFEK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 01:04:10 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41621 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbeJFFEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 01:04:09 -0400
Received: by mail-pg1-f194.google.com with SMTP id 23-v6so5279128pgc.8;
        Fri, 05 Oct 2018 15:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Mx8OKx5bkkUbswk/e64BN04GCgYQ2hRTHcHxGOMLwf4=;
        b=Agx2kubDpUE5oRgDggDnvEfuBmr9VWhyO8lWdKtFaVzJ52bECwHA6LqmBLci9qmr56
         7f0/Cz+pq3rPo98CMeMT/KhiWCR8KjWbgiKRSVRh0re+bMY5fXDHKg4VDO7yDc9ZUtz3
         Wkabe6IsBcV8CfietkE5Wcyz9evpufhIXN/xWjlYhFPqolfq9DKatz1e6NbDvHvIGnhl
         blZMWkPRDvoVN5IJxssaI+Fnrx32af5vbkV1/ywoRzDCsUwjLth9mLan4BMLPpP54GEN
         qsg8qvBW3kyP0ug+iZF1KzVvJDuG5P6+bEQaq/71qOzzuRiPwoiCeMsdIWbl0D23iT32
         e0Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Mx8OKx5bkkUbswk/e64BN04GCgYQ2hRTHcHxGOMLwf4=;
        b=q9Z4qttHKKfa3LK+dzkCMawAVdsMvqKLQcth6oHVyRVdxngt/Lw5XdzJkivVNKTBAL
         14hOgGoZGaMdm6rhNhjcczUhLrFkS8FekHQMiTvPqXaWLRNbwtZYsuo/AdOsUnc5otmd
         2+67Fy588x65wYbqPOSs7rHgzKblKLtCk+aWeiXQksQb+rQ5Hgu6sTAocvnH77vVdtQi
         Qhu44vH+luaDjiK/UpXAW/fuTYAYXhc5F91uKiRJALDN9tFExwiA5KnLB+q9FR+RVLaD
         uJHFMPrYv2ody+Jt/f2eh0sFkGFyJ0OhBRGr2SowYmqI5F2XFgZVT/T9+mpevcC44evM
         f4sw==
X-Gm-Message-State: ABuFfojfx291WCvxf/X7ezNLm+Hg+X0OP7DjzUqjuzgeLhMqcWD2wiNE
        HlpXhungNBzQbtZaCMHpEsk=
X-Google-Smtp-Source: ACcGV620wq/iIce6dD8WTlr8AsB2iKotNQ6AGShwn9UOWwUDGZcFMzHDKCxf1gXVdozFcxhmqrFNZA==
X-Received: by 2002:a62:8559:: with SMTP id u86-v6mr13927462pfd.32.1538777008079;
        Fri, 05 Oct 2018 15:03:28 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id q2-v6sm31610145pfc.17.2018.10.05.15.03.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 15:03:27 -0700 (PDT)
Date:   Fri, 5 Oct 2018 15:03:25 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brijesh Singh <brijesh.singh@amd.com>,
        Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH] KVM: X86: Add missing KVM_AMD dependency
Message-ID: <20181005220325.GA24365@roeck-us.net>
References: <1538765165-19177-1-git-send-email-linux@roeck-us.net>
 <749a21f9-ad88-af0e-bed7-b505ac57568d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <749a21f9-ad88-af0e-bed7-b505ac57568d@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 05, 2018 at 10:41:55PM +0200, Paolo Bonzini wrote:
> On 05/10/2018 20:46, Guenter Roeck wrote:
> > Analysis shows that commit 59414c9892208 ("KVM: SVM: Add support for
> > KVM_SEV_LAUNCH_START command") added a dependency of KVM_AMD on
> > CRYPTO_DEV_CCP_DD if CRYPTO_DEV_SP_PSP is enabled: If CRYPTO_DEV_CCP_DD
> > is built as module, KVM_AMD must be built as module as well.
> > 
> > Fixes: 59414c9892208 ("KVM: SVM: Add support for KVM_SEV_LAUNCH_START command")
> > Cc: Brijesh Singh <brijesh.singh@amd.com>
> > Cc: Borislav Petkov <bp@suse.de>
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> 
> This should be handled by
> 
> config KVM_AMD_SEV
>         def_bool y
>         bool "AMD Secure Encrypted Virtualization (SEV) support"
>         depends on KVM_AMD && X86_64
>         depends on CRYPTO_DEV_SP_PSP && !(KVM_AMD=y && CRYPTO_DEV_CCP_DD=m)
>         ---help---
>         Provides support for launching Encrypted VMs on AMD processors.
> 

Unfortunately it doesn't. It disables KVM_AMD_SEV, but that doesn't prevent
the calls.

> Maybe this works as well?  I haven't tested it yet:
> 

I am sure there are many possible solutions. I would personally prefer one
that enforces KVM_AMD=m with CRYPTO_DEV_CCP_DD=m, but that is just me.

Thanks,
Guenter

> diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
> index 89c4c5aa15f1..55f10b17d044 100644
> --- a/arch/x86/kvm/svm.c
> +++ b/arch/x86/kvm/svm.c
> @@ -441,9 +441,13 @@ static inline bool svm_sev_enabled(void)
> 
>  static inline bool sev_guest(struct kvm *kvm)
>  {
> +#ifdef CONFIG_KVM_AMD_SEV
>  	struct kvm_sev_info *sev = &to_kvm_svm(kvm)->sev_info;
> 
>  	return sev->active;
> +#else
> +	return false;
> +#endif
>  }
> 
>  static inline int sev_get_asid(struct kvm *kvm)
> 
> Thanks,
> 
> Paolo
