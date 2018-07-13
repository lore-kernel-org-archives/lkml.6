Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E3C9ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 05:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 087F4208E2
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 05:14:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="H0krVt+V";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="H0krVt+V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 087F4208E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbeGMF1f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 01:27:35 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52030 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbeGMF1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 01:27:35 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id BF5B360B10; Fri, 13 Jul 2018 05:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531458878;
        bh=D0es5P1WT4M6hq3pICTqvGE1X50oxGPhXQE1A4StQM8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=H0krVt+V52b+oABovD7pz3Ec2W+32AtFdgQH3h1knIkXXLakZYeS5yU0Jooy0dCTN
         dUqoAbq5IYt/mnveqEsO5y8qpU0F6XdUclvhqzT7Nj+ywCNylTkjPj3zIxMyVBQe8P
         tFgB56kMX94//9cW9mpiums9WiXuF2ULpXu2ubcI=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 673D360250;
        Fri, 13 Jul 2018 05:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531458878;
        bh=D0es5P1WT4M6hq3pICTqvGE1X50oxGPhXQE1A4StQM8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=H0krVt+V52b+oABovD7pz3Ec2W+32AtFdgQH3h1knIkXXLakZYeS5yU0Jooy0dCTN
         dUqoAbq5IYt/mnveqEsO5y8qpU0F6XdUclvhqzT7Nj+ywCNylTkjPj3zIxMyVBQe8P
         tFgB56kMX94//9cW9mpiums9WiXuF2ULpXu2ubcI=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 13 Jul 2018 10:44:38 +0530
From:   poza@codeaurora.org
To:     Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, linux-pci-owner@vger.kernel.org
Subject: Re: [PATCH] PCI/AER: Enable SERR# forwarding in non ACPI flow
In-Reply-To: <1531406719-18606-1-git-send-email-bharat.kumar.gogada@xilinx.com>
References: <1531406719-18606-1-git-send-email-bharat.kumar.gogada@xilinx.com>
Message-ID: <b5ba83a0fd8694905528f740a186b891@codeaurora.org>
X-Sender: poza@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-12 20:15, Bharat Kumar Gogada wrote:
> Currently PCI_BRIDGE_CTL_SERR is being enabled only in
> ACPI flow.
> This bit is required for forwarding errors reported
> by EP devices to upstream device.
> This patch enables SERR# for Type-1 PCI device.
> 
> Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> ---
>  drivers/pci/pcie/aer.c |   23 +++++++++++++++++++++++
>  1 files changed, 23 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index a2e8838..943e084 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -343,6 +343,19 @@ int pci_enable_pcie_error_reporting(struct pci_dev 
> *dev)
>  	if (!dev->aer_cap)
>  		return -EIO;
> 
> +	if (!IS_ENABLED(CONFIG_ACPI) &&
> +	    dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
> +		u16 control;
> +
> +		/*
> +		 * A Type-1 PCI bridge will not forward ERR_ messages coming
> +		 * from an endpoint if SERR# forwarding is not enabled.
> +		 */
> +		pci_read_config_word(dev, PCI_BRIDGE_CONTROL, &control);
> +		control |= PCI_BRIDGE_CTL_SERR;
> +		pci_write_config_word(dev, PCI_BRIDGE_CONTROL, control);
> +	}
> +
>  	return pcie_capability_set_word(dev, PCI_EXP_DEVCTL, 
> PCI_EXP_AER_FLAGS);
>  }
>  EXPORT_SYMBOL_GPL(pci_enable_pcie_error_reporting);
> @@ -352,6 +365,16 @@ int pci_disable_pcie_error_reporting(struct 
> pci_dev *dev)
>  	if (pcie_aer_get_firmware_first(dev))
>  		return -EIO;
> 
> +	if (!IS_ENABLED(CONFIG_ACPI) &&
> +	    dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
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


Should this configuration no be set by Firmware ? why should Linux 
dictate it ?

Regards,
Oza.


