Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A749EC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 11:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DDC521528
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 11:44:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DDC521528
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729026AbeHVPJb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 11:09:31 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:35947 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728791AbeHVPJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 11:09:31 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fsRZ9-0005nl-A5; Wed, 22 Aug 2018 13:44:47 +0200
Date:   Wed, 22 Aug 2018 13:44:44 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Heiner Kallweit <hkallweit1@gmail.com>
cc:     David Miller <davem@davemloft.net>, helgaas@kernel.org,
        jian-hong@endlessm.com, nic_swsd@realtek.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@endlessm.com, linux-pci@vger.kernel.org,
        marc.zyngier@arm.com, hch@lst.de
Subject: Re: [PATCH] r8169: don't use MSI-X on RTL8106e
In-Reply-To: <da97e198-7683-e0ff-92a9-3b1b22da3757@gmail.com>
Message-ID: <alpine.DEB.2.21.1808221222260.2514@nanos.tec.linutronix.de>
References: <ac30d4e6-6411-09e6-1205-96e3e8e29f6f@gmail.com> <20180820184438.GA154536@bhelgaas-glaptop.roam.corp.google.com> <9d7d960a-6c55-dc4b-7969-f5cf46bff0ce@gmail.com> <20180821.123108.89921430801253333.davem@davemloft.net>
 <da97e198-7683-e0ff-92a9-3b1b22da3757@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Aug 2018, Heiner Kallweit wrote:
> On 21.08.2018 21:31, David Miller wrote:
> > From: Heiner Kallweit <hkallweit1@gmail.com>
> > Date: Mon, 20 Aug 2018 22:46:48 +0200
> > 
> >> I'm in contact with Realtek and according to them few chip versions
> >> seem to clear MSI-X table entries on resume from suspend. Checking
> >> with them how this could be fixed / worked around.
> >> Worst case we may have to disable MSI-X in general.
> > 
> > I worry that if the chip does this, and somehow MSI-X is enabled and
> > an interrupt is generated, the chip will write to the cleared out
> > MSI-X address.  This will either write garbage into memory or cause
> > a bus error and require PCI error recovery.
> > 
> > It also looks like your test patch doesn't fix things for people who
> > have tested it.
> > 
> The test patch was based on the first info from Realtek which made me
> think that the base address of the MSI-X table is cleared, what
> obviously is not the case.
> 
> After some further tests it seems that the solution isn't as simple
> as storing the MSI-X table entries on suspend and restore them on
> resume. On my system (where MSI-X works fine) MSI-X table entries
> on resume are partially different from the ones on suspend.

Which is not a surprise. Please don't try to fiddle with that at the driver
level. The irq and PCI core code are the ones in charge and if you'd
restore at the wrong point then hell breaks lose.

Can you please do the following:

 1) Store the PCI config space at suspend time
 2) Compare the PCI config space at resume time and print the difference

Do that on a working and a non-working version of Realtek NICs.

Thanks,

	tglx


