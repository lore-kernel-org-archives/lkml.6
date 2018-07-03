Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE00C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 08:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FA1023C71
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 08:34:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FA1023C71
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933741AbeGCIew (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 04:34:52 -0400
Received: from bmailout3.hostsharing.net ([176.9.242.62]:53473 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932471AbeGCIeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 04:34:50 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 36391100FBEED;
        Tue,  3 Jul 2018 10:34:48 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id CE00C1BE91; Tue,  3 Jul 2018 10:34:47 +0200 (CEST)
Date:   Tue, 3 Jul 2018 10:34:47 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Sinan Kaya <okaya@codeaurora.org>
Cc:     linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Oza Pawandeep <poza@codeaurora.org>,
        Keith Busch <keith.busch@intel.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V5 3/3] PCI: Mask and unmask hotplug interrupts during
 reset
Message-ID: <20180703083447.GA2689@wunner.de>
References: <1530571967-19099-1-git-send-email-okaya@codeaurora.org>
 <1530571967-19099-4-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530571967-19099-4-git-send-email-okaya@codeaurora.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 02, 2018 at 06:52:47PM -0400, Sinan Kaya wrote:
> If a bridge supports hotplug and observes a PCIe fatal error, the following
> events happen:
> 
> 1. AER driver removes the devices from PCI tree on fatal error
> 2. AER driver brings down the link by issuing a secondary bus reset waits
> for the link to come up.
> 3. Hotplug driver observes a link down interrupt
> 4. Hotplug driver tries to remove the devices waiting for the rescan lock
> but devices are already removed by the AER driver and AER driver is waiting
> for the link to come back up.
> 5. AER driver tries to re-enumerate devices after polling for the link
> state to go up.
> 6. Hotplug driver obtains the lock and tries to remove the devices again.
> 
> If a bridge is a hotplug capable bridge, mask hotplug interrupts before the
> reset and unmask afterwards.

Would it work for you if you just amended the AER driver to skip
removal and re-enumeration of devices if the port is a hotplug bridge?
Just check for is_hotplug_bridge in struct pci_dev.

That would seem like a much simpler solution, given that it is known
that the link will flap on reset, causing the hotplug driver to remove
and re-enumerate devices.  That would also cover cases where hotplug is
handled by a different driver than pciehp, or by the platform firmware.

Thanks,

Lukas
