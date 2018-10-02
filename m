Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 517D2C004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 09:03:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3E3F20878
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 09:03:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PYZl6qkf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3E3F20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbeJBPp2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 11:45:28 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42242 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbeJBPp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 11:45:28 -0400
Received: by mail-pl1-f193.google.com with SMTP id c8-v6so669797plo.9
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 02:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jhRth2zriuuqvJAv2fDFsUEb0CAiwLAS3hhHepahHtc=;
        b=PYZl6qkfvisyyLDNWoGBhRPpWxFDfL/ZSyzkSuc2xWJeyXlg4bVcMtIZ2RTQfYDoZe
         S7Wvu3IyiJJDef7vr3tnl8mk3wBqtOYeitoVnBgvaxsVl9XZ7IUdqqxz1yoUfC2+p89J
         9Bl+T3imF8JQmaCVsMO2Yi3uEvCT5VGR0KAs0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=jhRth2zriuuqvJAv2fDFsUEb0CAiwLAS3hhHepahHtc=;
        b=cwpAt6zquiVMQO234Fg8NOy3COi8aYAJG4sGaA6KzFkPHkH10qA15jEYoUuuM8s/se
         7utssllWRtD4CkSWo4fOv6KgEdEmRNLif4DjqWp+I2mSTDDu1zuaOu/hr0KjnUx4fdFy
         A2uMp/g7mWyVVImmwz+8ipd/qJ7dE6T1VnMbFygr0jw7JTnakSmXFlm+/lHbYphegV4F
         cxbX4mlVFMfFloqWpLAN8VExNLfy3sFLs269UTCx9HxChP8AHT9A8zsQN6rJJDKvzUW9
         YTquIkGIoS4+sGfEWtS18hN32NOETH4qc7kJbVu+FdKPPg4eTd4yVeBqUxxGJjqCVRhB
         hfrg==
X-Gm-Message-State: ABuFfoh1TYsrwYD3Nu7ct4Ye7UMq43xkzYaisESbpTAtJAG5+soFIu/P
        QYNrK4fZ+uUNMZpHJkzUeex9oQ==
X-Google-Smtp-Source: ACcGV62PMmOfn/RSv89d4fC34IWZBIwyA8upHqu2+Uu8hQ63SYDErSCryM6W+Ry+x4invRapk+enag==
X-Received: by 2002:a17:902:286a:: with SMTP id e97-v6mr15885558plb.340.1538470994414;
        Tue, 02 Oct 2018 02:03:14 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id y1-v6sm23019752pfy.89.2018.10.02.02.03.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 02:03:13 -0700 (PDT)
Date:   Tue, 2 Oct 2018 18:04:40 +0900
From:   "AKASHI, Takahiro" <takahiro.akashi@linaro.org>
To:     David Gibson <david@gibson.dropbear.id.au>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        David Howells <dhowells@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>, dyoung@redhat.com,
        Baoquan He <bhe@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        prudo@linux.ibm.com, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        James Morse <james.morse@arm.com>, bhsharma@redhat.com,
        kexec@lists.infradead.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v15 06/16] of/fdt: add helper functions for handling
 properties
Message-ID: <20181002090438.GH32578@linaro.org>
Mail-Followup-To: "AKASHI, Takahiro" <takahiro.akashi@linaro.org>,
        David Gibson <david@gibson.dropbear.id.au>,
        Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        David Howells <dhowells@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>, dyoung@redhat.com,
        Baoquan He <bhe@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>, prudo@linux.ibm.com,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        James Morse <james.morse@arm.com>, bhsharma@redhat.com,
        kexec@lists.infradead.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org
References: <20180928064841.14117-1-takahiro.akashi@linaro.org>
 <20180928064841.14117-7-takahiro.akashi@linaro.org>
 <CAL_JsqKwmcdQ+2eK3LGHhcQ2Wb+Yz1-Atz0-3K6WKNZQt_woVw@mail.gmail.com>
 <20181002044710.GD1886@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181002044710.GD1886@umbus.fritz.box>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 02, 2018 at 02:47:10PM +1000, David Gibson wrote:
> On Fri, Sep 28, 2018 at 08:44:42AM -0500, Rob Herring wrote:
> > +David Gibson
> > 
> > On Fri, Sep 28, 2018 at 1:48 AM AKASHI Takahiro
> > <takahiro.akashi@linaro.org> wrote:
> > >
> > > These functions will be used later to handle kexec-specific properties
> > > in arm64's kexec_file implementation.
> > >
> > > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > > Cc: Rob Herring <robh+dt@kernel.org>
> > > Cc: Frank Rowand <frowand.list@gmail.com>
> > > Cc: devicetree@vger.kernel.org
> > > ---
> > >  drivers/of/fdt.c       | 56 ++++++++++++++++++++++++++++++++++++++++++
> > >  include/linux/of_fdt.h |  4 +++
> > >  2 files changed, 60 insertions(+)
> > >
> > > diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> > > index 800ad252cf9c..c65c31562ccb 100644
> > > --- a/drivers/of/fdt.c
> > > +++ b/drivers/of/fdt.c
> > > @@ -25,6 +25,7 @@
> > >  #include <linux/debugfs.h>
> > >  #include <linux/serial_core.h>
> > >  #include <linux/sysfs.h>
> > > +#include <linux/types.h>
> > >
> > >  #include <asm/setup.h>  /* for COMMAND_LINE_SIZE */
> > >  #include <asm/page.h>
> > > @@ -1323,3 +1324,58 @@ late_initcall(of_fdt_raw_init);
> > >  #endif
> > >
> > >  #endif /* CONFIG_OF_EARLY_FLATTREE */
> > > +
> > > +#define FDT_ALIGN(x, a)        (((x) + (a) - 1) & ~((a) - 1))
> > > +#define FDT_TAGALIGN(x)        (FDT_ALIGN((x), FDT_TAGSIZE))
> > > +
> > > +int fdt_prop_len(const char *prop_name, int len)
> > > +{
> > > +       return (strlen(prop_name) + 1) +
> > > +               sizeof(struct fdt_property) +
> > > +               FDT_TAGALIGN(len);
> > 
> > Looks like you are using this to calculate how much space you need to
> > allocate in addition to the current DTB for a couple of new or
> > replaced properties. I'm not sure that this calculation is completely
> > accurate. And it is strange there doesn't seem to be any libfdt
> > function for this already. It would be simpler to just add some fixed
> > additional amount.
> > 
> > Maybe David G has comments on this?
> 
> Hrm.  Yeah, the approach I'd suggest would be to just add a fixed
> amount, and if your functions return -FDT_ERR_NOSPACE, add some more.
> That's pretty much the expected way of working with fdts in write
> mode.

I will try to follow this approach.

Thanks,
-Takahiro Akashi

> If that's really not suitable, we could look at adding a helper to
> estimate this in libfdt.  Or, actually, I suspect taking an existing
> libfdt internal helper, polishing and exporting it.
> 
> > 
> > > +}
> > > +
> > 
> > The rest of this should go in drivers/of/fdt_address.c. Ultimately, it
> > should go into libfdt, but I'm fine with having it in the kernel for
> > now.
> > 
> > > +static void fill_property(void *buf, u64 val64, int cells)
> > > +{
> > > +       __be32 val32;
> > > +
> > > +       while (cells) {
> > > +               val32 = cpu_to_fdt32((val64 >> (32 * (--cells))) & U32_MAX);
> > > +               memcpy(buf, &val32, sizeof(val32));
> > > +               buf += sizeof(val32);
> > 
> > This is kind of hard to read. I would copy u-boot's fdt_pack_reg function.
> > 
> > BTW, for purposes of moving to libfdt, we'll need the authors'
> > (Masahiro Yamada and Hans de Goede) permission to dual license.
> > 
> > > +       }
> > > +}
> > > +
> > > +int fdt_setprop_reg(void *fdt, int nodeoffset, const char *name,
> > > +                                               u64 addr, u64 size)
> > > +{
> > > +       int addr_cells, size_cells;
> > > +       char buf[sizeof(__be32) * 2 * 2];
> > > +               /* assume dt_root_[addr|size]_cells <= 2 */
> > > +       void *prop;
> > > +       size_t buf_size;
> > > +
> > > +       addr_cells = fdt_address_cells(fdt, 0);
> > > +       if (addr_cells < 0)
> > > +               return addr_cells;
> > > +       size_cells = fdt_size_cells(fdt, 0);
> > > +       if (size_cells < 0)
> > > +               return size_cells;
> > > +
> > > +       /* if *_cells >= 2, cells can hold 64-bit values anyway */
> > > +       if ((addr_cells == 1) && (addr > U32_MAX))
> > > +               return -FDT_ERR_BADVALUE;
> > > +
> > > +       if ((size_cells == 1) && (size > U32_MAX))
> > > +               return -FDT_ERR_BADVALUE;
> > > +
> > > +       buf_size = (addr_cells + size_cells) * sizeof(u32);
> > > +       prop = buf;
> > > +
> > > +       fill_property(prop, addr, addr_cells);
> > > +       prop += addr_cells * sizeof(u32);
> > > +
> > > +       fill_property(prop, size, size_cells);
> > > +
> > > +       return fdt_setprop(fdt, nodeoffset, name, buf, buf_size);
> > > +}
> > > diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
> > > index b9cd9ebdf9b9..842af6ea92ea 100644
> > > --- a/include/linux/of_fdt.h
> > > +++ b/include/linux/of_fdt.h
> > > @@ -108,5 +108,9 @@ static inline void unflatten_device_tree(void) {}
> > >  static inline void unflatten_and_copy_device_tree(void) {}
> > >  #endif /* CONFIG_OF_EARLY_FLATTREE */
> > >
> > > +int fdt_prop_len(const char *prop_name, int len);
> > > +int fdt_setprop_reg(void *fdt, int nodeoffset, const char *name,
> > > +                                               u64 addr, u64 size);
> > > +
> > >  #endif /* __ASSEMBLY__ */
> > >  #endif /* _LINUX_OF_FDT_H */
> > >
> > 
> 
> -- 
> David Gibson			| I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
> 				| _way_ _around_!
> http://www.ozlabs.org/~dgibson


