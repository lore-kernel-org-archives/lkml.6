Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E222AC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 09:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 968742145D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 09:48:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jNd9/tQE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 968742145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbeK3U5j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 15:57:39 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36742 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbeK3U5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 15:57:39 -0500
Received: by mail-wm1-f67.google.com with SMTP id a18so5047585wmj.1;
        Fri, 30 Nov 2018 01:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vJr0/ONtK8hIoVtLwcArO0IDujgifRzV5TTKMGnZyzw=;
        b=jNd9/tQEBmzfJG20Fhz2P45javWa3I/c/FeSR6HmBvEMfUoGeg2FF/cpyOvQYddAWX
         Uv6gcrhsAWn/fLRLxQFHL+0FccReddJGke0nm3mVLsdhG6NJqMA7TsaABNLeLlRUYutx
         lWbPQ01Y2UklhCSX968OWJL3JD/pYh/vWvUlZj3yUmxph9K57IGFHHxlTOmaGgL9U2Ph
         wzcy9rDvrjLDAV9NlxT5+6hWOZ7JrbbPG5b5k/++Wmh3VMnAbOkeAGhaAJDFjYeSYdzU
         FGEpCEGLppwt9n3U2Op4JuIWTHlxtHWoxsWlw000HXPPHpysKaVQKmvZlYrpnXFDnce6
         z53w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=vJr0/ONtK8hIoVtLwcArO0IDujgifRzV5TTKMGnZyzw=;
        b=NA9BHSlvrL81l3Cdf9gQPDnWHvdAuvqSPfFQWSdT4g/d+QZ5zha9X+MO2AbGKaCC6S
         CEiLI0LjMyXpdjKAO4QX4cngai4HS8FAmVIWW/9104ft0mM0/0KJR00dKa1Ef0dGA4DQ
         s8DalX8DepTaWZlSqgl0qv2POAx251Sv8TDLcfaEx1icHy6XfOprGuA5qNPrXo0A3O0K
         rmIqdzReeTVU3OX5Qy8mub+B/Di1jIGZGGlG7xhWv/BRuwycTxWo5yKM8t2bkBqb+BEy
         Obhl9eIGpRP9XkW+B9KbKx7L/gU9tSTtwNRpwVJwJV0zhgQZ3HfcV6nm/uGegvL0wE+f
         wP0w==
X-Gm-Message-State: AA+aEWY0Ie2ZqWV00AA6YgtVQKhVYpNjPseoV6FgNj8VJefuwTxmGpZ2
        me12wO7OlbCnQAUNRZ/DVBU=
X-Google-Smtp-Source: AFSGD/Wy+iZgAp2YpuiTcGoxUUi+oj5F47zZvlI9V8+tH4hSoapp3ahNADkXrsYkA/+gnoPPBuRLFg==
X-Received: by 2002:a7b:ce84:: with SMTP id q4mr5092339wmj.105.1543571333150;
        Fri, 30 Nov 2018 01:48:53 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id y138sm3363685wmc.16.2018.11.30.01.48.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 01:48:52 -0800 (PST)
Date:   Fri, 30 Nov 2018 10:48:49 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arend Van Spriel <arend.vanspriel@broadcom.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Joe Perches <joe@perches.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        YiFei Zhu <zhuyifei1999@gmail.com>
Subject: Re: [PATCH] efi/fdt: More cleanups
Message-ID: <20181130094849.GA128917@gmail.com>
References: <20181129171230.18699-1-ard.biesheuvel@linaro.org>
 <20181129171230.18699-3-ard.biesheuvel@linaro.org>
 <20181130075658.GB16084@gmail.com>
 <CAKv+Gu8dLTwQp-FemEB0Bhzc3KEYDqpP_Pke3Q+miCh3h2xxbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu8dLTwQp-FemEB0Bhzc3KEYDqpP_Pke3Q+miCh3h2xxbw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:

> On Fri, 30 Nov 2018 at 08:57, Ingo Molnar <mingo@kernel.org> wrote:
> >
> >
> > * Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> >
> > > From: Julien Thierry <julien.thierry@arm.com>
> > >
> > > Closing bracket seems to end a for statement when it is actually ending
> > > the contained if. Add some brackets to have clear delimitation of each
> > > scope.
> > >
> > > No functional change/fix, just fix the indentation.
> > >
> > > Signed-off-by: Julien Thierry <julien.thierry@arm.com>
> > > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > > ---
> > >  drivers/firmware/efi/libstub/fdt.c | 5 +++--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/firmware/efi/libstub/fdt.c b/drivers/firmware/efi/libstub/fdt.c
> > > index 0c0d2312f4a8..a3614f9b5f75 100644
> > > --- a/drivers/firmware/efi/libstub/fdt.c
> > > +++ b/drivers/firmware/efi/libstub/fdt.c
> > > @@ -376,7 +376,7 @@ void *get_fdt(efi_system_table_t *sys_table, unsigned long *fdt_size)
> > >       tables = (efi_config_table_t *) sys_table->tables;
> > >       fdt = NULL;
> > >
> > > -     for (i = 0; i < sys_table->nr_tables; i++)
> > > +     for (i = 0; i < sys_table->nr_tables; i++) {
> > >               if (efi_guidcmp(tables[i].guid, fdt_guid) == 0) {
> > >                       fdt = (void *) tables[i].table;
> > >                       if (fdt_check_header(fdt) != 0) {
> > > @@ -385,7 +385,8 @@ void *get_fdt(efi_system_table_t *sys_table, unsigned long *fdt_size)
> > >                       }
> > >                       *fdt_size = fdt_totalsize(fdt);
> > >                       break;
> > > -      }
> > > +             }
> > > +     }
> >
> > So if we are doing trivial cleanups, how about the patch below on top? It
> > cleans up this file for good. Only minimally build tested.
> >
> > Thanks,
> >
> >         Ingo
> >
> > ======================>
> > Subject: efi/fdt: More cleanups
> > From: Ingo Molnar <mingo@kernel.org>
> >
> > Apply a number of cleanups:
> >
> >  - Introduce fdt_setprop_*var() helper macros to simplify and shorten repetitive
> >    sequences - this also makes it less likely that the wrong variable size is
> >    passed in. This change makes a lot of the property-setting calls single-line
> >    and easier to read.
> >
> 
> This change looks fine to me, but scripts/dtc/libfdt/libfdt.h is part
> of an external library, so we'd either need to contribute it there or
> define the macro in a local header.

Whichever variant you prefer. If the external library has a different 
license that requires a separate permission then for that too feel free 
to add:

  Signed-off-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
