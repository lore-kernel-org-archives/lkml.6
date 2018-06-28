Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB1AC43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 13:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22B88273CB
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 13:07:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tMwKh9SH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22B88273CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965477AbeF1NHl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 09:07:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:57560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964849AbeF1NHj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 09:07:39 -0400
Received: from localhost (173-25-171-118.client.mchsi.com [173.25.171.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76F94273C7;
        Thu, 28 Jun 2018 13:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530191258;
        bh=FENXYr9HSE9g5xwZRzM9/vpzsOEWBo9qcFZcm36t85E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tMwKh9SHS8sMQnvNKWq8KAY0+QEebV8pw7ysNmfmEzq37Hs5WnhqHUs3yCvZaUjOt
         p6mGwR+6MSUoLdX7WL+2UIQptT1yWxUQMs5jLqM4DP9qFuKxjnwzm/wBS9ctpInXMh
         2Az6wytbU2PcSA+JzMoTBVsMLswCQan9W4nlidDk=
Date:   Thu, 28 Jun 2018 08:07:37 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     honghui.zhang@mediatek.com
Cc:     lorenzo.pieralisi@arm.com, marc.zyngier@arm.com,
        bhelgaas@google.com, matthias.bgg@gmail.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        yingjoe.chen@mediatek.com, eddie.huang@mediatek.com,
        ryder.lee@mediatek.com, youlin.pei@mediatek.com,
        hongkun.cao@mediatek.com, sean.wang@mediatek.com,
        yt.shen@mediatek.com, yong.wu@mediatek.com
Subject: Re: [PATCH 1/4] PCI: mediatek: fixup mtk_pcie_find_port logical
Message-ID: <20180628130737.GA90450@bhelgaas-glaptop.roam.corp.google.com>
References: <1530091298-28120-1-git-send-email-honghui.zhang@mediatek.com>
 <1530091298-28120-2-git-send-email-honghui.zhang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530091298-28120-2-git-send-email-honghui.zhang@mediatek.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 05:21:35PM +0800, honghui.zhang@mediatek.com wrote:
> From: Honghui Zhang <honghui.zhang@mediatek.com>
> 
> Mediatek's host controller have two slots, each have it's own control
> registers. The host driver need to identify which slot was connected
> in order to access the device's configuration space. There's problem
> for current host driver to find out which slot was connected to for
> a given EP device.

  The Mediatek host controller has two slots, each with its own control
  registers.

> Assuming each slot have connect with one EP device as below:
> 
>                 host bridge
>   bus 0 --> __________|_______
>            |                  |
>            |                  |
>          slot 0             slot 1
>   bus 1 -->|        bus 2 --> |
>            |                  |
>          EP 0               EP 1
> 
> While PCI emulation, system software will scan all the PCI device

s/While PCI emulation/During PCI enumeration/

> starting from devfn 0. So it will get the proper port for slot0 and
> slot1 device when using PCI_SLOT(devfn) for match. But it will get
> the wrong slot for EP1: The devfn will be start from 0 when scanning
> EP1 behind slot1, it will get port0 since the PCI_SLOT(EP1) is match
> for port0's slot value. So the host driver should not using EP's devfn
> but the slot's devfn(the slot which EP was connected to) for match.
> 
> This patch fix the mtk_pcie_find_port's logical by using the slot's
> devfn for match.
> 
> Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
> Reviewed-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  drivers/pci/controller/pcie-mediatek.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
> index 0baabe3..9cf7ecf 100644
> --- a/drivers/pci/controller/pcie-mediatek.c
> +++ b/drivers/pci/controller/pcie-mediatek.c
> @@ -337,10 +337,23 @@ static struct mtk_pcie_port *mtk_pcie_find_port(struct pci_bus *bus,
>  {
>  	struct mtk_pcie *pcie = bus->sysdata;
>  	struct mtk_pcie_port *port;
> +	struct pci_dev *dev;
> +	struct pci_bus *pbus;
>  
> -	list_for_each_entry(port, &pcie->ports, list)
> -		if (port->slot == PCI_SLOT(devfn))
> +	list_for_each_entry(port, &pcie->ports, list) {

mvebu has the identical hardware structure but uses an array instead
of a list:

  num = of_get_available_child_count(np);
  pcie->ports = devm_kcalloc(dev, num, sizeof(*pcie->ports), GFP_KERNEL);
  for_each_available_child_of_node(np, child) {
    struct mvebu_pcie_port *port = &pcie->ports[i];
    mvebu_pcie_parse_port(pcie, port, child);
  }

It would be nice if mvebu and mtk used the same strategy so the code
looks the same.

> +		if (bus->number == 0 && port->slot == PCI_SLOT(devfn)) {

Is the root bus number fixed at 0 or is it programmable?  Many drivers
do something like this:

  if (bus->number == pcie->root_bus_nr)

to handle the case of the root bus number being programmable.

>  			return port;
> +		} else if (bus->number != 0) {
> +			pbus = bus;
> +			do {
> +				dev = pbus->self;
> +				if (port->slot == PCI_SLOT(dev->devfn))
> +					return port;
> +
> +				pbus = dev->bus;
> +			} while (dev->bus->number != 0);

You should not need to search up the tree of dev->bus->self.

mvebu_pcie_find_port() checks the root port secondary and subordinate
bus numbers, which should work here, too.

> +		}
> +	}
>  
>  	return NULL;
>  }
> -- 
> 2.6.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
