Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8AC1C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AB7220877
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:00:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AB7220877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933831AbeGIQAO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 12:00:14 -0400
Received: from bmailout2.hostsharing.net ([83.223.90.240]:48293 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932902AbeGIQAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 12:00:10 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id EFD7B2800BB98;
        Mon,  9 Jul 2018 18:00:08 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 955664A26; Mon,  9 Jul 2018 18:00:08 +0200 (CEST)
Date:   Mon, 9 Jul 2018 18:00:08 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Sinan Kaya <Okaya@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Oza Pawandeep <poza@codeaurora.org>,
        Keith Busch <keith.busch@intel.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V5 3/3] PCI: Mask and unmask hotplug interrupts during
 reset
Message-ID: <20180709160008.GA1490@wunner.de>
References: <CAK9iUCM=zWexWow9TwkRfO186Hwr5WyGy0NHZF1vtXn3wbbZGQ@mail.gmail.com>
 <12fc8de5-ff03-cb00-52cb-25a43c71d03a@codeaurora.org>
 <20180708171418.GA11476@wunner.de>
 <CAK9iUCMcic5mzGiT20KNxgwPo6AuajHFsoj7GOjSht5SwrQevg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK9iUCMcic5mzGiT20KNxgwPo6AuajHFsoj7GOjSht5SwrQevg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 08:48:44AM -0600, Sinan Kaya wrote:
> On 7/8/18, Lukas Wunner <lukas@wunner.de> wrote:
> > On Tue, Jul 03, 2018 at 11:43:26AM -0400, Sinan Kaya wrote:
> > > My solution doesn't help if link down interrupt is observed before the
> > > AER
> > > or DPC services.
> >
> > If pciehp gets an interrupt quicker than dpc/aer, it will (at least with
> > my patches) remove all devices, check if the presence bit is set,
> > and if so, try to bring the slot up again.
> 
> Hotplug driver should only observe a link down interrupt. Link would
> come up in response to a secondary bus reset initiated by the AER
> driver.

PCIe hotplug doesn't have separate Link Down and Link Up interrupts,
there is only a Link State *Changed* event.

> Can you point me to the code that would bring up the link in hp code?

I was referring to the situation with my recently posted pciehp patches
applied, in particular patch [21/32] ("PCI: pciehp: Become resilient to
missed events"):
https://patchwork.ozlabs.org/patch/930389/

When I get a presence or link changed event, I turn the slot off.  That
includes removing all devices in the slot.  Because even if the slot is
still occupied or link is up, there was definitely a change and the safe
behavior is to assume that the card in the slot is now a different one
than before.

Afterwards, I check if the slot is occupied or link is up.  If either
of those conditions is true, I try to bring the slot up again.

Thanks,

Lukas
