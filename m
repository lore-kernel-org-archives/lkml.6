Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E373C65BA7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 13:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C736F208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 13:25:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ktZpWwJ9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C736F208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728797AbeJEUWy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 16:22:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:59838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728764AbeJEUWx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 16:22:53 -0400
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BAC121477;
        Fri,  5 Oct 2018 13:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538745850;
        bh=Eql3v4IORNh6z2CGHUZvvCCBIYV/BOOXmWvpyVfwUeI=;
        h=References:In-Reply-To:From:Date:Subject:To:From;
        b=ktZpWwJ91/5LajAaWLXo+hes9MTl46qMoRFyQARpRI3NV8jNZx4VxDqVVFoYDot2N
         hIfZNjwUBwiae4piGsIsh/WljRjSqx1LAyqvlxPQmaacevavr1AaoveVBYI72YPTZr
         vSbJWBiamd0vpZONKSiVJ0IYZBnSFgMCNOplZlyQ=
Received: by mail-qt1-f179.google.com with SMTP id l9-v6so13712956qtf.5;
        Fri, 05 Oct 2018 06:24:10 -0700 (PDT)
X-Gm-Message-State: ABuFfojM/h8ZQ17nib37jfjEX+9UEkANQL4iSK7IvQ9HmBsnRvOWS8FJ
        gHaClnfhwp1BxcQggmSh0dd/C2/SSoJdHC3EfQ==
X-Google-Smtp-Source: ACcGV63cklQmy1rurYYMaVvCecau0qMiPA/ZzII7nvWqw216p92g90AZUQRnG19epsw58mumGu/2JeK7JpTTeZpIX5A=
X-Received: by 2002:a0c:b5d3:: with SMTP id o19-v6mr9463349qvf.218.1538745849777;
 Fri, 05 Oct 2018 06:24:09 -0700 (PDT)
MIME-Version: 1.0
References: <20180928064841.14117-1-takahiro.akashi@linaro.org>
 <20180928064841.14117-7-takahiro.akashi@linaro.org> <CAL_JsqKwmcdQ+2eK3LGHhcQ2Wb+Yz1-Atz0-3K6WKNZQt_woVw@mail.gmail.com>
 <20181005030849.GK32578@linaro.org>
In-Reply-To: <20181005030849.GK32578@linaro.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 5 Oct 2018 08:23:57 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+wXU8PCyJhaTKE7ezZhiD0KARUFXVzQBk0ZptEEK7ubQ@mail.gmail.com>
Message-ID: <CAL_Jsq+wXU8PCyJhaTKE7ezZhiD0KARUFXVzQBk0ZptEEK7ubQ@mail.gmail.com>
Subject: Re: [PATCH v15 06/16] of/fdt: add helper functions for handling properties
To:     "AKASHI, Takahiro" <takahiro.akashi@linaro.org>,
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
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 4, 2018 at 10:07 PM AKASHI, Takahiro
<takahiro.akashi@linaro.org> wrote:
>
> Rob,
>
> # I haven't replied to this comment yet.
>
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
> >
> > > +}
> > > +
> >
> > The rest of this should go in drivers/of/fdt_address.c. Ultimately, it
> > should go into libfdt, but I'm fine with having it in the kernel for
> > now.
>
> I'd like to have this function in the kernel for now.
>
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
>
> Are you sure?
> I originally implemented this function in a similar way that fdt_pack_reg()
> was, but, you suggested, in your past comment[1], that we'd be better to
> have of_read_number()-like implementation.
>
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2018-May/579118.html

Yeah, you're right. Plus, I'm not sure the u-boot one would work for
unaligned accesses with armv5 and earlier h/w.

My only comment then is I think you can drop the U32_MAX masking.

Rob
