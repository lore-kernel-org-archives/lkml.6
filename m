Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 865B7ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 15:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2825720878
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 15:08:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2825720878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paulk.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731305AbeGMPX0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 11:23:26 -0400
Received: from leonov.paulk.fr ([185.233.101.22]:52720 "EHLO leonov.paulk.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729653AbeGMPXZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 11:23:25 -0400
Received: from gagarine.paulk.fr (gagarine [192.168.1.127])
        by leonov.paulk.fr (Postfix) with ESMTPS id 19D84C013D
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 17:08:23 +0200 (CEST)
Received: by gagarine.paulk.fr (Postfix, from userid 114)
        id 8B700C0EE0; Fri, 13 Jul 2018 17:08:22 +0200 (CEST)
Received: from aptenodytes (AAubervilliers-681-1-27-161.w90-88.abo.wanadoo.fr [90.88.147.161])
        by gagarine.paulk.fr (Postfix) with ESMTPSA id 33F91C0ED8;
        Fri, 13 Jul 2018 17:08:13 +0200 (CEST)
Message-ID: <dcf5d2e506b77e835e6175311054f3be9754fa47.camel@paulk.fr>
Subject: Re: [PATCH] Revert "arm64: Use aarch64elf and aarch64elfb emulation
 mode variants"
From:   Paul Kocialkowski <contact@paulk.fr>
To:     Olof Johansson <olof@lixom.net>, Will Deacon <will.deacon@arm.com>
Cc:     Laura Abbott <labbott@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Date:   Fri, 13 Jul 2018 17:08:09 +0200
In-Reply-To: <CAOesGMguQk_buucvNyKD6NmtdE0Re5_98Af+PME-HzZGHmeQGQ@mail.gmail.com>
References: <20180709200956.31158-1-labbott@redhat.com>
         <20180710090125.GA28924@arm.com>
         <fcd8d97b6714d787297f1b362558e7a68855a1da.camel@paulk.fr>
         <20180710093615.GA30095@arm.com>
         <20180713145910.2mlzip5ssk72cleo@localhost>
         <CAOesGMguQk_buucvNyKD6NmtdE0Re5_98Af+PME-HzZGHmeQGQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 2018-07-13 at 08:01 -0700, Olof Johansson wrote:
> On Fri, Jul 13, 2018 at 7:59 AM, Olof Johansson <olof@lixom.net> wrote:
> > On Tue, Jul 10, 2018 at 10:36:16AM +0100, Will Deacon wrote:
> > > On Tue, Jul 10, 2018 at 11:30:39AM +0200, Paul Kocialkowski wrote:
> > > > On Tue, 2018-07-10 at 10:01 +0100, Will Deacon wrote:
> > > > > Thanks, Laura.
> > > > > 
> > > > > I'll take this as a fix, and add a comment to the Makefile to justify
> > > > > why we need the linux target.
> > > > 
> > > > So this comes down to either breaking fedora/debian toolchains (that
> > > > don't support elf emulation mode) or breaking bare-metal toolchains
> > > > (that don't support linux emulation mode).
> > > > 
> > > > Since Linux is a bare-metal project that does not technically require
> > > > the linux target (who said using "Linux" for all things is confusing?),
> > > > I think it should aim for the elf target in the long term.
> > > > 
> > > > But well, breaking Linux build in common distros isn't good either, so I
> > > > guess it makes sense to revert this while distros toolchains are being
> > > > fixed. Hopefully, it won't take too long.
> > > > 
> > > > What do you think?
> > > 
> > > Yes, we need to revert the change since it's a regression otherwise. I think
> > > the best course of action here would be to find a way that we can either
> > > tell the linker that it doesn't need the missing linker scripts because
> > > we're providing our own, or find a way to pass different LD flags depending
> > > on whether or not we have a linux toolchain.
> > > 
> > > For now, I've pushed the revert to for-next/fixes.
> > 
> > Hi Will,
> > 
> > This is regressed in mainline as well. But I think we can just use a (slightly
> > improved) ld-option here? I checked it for x86 regression since it uses the
> > one-argument version. Patch is here, can you pick that up instead and get it in
> > for 4.18-rc?
> > 
> > Thanks,
> > 
> > 
> > -Olof
> > 
> > From 0d73b2d1774d5edce20aac919ba356b61d098646 Mon Sep 17 00:00:00 2001
> > From: Olof Johansson <olof@lixom.net>
> > Date: Fri, 13 Jul 2018 07:56:11 -0700
> > Subject: [PATCH] arm64: Fix build on some toolchains
> > 
> > Not all toolchains have the baremetal elf targets, RedHat/Fedora ones in
> > particular. So, probe for whether it's available and use the previous
> > (linux) targets if it isn't.
> > 
> > Fixes: 38fc42486775 ("arm64: Use aarch64elf and aarch64elfb emulation mode variants")
> > Signed-off-by: Olof Johansson <olof@lixom.net>
> 
> Of course, please add:
> Reported-by: Laura Abbott <labbott@redhat.com>
> 
> or other suitable tag. Sloppy of me to miss.

Thanks for taking care of this patch!

I will definitely try it when I get the chance.

Cheers,

Paul

-- 
Developer of free digital technology and hardware support.

Website: https://www.paulk.fr/
Coding blog: https://code.paulk.fr/
Git repositories: https://git.paulk.fr/ https://git.code.paulk.fr/
