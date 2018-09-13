Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70161C46469
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 15:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E651206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 15:06:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E651206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728377AbeIMUQA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 16:16:00 -0400
Received: from foss.arm.com ([217.140.101.70]:49852 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727760AbeIMUQA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 16:16:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BD95B7A9;
        Thu, 13 Sep 2018 08:06:05 -0700 (PDT)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.emea.arm.com [10.4.13.117])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 668143F557;
        Thu, 13 Sep 2018 08:06:04 -0700 (PDT)
Date:   Thu, 13 Sep 2018 16:05:54 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3] PCI: dwc: fix scheduling while atomic issues
Message-ID: <20180913150543.GA6199@e107981-ln.cambridge.arm.com>
References: <20180829110408.556c3622@xhacker.debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180829110408.556c3622@xhacker.debian>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 11:04:08AM +0800, Jisheng Zhang wrote:
> When programming inbound/outbound atu, we call usleep_range() after
> each checking PCIE_ATU_ENABLE bit. Unfortunately, the atu programming
> can be called in atomic context:
> 
> inbound atu programming could be called through
> pci_epc_write_header()
>   =>dw_pcie_ep_write_header()
>     =>dw_pcie_prog_inbound_atu()
> 
> outbound atu programming could be called through
> pci_bus_read_config_dword()
>   =>dw_pcie_rd_conf()
>     =>dw_pcie_prog_outbound_atu()
> 
> Fix this issue by calling mdelay() instead.
> 
> Fixes: f8aed6ec624f ("PCI: dwc: designware: Add EP mode support")
> Fixes: d8bbeb39fbf3 ("PCI: designware: Wait for iATU enable")
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> ---

Applied to pci/controller-fixes aiming at one of the upcoming -rc*.

Thanks,
Lorenzo

> since v2:
>  - Add Fixes tag
>  - Add Gustavo's Ack
> 
> since v1:
>  - use mdelay() instead of udelay() to avoid __bad_udelay()
> 
>  drivers/pci/controller/dwc/pcie-designware.c | 8 ++++----
>  drivers/pci/controller/dwc/pcie-designware.h | 3 +--
>  2 files changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 778c4f76a884..2153956a0b20 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -135,7 +135,7 @@ static void dw_pcie_prog_outbound_atu_unroll(struct dw_pcie *pci, int index,
>  		if (val & PCIE_ATU_ENABLE)
>  			return;
>  
> -		usleep_range(LINK_WAIT_IATU_MIN, LINK_WAIT_IATU_MAX);
> +		mdelay(LINK_WAIT_IATU);
>  	}
>  	dev_err(pci->dev, "Outbound iATU is not being enabled\n");
>  }
> @@ -178,7 +178,7 @@ void dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, int type,
>  		if (val & PCIE_ATU_ENABLE)
>  			return;
>  
> -		usleep_range(LINK_WAIT_IATU_MIN, LINK_WAIT_IATU_MAX);
> +		mdelay(LINK_WAIT_IATU);
>  	}
>  	dev_err(pci->dev, "Outbound iATU is not being enabled\n");
>  }
> @@ -236,7 +236,7 @@ static int dw_pcie_prog_inbound_atu_unroll(struct dw_pcie *pci, int index,
>  		if (val & PCIE_ATU_ENABLE)
>  			return 0;
>  
> -		usleep_range(LINK_WAIT_IATU_MIN, LINK_WAIT_IATU_MAX);
> +		mdelay(LINK_WAIT_IATU);
>  	}
>  	dev_err(pci->dev, "Inbound iATU is not being enabled\n");
>  
> @@ -282,7 +282,7 @@ int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, int index, int bar,
>  		if (val & PCIE_ATU_ENABLE)
>  			return 0;
>  
> -		usleep_range(LINK_WAIT_IATU_MIN, LINK_WAIT_IATU_MAX);
> +		mdelay(LINK_WAIT_IATU);
>  	}
>  	dev_err(pci->dev, "Inbound iATU is not being enabled\n");
>  
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 96126fd8403c..9f1a5e399b70 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -26,8 +26,7 @@
>  
>  /* Parameters for the waiting for iATU enabled routine */
>  #define LINK_WAIT_MAX_IATU_RETRIES	5
> -#define LINK_WAIT_IATU_MIN		9000
> -#define LINK_WAIT_IATU_MAX		10000
> +#define LINK_WAIT_IATU			9
>  
>  /* Synopsys-specific PCIe configuration registers */
>  #define PCIE_PORT_LINK_CONTROL		0x710
> -- 
> 2.18.0
> 
