Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91CE9FF05FE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 12:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40B2620870
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 12:33:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40B2620870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbeG2ODM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 10:03:12 -0400
Received: from bmailout1.hostsharing.net ([83.223.95.100]:49215 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726361AbeG2ODM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 10:03:12 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 0947830000621;
        Sun, 29 Jul 2018 14:32:52 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id D357EB6609; Sun, 29 Jul 2018 14:32:51 +0200 (CEST)
Date:   Sun, 29 Jul 2018 14:32:51 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     poza@codeaurora.org
Cc:     okaya@codeaurora.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Keith Busch <keith.busch@intel.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V5 3/3] PCI: Mask and unmask hotplug interrupts during
 reset
Message-ID: <20180729123251.GB4364@wunner.de>
References: <1530571967-19099-1-git-send-email-okaya@codeaurora.org>
 <1530571967-19099-4-git-send-email-okaya@codeaurora.org>
 <20180703083447.GA2689@wunner.de>
 <8b6ce0f415858463d1c0588c29e30415@codeaurora.org>
 <9e871cc3978fbdca12ccf8a91f34ad07@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e871cc3978fbdca12ccf8a91f34ad07@codeaurora.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 06:41:33PM +0530, poza@codeaurora.org wrote:
> pciehp_unconfigure_device doing little more than enumeration to quiescence
> the bus.
> 
>		/*
> 		 * Ensure that no new Requests will be generated from
> 		 * the device.
> 		 */
> 		if (presence) {
> 			pci_read_config_word(dev, PCI_COMMAND, &command);
> 			command &= ~(PCI_COMMAND_MASTER | PCI_COMMAND_SERR);
> 			command |= PCI_COMMAND_INTX_DISABLE;
> 			pci_write_config_word(dev, PCI_COMMAND, command);
> 		}

That piece of code is supposed to be executed on safe removal via sysfs
or an Attention Button press:  The card remains in the slot, even though
the slot is brought down.  So the card is quiesced.

However IIUC, on fatal error the link goes down and for pciehp, that's
essentially a surprise removal.  In that case, the above code is not
intended to be executed, rather the devices below the hotplug bridge
are marked disconnected.  See this patch I posted yesterday:
https://www.spinics.net/lists/linux-pci/msg74763.html

Thanks,

Lukas
