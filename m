Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F9C3C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9EDE2189C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:09:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9EDE2189C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752899AbeGDOJY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 10:09:24 -0400
Received: from foss.arm.com ([217.140.101.70]:38006 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752399AbeGDOJW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 10:09:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8ECC718A;
        Wed,  4 Jul 2018 07:09:22 -0700 (PDT)
Received: from red-moon (unknown [10.1.206.55])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A4B573F5A0;
        Wed,  4 Jul 2018 07:09:21 -0700 (PDT)
Date:   Wed, 4 Jul 2018 15:11:13 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: endpoint: Fix NULL pointer dereference error when
 CONFIGFS is disabled
Message-ID: <20180704141113.GB12863@red-moon>
References: <20180703090017.22734-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180703090017.22734-1-kishon@ti.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 02:30:17PM +0530, Kishon Vijay Abraham I wrote:
> commit ef1433f717a2c63747a519d86965d73 ("PCI: endpoint: Create configfs
> entry for each pci_epf_device_id table entry") while adding configfs
> entry for each pci_epf_device_id table entry introduced a NULL pointer
> dereference error when CONFIG_PCI_ENDPOINT_CONFIGFS is not enabled.
> Fix it here.
> 
> Fixes: ef1433f717a2c63747a519d86965d73 ("PCI: endpoint: Create configfs
> entry for each pci_epf_device_id table entry")
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/pci/endpoint/pci-epf-core.c | 62 ++++++++++++++++++++---------
>  1 file changed, 43 insertions(+), 19 deletions(-)

Applied to pci/controller-fixes, to be sent tentatively for one of
the upcoming -rc*, thanks.

Lorenzo

> diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
> index 523a8cab3bfb..7fe1930d6589 100644
> --- a/drivers/pci/endpoint/pci-epf-core.c
> +++ b/drivers/pci/endpoint/pci-epf-core.c
> @@ -137,25 +137,60 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar)
>  }
>  EXPORT_SYMBOL_GPL(pci_epf_alloc_space);
>  
> -/**
> - * pci_epf_unregister_driver() - unregister the PCI EPF driver
> - * @driver: the PCI EPF driver that has to be unregistered
> - *
> - * Invoke to unregister the PCI EPF driver.
> - */
> -void pci_epf_unregister_driver(struct pci_epf_driver *driver)
> +static void pci_epf_remove_cfs(struct pci_epf_driver *driver)
>  {
>  	struct config_group *group;
>  
> +	if (!IS_ENABLED(CONFIG_PCI_ENDPOINT_CONFIGFS))
> +		return;
> +
>  	mutex_lock(&pci_epf_mutex);
>  	list_for_each_entry(group, &driver->epf_group, group_entry)
>  		pci_ep_cfs_remove_epf_group(group);
>  	list_del(&driver->epf_group);
>  	mutex_unlock(&pci_epf_mutex);
> +}
> +
> +/**
> + * pci_epf_unregister_driver() - unregister the PCI EPF driver
> + * @driver: the PCI EPF driver that has to be unregistered
> + *
> + * Invoke to unregister the PCI EPF driver.
> + */
> +void pci_epf_unregister_driver(struct pci_epf_driver *driver)
> +{
> +	pci_epf_remove_cfs(driver);
>  	driver_unregister(&driver->driver);
>  }
>  EXPORT_SYMBOL_GPL(pci_epf_unregister_driver);
>  
> +static int pci_epf_add_cfs(struct pci_epf_driver *driver)
> +{
> +	struct config_group *group;
> +	const struct pci_epf_device_id *id;
> +
> +	if (!IS_ENABLED(CONFIG_PCI_ENDPOINT_CONFIGFS))
> +		return 0;
> +
> +	INIT_LIST_HEAD(&driver->epf_group);
> +
> +	id = driver->id_table;
> +	while (id->name[0]) {
> +		group = pci_ep_cfs_add_epf_group(id->name);
> +		if (IS_ERR(group)) {
> +			pci_epf_remove_cfs(driver);
> +			return PTR_ERR(group);
> +		}
> +
> +		mutex_lock(&pci_epf_mutex);
> +		list_add_tail(&group->group_entry, &driver->epf_group);
> +		mutex_unlock(&pci_epf_mutex);
> +		id++;
> +	}
> +
> +	return 0;
> +}
> +
>  /**
>   * __pci_epf_register_driver() - register a new PCI EPF driver
>   * @driver: structure representing PCI EPF driver
> @@ -167,8 +202,6 @@ int __pci_epf_register_driver(struct pci_epf_driver *driver,
>  			      struct module *owner)
>  {
>  	int ret;
> -	struct config_group *group;
> -	const struct pci_epf_device_id *id;
>  
>  	if (!driver->ops)
>  		return -EINVAL;
> @@ -183,16 +216,7 @@ int __pci_epf_register_driver(struct pci_epf_driver *driver,
>  	if (ret)
>  		return ret;
>  
> -	INIT_LIST_HEAD(&driver->epf_group);
> -
> -	id = driver->id_table;
> -	while (id->name[0]) {
> -		group = pci_ep_cfs_add_epf_group(id->name);
> -		mutex_lock(&pci_epf_mutex);
> -		list_add_tail(&group->group_entry, &driver->epf_group);
> -		mutex_unlock(&pci_epf_mutex);
> -		id++;
> -	}
> +	pci_epf_add_cfs(driver);
>  
>  	return 0;
>  }
> -- 
> 2.17.1
> 
