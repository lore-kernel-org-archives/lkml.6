Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C30C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 14:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8BBC24B9B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 14:34:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8BBC24B9B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932603AbeGCOei (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 10:34:38 -0400
Received: from bmailout2.hostsharing.net ([83.223.90.240]:35499 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932133AbeGCOeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 10:34:36 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id CA62528011BBF;
        Tue,  3 Jul 2018 16:34:34 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 6E1731BE87; Tue,  3 Jul 2018 16:34:34 +0200 (CEST)
Date:   Tue, 3 Jul 2018 16:34:34 +0200
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
Message-ID: <20180703143434.GA4086@wunner.de>
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
> @@ -308,8 +310,17 @@ void pcie_do_fatal_recovery(struct pci_dev *dev, u32 service)
>  		pci_dev_put(pdev);
>  	}
>  
> +	hpsvc = pcie_port_find_service(udev, PCIE_PORT_SERVICE_HP);
> +	hpdev = pcie_port_find_device(udev, PCIE_PORT_SERVICE_HP);
> +
> +	if (hpdev && hpsvc)
> +		hpsvc->mask_irq(to_pcie_device(hpdev));
> +
>  	result = reset_link(udev, service);
>  
> +	if (hpdev && hpsvc)
> +		hpsvc->unmask_irq(to_pcie_device(hpdev));
> +

We've already got the ->reset_slot callback in struct hotplug_slot_ops,
I'm wondering if we really need additional ones for this use case.

If you just do...

	if (!pci_probe_reset_slot(dev->slot))
		pci_reset_slot(dev->slot)
	else {
		/* regular code path */
	}

would that not be equivalent?

(It's worth noting though that pciehp is the only hotplug driver
implementing the ->reset_slot callback.  If hotplug is handled by
a different driver or by the platform firmware, devices may still
be removed and re-enumerated twice.)

Thanks,

Lukas
