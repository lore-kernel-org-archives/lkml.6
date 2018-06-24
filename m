Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04BEEC43142
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 11:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5B1824EB4
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 11:34:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5B1824EB4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751409AbeFXLeH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 07:34:07 -0400
Received: from bmailout2.hostsharing.net ([83.223.90.240]:60951 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750780AbeFXLeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 07:34:06 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 491182800B489;
        Sun, 24 Jun 2018 13:34:04 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id DB885351FE; Sun, 24 Jun 2018 13:34:03 +0200 (CEST)
Date:   Sun, 24 Jun 2018 13:34:03 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 2/2] genirq: Synchronize only with single thread on
 free_irq()
Message-ID: <20180624113403.GA22016@wunner.de>
References: <32fc25aa35ecef4b2692f57687bb7fc2a57230e2.1529828292.git.lukas@wunner.de>
 <d72b41309f077c8d3bee6cc08ad3662d50b5d22a.1529828292.git.lukas@wunner.de>
 <alpine.DEB.2.21.1806241148030.8650@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1806241148030.8650@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 24, 2018 at 11:49:10AM +0200, Thomas Gleixner wrote:
> On Sun, 24 Jun 2018, Lukas Wunner wrote:
> > When pciehp is converted to threaded IRQ handling, removal of unplugged
> > devices below a PCIe hotplug port happens synchronously in the IRQ
> > thread.  Removal of devices typically entails a call to free_irq() by
> > their drivers.
> 
> Is this an actual mainline problem or did you discover that in course of
> upcoming work?

It's needed for upcoming work, specifically the pciehp event handling
rework which will hopefully appear in 4.19, so nothing urgent.
Doesn't hurt at all to let this bake in linux-next for a few weeks.

There is something else, you introduced irq_wake_thread() four years ago
with a92444c6b222 for sdhci/sdio, but for some reason it was never used.
Before you or anyone else deletes it for lack of callers, please be aware
that I'm making heavy use of it now in pciehp.  I forgot to cc you on the
relevant patch [17/32], but I'll bounce it to you in a minute in case
you want to take a look at it.

Of course this begs the question how irq_wake_thread() is serialized
against __free_irq(), but it seems that's safe because irq_wake_thread()
searches the action list while holding desc->lock:  If it grabs the lock
before __free_irq(), it'll just wake the thread normally.  If it grabs
the lock after __free_irq(), the action will be gone from the list,
so irq_wake_thread() essentially becomes a no-op.

Thanks,

Lukas
