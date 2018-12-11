Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F11CC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 07:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4AC72082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 07:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="W8Ml4FTZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4AC72082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbeLKHsq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 02:48:46 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41648 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbeLKHsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 02:48:46 -0500
Received: by mail-pg1-f193.google.com with SMTP id 70so6259296pgh.8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 23:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XipAuGThqb8NbwoNlzBfTaW9mP3dpkNB+nduQZICwtI=;
        b=W8Ml4FTZ9Vui4AWq2Lic8+GhkkdlGnkM/bXw2S9JU8g1O/JfnJPSakZ++3HDe6sg/J
         hlfS/759szunBDUSCyP87ly7bkHyp+/Y/vytKpqt7KTaOzE7RPGUl81VhM+VOmkSUTPH
         8lhy/8WxHOJjQklvIFHXN4ZC0kh67MccBUTgk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=XipAuGThqb8NbwoNlzBfTaW9mP3dpkNB+nduQZICwtI=;
        b=lccOMwvaH326TXggscspJBpmouc28eOB4rLZOBH4WLT3G3K4xfx7ETw2JHBhA9ulkr
         QD4BQxxR9OjaicWqzoXKU6HE3Wm5L0tZ3gi4K9IkoNd0xhi6efLWmQGox9Dfuqw7wH2Q
         /V71Ies237c1sDRSog5U26gp+lPmfq6H7ZGvA3cIX6eiTl5+52HisFEDX0re0q7BVxzz
         u99nwXbKyC8VDYUFZnjOHUdQWbo7XkSE5yZxaBmObRS+jZFd8Nd0pFZ9dEIUmY5u8Z2z
         36efEZX1GIp+uaZjpZtZJdbDyTrIDC/zZNAaFqHoiJLgQi4/ORJJbGJPul7sWSVYlWkx
         yZ5w==
X-Gm-Message-State: AA+aEWbYrFGJCK+Ga5GwvZH2ZQYj9uo0HQ0v+UDYUw/vE/8aQZ5MdEMC
        84131Dug6H0PUwveNWYrrLnuHA==
X-Google-Smtp-Source: AFSGD/VX86b4Tg0CagAJIHZAwHm15gXhdAnszBGxA3VRZ8weipHkom7RxlrXj+La7mK+1a3ZnbwQwA==
X-Received: by 2002:a62:8893:: with SMTP id l141mr15211872pfd.1.1544514524834;
        Mon, 10 Dec 2018 23:48:44 -0800 (PST)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id q25sm16485230pgb.2.2018.12.10.23.48.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 23:48:44 -0800 (PST)
Date:   Tue, 11 Dec 2018 16:51:57 +0900
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     Will Deacon <will.deacon@arm.com>, catalin.marinas@arm.com,
        dhowells@redhat.com, vgoyal@redhat.com,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        dyoung@redhat.com, bhe@redhat.com, arnd@arndb.de,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        prudo@linux.ibm.com, ard.biesheuvel@linaro.org,
        james.morse@arm.com, bhsharma@redhat.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v16 16/16] arm64: kexec_file: add kaslr support
Message-ID: <20181211075155.GG21466@linaro.org>
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
 <20181211055001.GE21466@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181211055001.GE21466@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 02:50:02PM +0900, AKASHI Takahiro wrote:
> On Fri, Nov 30, 2018 at 01:19:44PM +0000, Will Deacon wrote:
> > On Thu, Nov 15, 2018 at 02:52:55PM +0900, AKASHI Takahiro wrote:
> > > Adding "kaslr-seed" to dtb enables triggering kaslr, or kernel virtual
> > > address randomization, at secondary kernel boot. We always do this as
> > > it will have no harm on kaslr-incapable kernel.
> > > 
> > > We don't have any "switch" to turn off this feature directly, but still
> > > can suppress it by passing "nokaslr" as a kernel boot argument.
> > > 
> > > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > Cc: Will Deacon <will.deacon@arm.com>
> > > ---
> > >  arch/arm64/kernel/machine_kexec_file.c | 46 +++++++++++++++++++++++++-
> > >  1 file changed, 45 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
> > > index ab296b98d633..a0a730bd9be6 100644
> > > --- a/arch/arm64/kernel/machine_kexec_file.c
> > > +++ b/arch/arm64/kernel/machine_kexec_file.c
> > > @@ -16,6 +16,7 @@
> > >  #include <linux/libfdt.h>
> > >  #include <linux/memblock.h>
> > >  #include <linux/of_fdt.h>
> > > +#include <linux/random.h>
> > >  #include <linux/slab.h>
> > >  #include <linux/string.h>
> > >  #include <linux/types.h>
> > > @@ -28,6 +29,7 @@
> > >  #define FDT_PSTR_INITRD_STA	"linux,initrd-start"
> > >  #define FDT_PSTR_INITRD_END	"linux,initrd-end"
> > >  #define FDT_PSTR_BOOTARGS	"bootargs"
> > > +#define FDT_PSTR_KASLR_SEED	"kaslr-seed"
> > >  
> > >  const struct kexec_file_ops * const kexec_file_loaders[] = {
> > >  	&kexec_image_ops,
> > > @@ -46,11 +48,38 @@ int arch_kimage_file_post_load_cleanup(struct kimage *image)
> > >  	return kexec_image_post_load_cleanup_default(image);
> > >  }
> > >  
> > > +/* crng needs to have been initialized for providing kaslr-seed */
> > > +static int random_ready;
> > > +
> > > +static void random_ready_notified(struct random_ready_callback *unused)
> > > +{
> > > +	random_ready = 1;
> > > +}
> > > +
> > > +static struct random_ready_callback random_ready_cb = {
> > > +	.func = random_ready_notified,
> > > +};
> > > +
> > > +static __init int init_random_ready_cb(void)
> > > +{
> > > +	int ret;
> > > +
> > > +	ret = add_random_ready_callback(&random_ready_cb);
> > > +	if (ret == -EALREADY)
> > > +		random_ready = 1;
> > > +	else if (ret)
> > > +		pr_warn("failed to add a callback for random_ready\n");
> > > +
> > > +	return 0;
> > > +}
> > > +late_initcall(init_random_ready_cb)
> > 
> > Why can't we just call crng_ready()?
> 
> because crng_ready() is locally defined in drivers/char/random.c.
> Instead, I'd like to use
>         wait_for_random_bytes();
>         value = get_random_u64();

Correction:
After several tests, I now don't think that calling wait_for_random_bytes()
is a good idea since it can make kexec_file_load() syscall stalled.
So, I would go for
        if (rng_is_initialized())
                value = get_random_u64();

-Takahiro Akashi

> > > +
> > >  static int setup_dtb(struct kimage *image,
> > >  		     unsigned long initrd_load_addr, unsigned long initrd_len,
> > >  		     char *cmdline, void *dtb)
> > >  {
> > >  	int nodeoffset;
> > > +	u64 value;
> > >  	int ret;
> > >  
> > >  	nodeoffset = fdt_path_offset(dtb, "/chosen");
> > > @@ -106,12 +135,27 @@ static int setup_dtb(struct kimage *image,
> > >  			return -EINVAL;
> > >  	}
> > >  
> > > +	/* add kaslr-seed */
> > > +	ret = fdt_delprop(dtb, nodeoffset, FDT_PSTR_KASLR_SEED);
> > > +	if (ret && (ret != -FDT_ERR_NOTFOUND))
> > > +		return -EINVAL;
> > > +
> > > +	if (random_ready) {
> > > +		get_random_bytes(&value, sizeof(value));
> > 
> > get_random_u64() ?
> 
> OK.
> 
> > > +		ret = fdt_setprop_u64(dtb, nodeoffset, FDT_PSTR_KASLR_SEED,
> > > +							value);
> > > +		if (ret)
> > > +			return (ret == -FDT_ERR_NOSPACE ? -ENOMEM : -EINVAL);
> > > +	} else {
> > 
> > Wouldn't we be better off preserving the previous seed here, if it was
> > present?
> 
> While there's no guarantee that dtb won't be (partially) broken
> on failure, I will let this function return successfully
> by deleting succeeding fdt_delprop().
> 
> 
> > > +		pr_notice("kaslr-seed won't be fed\n");
> > 
> > "fed" is probably not the right word here.
> 
> => won't be *provided* on kexec?
> 
> -Takahiro Akashi
> 
> > Will
