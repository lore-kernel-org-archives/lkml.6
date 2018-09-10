Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C58AAC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 02:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B6FD20893
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 02:37:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="H4WVNWni"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B6FD20893
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbeIJH3U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 03:29:20 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38906 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbeIJH3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 03:29:20 -0400
Received: by mail-pl1-f195.google.com with SMTP id u11-v6so9008169plq.5
        for <linux-kernel@vger.kernel.org>; Sun, 09 Sep 2018 19:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9Si9Oe38ub8Xry5j1lutubNrUedyVFyTsK7019+QGMM=;
        b=H4WVNWniYLrvRzyCrnskGEZkNxictRye1vYen49FLm4P9KO26cCSxa4w02WZ9aBLeB
         BxuQO1m3gEOVMlPShav7CB/sNMrE436ym6tLONHvSkoz2a/DvZ5/35nk/73Kp5MTvyqm
         izDcWmjNdHarHTcNhS40zQpg74y/VpFM8VIxM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=9Si9Oe38ub8Xry5j1lutubNrUedyVFyTsK7019+QGMM=;
        b=qFBEVIx1zfYKGSCegs7SCyfB92MFMmzDrOavY+etnQILpieeKDuVciYBZZrRUidtnm
         kF6b7P8xiIZbP8JWZ6/g8851+zjlFJJgwRPEm9xz1i8FFreBsi59lFvz/QFJ4gdr2Ocw
         VCZPKaWWIKeSrXyuKUV8dm2lsMXRFfLmKqe20AOmgpyLEWKooE6rPiW7pxR0lV+dv1Ps
         me7Pq9AZK2l394FvMrcbWxXK7R7ELH1NFOrYDq3BnNpfvEWQhTZkNp0h/l7oBkgoaGC5
         XuQ2PG83n8C7qB7Cb0Aw1aNSuSn5lBjhMCYSc8m5KNpsD/MVcX5eC2PLD8TqH6mN2ye7
         JRwg==
X-Gm-Message-State: APzg51D0xMEEWSNUbggg+fZRdqT/NI32Bs8jfG1q82pWfbjp/fr34/2+
        AoxhqaMVslm11jLa7qYcEgdvRA==
X-Google-Smtp-Source: ANB0Vdbx+8ypyVBFjN6D2UbOLEOGl6y4DDYtL/6xuOtu7X3ihwKMkdhUiiVYOgU5e/WlDLbXSpzGLg==
X-Received: by 2002:a17:902:402:: with SMTP id 2-v6mr19341999ple.277.1536547057786;
        Sun, 09 Sep 2018 19:37:37 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id n26-v6sm15995849pgv.78.2018.09.09.19.37.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Sep 2018 19:37:37 -0700 (PDT)
Date:   Mon, 10 Sep 2018 11:38:21 +0900
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, dyoung@redhat.com, bhe@redhat.com,
        arnd@arndb.de, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        prudo@linux.ibm.com, ard.biesheuvel@linaro.org,
        james.morse@arm.com, bhsharma@redhat.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v14 06/16] of/fdt: add helper functions for handling
 properties
Message-ID: <20180910023819.GA30795@linaro.org>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>, catalin.marinas@arm.com,
        will.deacon@arm.com, dhowells@redhat.com, vgoyal@redhat.com,
        herbert@gondor.apana.org.au, davem@davemloft.net, dyoung@redhat.com,
        bhe@redhat.com, arnd@arndb.de, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, prudo@linux.ibm.com,
        ard.biesheuvel@linaro.org, james.morse@arm.com, bhsharma@redhat.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
References: <20180907080040.4967-1-takahiro.akashi@linaro.org>
 <a535515a-92f1-fc33-bdb9-6f5e0392cb11@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a535515a-92f1-fc33-bdb9-6f5e0392cb11@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Frank,

Thank you for the comments. I will address all of them, but
have one question:

On Fri, Sep 07, 2018 at 12:53:58PM -0700, Frank Rowand wrote:
> On 09/07/18 01:00, AKASHI Takahiro wrote:
> > These functions will be used later to handle kexec-specific properties
> > in arm64's kexec_file implementation.
> > 
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Frank Rowand <frowand.list@gmail.com>
> > ---
> >  drivers/of/fdt.c       | 62 ++++++++++++++++++++++++++++++++++++++++--
> >  include/linux/of_fdt.h | 10 +++++--
> >  2 files changed, 68 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> > index 800ad252cf9c..dc960cea1355 100644
> > --- a/drivers/of/fdt.c
> > +++ b/drivers/of/fdt.c
> > @@ -25,6 +25,7 @@
> >  #include <linux/debugfs.h>
> >  #include <linux/serial_core.h>
> >  #include <linux/sysfs.h>
> > +#include <linux/types.h>
> >  
> >  #include <asm/setup.h>  /* for COMMAND_LINE_SIZE */
> >  #include <asm/page.h>
> > @@ -537,8 +538,8 @@ void *of_fdt_unflatten_tree(const unsigned long *blob,
> >  EXPORT_SYMBOL_GPL(of_fdt_unflatten_tree);
> >  
> >  /* Everything below here references initial_boot_params directly. */
> > -int __initdata dt_root_addr_cells;
> > -int __initdata dt_root_size_cells;
> > +int dt_root_addr_cells;
> > +int dt_root_size_cells;
> >  
> >  void *initial_boot_params;
> >  
> > @@ -1323,3 +1324,60 @@ late_initcall(of_fdt_raw_init);
> >  #endif
> >  
> >  #endif /* CONFIG_OF_EARLY_FLATTREE */
> > +
> 
> Please add comment:
> 
> /* helper functions for arm64 kexec */
> 
> 
> > +bool of_fdt_cells_size_fitted(u64 base, u64 size)
> 
> Please rename as of_fdt_range_valid()
> 
> 
> > +{
> > +	/* if *_cells >= 2, cells can hold 64-bit values anyway */
> > +	if ((dt_root_addr_cells == 1) && (base > U32_MAX))
> > +		return false;
> > +
> > +	if ((dt_root_size_cells == 1) && (size > U32_MAX))
> > +		return false;
> 
> Should also check that base + size does not wrap around.

What is the upper limit here?
For instance, #address_cells = <1> and #size_cells = <1>,
and can 'base + size' be over U32_MAX?
Assuming 'not' is quite reasonable, but it seems to me
that devicetree spec doesn't exclude it, as least I couldn't
find any notes about such a case.
(In my understands, #address_cells only restricts a size in 'reg' property.)

Thanks,
-Takahiro Akashi

> 
> > +
> > +	return true;
> > +}
> > +
> > +size_t of_fdt_reg_cells_size(void)
> 
> Please rename as of_fdt_root_range_size()
> 
> 
> > +{
> > +	return (dt_root_addr_cells + dt_root_size_cells) * sizeof(u32);
> > +}
> > +
> > +#define FDT_ALIGN(x, a)	(((x) + (a) - 1) & ~((a) - 1))
> > +#define FDT_TAGALIGN(x)	(FDT_ALIGN((x), FDT_TAGSIZE))
> > +
> > +int fdt_prop_len(const char *prop_name, int len)
> 
> Please rename as fdt_len_added_prop()
> 
> 
> > +{
> > +	return (strlen(prop_name) + 1) +
> > +		sizeof(struct fdt_property) +
> > +		FDT_TAGALIGN(len);
> > +}
> > +
> 
> Please add comment, something like:
> 
> /* cells must be 1 or 2 */
> 
> 
> > +static void fill_property(void *buf, u64 val64, int cells)
> 
> Please rename as cpu64_to_fdt_cells()
> 
> Thanks,
> 
> Frank
> 
> > +{
> > +	__be32 val32;
> > +
> > +	while (cells) {
> > +		val32 = cpu_to_fdt32((val64 >> (32 * (--cells))) & U32_MAX);
> > +		memcpy(buf, &val32, sizeof(val32));
> > +		buf += sizeof(val32);
> > +	}
> > +}
> > +
> > +int fdt_setprop_reg(void *fdt, int nodeoffset, const char *name,
> > +						u64 addr, u64 size)
> > +{
> > +	char buf[sizeof(__be32) * 2 * 2];
> > +		/* assume dt_root_[addr|size]_cells <= 2 */
> > +	void *prop;
> > +	size_t buf_size;
> > +
> > +	buf_size = of_fdt_reg_cells_size();
> > +	prop = buf;
> > +
> > +	fill_property(prop, addr, dt_root_addr_cells);
> > +	prop += dt_root_addr_cells * sizeof(u32);
> > +
> > +	fill_property(prop, size, dt_root_size_cells);
> > +
> > +	return fdt_setprop(fdt, nodeoffset, name, buf, buf_size);
> > +}
> > diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
> > index b9cd9ebdf9b9..9615d6142578 100644
> > --- a/include/linux/of_fdt.h
> > +++ b/include/linux/of_fdt.h
> > @@ -37,8 +37,8 @@ extern void *of_fdt_unflatten_tree(const unsigned long *blob,
> >  				   struct device_node **mynodes);
> >  
> >  /* TBD: Temporary export of fdt globals - remove when code fully merged */
> > -extern int __initdata dt_root_addr_cells;
> > -extern int __initdata dt_root_size_cells;
> > +extern int dt_root_addr_cells;
> > +extern int dt_root_size_cells;
> >  extern void *initial_boot_params;
> >  
> >  extern char __dtb_start[];
> > @@ -108,5 +108,11 @@ static inline void unflatten_device_tree(void) {}
> >  static inline void unflatten_and_copy_device_tree(void) {}
> >  #endif /* CONFIG_OF_EARLY_FLATTREE */
> >  
> > +bool of_fdt_cells_size_fitted(u64 base, u64 size);
> > +size_t of_fdt_reg_cells_size(void);
> > +int fdt_prop_len(const char *prop_name, int len);
> > +int fdt_setprop_reg(void *fdt, int nodeoffset, const char *name,
> > +						u64 addr, u64 size);
> > +
> >  #endif /* __ASSEMBLY__ */
> >  #endif /* _LINUX_OF_FDT_H */
> > 
> 
