Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D93C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 13:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D85FA2081B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 13:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LKiQ71fa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731373AbfBDNny (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 08:43:54 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:40727 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbfBDNnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 08:43:53 -0500
Received: by mail-it1-f194.google.com with SMTP id h193so20998436ita.5
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 05:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2qRXtdzfk3K1AL17TPQYLnWwn9x5g9yhTRC4UUzz6Hw=;
        b=LKiQ71fa+zCG+DyzUs+ZElixKEJiNQMb5YX9Q+YkpoGryrsd3gOZDxlNtPEZCKvskm
         QwsCVHv5lWYiW8W8hQ7Es6NYKe3RbYmi/FltA6qNlWZni3lgrs/V9w+xy/8yJsD5H41U
         l7u2nx+0pmB1mRYTac/Q72PauSOvuhT1D2BLk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2qRXtdzfk3K1AL17TPQYLnWwn9x5g9yhTRC4UUzz6Hw=;
        b=g4P2yFxEr2YTmpcLADNLQ8B0NPHfVGhmNZWLyJ7EunSjFDb+vnfUKEcFEyz/XBDrrz
         V42dTeAWJS3TXJkF5G9vCFvffaDa0/QIuoFFGojQjYsMCm8NwAZl/SRTdN3uepiPEBlx
         vTUHGSPhUx0A3T8VIow1tNVbRBAGYwppHrtgcW+hjGW3GEywzQQsKwGAOyF3DucvodmF
         N8mM6GFkdIJ8z0aYiP5lrcoJ0IUfew7xc/aZ9PlICgn1fLQbxa2lC7kerVaVYV1p7Q4e
         NbQP9SaYD6LmjQakNWogFRKYxDd7Kms0N6pwt3V0Eq54EMS+OxOD0AsKbz4m6lv1cWy9
         OQnQ==
X-Gm-Message-State: AHQUAuYLd7tZD8GqrO4rqGrZiQjtVvo7B/XmLRNwR0hB3AeY33ZegQc2
        fi+UsFfGjawVVNJJp4lRO+4LWazYYMHKH+BqvHfkxg==
X-Google-Smtp-Source: AHgI3IbfDrjeq4B5BvM8BcgO7TOdeqbsXdtl130yjhLsFYrA+OaBZsUnNXQ0kmiKEQm5M/4oZ5q/G8eM9a6Yy82qDO0=
X-Received: by 2002:a24:710:: with SMTP id f16mr7559281itf.121.1549287832781;
 Mon, 04 Feb 2019 05:43:52 -0800 (PST)
MIME-Version: 1.0
References: <20190118163736.6A99268CEB@newverein.lst.de> <20190118163908.E338E68D93@newverein.lst.de>
 <bdcbdda9-d9e8-20e5-429e-35473ade56cc@arm.com> <20190122132832.GB16778@lst.de>
 <CAKv+Gu_sk-jbT3BfTVt1jdx5tR3KCGYzU63T8bv+TYy0Oizy+g@mail.gmail.com> <20190204120308.GA7660@lst.de>
In-Reply-To: <20190204120308.GA7660@lst.de>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 4 Feb 2019 14:43:42 +0100
Message-ID: <CAKv+Gu-3vzo4YJxN=qQ5yRDJnWjCt7L96HkoG3y2AUJk_zX3ag@mail.gmail.com>
Subject: Re: [PATCH v7 2/3] arm64: implement ftrace with regs
To:     Torsten Duwe <duwe@lst.de>
Cc:     Julien Thierry <julien.thierry@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        "Singh, Balbir" <bsingharora@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Feb 2019 at 13:03, Torsten Duwe <duwe@lst.de> wrote:
>
> On Tue, Jan 22, 2019 at 02:55:12PM +0100, Ard Biesheuvel wrote:
> > On Tue, 22 Jan 2019 at 14:28, Torsten Duwe <duwe@lst.de> wrote:
> > >
> > > On Tue, Jan 22, 2019 at 10:18:17AM +0000, Julien Thierry wrote:
> > > > Hi Torsten,
> > > >
> > > > A few suggestions below.
> > > >
> > > > > +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
> > > > > +#define ARCH_SUPPORTS_FTRACE_OPS 1
> > > > > +#define REC_IP_BRANCH_OFFSET AARCH64_INSN_SIZE
> > > > > +/* All we need is some magic value. Simply use "_mCount:" */
> > > >
> > > > Nit: Should the casing be "_mcount" ?
> > >
> > > No! The string makes it clear what it's supposed to be and the peculiar
> > > casing makes it unique and leaves no doubt were it came from. So whenever
> > > you see this register value in a crash dump you don't have to wonder about
> > > weird linkage errors, as it surely did not originate from a symtab.
> > >
> >
> > In that case, do you need to deal with endianness here?
> >
> > > > > +#define MCOUNT_ADDR                (0x5f6d436f756e743a)
>
> Strictly speaking, yes. OTOH "wrong-andian" machines always show a difference
> when memory is dumped in bigger units than bytes, so when you see the register
> value in hex...
>
> Since all that's needed is a somewhat unique constant, let's not over-engineer
> this ok?
>

Ah ok, if it is only for visual recognition, then I guess it doesn't matter.

> If there are no other comments I'll send out v8 with the discussed changes.
>
>         Torsten
>
