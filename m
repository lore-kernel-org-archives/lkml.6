Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C99D6C67839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 05:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82C422081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 05:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Baqr7tOc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82C422081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728822AbeLKFqv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 00:46:51 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38675 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727589AbeLKFqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 00:46:51 -0500
Received: by mail-pl1-f194.google.com with SMTP id e5so6410078plb.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 21:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zhPCOr+gesxOtbwej8Ug6B66BepSASL63C1mfvGXgVQ=;
        b=Baqr7tOcm2K56MXemu6O72YhW/Z1+si95z5pK9Lj35LaTdBp/8xxdg0tdlew0qz9J4
         xlamSiOcHjWDdeU83EDmGL4k+yzmUQ9L+ZhVVkuRgS6W0kSQ83Jcd72X1LJCxBE/1NNY
         IRH40GEXopZOfk7z/XrttCt/mRcGOe7pTXOi4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=zhPCOr+gesxOtbwej8Ug6B66BepSASL63C1mfvGXgVQ=;
        b=XUfJ8uDV+8uqGq2gHG+LUqRYGvbcLCusuxfnfmH1fuAYL900psbm6eQ+TaN/kuQBs+
         WDCnoXmAUP/3QvOMI5ezRFuz/Kn6JwIcTKj8DASHV9bEU8Y/rnQh1JTISi3rduPqeMkd
         PKD1d6lSXOURAbs+42yS+LoUhz+TrHhfpKPHd6DGi21RhxlM6T6VRPtVWf8MMom8jFB9
         DA6P8SYx0AHvJsIZTS2v96P6jGjLQ10VX6uz9bKppS8AjwWB6+k4ROAcH7m0h2UKMaqF
         kdDm98oUp2VBWEjH1OBlweRAfZFz4z4g/UIdt9laPd4Ufd66AJhe1ebId7/L6vLuhC8r
         aX3g==
X-Gm-Message-State: AA+aEWZHRwifN9+P2+GEaiRfoS1asl0pUZ4Mv+J2uLwZtn86xSqX06Pj
        iEu3QEFjWirZ+c9XLDddNegfvQ==
X-Google-Smtp-Source: AFSGD/UTPm6cehXdzedZY6PaqCe0uExS5SiGeG1KTkyAbSz3EuLDcBkgFY5BrzTGiIVR93OTA/NiVw==
X-Received: by 2002:a17:902:f24:: with SMTP id 33mr15054106ply.65.1544507210466;
        Mon, 10 Dec 2018 21:46:50 -0800 (PST)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id u6sm14711918pgr.79.2018.12.10.21.46.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 21:46:49 -0800 (PST)
Date:   Tue, 11 Dec 2018 14:50:02 +0900
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
Subject: Re: [PATCH v16 16/16] arm64: kexec_file: add kaslr support
Message-ID: <20181211055001.GE21466@linaro.org>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Will Deacon <will.deacon@arm.com>, catalin.marinas@arm.com,
        dhowells@redhat.com, vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, dyoung@redhat.com, bhe@redhat.com,
        arnd@arndb.de, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        prudo@linux.ibm.com, ard.biesheuvel@linaro.org, james.morse@arm.com,
        bhsharma@redhat.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20181115055254.2812-1-takahiro.akashi@linaro.org>
 <20181115055254.2812-17-takahiro.akashi@linaro.org>
 <20181130131944.GA9000@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181130131944.GA9000@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 01:19:44PM +0000, Will Deacon wrote:
> On Thu, Nov 15, 2018 at 02:52:55PM +0900, AKASHI Takahiro wrote:
> > Adding "kaslr-seed" to dtb enables triggering kaslr, or kernel virtual
> > address randomization, at secondary kernel boot. We always do this as
> > it will have no harm on kaslr-incapable kernel.
> > 
> > We don't have any "switch" to turn off this feature directly, but still
> > can suppress it by passing "nokaslr" as a kernel boot argument.
> > 
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will.deacon@arm.com>
> > ---
> >  arch/arm64/kernel/machine_kexec_file.c | 46 +++++++++++++++++++++++++-
> >  1 file changed, 45 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
> > index ab296b98d633..a0a730bd9be6 100644
> > --- a/arch/arm64/kernel/machine_kexec_file.c
> > +++ b/arch/arm64/kernel/machine_kexec_file.c
> > @@ -16,6 +16,7 @@
> >  #include <linux/libfdt.h>
> >  #include <linux/memblock.h>
> >  #include <linux/of_fdt.h>
> > +#include <linux/random.h>
> >  #include <linux/slab.h>
> >  #include <linux/string.h>
> >  #include <linux/types.h>
> > @@ -28,6 +29,7 @@
> >  #define FDT_PSTR_INITRD_STA	"linux,initrd-start"
> >  #define FDT_PSTR_INITRD_END	"linux,initrd-end"
> >  #define FDT_PSTR_BOOTARGS	"bootargs"
> > +#define FDT_PSTR_KASLR_SEED	"kaslr-seed"
> >  
> >  const struct kexec_file_ops * const kexec_file_loaders[] = {
> >  	&kexec_image_ops,
> > @@ -46,11 +48,38 @@ int arch_kimage_file_post_load_cleanup(struct kimage *image)
> >  	return kexec_image_post_load_cleanup_default(image);
> >  }
> >  
> > +/* crng needs to have been initialized for providing kaslr-seed */
> > +static int random_ready;
> > +
> > +static void random_ready_notified(struct random_ready_callback *unused)
> > +{
> > +	random_ready = 1;
> > +}
> > +
> > +static struct random_ready_callback random_ready_cb = {
> > +	.func = random_ready_notified,
> > +};
> > +
> > +static __init int init_random_ready_cb(void)
> > +{
> > +	int ret;
> > +
> > +	ret = add_random_ready_callback(&random_ready_cb);
> > +	if (ret == -EALREADY)
> > +		random_ready = 1;
> > +	else if (ret)
> > +		pr_warn("failed to add a callback for random_ready\n");
> > +
> > +	return 0;
> > +}
> > +late_initcall(init_random_ready_cb)
> 
> Why can't we just call crng_ready()?

because crng_ready() is locally defined in drivers/char/random.c.
Instead, I'd like to use
        wait_for_random_bytes();
        value = get_random_u64();

> > +
> >  static int setup_dtb(struct kimage *image,
> >  		     unsigned long initrd_load_addr, unsigned long initrd_len,
> >  		     char *cmdline, void *dtb)
> >  {
> >  	int nodeoffset;
> > +	u64 value;
> >  	int ret;
> >  
> >  	nodeoffset = fdt_path_offset(dtb, "/chosen");
> > @@ -106,12 +135,27 @@ static int setup_dtb(struct kimage *image,
> >  			return -EINVAL;
> >  	}
> >  
> > +	/* add kaslr-seed */
> > +	ret = fdt_delprop(dtb, nodeoffset, FDT_PSTR_KASLR_SEED);
> > +	if (ret && (ret != -FDT_ERR_NOTFOUND))
> > +		return -EINVAL;
> > +
> > +	if (random_ready) {
> > +		get_random_bytes(&value, sizeof(value));
> 
> get_random_u64() ?

OK.

> > +		ret = fdt_setprop_u64(dtb, nodeoffset, FDT_PSTR_KASLR_SEED,
> > +							value);
> > +		if (ret)
> > +			return (ret == -FDT_ERR_NOSPACE ? -ENOMEM : -EINVAL);
> > +	} else {
> 
> Wouldn't we be better off preserving the previous seed here, if it was
> present?

While there's no guarantee that dtb won't be (partially) broken
on failure, I will let this function return successfully
by deleting succeeding fdt_delprop().


> > +		pr_notice("kaslr-seed won't be fed\n");
> 
> "fed" is probably not the right word here.

=> won't be *provided* on kexec?

-Takahiro Akashi

> Will
