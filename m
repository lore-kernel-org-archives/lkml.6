Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B96BC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 05:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E43F72172D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 05:47:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E43F72172D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbeHUJFq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 05:05:46 -0400
Received: from bmailout3.hostsharing.net ([176.9.242.62]:49369 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbeHUJFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 05:05:46 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 48F9F100DA1DC;
        Tue, 21 Aug 2018 07:47:05 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id EE5C34A15; Tue, 21 Aug 2018 07:47:04 +0200 (CEST)
Date:   Tue, 21 Aug 2018 07:47:04 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        mmyangfl@gmail.com
Subject: Re: Enumeration issue with QCA9005 AR9462
Message-ID: <20180821054704.jlqk5zrlbbsjsd4g@wunner.de>
References: <20180820230624.GB154536@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180820230624.GB154536@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 20, 2018 at 06:06:24PM -0500, Bjorn Helgaas wrote:
> mmyangfl@gmail.com reported a problem [1]: on v4.17, a QCA9005 AR9462
> wifi device was present at boot, but disappeared after suspend/resume.
> 
> He also tested a recent kernel (5c60a7389d79, from Thu Aug 16),
> where the suspend/resume problem doesn't seem to happen, but the wifi
> device isn't enumerated correctly at boot-time.
> 
> [    0.928714] pciehp 0000:04:00.0:pcie204: Slot #0 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl- LLActRep+
> [    0.928752] pciehp 0000:04:00.0:pcie204: Slot(0-1): Card not present
> [    0.928811] pciehp 0000:04:00.0:pcie204: Slot(0-1): Link Up
> [    0.928815] pciehp 0000:04:00.0:pcie204: Slot(0-1): No adapter
> 
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=200839
> [2] https://bugzilla.kernel.org/attachment.cgi?id=277923

The hardware appears to be broken in that the Presence Detect State bit
in the Slot Status register is 0 (Slot Empty) even though the slot is
occupied.

Thus, as of v4.19, pciehp will initially consider the slot to be in
ON_STATE when it probes (because there are enumerated children).
It then looks at the PDS bit, sees that it's 0, believes that there
is no longer anything in the slot and synthesizes a Presence Detect
Changed event to bring down the slot.  The IRQ thread then removes
the device in the slot, sees that the link is up, tries to bring the
slot up again, but that fails because __pciehp_enable_slot() complains
that the Presence Detect State bit isn't set ("No adapter").

The slot is then considered to be in OFF_STATE by pciehp, even though
the rescan made the device reappear behind pciehp's back.  On resume
from system sleep, pciehp sees that the Presence Detect State bit
in the Slot Status register is still 0, and because it's already in
OFF_STATE, there's nothing to do.

Up until v4.18, an unoccupied slot was only brought down on resume:

	/* Check if slot is occupied */
	pciehp_get_adapter_status(slot, &status);
	mutex_lock(&slot->hotplug_lock);
	if (status)
		pciehp_enable_slot(slot);
	else
		pciehp_disable_slot(slot);
	mutex_unlock(&slot->hotplug_lock);

From v4.19, this is now also done on probe for consistency.

The above hypothesis is confirmed by the lspci -vv output:

LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk- DLActive+ BWMgmt+ ABWMgmt-
                                                        ^^^^^^^^^
SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
                                                 ^^^^^^^^

Possible solutions:

(a) Be lenient towards broken hardware and accept DLActive+ as a proxy
    for PresDet+.

(b) Add a blacklist to pciehp such that it doesn't bind to [1ae9:0200].
    The bug reporter writes that "it's a single Half Mini PCIe card,
    with two chipsets (Wil6110? + AR9462) combined by a PCIe hub".
    This sounds like it's not really hotpluggable.
    (Is Mini PCIe hotplug capable at all?)

Let me go through the driver and see if (a) is feasible and how intrusive
it would be.

Thanks,

Lukas
