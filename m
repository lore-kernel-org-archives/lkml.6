Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22313C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 13:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8B2D20894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 13:54:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8B2D20894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=isi.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389453AbeHAPkg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 11:40:36 -0400
Received: from mail-c.ads.isi.edu ([128.9.180.198]:49018 "EHLO
        mail-c.ads.isi.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389329AbeHAPkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 11:40:36 -0400
X-IronPort-AV: E=Sophos;i="5.51,432,1526367600"; 
   d="scan'208";a="6791975"
Received: from guest228.east.isi.edu (HELO localhost) ([65.123.202.228])
  by mail-c.ads.isi.edu with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Aug 2018 06:54:42 -0700
Date:   Wed, 1 Aug 2018 09:54:41 -0400
From:   Alexei Colin <acolin@isi.edu>
To:     Russell King - ARM Linux <linux@armlinux.org.uk>
Cc:     Alex Bounine <alex.bou9@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, John Paul Walters <jwalters@isi.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 6/6] arm64: enable RapidIO menu in Kconfig
Message-ID: <20180801135441.GD38497@guest228.east.isi.edu>
References: <20180730225035.28365-1-acolin@isi.edu>
 <20180730225035.28365-7-acolin@isi.edu>
 <20180731084143.GA4680@arm.com>
 <d09cb4f5-768b-acd8-f9b1-d1d320a93564@gmail.com>
 <20180731155228.GN17271@n2100.armlinux.org.uk>
 <044af717-3883-a7a6-c346-18fa8cebce76@gmail.com>
 <20180731181834.GA30658@n2100.armlinux.org.uk>
 <570ad147-3c58-8911-0111-29e21087ca7a@gmail.com>
 <20180801103855.GD30658@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180801103855.GD30658@n2100.armlinux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Why we cannot use "select HAS_RAPIDIO" HW-specific Kconfig file
> > (mach-*/Kconfig)? And have on-chip port selection in the same board-specific
> > place.
> 
> As I've already explained, HAS_RAPIDIO has the expectation that it
> controls the availability of the RAPIDIO option, not of drivers.
> It is HAS_*RAPIDIO*, the clue is in the name.  Using it as you are
> (basically, to mean that on-SoC rapidio hardware is present) and
> allowing such configurations as HAS_RAPIDIO=n RAPIDIO=y PCI=y is
> completely counter-intuitive.

The intention in the patch was for HAS_RAPIDIO to mean exactly "on-SoC
RapidIO hardware is present". Since the name does not reflect that well,
I'll change it in the next version: would HAS_RAPIDIO_ONCHIP reflect the
meaning well? 

HAS_RAPIDIO=n RAPIDIO=y PCI=y should be an intuitive configuration,
for example for MIPS until last week it effectively was the only option
https://www.linux-mips.org/archives/linux-mips/2018-07/msg00584.html
If we have to rename to make this configuration intuitive again, then
I'll rename and resubmit.

There was never the intention to assign any other meaning to
HAS_RAPIDIO, specifically that it controls the availability of the
RAPIDIO menu option. I think interpreting it this way is is behind a lot
of the issues raised. The intention is that availability of the menu
options is controlled by (1) whether the architecture sources the
rapidio/Kconfig and (2) whether dependencies of RapidIO are satisfied
(either having a PCI bus and enabling it, or having the on-SoC RapidIO
hardware.

The patch does not indend to change the current meaning and usage of the
config options and behavior for X86, PPC, MIPS -- the patch only
refactors there (because it was requested). For ARM and ARM64, we are
adding the same behavior in same way as for those three architectures. I
assume there is nothing that sets ARM and ARM64 apart from the others in
this narrow context. This is the indended scope of this patch. Are we
now discussing a change in the current meaning/usage/behavior?  If so,
could we do one piece at a time -- first, add ARM and ARM64 in the way
consistent with the way other architectures currently do it?
