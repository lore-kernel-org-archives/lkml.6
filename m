Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A74BEC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 09:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F1112154B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 09:22:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F1112154B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbeHTMhb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 08:37:31 -0400
Received: from bmailout1.hostsharing.net ([83.223.95.100]:48923 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbeHTMhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 08:37:31 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id E633E300168AA;
        Mon, 20 Aug 2018 11:22:38 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id C05B3240BB0; Mon, 20 Aug 2018 11:22:38 +0200 (CEST)
Date:   Mon, 20 Aug 2018 11:22:38 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Sinan Kaya <okaya@kernel.org>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Oza Pawandeep <poza@codeaurora.org>,
        Keith Busch <keith.busch@intel.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 1/2] PCI: pciehp: Ignore link events when there is a
 fatal error pending
Message-ID: <20180820092238.kvktwlovc64oa66e@wunner.de>
References: <20180818065126.77912-1-okaya@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180818065126.77912-1-okaya@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 17, 2018 at 11:51:09PM -0700, Sinan Kaya wrote:
> --- a/drivers/pci/hotplug/pciehp_ctrl.c
> +++ b/drivers/pci/hotplug/pciehp_ctrl.c
> @@ -222,9 +222,27 @@ void pciehp_handle_disable_request(struct slot *slot)
>  void pciehp_handle_presence_or_link_change(struct slot *slot, u32 events)
>  {
>  	struct controller *ctrl = slot->ctrl;
> +	struct pci_dev *pdev = ctrl->pcie->port;
>  	bool link_active;
>  	u8 present;
>  
> +	/* If a fatal error is pending, wait for AER or DPC to handle it. */
> +	if (pcie_fatal_error_pending(pdev)) {
> +		bool recovered;
> +
> +		recovered = pcie_wait_fatal_error_clear(pdev);
> +
> +		/* If the fatal error is gone and the link is up, return */
> +		if (recovered && pcie_wait_for_link(pdev, true)) {
> +			ctrl_info(ctrl, "Slot(%s): Ignoring Link event due to successful fatal error recovery\n",
> +				  slot_name(slot));
> +			return;
> +		}
> +
> +		ctrl_info(ctrl, "Slot(%s): Fatal error recovery failed for Link event, trying hotplug reset\n",
> +			  slot_name(slot));
> +	}
> +

This differs from v7 of the patch in that *any* fatal error, not just
a Surprise Link Down, results in pciehp waiting for the error to clear.

I'm wondering if that's safe:  Theoretically, the user might quickly
swap the card in the slot during, say, a Completion Timeout Error,
and with this patch pciehp would carry on as if nothing happened.

Thanks,

Lukas
