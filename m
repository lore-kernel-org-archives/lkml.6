Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A4FECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 15:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7E28208B1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 15:06:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7E28208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730038AbeGMPVU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 11:21:20 -0400
Received: from foss.arm.com ([217.140.101.70]:36606 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729643AbeGMPVU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 11:21:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B5BC57A9;
        Fri, 13 Jul 2018 08:06:19 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 87BF83F5B1;
        Fri, 13 Jul 2018 08:06:19 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 338591AE4D0E; Fri, 13 Jul 2018 16:07:02 +0100 (BST)
Date:   Fri, 13 Jul 2018 16:07:02 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Olof Johansson <olof@lixom.net>
Cc:     Paul Kocialkowski <contact@paulk.fr>,
        Laura Abbott <labbott@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>
Subject: Re: [PATCH] Revert "arm64: Use aarch64elf and aarch64elfb emulation
 mode variants"
Message-ID: <20180713150701.GA3049@arm.com>
References: <20180709200956.31158-1-labbott@redhat.com>
 <20180710090125.GA28924@arm.com>
 <fcd8d97b6714d787297f1b362558e7a68855a1da.camel@paulk.fr>
 <20180710093615.GA30095@arm.com>
 <20180713145910.2mlzip5ssk72cleo@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180713145910.2mlzip5ssk72cleo@localhost>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Olof,

On Fri, Jul 13, 2018 at 07:59:10AM -0700, Olof Johansson wrote:
> On Tue, Jul 10, 2018 at 10:36:16AM +0100, Will Deacon wrote:
> > On Tue, Jul 10, 2018 at 11:30:39AM +0200, Paul Kocialkowski wrote:
> > > On Tue, 2018-07-10 at 10:01 +0100, Will Deacon wrote:
> > > > Thanks, Laura.
> > > > 
> > > > I'll take this as a fix, and add a comment to the Makefile to justify
> > > > why we need the linux target.
> > > 
> > > So this comes down to either breaking fedora/debian toolchains (that
> > > don't support elf emulation mode) or breaking bare-metal toolchains
> > > (that don't support linux emulation mode).
> > > 
> > > Since Linux is a bare-metal project that does not technically require
> > > the linux target (who said using "Linux" for all things is confusing?),
> > > I think it should aim for the elf target in the long term.
> > > 
> > > But well, breaking Linux build in common distros isn't good either, so I
> > > guess it makes sense to revert this while distros toolchains are being
> > > fixed. Hopefully, it won't take too long.
> > > 
> > > What do you think?
> > 
> > Yes, we need to revert the change since it's a regression otherwise. I think
> > the best course of action here would be to find a way that we can either
> > tell the linker that it doesn't need the missing linker scripts because
> > we're providing our own, or find a way to pass different LD flags depending
> > on whether or not we have a linux toolchain.
> > 
> > For now, I've pushed the revert to for-next/fixes.
> 
> Hi Will,
> 
> This is regressed in mainline as well. But I think we can just use a (slightly
> improved) ld-option here? I checked it for x86 regression since it uses the
> one-argument version. Patch is here, can you pick that up instead and get it in
> for 4.18-rc?

I already sent the revert to Linus, but I can certainly queue the ld-option
for 4.19 if we pick up some more tested-bys. Could you send it out as its
own patch please?

Cheers,

Will
