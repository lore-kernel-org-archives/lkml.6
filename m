Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE25CC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 18:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87C32208A2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 18:44:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tv28Qq8t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87C32208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbeHTWB1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 18:01:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:55140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726197AbeHTWB0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 18:01:26 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF82320676;
        Mon, 20 Aug 2018 18:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534790680;
        bh=Rm3TKpQFxsT/HbOwq3uS2QgQkcVBbdDJElBPH+s68kM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tv28Qq8tjta/fYDtwrsHWiA5kjytx40Wvs5QRzF78OW7GPhIWNzjouE45t9OSjI2O
         q57VKLYmn14qDCZNFlFHqCmgVpVzsYc6u31M1VpsJUHnvwYIlef0o2qr3yq/Widkyh
         MMQSN4pP8TPfrnrcQO/dLnfBhk1HzMKe1IL+Znbw=
Date:   Mon, 20 Aug 2018 13:44:38 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     David Miller <davem@davemloft.net>, jian-hong@endlessm.com,
        nic_swsd@realtek.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@endlessm.com,
        linux-pci@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] r8169: don't use MSI-X on RTL8106e
Message-ID: <20180820184438.GA154536@bhelgaas-glaptop.roam.corp.google.com>
References: <20180815062110.16155-1-jian-hong@endlessm.com>
 <20180816.122131.604270853620318143.davem@davemloft.net>
 <458efbf9-5971-653a-e7cd-8c56ba055648@gmail.com>
 <20180816.123958.750435252621963789.davem@davemloft.net>
 <ac30d4e6-6411-09e6-1205-96e3e8e29f6f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac30d4e6-6411-09e6-1205-96e3e8e29f6f@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+cc Marc, Thomas, Christoph, linux-pci)
(beginning of thread at [1])

On Thu, Aug 16, 2018 at 09:50:48PM +0200, Heiner Kallweit wrote:
> On 16.08.2018 21:39, David Miller wrote:
> > From: Heiner Kallweit <hkallweit1@gmail.com>
> > Date: Thu, 16 Aug 2018 21:37:31 +0200
> > 
> >> On 16.08.2018 21:21, David Miller wrote:
> >>> From: <jian-hong@endlessm.com>
> >>> Date: Wed, 15 Aug 2018 14:21:10 +0800
> >>>
> >>>> Found the ethernet network on ASUS X441UAR doesn't come back on resume
> >>>> from suspend when using MSI-X.  The chip is RTL8106e - version 39.
> >>>
> >>> Heiner, please take a look at this.
> >>>
> >>> You recently disabled MSI-X on RTL8168g for similar reasons.
> >>>
> >>> Now that we've seen two chips like this, maybe there is some other
> >>> problem afoot.
> >>>
> >> Thanks for the hint. I saw it already and just contacted Realtek
> >> whether they are aware of any MSI-X issues with particular chip
> >> versions. With the chip versions I have access to MSI-X works fine.
> >>
> >> There's also the theoretical option that the issues are caused by
> >> broken BIOS's. But so far only chip versions have been reported
> >> which are very similar, at least with regard to version number
> >> (2x VER_40, 1x VER_39). So they may share some buggy component.
> >>
> >> Let's see whether Realtek can provide some hint.
> >> If more chip versions are reported having problems with MSI-X,
> >> then we could switch to a whitelist or disable MSI-X in general.
> > 
> > It could be that we need to reprogram some register(s) on resume,
> > which normally might not be needed, and that is what is causing the
> > problem with some chips.
> > 
> Indeed. That's what I'm checking with Realtek.
> In the register list in the r8169 driver there's one entry which
> seems to indicate that there are MSI-X specific settings.
> However this register isn't used, and the r8168 vendor driver
> uses only MSI. And there are no public datasheets.

Do we have any information about these chip versions in other systems?
Or other devices using MSI-X in the same ASUS system?  It seems
possible that there's some PCI core or suspend/resume issue with MSI-X
and this patch just avoids it without fixing the root cause.

It might be useful to have a kernel.org bugzilla with the complete
dmesg, "sudo lspci -vv" output, and /proc/interrupts contents archived
for future reference.

[1] https://lkml.kernel.org/r/20180815062110.16155-1-jian-hong@endlessm.com
