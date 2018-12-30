Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 337E0C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 03:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3D9D21019
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 03:29:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725941AbeL3D3I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 22:29:08 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:50362 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbeL3D3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 22:29:07 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id CF1AB28EDF;
        Sat, 29 Dec 2018 22:29:03 -0500 (EST)
Date:   Sun, 30 Dec 2018 14:28:56 +1100 (AEDT)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Arnd Bergmann <arnd@arndb.de>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v8 24/25] powerpc: Adopt nvram module for PPC64
In-Reply-To: <CAK8P3a2p91XJfJuSCZqRLRgC-aP3LR1tMK2DDxTiSuD8_FOg8Q@mail.gmail.com>
Message-ID: <alpine.LNX.2.21.1812301401220.215@nippy.intranet>
References: <cover.1545784679.git.fthain@telegraphics.com.au> <2fe2b8e6395aeacfafcbde590a50922d4e632189.1545784679.git.fthain@telegraphics.com.au> <CAK8P3a2p91XJfJuSCZqRLRgC-aP3LR1tMK2DDxTiSuD8_FOg8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Dec 2018, Arnd Bergmann wrote:

> On Wed, Dec 26, 2018 at 1:43 AM Finn Thain <fthain@telegraphics.com.au> wrote:
> 
> > +static ssize_t ppc_nvram_get_size(void)
> > +{
> > +       if (ppc_md.nvram_size)
> > +               return ppc_md.nvram_size();
> > +       return -ENODEV;
> > +}
> 
> > +const struct nvram_ops arch_nvram_ops = {
> > +       .read           = ppc_nvram_read,
> > +       .write          = ppc_nvram_write,
> > +       .get_size       = ppc_nvram_get_size,
> > +       .sync           = ppc_nvram_sync,
> > +};
> 
> Coming back to this after my comment on the m68k side, I notice that 
> there is now a double indirection through function pointers. Have you 
> considered completely removing the operations from ppc_md instead by 
> having multiple copies of nvram_ops?
> 

I considered a few alternatives. I figured that it was refactoring that 
could be deferred, as it would be confined to arch/powerpc. I was more 
interested in the cross-platform API.

> With the current method, it does seem odd to have a single 
> per-architecture instance of the exported structure containing function 
> pointers. This doesn't give us the flexibility of having multiple copies 
> in the kernel the way that ppc_md does, but it adds overhead compared to 
> simply exporting the functions directly.
> 

You're right, there is overhead here.

With a bit of auditing, wrappers like the one you quoted (which merely 
checks whether or not a ppc_md method is implemented) could surely be 
avoided.

The arch_nvram_ops methods are supposed to optional (that is, they are 
allowed to be NULL).

We could call exactly the same function pointers though either ppc_md or 
arch_nvram_ops. That would avoid the double indirection.

-- 

>        Arnd
> 
