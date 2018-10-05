Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4319DC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 05:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D973320875
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 05:04:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="J4tt0XPQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D973320875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbeJEMB6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 08:01:58 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40377 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbeJEMB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 08:01:58 -0400
Received: by mail-pl1-f196.google.com with SMTP id 1-v6so6247217plv.7
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 22:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vVlsO9I/ACXZynLrNlLE3DGRmR4Z34tez286koyf88k=;
        b=J4tt0XPQCLyzPlr7B3bpCBUsI9MwJ0PhPg6Y7mokubNRfMKw5gy/YNxBiCms24PwXG
         zi5lAEgoIk7K2syEflZ2nQUZygYt/BmZ5ZgaZbfgFzq/wYQ0bKtgYNN3Fu0MM7+pHGUg
         7HqtPGE2HZFPk7EGpzNzrM17/Xl6Epj5h64/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=vVlsO9I/ACXZynLrNlLE3DGRmR4Z34tez286koyf88k=;
        b=egPyPiTX70QcohtIFgnby8vcbdeB9wn2JzevPBp1DvqY93CkSy0p5D+ln5nrWo5+8a
         8jsuphmBhq4jG1MmuAQBJkispjMyvqo//qJkLEgbPNIyc1+beghxgSmDktnu5uh/tIQZ
         FB9aWu5ktdDQ8C/jApyPhBa8D6zjwkpdbbQthIwiiMROBVWCilZ3Yr2iNn4Pm/QUm1UV
         GlDh70bYctV9OV8ye6i8nG36gGZJ3eKJ2B2Uc2N5YRy8QlToIrTzZ53pYSSIHAwiUGuA
         XQHMq5I31I+b4ZBmLG6XW8UPl8ZvdeZxLT/g4JZD+tEzUP1gvqmvR2LG3BpQjGRXcP9v
         WV9w==
X-Gm-Message-State: ABuFfohu5Ol9aqQKA5kupbN42QJ2oKT0NX6OQMrW9sFZ2O2uaLO0hTY4
        OzPn1bxoDcIf3FRc1IaBzzykVg==
X-Google-Smtp-Source: ACcGV63TkrENe/bjIJJ7NHBGoht6DwJg5zAu7C6bYwxJug7/XGt8KqgZCUB5b9mvBJEaVaiXlA/FMg==
X-Received: by 2002:a17:902:29e3:: with SMTP id h90-v6mr9810188plb.215.1538715897143;
        Thu, 04 Oct 2018 22:04:57 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id c21-v6sm11567882pfe.93.2018.10.04.22.04.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Oct 2018 22:04:56 -0700 (PDT)
Date:   Fri, 5 Oct 2018 14:06:29 +0900
From:   "AKASHI, Takahiro" <takahiro.akashi@linaro.org>
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        David Gibson <david@gibson.dropbear.id.au>,
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
        devicetree@vger.kernel.org
Subject: Re: [PATCH v15 06/16] of/fdt: add helper functions for handling
 properties
Message-ID: <20181005050627.GL32578@linaro.org>
Mail-Followup-To: "AKASHI, Takahiro" <takahiro.akashi@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        David Gibson <david@gibson.dropbear.id.au>,
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
        devicetree@vger.kernel.org
References: <20180928064841.14117-1-takahiro.akashi@linaro.org>
 <20180928064841.14117-7-takahiro.akashi@linaro.org>
 <CAL_JsqKwmcdQ+2eK3LGHhcQ2Wb+Yz1-Atz0-3K6WKNZQt_woVw@mail.gmail.com>
 <6a8d3ddb-c3bc-c044-4d6c-55e110d89e72@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a8d3ddb-c3bc-c044-4d6c-55e110d89e72@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Frank,

# I haven't reply to your comments.

On Fri, Sep 28, 2018 at 02:13:58PM -0700, Frank Rowand wrote:
> On 09/28/18 06:44, Rob Herring wrote:
> > +David Gibson
> > 
> > On Fri, Sep 28, 2018 at 1:48 AM AKASHI Takahiro
> > <takahiro.akashi@linaro.org> wrote:
> >>
> >> These functions will be used later to handle kexec-specific properties
> >> in arm64's kexec_file implementation.
> 
> As I requested in version 14:
> 
>   The intent of the helper functions is related to properties whose values are
>    tuples of the same format as the "reg" property of the "/memory" nodes.  For
>    example, the "linux,usable-memory-range" and "linux,elfcoredhr" properties of
>    the "/chosen" node.
> 
>    The patch header and the function names should be updated to reflect this intent.

I agree regarding the patch header.

> 
> >>
> >> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> >> Cc: Rob Herring <robh+dt@kernel.org>
> >> Cc: Frank Rowand <frowand.list@gmail.com>
> >> Cc: devicetree@vger.kernel.org
> >> ---
> 
> Missing list of changes since version 14.

Sorry for the inconvenience, but a whole change list goes into
the cover letter, not individual patches.

> 
> >>  drivers/of/fdt.c       | 56 ++++++++++++++++++++++++++++++++++++++++++
> >>  include/linux/of_fdt.h |  4 +++
> >>  2 files changed, 60 insertions(+)
> >>
> >> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> >> index 800ad252cf9c..c65c31562ccb 100644
> >> --- a/drivers/of/fdt.c
> >> +++ b/drivers/of/fdt.c
> >> @@ -25,6 +25,7 @@
> >>  #include <linux/debugfs.h>
> >>  #include <linux/serial_core.h>
> >>  #include <linux/sysfs.h>
> >> +#include <linux/types.h>
> >>
> >>  #include <asm/setup.h>  /* for COMMAND_LINE_SIZE */
> >>  #include <asm/page.h>
> >> @@ -1323,3 +1324,58 @@ late_initcall(of_fdt_raw_init);
> >>  #endif
> >>
> >>  #endif /* CONFIG_OF_EARLY_FLATTREE */
> 
> In v14 I requested:
> 
>    Please add comment:
> 
>    /* helper functions for arm64 kexec */

Okay.

> 
> >> +
> >> +#define FDT_ALIGN(x, a)        (((x) + (a) - 1) & ~((a) - 1))
> >> +#define FDT_TAGALIGN(x)        (FDT_ALIGN((x), FDT_TAGSIZE))
> >> +
> >> +int fdt_prop_len(const char *prop_name, int len)
> 
> In v14, I requested:
> 
>    Please rename as fdt_len_added_prop()

Anyhow, I will drop this function, preferring to new
fdt_[address|size]_cells().

> I'm not really happy with my suggested name, but do not have a
> better one yet.  As Rob notes, maybe David G will have a helpful
> comment.
> 
> >> +{
> >> +       return (strlen(prop_name) + 1) +
> >> +               sizeof(struct fdt_property) +
> >> +               FDT_TAGALIGN(len);
> > 
> > Looks like you are using this to calculate how much space you need to
> > allocate in addition to the current DTB for a couple of new or
> > replaced properties. I'm not sure that this calculation is completely
> > accurate. And it is strange there doesn't seem to be any libfdt
> > function for this already. It would be simpler to just add some fixed
> > additional amount.
> > 
> > Maybe David G has comments on this?

I'm not quit sure why it's not that accurate, but as I said in a reply to
David's comment, I will take your suggestion.

> >> +}
> >> +
> > 
> > The rest of this should go in drivers/of/fdt_address.c. Ultimately, it
> > should go into libfdt, but I'm fine with having it in the kernel for
> > now.
> > 
> >> +static void fill_property(void *buf, u64 val64, int cells)
> 
> In v14 I requested:
> 
> Please rename as cpu64_to_fdt_cells()

I don't mind, but this function may be dropped if Rob sticks to
u-boot's fdt_pack_reg() over my fdt_setprop_reg().

> 
> >> +{
> >> +       __be32 val32;
> >> +
> >> +       while (cells) {
> >> +               val32 = cpu_to_fdt32((val64 >> (32 * (--cells))) & U32_MAX);
> >> +               memcpy(buf, &val32, sizeof(val32));
> >> +               buf += sizeof(val32);
> > 
> > This is kind of hard to read. I would copy u-boot's fdt_pack_reg function.
> > 
> > BTW, for purposes of moving to libfdt, we'll need the authors'
> > (Masahiro Yamada and Hans de Goede) permission to dual license.
> > 
> >> +       }
> >> +}
> >> +
> >> +int fdt_setprop_reg(void *fdt, int nodeoffset, const char *name,
> >> +                                               u64 addr, u64 size)
> >> +{
> >> +       int addr_cells, size_cells;
> 
> unsigned

fdt_[address|size]_cell() returns an int.

> 
> >> +       char buf[sizeof(__be32) * 2 * 2];
> >> +               /* assume dt_root_[addr|size]_cells <= 2 */
> >> +       void *prop;
> >> +       size_t buf_size;
> >> +
> >> +       addr_cells = fdt_address_cells(fdt, 0);
> >> +       if (addr_cells < 0)
> >> +               return addr_cells;
> >> +       size_cells = fdt_size_cells(fdt, 0);
> >> +       if (size_cells < 0)
> >> +               return size_cells;
> >> +
> >> +       /* if *_cells >= 2, cells can hold 64-bit values anyway */
> >> +       if ((addr_cells == 1) && (addr > U32_MAX))
> >> +               return -FDT_ERR_BADVALUE;
> >> +
> >> +       if ((size_cells == 1) && (size > U32_MAX))
> >> +               return -FDT_ERR_BADVALUE;
> 
> In v14 I requested:
> 
>    Should also check that base + size does not wrap around.

Okay, I will start discussion, as you have suggested, in devicetree-spec ML.

Thanks,
-Takahiro Akashi

> 
> >> +
> >> +       buf_size = (addr_cells + size_cells) * sizeof(u32);
> >> +       prop = buf;
> >> +
> >> +       fill_property(prop, addr, addr_cells);
> >> +       prop += addr_cells * sizeof(u32);
> >> +
> >> +       fill_property(prop, size, size_cells);
> >> +
> >> +       return fdt_setprop(fdt, nodeoffset, name, buf, buf_size);
> >> +}
> >> diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
> >> index b9cd9ebdf9b9..842af6ea92ea 100644
> >> --- a/include/linux/of_fdt.h
> >> +++ b/include/linux/of_fdt.h
> >> @@ -108,5 +108,9 @@ static inline void unflatten_device_tree(void) {}
> >>  static inline void unflatten_and_copy_device_tree(void) {}
> >>  #endif /* CONFIG_OF_EARLY_FLATTREE */
> >>
> >> +int fdt_prop_len(const char *prop_name, int len);
> >> +int fdt_setprop_reg(void *fdt, int nodeoffset, const char *name,
> >> +                                               u64 addr, u64 size);
> >> +
> >>  #endif /* __ASSEMBLY__ */
> >>  #endif /* _LINUX_OF_FDT_H */
> >> --
> >> 2.19.0
> >>
> > 
> 
