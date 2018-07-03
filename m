Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92871C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 10:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 403F720C07
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 10:52:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="NgT5ckm8";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="NgT5ckm8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 403F720C07
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752885AbeGCKw2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 06:52:28 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50340 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752069AbeGCKw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 06:52:26 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id EE89860B27; Tue,  3 Jul 2018 10:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530615145;
        bh=pdhEUd6zCmB40iuhXUGlHf+DWPrIwzBRuW8mP4Cv8Bw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NgT5ckm8kqX3bsIfYkMYPvGYuEOf5uL0ZWL4hF9gP8wsU2OFbgcBIRV6X7wVu1KV3
         2BI+Wrpu8s2wzeyzI5bphBlJUrzKnFpGO3B/swjOWgcBD2r08lZI60LFV/CTrCg6r6
         G01qtruXvF2rWnd3bhf9fLdBCAtcuzTnBlfvb/CA=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 39CF16028D;
        Tue,  3 Jul 2018 10:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530615145;
        bh=pdhEUd6zCmB40iuhXUGlHf+DWPrIwzBRuW8mP4Cv8Bw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NgT5ckm8kqX3bsIfYkMYPvGYuEOf5uL0ZWL4hF9gP8wsU2OFbgcBIRV6X7wVu1KV3
         2BI+Wrpu8s2wzeyzI5bphBlJUrzKnFpGO3B/swjOWgcBD2r08lZI60LFV/CTrCg6r6
         G01qtruXvF2rWnd3bhf9fLdBCAtcuzTnBlfvb/CA=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 03 Jul 2018 16:22:25 +0530
From:   poza@codeaurora.org
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Sinan Kaya <okaya@codeaurora.org>, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Keith Busch <keith.busch@intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        linux-pci-owner@vger.kernel.org
Subject: Re: [PATCH V5 3/3] PCI: Mask and unmask hotplug interrupts during
 reset
In-Reply-To: <20180703083447.GA2689@wunner.de>
References: <1530571967-19099-1-git-send-email-okaya@codeaurora.org>
 <1530571967-19099-4-git-send-email-okaya@codeaurora.org>
 <20180703083447.GA2689@wunner.de>
Message-ID: <324f8cf2fe6f7bdc43ca8a646eea908d@codeaurora.org>
X-Sender: poza@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-03 14:04, Lukas Wunner wrote:
> On Mon, Jul 02, 2018 at 06:52:47PM -0400, Sinan Kaya wrote:
>> If a bridge supports hotplug and observes a PCIe fatal error, the 
>> following
>> events happen:
>> 
>> 1. AER driver removes the devices from PCI tree on fatal error
>> 2. AER driver brings down the link by issuing a secondary bus reset 
>> waits
>> for the link to come up.
>> 3. Hotplug driver observes a link down interrupt
>> 4. Hotplug driver tries to remove the devices waiting for the rescan 
>> lock
>> but devices are already removed by the AER driver and AER driver is 
>> waiting
>> for the link to come back up.
>> 5. AER driver tries to re-enumerate devices after polling for the link
>> state to go up.
>> 6. Hotplug driver obtains the lock and tries to remove the devices 
>> again.
>> 
>> If a bridge is a hotplug capable bridge, mask hotplug interrupts 
>> before the
>> reset and unmask afterwards.
> 
> Would it work for you if you just amended the AER driver to skip
> removal and re-enumeration of devices if the port is a hotplug bridge?
> Just check for is_hotplug_bridge in struct pci_dev.
> 

I tend to agree with you Lukas.

on this line I already have follow up patches
although I am waiting for Bjorn to review some patch-series before that.
[PATCH v2 0/6] Fix issues and cleanup for ERR_FATAL and ERR_NONFATAL

It doesn't look to me a an entirely a race condition since its guarded 
by pci_lock_rescan_remove())
I observed that both hotplug and aer/dpc comes out of it in a quiet sane 
state.

My thinking is: Disabling hotplug interrupts during ERR_FATAL,
is something little away from natural course of link_down event 
handling, which is handled by pciehp more maturely.
so it would be just easy not to take any action e.g. removal and 
re-enumeration of devices from ERR_FATAL handling point of view.

I leave it to Bjorn.

follwing is the patch wich I am trying to set it right and under test.
so till now I am in an opinion to handle this by checking in err.c

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 410c35c..607a234 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -292,15 +292,17 @@ void pcie_do_fatal_recovery(struct pci_dev *dev, 
u32 service)

         parent = udev->subordinate;
         pci_lock_rescan_remove();
-       list_for_each_entry_safe_reverse(pdev, temp, &parent->devices,
-                                        bus_list) {
-               pci_dev_get(pdev);
-               pci_dev_set_disconnected(pdev, NULL);
-               if (pci_has_subordinate(pdev))
-                       pci_walk_bus(pdev->subordinate,
-                                    pci_dev_set_disconnected, NULL);
-               pci_stop_and_remove_bus_device(pdev);
-               pci_dev_put(pdev);
+       if (!udev->is_hotplug_bridge) {
+               list_for_each_entry_safe_reverse(pdev, temp, 
&parent->devices,
+                                                bus_list) {
+                       pci_dev_get(pdev);
+                       pci_dev_set_disconnected(pdev, NULL);
+                       if (pci_has_subordinate(pdev))
+                               pci_walk_bus(pdev->subordinate,
+                                            pci_dev_set_disconnected, 
NULL);
+                       pci_stop_and_remove_bus_device(pdev);
+                       pci_dev_put(pdev);
+               }
         }

         result = reset_link(udev, service);
@@ -318,7 +320,7 @@ void pcie_do_fatal_recovery(struct pci_dev *dev, u32 
service)
         }

         if (result == PCI_ERS_RESULT_RECOVERED) {
-               if (pcie_wait_for_link(udev, true))
+               if (pcie_wait_for_link(udev, true) && 
!udev->is_hotplug_bridge)
                         pci_rescan_bus(udev->bus);
                 pci_info(dev, "Device recovery from fatal error 
successful\n");
                 dev->error_state = pci_channel_io_normal;


> That would seem like a much simpler solution, given that it is known
> that the link will flap on reset, causing the hotplug driver to remove
> and re-enumerate devices.  That would also cover cases where hotplug is
> handled by a different driver than pciehp, or by the platform firmware.
> 
> Thanks,
> 
> Lukas










