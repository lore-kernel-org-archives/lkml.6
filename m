Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 427F2ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 20:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF12E20673
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 20:01:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="diZ4R2pd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF12E20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbeGTUvO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 16:51:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:49174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727429AbeGTUvN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 16:51:13 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 203CD20661;
        Fri, 20 Jul 2018 20:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532116886;
        bh=41Xoo+71BD8l4sJvbFH74KVX8ctiJ9NUCW6ZsEDev7c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=diZ4R2pdHL+GLr3Gfxef3usYu8I05MLZ/P+b+Ktg1NoTmtcbzNZjB78QqmcpP7Rig
         Ol8ptak6QnlsLvVWJ3KQvub32NXeaAKnN63CzzEg4CxFQ9mVGVl9pMNP7/zd3C/OLH
         jBg9l/tTdx/Clj/EXUgW1WLgap2TZTrXZ/E318iQ=
Date:   Fri, 20 Jul 2018 15:01:23 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sinan Kaya <Okaya@kernel.org>
Cc:     Lukas Wunner <lukas@wunner.de>,
        Oza Pawandeep <poza@codeaurora.org>, linux-pci@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        Keith Busch <keith.busch@intel.com>,
        linux-arm-msm@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V5 3/3] PCI: Mask and unmask hotplug interrupts during
 reset
Message-ID: <20180720200123.GS128988@bhelgaas-glaptop.roam.corp.google.com>
References: <CAK9iUCM=zWexWow9TwkRfO186Hwr5WyGy0NHZF1vtXn3wbbZGQ@mail.gmail.com>
 <12fc8de5-ff03-cb00-52cb-25a43c71d03a@codeaurora.org>
 <20180708171418.GA11476@wunner.de>
 <CAK9iUCMcic5mzGiT20KNxgwPo6AuajHFsoj7GOjSht5SwrQevg@mail.gmail.com>
 <20180709160008.GA1490@wunner.de>
 <CAK9iUCMMVR114msKiMHu7ik0VK8T5j=LAYAKsEkdnocTqkdMjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK9iUCMMVR114msKiMHu7ik0VK8T5j=LAYAKsEkdnocTqkdMjQ@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 02:30:11PM -0400, Sinan Kaya wrote:
> On Mon, Jul 9, 2018 at 12:00 PM, Lukas Wunner <lukas@wunner.de> wrote:
> > On Mon, Jul 09, 2018 at 08:48:44AM -0600, Sinan Kaya wrote:
> > > On 7/8/18, Lukas Wunner <lukas@wunner.de> wrote:
> > > > On Tue, Jul 03, 2018 at 11:43:26AM -0400, Sinan Kaya wrote:
> > > > > My solution doesn't help if link down interrupt is observed
> > > > > before the AER or DPC services.
> > > >
> > > > If pciehp gets an interrupt quicker than dpc/aer, it will (at
> > > > least with my patches) remove all devices, check if the
> > > > presence bit is set, and if so, try to bring the slot up
> > > > again.
> > >
> > > Hotplug driver should only observe a link down interrupt. Link
> > > would come up in response to a secondary bus reset initiated by
> > > the AER driver.
> >
> > PCIe hotplug doesn't have separate Link Down and Link Up
> > interrupts, there is only a Link State *Changed* event.
> >
> > > Can you point me to the code that would bring up the link in hp
> > > code?
> >
> > I was referring to the situation with my recently posted pciehp
> > patches applied, in particular patch [21/32] ("PCI: pciehp: Become
> > resilient to missed events"):
> > https://patchwork.ozlabs.org/patch/930389/
> >
> > When I get a presence or link changed event, I turn the slot off.
> > That includes removing all devices in the slot.  Because even if
> > the slot is still occupied or link is up, there was definitely a
> > change and the safe behavior is to assume that the card in the
> > slot is now a different one than before.
> 
> We do have a bit of mess unfortunately. Error handling and hotplug
> drivers do not play nicely with each other.
> 
> When hotplug driver observes a link down, we are not checking if the
> link down happened because user really wanted to remove a card or if
> it was because it was originated by an error handling service such
> as AER/DPC.
> 
> I'm thinking that we could potentially check if a hotplug event is
> pending at the entrance of fatal error handling. If it is pending,
> we could poll until the status bit clears. That should flush the
> link down event.
> 
> Even then, link down indication of hotplug seem to turn off slot
> power and LED.
> 
> If AER/DPC service runs after the hotplug driver, link won't come
> back up as the power to the slot is turned off.
> 
> I'd like to hear about Bjorn's opinion before we throw something
> else into this problem.

You guys know way more about this than I do.

I think the separation of AER/DPC/pciehp into separate drivers is
somewhat artificial because there are many interdependencies.  The
driver model doesn't apply very well because there's only one
underlying piece of hardware, which forces us to use the portdrv as
sort of a multiplexer.  The fact that portdrv claims these bridges
also means normal drivers (e.g., for performance counters) can't use
the usual model.

All that is to say that if integrating these services more tightly
would help solve this problem, I'd be open to that.

Bjorn
