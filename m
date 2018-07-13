Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EABDECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 07:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0A1E208E3
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 07:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="a21LfUkt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0A1E208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731639AbeGMIBo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 04:01:44 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:45108 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729764AbeGMIBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 04:01:43 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w6D7m35p070450;
        Fri, 13 Jul 2018 02:48:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1531468083;
        bh=ekpUcaDQsAyRxA8GvaXIzJI9wHMGBXFPL6x3qRKEaVo=;
        h=Subject:To:References:CC:From:Date:In-Reply-To;
        b=a21LfUktq9n4sZmv362gOT98Jog8JDKPhCW2UMC6K7/FRk9jfkEik91ldpMxpvSZP
         vzTxpxE6jeHSEtp7Ob0KjX7516d2sAYPyHVJBDERr0JRlJU+lSoEM+qMEBDhdYwyg8
         m6rpXPtqEfiDvjPJuQJFlpp/GYlSVsX/+NXcPjhI=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6D7m2IP004345;
        Fri, 13 Jul 2018 02:48:02 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 13
 Jul 2018 02:48:01 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 13 Jul 2018 02:48:02 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6D7lwsq027765;
        Fri, 13 Jul 2018 02:47:59 -0500
Subject: Re: [PATCH v9 01/12] PCI: dwc: Fix EP link notification
 implementation
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>,
        <Joao.Pinto@synopsys.com>, <jingoohan1@gmail.com>,
        <adouglas@cadence.com>, <jesper.nilsson@axis.com>,
        <shawn.lin@rock-chips.com>
References: <cover.1531155252.git.gustavo.pimentel@synopsys.com>
 <3b43f37cc5fe654294c1ea696ed8df1797ad213b.1531155252.git.gustavo.pimentel@synopsys.com>
CC:     <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <d7ce93a5-0f35-4b8e-3744-d5fd319d8172@ti.com>
Date:   Fri, 13 Jul 2018 13:17:57 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <3b43f37cc5fe654294c1ea696ed8df1797ad213b.1531155252.git.gustavo.pimentel@synopsys.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Monday 09 July 2018 11:12 PM, Gustavo Pimentel wrote:
> Move specific features settings from EP shared code
> (pcie-designware-ep.c) to the driver (pcie-designware-plat.c).
> 
> Previous implementation disables the EP link notification
> by default for all SoCs that uses EP DesignWare IP, which affects
> directly the dra7xx and artpec6 SoCs.
> 
> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>

Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
> Change v8->v9:
>  - Created patch file.
> 
>  drivers/pci/controller/dwc/pcie-designware-ep.c   | 14 ++++++--------
>  drivers/pci/controller/dwc/pcie-designware-plat.c |  3 +++
>  2 files changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 8650416..04092a7 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -386,15 +386,18 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>  		return -ENOMEM;
>  	ep->outbound_addr = addr;
>  
> -	if (ep->ops->ep_init)
> -		ep->ops->ep_init(ep);
> -
>  	epc = devm_pci_epc_create(dev, &epc_ops);
>  	if (IS_ERR(epc)) {
>  		dev_err(dev, "Failed to create epc device\n");
>  		return PTR_ERR(epc);
>  	}
>  
> +	ep->epc = epc;
> +	epc_set_drvdata(epc, ep);
> +
> +	if (ep->ops->ep_init)
> +		ep->ops->ep_init(ep);
> +
>  	ret = of_property_read_u8(np, "max-functions", &epc->max_functions);
>  	if (ret < 0)
>  		epc->max_functions = 1;
> @@ -413,11 +416,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>  		return -ENOMEM;
>  	}
>  
> -	epc->features = EPC_FEATURE_NO_LINKUP_NOTIFIER;
> -	EPC_FEATURE_SET_BAR(epc->features, BAR_0);
> -
> -	ep->epc = epc;
> -	epc_set_drvdata(epc, ep);
>  	dw_pcie_setup(pci);
>  
>  	return 0;
> diff --git a/drivers/pci/controller/dwc/pcie-designware-plat.c b/drivers/pci/controller/dwc/pcie-designware-plat.c
> index 5937fed..0ce3440 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-plat.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-plat.c
> @@ -70,10 +70,13 @@ static const struct dw_pcie_ops dw_pcie_ops = {
>  static void dw_plat_pcie_ep_init(struct dw_pcie_ep *ep)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> +	struct pci_epc *epc = ep->epc;
>  	enum pci_barno bar;
>  
>  	for (bar = BAR_0; bar <= BAR_5; bar++)
>  		dw_pcie_ep_reset_bar(pci, bar);
> +
> +	epc->features |= EPC_FEATURE_NO_LINKUP_NOTIFIER;
>  }
>  
>  static int dw_plat_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
> 
