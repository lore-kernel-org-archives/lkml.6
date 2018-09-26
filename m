Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F69C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 05:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3897D20843
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 05:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="e/oe/Mhc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3897D20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbeIZMHL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 08:07:11 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44051 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbeIZMHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 08:07:11 -0400
Received: by mail-pg1-f196.google.com with SMTP id g2-v6so5299120pgu.11
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 22:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oWvLw4yntanBvwTEiCnLxuHGJCiVtTaUvg0kx8+jsFw=;
        b=e/oe/Mhc3PVq8L6QufGO7ZuYz9btYmhzjCCsqbq1YtXKYj1gmAC1YP3jo9CLRpTX5M
         ZuH0zqeJtYDhRZZylcNWZRD+pISltCe2xQsfq1fjR0MUxFyM4QSzxsdfRp6QQ2qfPA82
         SNRJ/Zy/+4NDPbDdmz5KfKId+oeJn5aVw+ObQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=oWvLw4yntanBvwTEiCnLxuHGJCiVtTaUvg0kx8+jsFw=;
        b=gDdsEEjV3rFkjLRwj9BMb8Smdalo8Vq+Rbsb/Z6OXsWB8cOUQU11e+saVDlEJS/+fS
         BnA64SwYT1kLMsZNC0Vg+pY9FDvlw+MwjCWFXRcBLHxpzcdiXPv+D/tWR633bpz4nQP9
         Mqc1C5NvlEJQ2NnifRIvE8xOhO0kYSqQ+jQQ8Zf3aAFxaSuTxFQzhsL7ADSS0M+KdKUI
         OOx/sh0OP7gZtLGGkZOSvL9KKjgGXNXmF6u7SD8hYtFCz6f7TraVgF9Z1mVsxFFSbYAv
         72+E5Hmaj6YB9YvEVMirmQ6EpjTru/5WslFf5H82YRuR2LXHynmxRhR65Bj4tZxFefal
         f+Yg==
X-Gm-Message-State: ABuFfoiOk/kQjjkfnjp4Md/EfQuYlXlHfODa6MoKLiN991ta1XN8/7i4
        WIgmQie5a5Ly6Kn6qEYtPH7JlQ==
X-Google-Smtp-Source: ACcGV62fv0F/AzJjNWHKzoFjYzIafJa2kTMIXdeElzyz9ndNA6+LJiKqtXsTca6ezqfdhesCWGTaSw==
X-Received: by 2002:a63:5726:: with SMTP id l38-v6mr4245338pgb.118.1537941357037;
        Tue, 25 Sep 2018 22:55:57 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id n80-v6sm7147900pfb.95.2018.09.25.22.55.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 22:55:56 -0700 (PDT)
Date:   Wed, 26 Sep 2018 14:57:07 +0900
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
Message-ID: <20180926055704.GC27322@linaro.org>
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
 <8403dfd5-3188-219b-966c-72b009f94e0f@gmail.com>
 <16a39f7f-a8cc-72a1-89a7-e9b49a4d6547@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16a39f7f-a8cc-72a1-89a7-e9b49a4d6547@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Frank,

On Fri, Sep 14, 2018 at 10:19:38AM -0700, Frank Rowand wrote:
> On 09/13/18 18:26, Frank Rowand wrote:
> > I was re-reading this while answering a later email in the thread.  After reading
> > other patches in the series that were not sent to me, I have a better understanding
> > of the intent behind this patch, and some changes to my previous reply.
> > 
> > The intent of the helper functions is related to properties whose values are
> > tuples of the same format as the "reg" property of the "/memory" nodes.  For
> > example, the "linux,usable-memory-range" and "linux,elfcoredhr" properties of
> > the "/chosen" node.
> > 
> > The patch header and the function names should be updated to reflect this intent.
> > This means most or all of my previous suggested function name changes are no longer
> > useful.
> > 
> > Please add devicetree@vger.kernel.org to the next version of this patch and to
> > the patches that use the functions in this patch.
> > 
> > 
> > On 09/07/18 12:53, Frank Rowand wrote:
> >> On 09/07/18 01:00, AKASHI Takahiro wrote:
> >>> These functions will be used later to handle kexec-specific properties
> >>> in arm64's kexec_file implementation.
> >>>
> >>> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> >>> Cc: Rob Herring <robh+dt@kernel.org>
> >>> Cc: Frank Rowand <frowand.list@gmail.com>
> >>> ---
> >>>  drivers/of/fdt.c       | 62 ++++++++++++++++++++++++++++++++++++++++--
> >>>  include/linux/of_fdt.h | 10 +++++--
> >>>  2 files changed, 68 insertions(+), 4 deletions(-)
> >>>
> >>> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> >>> index 800ad252cf9c..dc960cea1355 100644
> >>> --- a/drivers/of/fdt.c
> >>> +++ b/drivers/of/fdt.c
> >>> @@ -25,6 +25,7 @@
> >>>  #include <linux/debugfs.h>
> >>>  #include <linux/serial_core.h>
> >>>  #include <linux/sysfs.h>
> >>> +#include <linux/types.h>
> >>>  
> >>>  #include <asm/setup.h>  /* for COMMAND_LINE_SIZE */
> >>>  #include <asm/page.h>
> >>> @@ -537,8 +538,8 @@ void *of_fdt_unflatten_tree(const unsigned long *blob,
> >>>  EXPORT_SYMBOL_GPL(of_fdt_unflatten_tree);
> >>>  
> >>>  /* Everything below here references initial_boot_params directly. */
> >>> -int __initdata dt_root_addr_cells;
> >>> -int __initdata dt_root_size_cells;
> >>> +int dt_root_addr_cells;
> >>> +int dt_root_size_cells;
> >>>  
> >>>  void *initial_boot_params;
> >>>  
> >>> @@ -1323,3 +1324,60 @@ late_initcall(of_fdt_raw_init);
> >>>  #endif
> >>>  
> >>>  #endif /* CONFIG_OF_EARLY_FLATTREE */
> >>> +
> > 
> > Global comment: this code should not be using the variables
> > dt_root_addr_cells and dt_root_size_cells.  These variables are
> > __initdata.
> > 
> > The code that is using these helpers is acting upon a specific FDT
> > (copied from initial_boot_params).  This code should be getting the
> > values of the root node's "#address-cells" and "#size-cells" from
> > the FDT.
> 
> There will be new functions available soon to return the values of
> a node's "#address-cells" and "#size-cells" from an fdt.  They are
> fdt_address_cells() and fdt_size_cells().
> 
> Rob submitted the patch to add them yesterday in "[PATCH 3/3] scripts/dtc:
> Update to upstream version v1.4.7-14-gc86da84d30e4" [1]

Will this patch go into mainline in v4.20 merge window?

>   [1] https://lkml.kernel.org/r/<20180913202828.15372-3-robh@kernel.org>

Unfortunately, fdt_addresses.c where fdt_address_cells() and
fdt_size_cells() are defined is NOT compiled in the kernel.
I will submit a patch.

-Takahiro Akashi


> -Frank
> 
> 
> > 
> > 
> >> Please add comment:
> >>
> >> /* helper functions for arm64 kexec */
> >>
> >>
> >>> +bool of_fdt_cells_size_fitted(u64 base, u64 size)
> >>
> >> Please rename as of_fdt_range_valid()
> > 
> > I'm not entirely sure of what the caller in 12/16 is trying to ensure
> > with this function.
> > 
> > (1) At the minimum (and what the implementation in of_fdt_cells_size_fitted()
> > does) is make sure that an address and size tuple are consistent with
> > the root properties "#address-cells" and "#size-cells".
> > 
> > The caller in 12/16 is using this check to validate values for the
> > properties  "linux,elfcorehdr" and "linux,usable-memory-range".
> > 
> > (2) A more complete check _might_ be to ensure that the values also
> > specify memory that is available to the kernel.  This memory is described
> > by the "reg" property of one or more "/memory" nodes.
> > 
> > This second check is probably what is actually desired.
> > 
> > One possible issue to note is that the binding for "linux,usable-memory-range"
> > suggests that available memory could be described by an EFI memory map.
> > I am not familiar with how or when an EFI memory map might exist instead
> > of the "/memory" nodes.
> > 
> > 
> >>> +{
> >>> +	/* if *_cells >= 2, cells can hold 64-bit values anyway */
> >>> +	if ((dt_root_addr_cells == 1) && (base > U32_MAX))
> >>> +		return false;
> >>> +
> >>> +	if ((dt_root_size_cells == 1) && (size > U32_MAX))
> >>> +		return false;
> >>
> >> Should also check that base + size does not wrap around.
> >>
> >>
> >>> +
> >>> +	return true;
> >>> +}
> >>> +
> >>> +size_t of_fdt_reg_cells_size(void)
> >>
> >> Please rename as of_fdt_root_range_size()
> > 
> > Even better would be to remove this function and replace the one place
> > that it is called from with the one line of code in this function.
> > 
> > -Frank
> > 
> > 
> >>> +{
> >>> +	return (dt_root_addr_cells + dt_root_size_cells) * sizeof(u32);
> >>> +}
> >>> +
> >>> +#define FDT_ALIGN(x, a)	(((x) + (a) - 1) & ~((a) - 1))
> >>> +#define FDT_TAGALIGN(x)	(FDT_ALIGN((x), FDT_TAGSIZE))
> >>> +
> >>> +int fdt_prop_len(const char *prop_name, int len)
> >>
> >> Please rename as fdt_len_added_prop()
> >>
> >>
> >>> +{
> >>> +	return (strlen(prop_name) + 1) +
> >>> +		sizeof(struct fdt_property) +
> >>> +		FDT_TAGALIGN(len);
> >>> +}
> >>> +
> >>
> >> Please add comment, something like:
> >>
> >> /* cells must be 1 or 2 */
> >>
> >>
> >>> +static void fill_property(void *buf, u64 val64, int cells)
> >>
> >> Please rename as cpu64_to_fdt_cells()
> >>
> >> Thanks,
> >>
> >> Frank
> >>
> >>> +{
> >>> +	__be32 val32;
> >>> +
> >>> +	while (cells) {
> >>> +		val32 = cpu_to_fdt32((val64 >> (32 * (--cells))) & U32_MAX);
> >>> +		memcpy(buf, &val32, sizeof(val32));
> >>> +		buf += sizeof(val32);
> >>> +	}
> >>> +}
> >>> +
> >>> +int fdt_setprop_reg(void *fdt, int nodeoffset, const char *name,
> >>> +						u64 addr, u64 size)
> >>> +{
> >>> +	char buf[sizeof(__be32) * 2 * 2];
> >>> +		/* assume dt_root_[addr|size]_cells <= 2 */
> >>> +	void *prop;
> >>> +	size_t buf_size;
> >>> +
> >>> +	buf_size = of_fdt_reg_cells_size();
> >>> +	prop = buf;
> >>> +
> >>> +	fill_property(prop, addr, dt_root_addr_cells);
> >>> +	prop += dt_root_addr_cells * sizeof(u32);
> >>> +
> >>> +	fill_property(prop, size, dt_root_size_cells);
> >>> +
> >>> +	return fdt_setprop(fdt, nodeoffset, name, buf, buf_size);
> >>> +}
> >>> diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
> >>> index b9cd9ebdf9b9..9615d6142578 100644
> >>> --- a/include/linux/of_fdt.h
> >>> +++ b/include/linux/of_fdt.h
> >>> @@ -37,8 +37,8 @@ extern void *of_fdt_unflatten_tree(const unsigned long *blob,
> >>>  				   struct device_node **mynodes);
> >>>  
> >>>  /* TBD: Temporary export of fdt globals - remove when code fully merged */
> >>> -extern int __initdata dt_root_addr_cells;
> >>> -extern int __initdata dt_root_size_cells;
> >>> +extern int dt_root_addr_cells;
> >>> +extern int dt_root_size_cells;
> >>>  extern void *initial_boot_params;
> >>>  
> >>>  extern char __dtb_start[];
> >>> @@ -108,5 +108,11 @@ static inline void unflatten_device_tree(void) {}
> >>>  static inline void unflatten_and_copy_device_tree(void) {}
> >>>  #endif /* CONFIG_OF_EARLY_FLATTREE */
> >>>  
> >>> +bool of_fdt_cells_size_fitted(u64 base, u64 size);
> >>> +size_t of_fdt_reg_cells_size(void);
> >>> +int fdt_prop_len(const char *prop_name, int len);
> >>> +int fdt_setprop_reg(void *fdt, int nodeoffset, const char *name,
> >>> +						u64 addr, u64 size);
> >>> +
> >>>  #endif /* __ASSEMBLY__ */
> >>>  #endif /* _LINUX_OF_FDT_H */
> >>>
> >>
> >>
> > 
> > 
> 
