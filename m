Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69917C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 12:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3804021783
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 12:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbeLaMdO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 07:33:14 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36099 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727220AbeLaMdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 07:33:13 -0500
Received: by mail-qt1-f194.google.com with SMTP id t13so29186932qtn.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Dec 2018 04:33:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RwU2Y+gpTZt+nue9fhxVSylTa7plk4FrzInK4LqoluI=;
        b=PY7tuM8J6UGp9DMtdlObosrhaDLjkQ5KEhASoyFGqUGpOCk8WCRoHkyvd0x0PvLHZy
         si1+fzB9igTHtEWh6Rbt5HGOCeERQS7FIMTQZeL6LUV1sUsK3H4z9DgT1GNY8CAR7Y6g
         OxB2DmoJllAICmVQazEq0XX8yCl0IulKj0RzBb4l/yIOH98xFMenNi5FTriUm6Z2Zukk
         MJEzEeMJ7bsWdZeOePTPPCtpGeWE0s2xXumO93EJUjWowPpt1z1SpLxti0IauW/lDeEI
         Rnws/7ZKKeUtkTYx20sg/Hl8BV7GCmxiHUAd2KI/XVLFVVZBlv6f9gK0nNNp7Q5GaUH3
         iCdg==
X-Gm-Message-State: AJcUukcMTcGFcmUQw7T48ky5rGerG7b7QAx8WKmJNkCEenwshXk+TXVQ
        Cs6YydIQ/dr3MwLXanse8R1bvlTXaQhefKqOwTA=
X-Google-Smtp-Source: ALg8bN4TD/GbypKBpOh5YRDFPzr2bnm3gxPGhwf/NOqhuWWtVExcUwllgVZc0JW3lX4qvLgT1gWHihXC91JJj95wCKA=
X-Received: by 2002:a0c:f50c:: with SMTP id j12mr35192233qvm.149.1546259592841;
 Mon, 31 Dec 2018 04:33:12 -0800 (PST)
MIME-Version: 1.0
References: <cover.1545784679.git.fthain@telegraphics.com.au>
 <2fe2b8e6395aeacfafcbde590a50922d4e632189.1545784679.git.fthain@telegraphics.com.au>
 <CAK8P3a2p91XJfJuSCZqRLRgC-aP3LR1tMK2DDxTiSuD8_FOg8Q@mail.gmail.com> <alpine.LNX.2.21.1812301401220.215@nippy.intranet>
In-Reply-To: <alpine.LNX.2.21.1812301401220.215@nippy.intranet>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 31 Dec 2018 13:32:56 +0100
Message-ID: <CAK8P3a3OD9ou=y+PaZ03v-ivW4A3fwwzA+aL+CoJDd_L2vTMLA@mail.gmail.com>
Subject: Re: [PATCH v8 24/25] powerpc: Adopt nvram module for PPC64
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 30, 2018 at 4:29 AM Finn Thain <fthain@telegraphics.com.au> wrote:
>
> On Sat, 29 Dec 2018, Arnd Bergmann wrote:
>
> > On Wed, Dec 26, 2018 at 1:43 AM Finn Thain <fthain@telegraphics.com.au> wrote:
> >
> > > +static ssize_t ppc_nvram_get_size(void)
> > > +{
> > > +       if (ppc_md.nvram_size)
> > > +               return ppc_md.nvram_size();
> > > +       return -ENODEV;
> > > +}
> >
> > > +const struct nvram_ops arch_nvram_ops = {
> > > +       .read           = ppc_nvram_read,
> > > +       .write          = ppc_nvram_write,
> > > +       .get_size       = ppc_nvram_get_size,
> > > +       .sync           = ppc_nvram_sync,
> > > +};
> >
> > Coming back to this after my comment on the m68k side, I notice that
> > there is now a double indirection through function pointers. Have you
> > considered completely removing the operations from ppc_md instead by
> > having multiple copies of nvram_ops?
> >
>
> I considered a few alternatives. I figured that it was refactoring that
> could be deferred, as it would be confined to arch/powerpc. I was more
> interested in the cross-platform API.

Fair enough.

> > With the current method, it does seem odd to have a single
> > per-architecture instance of the exported structure containing function
> > pointers. This doesn't give us the flexibility of having multiple copies
> > in the kernel the way that ppc_md does, but it adds overhead compared to
> > simply exporting the functions directly.
> >
>
> You're right, there is overhead here.
>
> With a bit of auditing, wrappers like the one you quoted (which merely
> checks whether or not a ppc_md method is implemented) could surely be
> avoided.
>
> The arch_nvram_ops methods are supposed to optional (that is, they are
> allowed to be NULL).
>
> We could call exactly the same function pointers though either ppc_md or
> arch_nvram_ops. That would avoid the double indirection.

I think you can have a 'const' structure in the __ro_after_init section,
so without changing anything else, powerpc could just copy the
function pointers from ppc_md into the arch_nvram_ops at early
init time, which should ideally simplify your implementation as well.

        Arnd
