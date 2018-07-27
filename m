Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF3FBC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 08:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53EFE2088E
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 08:29:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YOZtQpWm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53EFE2088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730088AbeG0JuU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 05:50:20 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:40269 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729431AbeG0JuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 05:50:19 -0400
Received: by mail-pl0-f66.google.com with SMTP id s17-v6so2018796plp.7
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 01:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YJmzstxTmmuNweYTxC9RQDVMDVgIiSXwr19WQzx7nqI=;
        b=YOZtQpWmQrtm6pr8jvDo4Or7I4t0z8l+2AkYy/VJ3TsBJTF7ABG+Q6H5pigcTJ/YB5
         3M6tuwDirCGq1Y2ig6YvOEwV7ESfwCM+yg8GfEMk90R1xpZ2I6bbKtN//7g9YoIuWy3x
         FKcYAfkXK/LVL1jSxesu3VriQ9JD5WG8CAJDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=YJmzstxTmmuNweYTxC9RQDVMDVgIiSXwr19WQzx7nqI=;
        b=PXBSfZqfUbVAwElb98e2a3NVEnoJXMsqFf0GX3vzVs6431s6bg7I+QxBUwpehuz10f
         Cey9qSTa4Se45ElN+qqwWmPwNEtbBIX9WbnvyhooEDnPp/agccpMdc90X2+t3Z6fl97z
         yAhwdcJAR5GsPqZJW/S4U/tNGouknLUYmpHJF7wxPLwLD5s25zxTh73JM/nzDJ3Vf9w+
         2r9WGDYV9yQJcjlSEMK7BlFpbJqLtCrOEDhilQmMRaLPIArMfsWXqWTNlPWQ3thPEL3Y
         rd3kONrdvZ4iaNCVVy0cJGnS0z/z2PMc+ILidtUw4j9FgfCWeTYkl21T+bbYb9wiUBKR
         8jnw==
X-Gm-Message-State: AOUpUlH8/WVJBKe/GEtmR3eDD5kDP9tWM4Rxl9aCE5BDekJFIq8kXS2w
        fnsnOwdiJEoaQL/pJbNGzOsLIQ==
X-Google-Smtp-Source: AAOMgpdKLECz1T5QnaBqGZQHNg/fLgUPdS3mtz/eh7llk1wrI0h8CDSqY5GxNefp0Nr+GnyCs2jbPQ==
X-Received: by 2002:a17:902:8ecb:: with SMTP id x11-v6mr5257490plo.308.1532680171924;
        Fri, 27 Jul 2018 01:29:31 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id z90-v6sm7387635pfk.85.2018.07.27.01.29.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 01:29:31 -0700 (PDT)
Date:   Fri, 27 Jul 2018 17:31:06 +0900
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     James Morse <james.morse@arm.com>
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, dyoung@redhat.com, bhe@redhat.com,
        arnd@arndb.de, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        ard.biesheuvel@linaro.org, bhsharma@redhat.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 16/16] arm64: kexec_file: add kaslr support
Message-ID: <20180727083104.GI11258@linaro.org>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
        James Morse <james.morse@arm.com>, catalin.marinas@arm.com,
        will.deacon@arm.com, dhowells@redhat.com, vgoyal@redhat.com,
        herbert@gondor.apana.org.au, davem@davemloft.net, dyoung@redhat.com,
        bhe@redhat.com, arnd@arndb.de, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, ard.biesheuvel@linaro.org,
        bhsharma@redhat.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20180724065759.19186-1-takahiro.akashi@linaro.org>
 <20180724065759.19186-17-takahiro.akashi@linaro.org>
 <50b31f17-fc85-aa72-06f5-d3b62060a91f@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50b31f17-fc85-aa72-06f5-d3b62060a91f@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 02:40:49PM +0100, James Morse wrote:
> Hi Akashi,
> 
> On 24/07/18 07:57, AKASHI Takahiro wrote:
> > Adding "kaslr-seed" to dtb enables triggering kaslr, or kernel virtual
> > address randomization, at secondary kernel boot.
> 
> Hmm, there are three things that get moved by CONFIG_RANDOMIZE_BASE. The kernel
> physical placement when booted via the EFIstub, the kernel-text VAs and the
> location of memory in the linear-map region. Adding the kaslr-seed only does the
> last two.

Yes, but I think that I and Mark has agreed that "kaslr" meant
"virtual" randomisation, not including "physical" randomisation.

> This means the physical placement of the new kernel is predictable from
> /proc/iomem ... but this also tells you the physical placement of the current
> kernel, so I don't think this is a problem.
> 
> 
> > We always do this as it will have no harm on kaslr-incapable kernel.
> 
> > We don't have any "switch" to turn off this feature directly, but still
> > can suppress it by passing "nokaslr" as a kernel boot argument.
> 
> 
> > diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
> > index 7356da5a53d5..47a4fbd0dc34 100644
> > --- a/arch/arm64/kernel/machine_kexec_file.c
> > +++ b/arch/arm64/kernel/machine_kexec_file.c
> > @@ -158,6 +160,12 @@ static int setup_dtb(struct kimage *image,
> 
> Don't you need to reserve some space in the area you vmalloc()d for the DT?

No, I don't think so.
All the data to be loaded are temporarily saved in kexec buffers,
which will eventually be copied to target locations in machine_kexec
(arm64_relocate_new_kernel, which, unlike its name, will handle
not only kernel but also other data as well).

> 
> > +	/* add kaslr-seed */
> > +	get_random_bytes(&value, sizeof(value));
> 
> What happens if the crng isn't ready?
> 
> It looks like this will print a warning that these random-bytes aren't really up
> to standard, but the new kernel doesn't know this happened.
> 
> crng_ready() isn't exposed, all we could do now is
> wait_for_random_bytes(), but that may wait forever because we do this
> unconditionally.
> 
> I'd prefer to leave this feature until we can check crng_ready(), and skip
> adding a dodgy-seed if its not-ready. This avoids polluting the next-kernel's
> entropy pool.

OK. I would try to follow the same way as Bhupesh's userspace patch
does for kaslr-seed:
http://lists.infradead.org/pipermail/kexec/2018-April/020564.html

  if (not found kaslr-seed in 1st kernel's dtb)
     don't care; go ahead
  else
     if (current kaslr-seed != 0)
        error
     if (crng_ready()) ; FIXME, it's a local macro
        get_random_bytes(non-blocking)
        set new kaslr-seed
     else
        error

> 
> > +	ret = fdt_setprop(buf, nodeoffset, "kaslr-seed", &value, sizeof(value));
> 
> Nit: It would be nice if this string were in a header file somewhere, to void
> future refactoring typos.

OK. (but in this file for now as I mentioned in my previous reply)

Thanks,
-Takahiro AKASHI

> 
> Thanks,
> 
> James
