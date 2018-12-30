Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF88C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 22:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C83392081B
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 22:12:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbeL3WMt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 17:12:49 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:33944 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726489AbeL3WMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 17:12:49 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 5AD0629BC9;
        Sun, 30 Dec 2018 17:12:44 -0500 (EST)
Date:   Mon, 31 Dec 2018 09:12:42 +1100 (AEDT)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     LEROY Christophe <christophe.leroy@c-s.fr>
cc:     Joshua Thompson <funaho@jurai.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v8 13/25] m68k: Dispatch nvram_ops calls to Atari or Mac
 functions
In-Reply-To: <20181230185300.Horde.o5iU5x8n8UeDsyjemaBU_w7@messagerie.si.c-s.fr>
Message-ID: <alpine.LNX.2.21.1812310847210.444@nippy.intranet>
References: <cover.1545784679.git.fthain@telegraphics.com.au> <505240b144f1666acf26a3c1e93c8e6868fe1408.1545784679.git.fthain@telegraphics.com.au> <CAK8P3a0P7r+PCykB1cHq3HBrpHagfJ5WhDV7JR-wu0tGTMSFMA@mail.gmail.com> <alpine.LNX.2.21.1812301750320.424@nippy.intranet>
 <20181230185300.Horde.o5iU5x8n8UeDsyjemaBU_w7@messagerie.si.c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Dec 2018, LEROY Christophe wrote:

> > > 
> > > Since the operations are almost entirely distinct, why not have two 
> > > separate 'nvram_ops' instances here that each refer to just the set 
> > > they actually need?
> > > 
> > 
> > The reason for that is that I am alergic to code duplication. But I'll 
> > change it if you think it matters. BTW, this patch has already been 
> > acked by Geert.
> 
> I agree it would be cleaner, as it would also avoid this 
> m68k_nvram_get_size() wouldn't it ?
> 

No, that function makes run-time decisions. #ifdef won't work.

> I don't see potential code duplication here, do you ?
> 

Here's my problem with Arnd's suggestion. Consider this C code,

#ifdef FOO
const struct nvram_ops arch_nvram_ops = {
	/* ... */
}
#else
const struct nvram_ops arch_nvram_ops = {
        /* ... */
}
#endif

Lets say you write a hypothetical patch to remove the 'const'. Now you 
have two 'const' keywords to edit, and you have the risk of overlooking 
one of them. The solution to this problem is sometimes referred to as 
"DRY", meaning Don't Repeat Yourself:

const struct nvram_ops arch_nvram_ops = {
        /* ... */
#ifdef FOO
        /* ... */
#else
        /* ... */
#endif
        /* ... */
}

But I'm over-simplifying. Arnd's alternative actually goes like this,

#if defined(CONFIG_MAC) && !defined(CONFIG_ATARI)
const struct nvram_ops arch_nvram_ops = {
        /* ... */
}
#elif !defined(CONFIG_MAC) && defined(CONFIG_ATARI)
const struct nvram_ops arch_nvram_ops = {
        /* ... */
}
#elif defined(CONFIG_MAC) && defined(CONFIG_ATARI)
const struct nvram_ops arch_nvram_ops = {
        /* ... */
}
#endif

So, you're right, this isn't "duplication", it's "triplication".

-- 

> Christophe
> 
