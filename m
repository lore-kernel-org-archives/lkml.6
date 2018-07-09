Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 791CDC6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 09:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 308EA20673
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 09:00:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZULQGnAs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 308EA20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932622AbeGIJAS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 05:00:18 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:47023 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752914AbeGIJAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 05:00:16 -0400
Received: by mail-pf0-f193.google.com with SMTP id l123-v6so13205813pfl.13
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 02:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KYxQu7doFu6e+nrLh0HttSrZJ4AdYWYNOJVxsuVli+o=;
        b=ZULQGnAsf6K0Jb+oLCdL75nmIY4Zw27XzCNAHrt0fcxK67rQT7LgC/QQ2VErMLJuh6
         Ftz7PpDoIudfQYLepBX4H69xcZAyjXEDXcYpmNZuwuWuNVkyZx4v61TRR5dYLObPasbS
         4QkGJ7PNL0UW8O/pLbMSV/vfWQRhtkJFtogB4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=KYxQu7doFu6e+nrLh0HttSrZJ4AdYWYNOJVxsuVli+o=;
        b=mpAAbNnZEMjbVHdrXIWf3i+trkIs2yKi0hOWsnZnK3GGgGkBTdx5hJu/+ABkJz8Xmo
         H4gaZkFMyuv1+873DnXaZEwt4welRRL4CdDs9VYFfshrRFY1cL4GWKsWNq5vhfywhgjw
         WBX0guwSjNEkxtF4aJPIfad3OXSDx3Xd8KQc5jB82WvnpJkBozpcYgaSUz+y4I3rPA9f
         YO7DyVvd82jXyvihXYo4UTZA6ZazLyKg2HLk5qPB4l7omCK8JTtpPpTOJmDpnvufWJS+
         f+7q3CAPsos3CBKWA3LqSZjVFMKGuoDeh1y6FtXWInZMo7447SAwCwNuQHASunOk+YNS
         9wTQ==
X-Gm-Message-State: APt69E2y4tGJ+MRYOeT5QkCKKZURgG8mkv33z4BNoMcSb45mj+H6OtPG
        gwD7p9Ny825uLaxGl8TE+cIXog==
X-Google-Smtp-Source: AAOMgpcxL94oUgcrIkLmNTG6Aa7nSBLCXJmW3dsOnu93QCeCJtOAXiAEom4M1iA1KcVc4DwYE4DDxw==
X-Received: by 2002:a62:1c16:: with SMTP id c22-v6mr7019872pfc.148.1531126816453;
        Mon, 09 Jul 2018 02:00:16 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id m15-v6sm12814438pgc.43.2018.07.09.02.00.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 02:00:15 -0700 (PDT)
Date:   Mon, 9 Jul 2018 18:01:34 +0900
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     James Morse <james.morse@arm.com>
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, dyoung@redhat.com, bhe@redhat.com,
        arnd@arndb.de, ard.biesheuvel@linaro.org, bhsharma@redhat.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 13/14] arm64: kexec_file: add kernel signature
 verification support
Message-ID: <20180709090133.GU28220@linaro.org>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
        James Morse <james.morse@arm.com>, catalin.marinas@arm.com,
        will.deacon@arm.com, dhowells@redhat.com, vgoyal@redhat.com,
        herbert@gondor.apana.org.au, davem@davemloft.net, dyoung@redhat.com,
        bhe@redhat.com, arnd@arndb.de, ard.biesheuvel@linaro.org,
        bhsharma@redhat.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20180623022058.10935-1-takahiro.akashi@linaro.org>
 <20180623022058.10935-14-takahiro.akashi@linaro.org>
 <ff77f2d9-82c6-8fbb-3696-e1fcfd61c333@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff77f2d9-82c6-8fbb-3696-e1fcfd61c333@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 06:47:38PM +0100, James Morse wrote:
> Hi Akashi,
> 
> On 23/06/18 03:20, AKASHI Takahiro wrote:
> > With this patch, kernel verification can be done without IMA security
> > subsystem enabled. Turn on CONFIG_KEXEC_VERIFY_SIG instead.
> > 
> > On x86, a signature is embedded into a PE file (Microsoft's format) header
> > of binary. Since arm64's "Image" can also be seen as a PE file as far as
> > CONFIG_EFI is enabled, we adopt this format for kernel signing.
> > 
> > You can create a signed kernel image with:
> >     $ sbsign --key ${KEY} --cert ${CERT} Image
> 
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index f68318f61c85..5133c22a01ab 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -845,6 +845,30 @@ config KEXEC_FILE
> >  	  for kernel and initramfs as opposed to list of segments as
> >  	  accepted by previous system call.
> >  
> > +config KEXEC_VERIFY_SIG
> > +	bool "Verify kernel signature during kexec_file_load() syscall"
> > +	depends on KEXEC_FILE
> > +	help
> > +	  Select this option to verify a signature with loaded kernel
> > +	  image. If configured, any attempt of loading a image without
> > +	  valid signature will fail.
> > +
> > +	  In addition to that option, you need to enable signature
> > +	  verification for the corresponding kernel image type being
> > +	  loaded in order for this to work.
> > +
> > +config KEXEC_IMAGE_VERIFY_SIG
> > +	bool "Enable Image signature verification support"
> > +	default y
> > +	depends on KEXEC_VERIFY_SIG
> > +	depends on EFI && SIGNED_PE_FILE_VERIFICATION
> > +	help
> > +	  Enable Image signature verification support.
> > +
> > +comment "Image signature verification is missing yet"
> > +	depends on KEXEC_VERIFY_SIG
> > +	depends on !EFI || !SIGNED_PE_FILE_VERIFICATION
> 
> 
> This comment thing is a good idea, but its also a bit confusing... it took me
> quite a while to work out what was missing. Could we phrase it something like:
> "Support for PE file signature verification disabled!"

OK.

> This tells us its about PE files, and its probably a missing config option
> somewhere, not some code that hasn't been written yet. (which was my first
> assumption!).
> 
> KEXEC_VERIFY_SIG presumably turns on just the IMA verification, which verifies
> the Image, but not in the same way as KEXEC_IMAGE_VERIFY_SIG.... (if I've
> understood it properly)

I'm afraid that I'm not clear at the cover letter.
Those two mechanisms, IMA verification and kexec-specific verification,
are totally different. The former is relatively new as well as generic,
and doesn't even require KEXEC_VERIFY_SIG at all as all the stuff is done
under IMA framework (via security hooks) with extended file attributes.

On the other hand, KEXEC_VERIFY_SIG is just an option that turns on
verification check in a kexec-specific (and more importantly arch-specific
and file-format-specific) manner through 'kexec_file_ops->verify interface.'

> Is there any reason to have these as separate enables?

If you are talking about KEXEC_VERIFY_SIG and KEXEC_IMAGE_VERIFY_SIG,
it is a leftover when "vmlinux" image was also supported in my
old versions of kexec_file patch set.
But please note that x86 also retains two separate configuration options,
KEXEC_VERIFY_SIG and KEXEC_BZIMAGE_VERIFY_SIG.
I simply followed that.

> Couldn't we 'select SIGNED_PE_FILE_VERIFICATION if EFI' in KEXEC_VERIFY_SIG?

I didn't "select" SIGNED_PE_FILE_VERIFICATION here following
"kbuild/kconfig-language.txt" which suggests, "use select only for
non-visible symbols (no prompts anywhere)."

> This would mean there is one option to verify signatures, instead of two...
> (does it really depend on EFI?)

Strictly speaking, SIGNED_PE_FILE_VERIFICATION depends on the fact
that a binary file is in PE format, which means that EFI is enabled
on arm64.
It is possible to support KEXEC_VERIFY_SIG for non-PE binaries, but
in that case, we will have to invent a new (arm64-specific) way of
verification.
(For instance, we might want to add a kexec-specific ELF segment to vmlinux.)

Thanks,
-Takahiro AKASHI

> 
> Thanks,
> 
> James
