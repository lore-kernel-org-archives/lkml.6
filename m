Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B75D0C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71301243DA
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:14:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71301243DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965906AbeGAROt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 13:14:49 -0400
Received: from bmailout1.hostsharing.net ([83.223.95.100]:42125 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933613AbeGAROp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 13:14:45 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 9EFC8300002CC;
        Sun,  1 Jul 2018 19:14:43 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 5B03A7878D; Sun,  1 Jul 2018 19:14:43 +0200 (CEST)
Date:   Sun, 1 Jul 2018 19:14:43 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Sinan Kaya <okaya@codeaurora.org>
Cc:     linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oza Pawandeep <poza@codeaurora.org>,
        Keith Busch <keith.busch@intel.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V4 7/7] PCI: Handle link reset via hotplug if supported
Message-ID: <20180701171443.GA28249@wunner.de>
References: <1530214274-21139-1-git-send-email-okaya@codeaurora.org>
 <1530214274-21139-7-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530214274-21139-7-git-send-email-okaya@codeaurora.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 03:31:05PM -0400, Sinan Kaya wrote:
> +static pci_ers_result_t pciehp_reset_link(struct pci_dev *pdev)
> +{
> +	struct pcie_device *pciedev;
> +	struct controller *ctrl;
> +	struct device *devhp;
> +	struct slot *slot;
> +	int rc;
> +
> +	devhp = pcie_port_find_device(pdev, PCIE_PORT_SERVICE_HP);
> +	pciedev = to_pcie_device(devhp);
> +	ctrl = get_service_data(pciedev);
> +	slot = ctrl->slot;
> +
> +	rc = reset_slot(slot->hotplug_slot, 0);
> +
> +	return !rc ? PCI_ERS_RESULT_RECOVERED : PCI_ERS_RESULT_DISCONNECT;
> +}

This looks like a bit of a detour.  There's a "struct pci_slot *slot"
pointer in struct pci_dev.  Any reason not to simply call:

	rc = reset_slot(pdev->slot->hotplug_slot)

Lukas
