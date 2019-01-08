Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF08C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 22:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18CAA214C6
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 22:51:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729860AbfAHWvO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 17:51:14 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:56610 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729418AbfAHWvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 17:51:13 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id BA86822C33;
        Tue,  8 Jan 2019 17:51:09 -0500 (EST)
Date:   Wed, 9 Jan 2019 09:51:48 +1100 (AEDT)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Michael Ellerman <mpe@ellerman.id.au>
cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v8 24/25] powerpc: Adopt nvram module for PPC64
In-Reply-To: <87h8ejts74.fsf@concordia.ellerman.id.au>
Message-ID: <alpine.LNX.2.21.1901090947170.11@nippy.intranet>
References: <cover.1545784679.git.fthain@telegraphics.com.au> <2fe2b8e6395aeacfafcbde590a50922d4e632189.1545784679.git.fthain@telegraphics.com.au> <CAK8P3a2p91XJfJuSCZqRLRgC-aP3LR1tMK2DDxTiSuD8_FOg8Q@mail.gmail.com> <8736q5xst1.fsf@concordia.ellerman.id.au>
 <alpine.LNX.2.21.1901071533060.30@nippy.intranet> <87h8ejts74.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jan 2019, Michael Ellerman wrote:

> > The reason why that doesn't work boils down to introspection. (This 
> > was mentioned elsewhere in this email thread.) For example, we 
> > presently have code like this,
> >
> > ssize_t nvram_get_size(void)
> > {
> >        if (ppc_md.nvram_size)
> >                return ppc_md.nvram_size();
> >        return -1;
> > }
> > EXPORT_SYMBOL(nvram_get_size);
> >
> > This construction means we get to decide at run-time which of the NVRAM 
> > functions should be used. (Whereas your example makes a build-time decision.)
> 
> Right, but we only need to make a runtime decision on powerpc (right?).

It's needed in many places outside of powerpc. Otherwise the caller can't 
determine at run-time which ops are implemented.

Hence you have to duplicate the caller for each supported configuration 
that you build.

Already, this precludes a shared misc device implementation and belies the 
"generic" in drivers/char/generic_nvram.c.

-- 
