Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18C94C67879
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 00:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1BB72145D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 00:36:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hBXPEZY7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1BB72145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbeJIHuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 03:50:17 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44687 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbeJIHuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 03:50:17 -0400
Received: by mail-pl1-f196.google.com with SMTP id p25-v6so10790267pli.11
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 17:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HePli8mKtdKbl3iIvUw8Wyge320kjCtZSB60kSgy08A=;
        b=hBXPEZY79NFf/JzEHo1u5gYIiL5wSszf9SKpDFr4S023sBiY3cLjg16RNyFnaxDnOe
         R3rCuLkmQBqm/ezByeLmuyno9hiNW0uvxJ3dCCI+0ryd3ZNEI5ZVudzKHsV2KcP+MYhx
         jj8/699LeZN4o8gM2UUEbjIiGK5U6pmq59M8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=HePli8mKtdKbl3iIvUw8Wyge320kjCtZSB60kSgy08A=;
        b=gaDBrANl+9xOyFMfb2Wzyt0ZgfRbg5HYECiav80HXAgdJfPQdTIfrEJd5GsOk159xr
         egu+Cln1Vyqs4CyZu02wcY108lJlGUPivqktQMIMMd5uQvpOJTcAC8Bt+O+m+EwlsPtY
         /yRWKTyLffMgm9OrPqP602yYkXesA5nqvzWNQWHVIalcq5eNJCYbp6llR1VcY3bZAsXO
         51ys6Y1ACK+68Zp+sDSM8nIYwqMkdlrPasSjZTXLHZcA7fFNnyW8ulWpNKgWnrZZQsDo
         /8z9S2SMY++D1zgOPQKm2LPwpojbZ0b1fzjIQG4Clf8oBz9ZmIR8JA5srDakIfir/wfu
         sdWA==
X-Gm-Message-State: ABuFfojv9zFtzoTd6zwpKRBp3vfzE5UKKeEZc6mbHFV1QL65E3eqjAE/
        Umiu+/s62fev0pKVFU7QCOaVsw==
X-Google-Smtp-Source: ACcGV61gebzGGVQcfkXflLpFg/ZJcnU3DYf+Mx9TesUPmKvwPITQOuVsEDNXUf5ens6DJ6bQD4KpYQ==
X-Received: by 2002:a17:902:bcc3:: with SMTP id o3-v6mr26781108pls.202.1539045358033;
        Mon, 08 Oct 2018 17:35:58 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id z26-v6sm14091043pfh.77.2018.10.08.17.35.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Oct 2018 17:35:57 -0700 (PDT)
Date:   Tue, 9 Oct 2018 09:37:37 +0900
From:   "AKASHI, Takahiro" <takahiro.akashi@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     David Gibson <david@gibson.dropbear.id.au>,
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
Message-ID: <20181009003733.GN32578@linaro.org>
Mail-Followup-To: "AKASHI, Takahiro" <takahiro.akashi@linaro.org>,
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
        Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org
References: <20180928064841.14117-1-takahiro.akashi@linaro.org>
 <20180928064841.14117-7-takahiro.akashi@linaro.org>
 <CAL_JsqKwmcdQ+2eK3LGHhcQ2Wb+Yz1-Atz0-3K6WKNZQt_woVw@mail.gmail.com>
 <20181005030849.GK32578@linaro.org>
 <CAL_Jsq+wXU8PCyJhaTKE7ezZhiD0KARUFXVzQBk0ZptEEK7ubQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+wXU8PCyJhaTKE7ezZhiD0KARUFXVzQBk0ZptEEK7ubQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 05, 2018 at 08:23:57AM -0500, Rob Herring wrote:
> On Thu, Oct 4, 2018 at 10:07 PM AKASHI, Takahiro
> <takahiro.akashi@linaro.org> wrote:
> >
> > Rob,
> >
> > # I haven't replied to this comment yet.
> >
> > On Fri, Sep 28, 2018 at 08:44:42AM -0500, Rob Herring wrote:
> > > +David Gibson
> > >
> > > On Fri, Sep 28, 2018 at 1:48 AM AKASHI Takahiro
> > > <takahiro.akashi@linaro.org> wrote:
> > > >
> > > > These functions will be used later to handle kexec-specific properties
> > > > in arm64's kexec_file implementation.
> > > >
> > > > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > > > Cc: Rob Herring <robh+dt@kernel.org>
> > > > Cc: Frank Rowand <frowand.list@gmail.com>
> > > > Cc: devicetree@vger.kernel.org
> > > > ---
> > > >  drivers/of/fdt.c       | 56 ++++++++++++++++++++++++++++++++++++++++++
> > > >  include/linux/of_fdt.h |  4 +++
> > > >  2 files changed, 60 insertions(+)
> > > >
> > > > diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> > > > index 800ad252cf9c..c65c31562ccb 100644
> > > > --- a/drivers/of/fdt.c
> > > > +++ b/drivers/of/fdt.c
> > > > @@ -25,6 +25,7 @@
> > > >  #include <linux/debugfs.h>
> > > >  #include <linux/serial_core.h>
> > > >  #include <linux/sysfs.h>
> > > > +#include <linux/types.h>
> > > >
> > > >  #include <asm/setup.h>  /* for COMMAND_LINE_SIZE */
> > > >  #include <asm/page.h>
> > > > @@ -1323,3 +1324,58 @@ late_initcall(of_fdt_raw_init);
> > > >  #endif
> > > >
> > > >  #endif /* CONFIG_OF_EARLY_FLATTREE */
> > > > +
> > > > +#define FDT_ALIGN(x, a)        (((x) + (a) - 1) & ~((a) - 1))
> > > > +#define FDT_TAGALIGN(x)        (FDT_ALIGN((x), FDT_TAGSIZE))
> > > > +
> > > > +int fdt_prop_len(const char *prop_name, int len)
> > > > +{
> > > > +       return (strlen(prop_name) + 1) +
> > > > +               sizeof(struct fdt_property) +
> > > > +               FDT_TAGALIGN(len);
> > >
> > > Looks like you are using this to calculate how much space you need to
> > > allocate in addition to the current DTB for a couple of new or
> > > replaced properties. I'm not sure that this calculation is completely
> > > accurate. And it is strange there doesn't seem to be any libfdt
> > > function for this already. It would be simpler to just add some fixed
> > > additional amount.
> > >
> > > Maybe David G has comments on this?
> > >
> > > > +}
> > > > +
> > >
> > > The rest of this should go in drivers/of/fdt_address.c. Ultimately, it
> > > should go into libfdt, but I'm fine with having it in the kernel for
> > > now.
> >
> > I'd like to have this function in the kernel for now.
> >
> > > > +static void fill_property(void *buf, u64 val64, int cells)
> > > > +{
> > > > +       __be32 val32;
> > > > +
> > > > +       while (cells) {
> > > > +               val32 = cpu_to_fdt32((val64 >> (32 * (--cells))) & U32_MAX);
> > > > +               memcpy(buf, &val32, sizeof(val32));
> > > > +               buf += sizeof(val32);
> > >
> > > This is kind of hard to read. I would copy u-boot's fdt_pack_reg function.
> >
> > Are you sure?
> > I originally implemented this function in a similar way that fdt_pack_reg()
> > was, but, you suggested, in your past comment[1], that we'd be better to
> > have of_read_number()-like implementation.
> >
> > [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2018-May/579118.html
> 
> Yeah, you're right. Plus, I'm not sure the u-boot one would work for
> unaligned accesses with armv5 and earlier h/w.
> 
> My only comment then is I think you can drop the U32_MAX masking.

Okay, then I will leave this function, yet renaming it to
cpu64_to_fdt_cells() after Frank's comment.

Thanks,
-Takahiro Akashi
> 
> Rob
