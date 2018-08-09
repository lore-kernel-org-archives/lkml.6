Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C09C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 15:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D4C921990
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 15:11:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ANuQJgQO";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="BX19nK02"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D4C921990
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732470AbeHIRgt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 13:36:49 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42594 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731432AbeHIRgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 13:36:49 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4941060B23; Thu,  9 Aug 2018 15:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533827488;
        bh=LOut9cMtMXt73/aZRGL4JeO6y2C5vmTJNFi/ARiDImo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ANuQJgQOX3XvTRLd5on6M7Ysh7B0Uchulr6knpce4tae3hzLoyp+5aUSpgVqga6JD
         6WauwAXHRGSpQj2GkHCzxqlNyCrMCiywS4Vz83ULHg0/bASnaN9Wr8yqEZGs7o6LGP
         LJPJI4uTSgYjxuGWzaWHz+8lPy5whUu2rGmWXQpA=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id E515B60807;
        Thu,  9 Aug 2018 15:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533827487;
        bh=LOut9cMtMXt73/aZRGL4JeO6y2C5vmTJNFi/ARiDImo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BX19nK02k5UzkCjX18N0ibPyzmtw91Tg45LI2czIEfZi/VB2BiAMaIg+rwwpEqNFg
         EXH7fTBNuzTxHehX78Gq5qYFaADUaBm2gz8d3ozsT2bVGvv6eAwRq7H0uzQUCiGemB
         zo7sGwhxU8sgJETJ4lWGZp00N4G9qpthM7D1LQwQ=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 09 Aug 2018 20:41:27 +0530
From:   poza@codeaurora.org
To:     Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, rgummal@xilinx.com,
        linux-pci-owner@vger.kernel.org
Subject: Re: [PATCH v2] PCI/AER: Enable SERR# forwarding in non ACPI flow
In-Reply-To: <1533826657-24552-1-git-send-email-bharat.kumar.gogada@xilinx.com>
References: <1533826657-24552-1-git-send-email-bharat.kumar.gogada@xilinx.com>
Message-ID: <2f53b7dd9c1464f40b10217eb64d511e@codeaurora.org>
X-Sender: poza@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-08-09 20:27, Bharat Kumar Gogada wrote:
> As per Figure 6-3 in PCIe r4.0, sec 6.2.6, ERR_ messages
> will be forwarded from the secondary interface to the primary 
> interface,
> if the SERR# Enable bit in the Bridge Control register is set.
> Currently PCI_BRIDGE_CTL_SERR is being enabled only in
> ACPI flow.
> This patch enables PCI_BRIDGE_CTL_SERR for Type-1 PCI device.
> 
> Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> ---
>  drivers/pci/pcie/aer.c |   23 +++++++++++++++++++++++
>  1 files changed, 23 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index a2e8838..4fb0d24 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -343,6 +343,20 @@ int pci_enable_pcie_error_reporting(struct pci_dev 
> *dev)
>  	if (!dev->aer_cap)
>  		return -EIO;
> 
> +	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
> +		u16 control;
> +
> +		/*
> +		 * A Type-1 PCI bridge will not forward ERR_ messages coming
> +		 * from an endpoint if SERR# forwarding is not enabled.
> +		 */
> +		pci_read_config_word(dev, PCI_BRIDGE_CONTROL, &control);
> +		if (!(control & PCI_BRIDGE_CTL_SERR)) {
> +			control |= PCI_BRIDGE_CTL_SERR;
> +			pci_write_config_word(dev, PCI_BRIDGE_CONTROL, control);
> +		}
> +	}
> +
>  	return pcie_capability_set_word(dev, PCI_EXP_DEVCTL, 
> PCI_EXP_AER_FLAGS);
>  }
>  EXPORT_SYMBOL_GPL(pci_enable_pcie_error_reporting);
> @@ -352,6 +366,15 @@ int pci_disable_pcie_error_reporting(struct 
> pci_dev *dev)
>  	if (pcie_aer_get_firmware_first(dev))
>  		return -EIO;
> 
> +	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
> +		u16 control;
> +
> +		/* Clear SERR Forwarding */
> +		pci_read_config_word(dev, PCI_BRIDGE_CONTROL, &control);
> +		control &= ~PCI_BRIDGE_CTL_SERR;
> +		pci_write_config_word(dev, PCI_BRIDGE_CONTROL, control);
> +	}
> +
>  	return pcie_capability_clear_word(dev, PCI_EXP_DEVCTL,
>  					  PCI_EXP_AER_FLAGS);
>  }


Hi Bjorn,

I made some comments on patchv1., same I am putting it across here.

what about hot-plug case ?
should not aer_init() call pci_enable_pcie_error_reporting() for all
the downstream pci_dev ?
and remove all the calls from drivers..
aer_init will be called for each device (pci_dev) while pciehp does 
re-enumeration.
so probable we might want to call pci_enable_pcie_error_reporting()
but that dictates the design where AER framework is taking decision to 
enable error reporting on behalf of drivers as well.
but thats fine I think, if drivers do not want to participate then they 
have to call  pci_disable_pcie_error_reporting explicitly.
does this make sense ?






