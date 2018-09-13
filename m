Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D90C07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D36FF20861
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:51:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D36FF20861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbeIMUB2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 16:01:28 -0400
Received: from foss.arm.com ([217.140.101.70]:49662 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727082AbeIMUB2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 16:01:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6E4287A9;
        Thu, 13 Sep 2018 07:51:37 -0700 (PDT)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.emea.arm.com [10.4.13.117])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C62913F557;
        Thu, 13 Sep 2018 07:51:35 -0700 (PDT)
Date:   Thu, 13 Sep 2018 15:51:30 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alan Douglas <adouglas@cadence.com>,
        Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] PCI: remove unnecessary check of device_type == pci
Message-ID: <20180913145130.GA5756@e107981-ln.cambridge.arm.com>
References: <20180829183440.13601-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180829183440.13601-1-robh@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 01:34:40PM -0500, Rob Herring wrote:
> PCI host drivers have already matched on compatible strings, so checking
> device_type is redundant. Also, device_type is considered deprecated for
> FDT though we've still been requiring it for PCI hosts as it is useful
> for finding PCI buses.

Hi Rob,

I have no problem with the patch per-se, I can't parse though the second
paragraph, in particular what you mean by "useful for finding PCI
buses".

What about the corresponding dts files ? I suspect we had better leave
them alone lest we can trigger regressions with new dts and older
kernels.

Thanks,
Lorenzo

> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Alan Douglas <adouglas@cadence.com>
> Cc: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
> Cc: Michal Simek <michal.simek@xilinx.com>
> Cc: linux-pci@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/pci/controller/pci-host-common.c   | 8 --------
>  drivers/pci/controller/pcie-cadence-host.c | 7 -------
>  drivers/pci/controller/pcie-mobiveil.c     | 7 -------
>  drivers/pci/controller/pcie-xilinx-nwl.c   | 9 ---------
>  drivers/pci/controller/pcie-xilinx.c       | 7 -------
>  5 files changed, 38 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
> index d8f10451f273..c742881b5061 100644
> --- a/drivers/pci/controller/pci-host-common.c
> +++ b/drivers/pci/controller/pci-host-common.c
> @@ -58,9 +58,7 @@ static struct pci_config_window *gen_pci_init(struct device *dev,
>  int pci_host_common_probe(struct platform_device *pdev,
>  			  struct pci_ecam_ops *ops)
>  {
> -	const char *type;
>  	struct device *dev = &pdev->dev;
> -	struct device_node *np = dev->of_node;
>  	struct pci_host_bridge *bridge;
>  	struct pci_config_window *cfg;
>  	struct list_head resources;
> @@ -70,12 +68,6 @@ int pci_host_common_probe(struct platform_device *pdev,
>  	if (!bridge)
>  		return -ENOMEM;
>  
> -	type = of_get_property(np, "device_type", NULL);
> -	if (!type || strcmp(type, "pci")) {
> -		dev_err(dev, "invalid \"device_type\" %s\n", type);
> -		return -EINVAL;
> -	}
> -
>  	of_pci_check_probe_only();
>  
>  	/* Parse and map our Configuration Space windows */
> diff --git a/drivers/pci/controller/pcie-cadence-host.c b/drivers/pci/controller/pcie-cadence-host.c
> index ec394f6a19c8..97e251090b4f 100644
> --- a/drivers/pci/controller/pcie-cadence-host.c
> +++ b/drivers/pci/controller/pcie-cadence-host.c
> @@ -235,7 +235,6 @@ static int cdns_pcie_host_init(struct device *dev,
>  
>  static int cdns_pcie_host_probe(struct platform_device *pdev)
>  {
> -	const char *type;
>  	struct device *dev = &pdev->dev;
>  	struct device_node *np = dev->of_node;
>  	struct pci_host_bridge *bridge;
> @@ -268,12 +267,6 @@ static int cdns_pcie_host_probe(struct platform_device *pdev)
>  	rc->device_id = 0xffff;
>  	of_property_read_u16(np, "device-id", &rc->device_id);
>  
> -	type = of_get_property(np, "device_type", NULL);
> -	if (!type || strcmp(type, "pci")) {
> -		dev_err(dev, "invalid \"device_type\" %s\n", type);
> -		return -EINVAL;
> -	}
> -
>  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "reg");
>  	pcie->reg_base = devm_ioremap_resource(dev, res);
>  	if (IS_ERR(pcie->reg_base)) {
> diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controller/pcie-mobiveil.c
> index a939e8d31735..77052a0712d0 100644
> --- a/drivers/pci/controller/pcie-mobiveil.c
> +++ b/drivers/pci/controller/pcie-mobiveil.c
> @@ -301,13 +301,6 @@ static int mobiveil_pcie_parse_dt(struct mobiveil_pcie *pcie)
>  	struct platform_device *pdev = pcie->pdev;
>  	struct device_node *node = dev->of_node;
>  	struct resource *res;
> -	const char *type;
> -
> -	type = of_get_property(node, "device_type", NULL);
> -	if (!type || strcmp(type, "pci")) {
> -		dev_err(dev, "invalid \"device_type\" %s\n", type);
> -		return -EINVAL;
> -	}
>  
>  	/* map config resource */
>  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
> index fb32840ce8e6..81538d77f790 100644
> --- a/drivers/pci/controller/pcie-xilinx-nwl.c
> +++ b/drivers/pci/controller/pcie-xilinx-nwl.c
> @@ -777,16 +777,7 @@ static int nwl_pcie_parse_dt(struct nwl_pcie *pcie,
>  			     struct platform_device *pdev)
>  {
>  	struct device *dev = pcie->dev;
> -	struct device_node *node = dev->of_node;
>  	struct resource *res;
> -	const char *type;
> -
> -	/* Check for device type */
> -	type = of_get_property(node, "device_type", NULL);
> -	if (!type || strcmp(type, "pci")) {
> -		dev_err(dev, "invalid \"device_type\" %s\n", type);
> -		return -EINVAL;
> -	}
>  
>  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "breg");
>  	pcie->breg_base = devm_ioremap_resource(dev, res);
> diff --git a/drivers/pci/controller/pcie-xilinx.c b/drivers/pci/controller/pcie-xilinx.c
> index 7b1389d8e2a5..9bd1a35cd5d8 100644
> --- a/drivers/pci/controller/pcie-xilinx.c
> +++ b/drivers/pci/controller/pcie-xilinx.c
> @@ -574,15 +574,8 @@ static int xilinx_pcie_parse_dt(struct xilinx_pcie_port *port)
>  	struct device *dev = port->dev;
>  	struct device_node *node = dev->of_node;
>  	struct resource regs;
> -	const char *type;
>  	int err;
>  
> -	type = of_get_property(node, "device_type", NULL);
> -	if (!type || strcmp(type, "pci")) {
> -		dev_err(dev, "invalid \"device_type\" %s\n", type);
> -		return -EINVAL;
> -	}
> -
>  	err = of_address_to_resource(node, 0, &regs);
>  	if (err) {
>  		dev_err(dev, "missing \"reg\" property\n");
> -- 
> 2.17.1
> 
