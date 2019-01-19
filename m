Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA4BC61CE4
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 10:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E24DB2086A
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 10:45:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="b5QJJpHO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbfASKpC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 05:45:02 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40816 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726306AbfASKpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 05:45:01 -0500
Received: by mail-wm1-f65.google.com with SMTP id f188so6680723wmf.5
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jan 2019 02:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X16utiK3fu3/GY0eUWcDWtc3d7tcknqv+WUU1uN/1tM=;
        b=b5QJJpHO4/3+5TYJj8Rx6qnnl4Kc24RiqlqHC5w7N9V6JSo6Tfo56XrHVI2QbT4XqP
         IQl/nf5bvHjAmRbiMdbqZH8Y+a3GtsMKObz++LKJqoQ6UDIl8C6iBXkDXWd7QftlsvWf
         KTqTKfAX4HnS2znLI1giEPSOJM6F1g/6kIsG0K+qPK+8QjV99Vi7OuSMYIzvDaM/aD5J
         k0a9IyDlV//hJM2RozjYkNK/XObIcBVWkhjpbKkQezmwYmxe27AQcIzBLzK98KtwV5zM
         95mM1X+8pxxov4frGR9iQHQhYXzI+NSOYWxHMVhrSFbLf0mxU9NxDwzqm0T13WcdPzph
         I6FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X16utiK3fu3/GY0eUWcDWtc3d7tcknqv+WUU1uN/1tM=;
        b=QOdHd24z71UiVbfQT/rqL35t6/8QAb045+W1VTOkLO6JEPSNZy0Yg3aH2BYAy4Tu1o
         rEh9SNR7yfGpC4kr9y3l6uw0fXsFg/je2wVhlviHSbJnWbR3PBAGIzDe/qLXsNVV+TVE
         LMlrMeBCweYDp5re3r4n20p36S+eewpiK608S8nQXJysLijoO9bEv0PBi272g1immkeq
         pt8wkTnIM24859RZp9RJjH0jWGBOM9PQg6jeWeLU/rJqY/aisnXO3Luw8vYtpcDr6F9t
         WzFeGPifA3ht9aH5NJ1D7V+RBN/PKVpnse7HaVlowv/Qz6akLURNS44VfrIf1NhqOvvH
         4w+g==
X-Gm-Message-State: AJcUukfuD59Nj4b//DQyyCGEfQ2fSZK7P02iupKaAoC09Y1ulsJoU3Ix
        CxdNaINNgrg9XCSf6FLI9+4f9KlYm07F28OsvzQ6hw==
X-Google-Smtp-Source: ALg8bN5fNbQeavCren1sHwZXnLM9KFTyZ/WsnntoJ8fFqRXqsaczAKaBxkkHEp9o1IOP+e4W/5qiddQOYJZEi6qbNrs=
X-Received: by 2002:a1c:a3c3:: with SMTP id m186mr18409123wme.16.1547894699912;
 Sat, 19 Jan 2019 02:44:59 -0800 (PST)
MIME-Version: 1.0
References: <20190107161047.10516-1-anup@brainfault.org> <20190107161047.10516-6-anup@brainfault.org>
 <20190115134746.GF13216@infradead.org>
In-Reply-To: <20190115134746.GF13216@infradead.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Sat, 19 Jan 2019 16:14:48 +0530
Message-ID: <CAAhSdy3skp+8qJcVhen7GN4EuF0aQoAyQtxoV2ZOv54vW9Fsew@mail.gmail.com>
Subject: Re: [PATCH 5/5] RISC-V: Implement compile-time fixed mappings
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup.patel@wdc.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Atish Patra <atish.patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 7:17 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Mon, Jan 07, 2019 at 09:40:47PM +0530, Anup Patel wrote:
> > From: Anup Patel <anup.patel@wdc.com>
> >
> > This patch implements compile-time virtual to physical
> > mappings. These compile-time fixed mappings can be used
> > by earlycon, ACPI, and early ioremap for creating fixed
> > mappings when FIX_EARLYCON_MEM=y.
> >
> > To start with, we have enabled compile-time fixed
> > mappings for earlycon.
> >
> > Signed-off-by: Anup Patel <anup.patel@wdc.com>
> > ---
> >  arch/riscv/Kconfig              |  3 ++
> >  arch/riscv/include/asm/fixmap.h | 52 +++++++++++++++++++++++++++++++++
> >  arch/riscv/mm/init.c            | 32 ++++++++++++++++++++
> >  3 files changed, 87 insertions(+)
> >  create mode 100644 arch/riscv/include/asm/fixmap.h
> >
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index e0d7d61779a6..66094aba9a59 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -86,6 +86,9 @@ config GENERIC_CSUM
> >  config GENERIC_HWEIGHT
> >       def_bool y
> >
> > +config FIX_EARLYCON_MEM
> > +     def_bool y
> > +
>
> Can you please throw in a prep patch to move FIX_EARLYCON_MEM to
> drivers/tty/serial/Kconfig and only select it from the architectures
> that use it?
>
> > + * fixmap.h: compile-time virtual memory allocation
>
> No need to mention the header name.
>
> > + */
> > +
> > +#ifndef _ASM_RISCV_FIXMAP_H
> > +#define _ASM_RISCV_FIXMAP_H
> > +
> > +#ifndef __ASSEMBLY__
>
> As far as I can tell we never include this header from assembly files,
> so this ifdef should not be needed.

Okay, will drop #ifndef

>
> > +/*
> > + * Here we define all the compile-time 'special' virtual
> > + * addresses. The point is to have a constant address at
> > + * compile time, but to set the physical address only
> > + * in the boot process.
> > + *
> > + * These 'compile-time allocated' memory buffers are
> > + * page-sized. Use set_fixmap(idx,phys) to associate
> > + * physical memory with fixmap indices.
> > + */
>
> Please use up the available 80 chars per line for comments.

Sure, will do.

Regards,
Anup
