Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9548C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 05:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F2742054F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 05:39:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WcVfm3tC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F2742054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729391AbeLKFjW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 00:39:22 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40584 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727721AbeLKFjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 00:39:22 -0500
Received: by mail-pf1-f196.google.com with SMTP id i12so6572488pfo.7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 21:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=stmSX3PXcRyVdMNVm5vUdxgGBOXh3Sb8rfzgIO0InSY=;
        b=WcVfm3tCW+gsL+H1w5KxyvEXeTSrBd1C9jxV6ngKiejSuW5C3zZJlKsgQ9TR+jfb4C
         /8wAu+Fq5Eo+kIHVuvnxVg/AtMrALY1AuP9M5sOcLGUk9VjtqTmo+ml+GEs7oKrtFjbt
         BiCRxVmsdlKbEEAvOMcQr3jnoY/GZPzimKoag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=stmSX3PXcRyVdMNVm5vUdxgGBOXh3Sb8rfzgIO0InSY=;
        b=gJuztZWdRAefPgfykC1L1n2N5lNeqE21cjAyswDWLMtl2C/ztYV8mGKOxbc2CLh5iY
         wb+amXoV5HGEG4FnmW+VfFddEtKAfzq54DqA171ew/w/2ChHrkJs9+yAItH+VieWdLgR
         ilfxlh/HuzvjwwQUmIJUQnYC6bAjD0ELIo8wT8pdi0ZfzuanaXdN4Pp5lH4WJCE/DFls
         HnMkSoEbM7OUJudPaQQck5hULDQ1rA7s3HHamxvhY5w/lOM1NIOcE88ioOyKi4dlJqLu
         tMbZi0Na5CDDpHvgeww4pDT3Z++/V9j6o/BCAOtSIcl8tqflG59P8SSOj+3af6u3dxvw
         B0yA==
X-Gm-Message-State: AA+aEWYkTNS53mZDQnJJQPKIJ8HIyIYEA/Opuk/x9JwfAUqfKRyTKzCh
        uFJNWUZjzY7xN/tpEUI0I0/0Bg==
X-Google-Smtp-Source: AFSGD/VCCVgXATy2JvAF53fkbdjvY8UCEbi/uUeiU2X8vftbNTZKnbuRV32qJAWawEjijqTs7eldAg==
X-Received: by 2002:a63:82c6:: with SMTP id w189mr13623171pgd.344.1544506761012;
        Mon, 10 Dec 2018 21:39:21 -0800 (PST)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id l19sm28311461pfi.71.2018.12.10.21.39.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 21:39:20 -0800 (PST)
Date:   Tue, 11 Dec 2018 14:42:33 +0900
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     Will Deacon <will.deacon@arm.com>
Cc:     catalin.marinas@arm.com, dhowells@redhat.com, vgoyal@redhat.com,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        dyoung@redhat.com, bhe@redhat.com, arnd@arndb.de,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        prudo@linux.ibm.com, ard.biesheuvel@linaro.org,
        james.morse@arm.com, bhsharma@redhat.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v16 15/16] arm64: kexec_file: add kernel signature
 verification support
Message-ID: <20181211054231.GD21466@linaro.org>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Will Deacon <will.deacon@arm.com>, catalin.marinas@arm.com,
        dhowells@redhat.com, vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, dyoung@redhat.com, bhe@redhat.com,
        arnd@arndb.de, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        prudo@linux.ibm.com, ard.biesheuvel@linaro.org, james.morse@arm.com,
        bhsharma@redhat.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20181115055254.2812-1-takahiro.akashi@linaro.org>
 <20181115055254.2812-16-takahiro.akashi@linaro.org>
 <20181130132113.GE9000@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181130132113.GE9000@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 01:21:14PM +0000, Will Deacon wrote:
> On Thu, Nov 15, 2018 at 02:52:54PM +0900, AKASHI Takahiro wrote:
> > With this patch, kernel verification can be done without IMA security
> > subsystem enabled. Turn on CONFIG_KEXEC_VERIFY_SIG instead.
> > 
> > On x86, a signature is embedded into a PE file (Microsoft's format) header
> > of binary. Since arm64's "Image" can also be seen as a PE file as far as
> > CONFIG_EFI is enabled, we adopt this format for kernel signing.
> > 
> > You can create a signed kernel image with:
> >     $ sbsign --key ${KEY} --cert ${CERT} Image
> > 
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Reviewed-by: James Morse <james.morse@arm.com>
> > ---
> >  arch/arm64/Kconfig              | 24 ++++++++++++++++++++++++
> >  arch/arm64/kernel/kexec_image.c | 17 +++++++++++++++++
> >  2 files changed, 41 insertions(+)
> > 
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index 93dc4d36d6db..11f3e1a00588 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -867,6 +867,30 @@ config KEXEC_FILE
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
> > +comment "Support for PE file signature verification disabled"
> > +	depends on KEXEC_VERIFY_SIG
> > +	depends on !EFI || !SIGNED_PE_FILE_VERIFICATION
> > +
> >  config CRASH_DUMP
> >  	bool "Build kdump crash kernel"
> >  	help
> > diff --git a/arch/arm64/kernel/kexec_image.c b/arch/arm64/kernel/kexec_image.c
> > index 9f0d8b5d62d3..d1c6c54c22e3 100644
> > --- a/arch/arm64/kernel/kexec_image.c
> > +++ b/arch/arm64/kernel/kexec_image.c
> > @@ -12,7 +12,9 @@
> >  #include <linux/errno.h>
> >  #include <linux/kernel.h>
> >  #include <linux/kexec.h>
> > +#include <linux/pe.h>
> >  #include <linux/string.h>
> > +#include <linux/verification.h>
> >  #include <asm/byteorder.h>
> >  #include <asm/cpufeature.h>
> >  #include <asm/image.h>
> > @@ -29,6 +31,10 @@ static int image_probe(const char *kernel_buf, unsigned long kernel_len)
> >  				sizeof(h->magic)))
> >  		return -EINVAL;
> >  
> > +	pr_debug("PE format: %s\n",
> > +			memcmp(&((struct mz_hdr *)h)->magic, "MZ", 2) ?
> > +							"no" : "yes");
> > 
> 
> Is this hunk really necessary? I'd prefer not to commit pr_debug()
> invocations.

This line comes from kexec-tools' code, but I don't mind removing it.
(as lots of lines diverge now from kexec-tools.)

-Takahiro Akashi


> Will
