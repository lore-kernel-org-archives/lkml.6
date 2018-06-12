Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id B2D7AC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 08:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D7E220693
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 08:30:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Rge6kUlb";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="cOjZ3zFC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D7E220693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933894AbeFLIaP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 04:30:15 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48130 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933572AbeFLIaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 04:30:12 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2AF5B60791; Tue, 12 Jun 2018 08:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528792212;
        bh=fHXpdvOfIYpPCVHFsZqw34XsrHkBPXNvSfPVZ1++T9g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Rge6kUlb+wmpu1kJqc2WfEFQ5dENEHQATrdy2utrPzNn1RCPOi5FV5vZH28g29NV0
         cKSPQhNeA2/eP3wdc5vf0tisWSjrOs3hwNAQ70xJ2Wi1ECTY/R65Q2P0LSGZXaWckr
         VbH3a0OCBH4VRqigPIOAcKR/sbgwm4BmXDYl26zE=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 2E592606DB;
        Tue, 12 Jun 2018 08:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528792211;
        bh=fHXpdvOfIYpPCVHFsZqw34XsrHkBPXNvSfPVZ1++T9g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cOjZ3zFCk51sGeNN28tI5BT8cIraLefBUjij8mIHDH3UNCWpbb2+U0Y9HrQO0hEcr
         YFHD3NbnDBvDjU17wisOEoxJ36ZRwgFa/C1suxlYvAu6oKZIV5063hMHUcj5umfIuK
         hxyuovaJwe0oxIiQnZNd0hqG/xKKLx8f/GVVh2Hs=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 12 Jun 2018 14:00:11 +0530
From:   poza@codeaurora.org
To:     Ray Jui <ray.jui@broadcom.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        linux-pci-owner@vger.kernel.org
Subject: Re: [PATCH v2 4/5] PCI: iproc: Reject unconfigured physical functions
 from PAXC
In-Reply-To: <1528762867-16823-5-git-send-email-ray.jui@broadcom.com>
References: <1528762867-16823-1-git-send-email-ray.jui@broadcom.com>
 <1528762867-16823-5-git-send-email-ray.jui@broadcom.com>
Message-ID: <2f545a86aa5433526b17071d64f68e50@codeaurora.org>
X-Sender: poza@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-06-12 05:51, Ray Jui wrote:
> PAXC is an emulated PCIe root complex internally in various Broadcom
> based SoCs. PAXC internally connects to the embedded network processor
> within these SoCs, with the embedeed network processor exposed as an
> endpoint device
> 
> The number of physical functions from the embedded network processor
> that can be accessed depend on the firmware configuration.
> Unfortunately, due to an ASIC bug, unconfigured physical functions 
> cannot
> be properly hidden from the root complex during enumerattion. As a
> result, config write access to these unconfigured physical functions
> during enumeration will cause a bus lock up on the embedded network
> processor
> 
> Fortunately, these unconfigured physical functions contain a very
> specific, staled PCIe device ID 0x168e. By making use of this device 
> ID,
> one is able to terminate the enumeration early in the vendor/device ID
> config read
> 
> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
> ---
>  drivers/pci/host/pcie-iproc.c | 26 +++++++++++++++++++++++++-
>  drivers/pci/host/pcie-iproc.h |  5 +++++
>  2 files changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pcie-iproc.c 
> b/drivers/pci/host/pcie-iproc.c
> index 0804aa2..59be1e0 100644
> --- a/drivers/pci/host/pcie-iproc.c
> +++ b/drivers/pci/host/pcie-iproc.c
> @@ -582,6 +582,25 @@ static int iproc_pcie_config_read(struct pci_bus
> *bus, unsigned int devfn,
>  	if (size <= 2)
>  		*val = (data >> (8 * (where & 3))) & ((1 << (size * 8)) - 1);
> 
> +	/*
> +	 * For PAXC and PAXCv2, the total number of PFs that one can 
> enumerate
> +	 * depends on the firmware configuration. Unfortunately, due to an 
> ASIC
> +	 * bug, unconfigured PFs cannot be properly hidden from the root
> +	 * complex. As a result, write access to these PFs will cause bus 
> lock
> +	 * up on the embedded processor
> +	 *
> +	 * Since all unconfigured PFs are left with an incorrect, staled 
> device
> +	 * ID of 0x168e (PCI_DEVICE_ID_NX2_57810), we try to catch those 
> access
> +	 * early here and reject them all
> +	 */
> +#define DEVICE_ID_MASK     0xffff0000
> +#define DEVICE_ID_SHIFT    16
> +	if (pcie->rej_unconfig_pf &&
> +	    (where & CFG_ADDR_REG_NUM_MASK) == PCI_VENDOR_ID)
> +		if ((*val & DEVICE_ID_MASK) ==
> +		    (PCI_DEVICE_ID_NX2_57810 << DEVICE_ID_SHIFT))
> +			return PCIBIOS_FUNC_NOT_SUPPORTED;
> +
>  	return PCIBIOS_SUCCESSFUL;
>  }
> 
> @@ -681,7 +700,7 @@ static int iproc_pcie_config_read32(struct pci_bus
> *bus, unsigned int devfn,
>  	struct iproc_pcie *pcie = iproc_data(bus);
> 
>  	iproc_pcie_apb_err_disable(bus, true);
> -	if (pcie->type == IPROC_PCIE_PAXB_V2)
> +	if (pcie->iproc_cfg_read)
>  		ret = iproc_pcie_config_read(bus, devfn, where, size, val);
>  	else
>  		ret = pci_generic_config_read32(bus, devfn, where, size, val);
> @@ -1336,6 +1355,7 @@ static int iproc_pcie_rev_init(struct iproc_pcie 
> *pcie)
>  		break;
>  	case IPROC_PCIE_PAXB:
>  		regs = iproc_pcie_reg_paxb;
> +		pcie->iproc_cfg_read = true;
>  		pcie->has_apb_err_disable = true;
>  		if (pcie->need_ob_cfg) {
>  			pcie->ob_map = paxb_ob_map;
> @@ -1358,10 +1378,14 @@ static int iproc_pcie_rev_init(struct 
> iproc_pcie *pcie)
>  	case IPROC_PCIE_PAXC:
>  		regs = iproc_pcie_reg_paxc;
>  		pcie->ep_is_internal = true;
> +		pcie->iproc_cfg_read = true;
> +		pcie->rej_unconfig_pf = true;
>  		break;
>  	case IPROC_PCIE_PAXC_V2:
>  		regs = iproc_pcie_reg_paxc_v2;
>  		pcie->ep_is_internal = true;
> +		pcie->iproc_cfg_read = true;
> +		pcie->rej_unconfig_pf = true;
>  		pcie->need_msi_steer = true;
>  		break;
>  	default:
> diff --git a/drivers/pci/host/pcie-iproc.h 
> b/drivers/pci/host/pcie-iproc.h
> index 9d5cfee..4f03ea5 100644
> --- a/drivers/pci/host/pcie-iproc.h
> +++ b/drivers/pci/host/pcie-iproc.h
> @@ -58,6 +58,9 @@ struct iproc_msi;
>   * @phy: optional PHY device that controls the Serdes
>   * @map_irq: function callback to map interrupts
>   * @ep_is_internal: indicates an internal emulated endpoint device is 
> connected
> + * @iproc_cfg_read: indicates the iProc config read function should be 
> used
> + * @rej_unconfig_pf: indicates the root complex needs to detect and 
> reject
> + * enumeration against unconfigured physical functions emulated in the 
> ASIC
>   * @has_apb_err_disable: indicates the controller can be configured to 
> prevent
>   * unsupported request from being forwarded as an APB bus error
>   * @fix_paxc_cap: indicates the controller has corrupted capability 
> list in its
> @@ -86,6 +89,8 @@ struct iproc_pcie {
>  	struct phy *phy;
>  	int (*map_irq)(const struct pci_dev *, u8, u8);
>  	bool ep_is_internal;
> +	bool iproc_cfg_read;
> +	bool rej_unconfig_pf;
>  	bool has_apb_err_disable;
>  	bool fix_paxc_cap;

Reviewed-by: Oza Pawandeep <poza@codeaurora.org>
