Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B278C6778C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 23:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 443C227ED6
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 23:30:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YOhrE57s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 443C227ED6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935522AbeF2Xai (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 19:30:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:43608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753582AbeF2Xag (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 19:30:36 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03CB227ED0;
        Fri, 29 Jun 2018 23:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530315036;
        bh=ZN4K8BMlM6eOzHNqdCHCYB8FfdSldrT4kIGItprnS/8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YOhrE57s8DCYrc6HVOfDvUbAzjTAZpTpwcx6VXXCUt3UMtAMC5mfpohCRm3I/1siP
         yNHHUZTcTjzOgz6OLj2JKbKxpFK3JPR1GEeCkpiWICZlXVdcl2wBjZt0NBk+VKYGBB
         58GU1sebCShEZjsa7fpWx0XuVkLklyYH82FSZouY=
Date:   Fri, 29 Jun 2018 18:30:34 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jan Kiszka <jan.kiszka@siemens.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-pci@vger.kernel.org,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH] PCI: Clean up resource allocation in
 devm_of_pci_get_host_bridge_resources()
Message-ID: <20180629233034.GH40928@bhelgaas-glaptop.roam.corp.google.com>
References: <cover.1526375226.git.jan.kiszka@siemens.com>
 <3aeb2ed038cbce8fe744b614dc19d414555a7e8f.1526375226.git.jan.kiszka@siemens.com>
 <CAHp75VeUbjobse6uLeM4h_xXRUw+YUQUN+EOye67AJy77a5euQ@mail.gmail.com>
 <CAHp75VeM7_8+9QJjOypXaiBhpWP4B5KACdUQ-p3frbS3jPh=OQ@mail.gmail.com>
 <f35b2972-aa40-5397-facb-765cafe7c315@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f35b2972-aa40-5397-facb-765cafe7c315@siemens.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 16, 2018 at 02:31:44PM +0200, Jan Kiszka wrote:
> Instead of first allocating and then freeing memory for struct resource
> in case we cannot parse a PCI resource from the device tree, work
> against a local struct and kmemdup it when we decide to go with it.
> 
> Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>

Applied with Vladimir's reviewed-by to pci/resource for v4.19, thanks!

> ---
>  drivers/pci/of.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index b06585a1da75..fc0f906c5c25 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -266,7 +266,7 @@ int devm_of_pci_get_host_bridge_resources(struct device *dev,
>  			struct list_head *resources, resource_size_t *io_base)
>  {
>  	struct device_node *dev_node = dev->of_node;
> -	struct resource *res;
> +	struct resource *res, tmp_res;
>  	struct resource *bus_range;
>  	struct of_pci_range range;
>  	struct of_pci_range_parser parser;
> @@ -320,18 +320,16 @@ int devm_of_pci_get_host_bridge_resources(struct device *dev,
>  		if (range.cpu_addr == OF_BAD_ADDR || range.size == 0)
>  			continue;
>  
> -		res = devm_kzalloc(dev, sizeof(struct resource), GFP_KERNEL);
> +		err = of_pci_range_to_resource(&range, dev_node, &tmp_res);
> +		if (err)
> +			continue;
> +
> +		res = devm_kmemdup(dev, &tmp_res, sizeof(tmp_res), GFP_KERNEL);
>  		if (!res) {
>  			err = -ENOMEM;
>  			goto failed;
>  		}
>  
> -		err = of_pci_range_to_resource(&range, dev_node, res);
> -		if (err) {
> -			devm_kfree(dev, res);
> -			continue;
> -		}
> -
>  		if (resource_type(res) == IORESOURCE_IO) {
>  			if (!io_base) {
>  				dev_err(dev,
> -- 
> 2.13.6
