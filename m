Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98495C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 22:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CFC1206C0
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 22:25:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729754AbfABWZN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 17:25:13 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:33224 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729719AbfABWZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 17:25:12 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id D1D4F29FC6;
        Wed,  2 Jan 2019 17:25:08 -0500 (EST)
Date:   Thu, 3 Jan 2019 09:25:08 +1100 (AEDT)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Arnd Bergmann <arnd@arndb.de>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v8 18/25] powerpc: Implement nvram sync ioctl
In-Reply-To: <alpine.LNX.2.21.1901011206010.574@nippy.intranet>
Message-ID: <alpine.LNX.2.21.1901030853160.614@nippy.intranet>
References: <cover.1545784679.git.fthain@telegraphics.com.au> <3ba1dd965c1097e00463eafe7c7d5fd93bbed836.1545784679.git.fthain@telegraphics.com.au> <CAK8P3a0-4vGuCR4aCq0=D1Du1K=f5MtnB9fyCBnOsF+4Na5dMg@mail.gmail.com> <alpine.LNX.2.21.1812301744540.424@nippy.intranet>
 <CAK8P3a1rkdMXGOt90SDhBkVvFeNsqdoMKQAu4nLfk_Eg+_CB6g@mail.gmail.com> <alpine.LNX.2.21.1901011206010.574@nippy.intranet>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Jan 2019, I wrote:

> 
> There are no [nvram] ioctls common to all architectures. So your example 
> becomes,
> 
> static long nvram_misc_ioctl(struct file *file, unsigned int cmd,
>                              unsigned long arg)
> {
>      if (ops->ioctl)
>           return ops->ioctl(file, cmd, arg);
>      return -ENOTTY;
> }
> 
> And then my objection is the same: m68k and x86 now have to duplicate 
> their common ops->ioctl() implementation.
> 

Perhaps code duplication is inevitable. Either you punt the ioctl 
implementation from the char misc driver (and duplicate that ioctl 
implementation under arch/) or else you duplicate the char misc driver.

Maybe this dilemma explains the situation we have now* which is duplicated 
drivers (drivers/char/nvram.c and drivers/char/generic_nvram.c). But this 
explanation doesn't seem to offer any solution. Re-using either of the 
existing drivers seems to be impossible.

Different interpretations of the NVRAM Kconfig symbol accross the tree are 
not helping. And having separate Kconfig symbols (NVRAM and GENERIC_NVRAM) 
for the two drivers doesn't help either. But maybe the NVRAM symbol can be 
dropped from arch/powerpc and all of the powerpc drivers...

* Actually, we presently have duplicated misc device drivers AND 
duplicated ioctl implementations too, for good measure. See 
arch/powerpc/kernel/nvram_64.c and drivers/char/generic_nvram.c.

-- 
