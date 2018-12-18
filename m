Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D7E2C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 12:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0447821841
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 12:00:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbeLRMA1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 07:00:27 -0500
Received: from foss.arm.com ([217.140.101.70]:44300 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726728AbeLRMAS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 07:00:18 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EBA7980D;
        Tue, 18 Dec 2018 04:00:17 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 91B373F5C0;
        Tue, 18 Dec 2018 04:00:16 -0800 (PST)
Date:   Tue, 18 Dec 2018 12:00:07 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Sinan Kaya <okaya@kernel.org>
Cc:     linux-acpi@vger.kernel.org, Hanjun Guo <hanjun.guo@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v11 6/7] ACPI/IORT: Stub out ACS functions when
 CONFIG_PCI is not set
Message-ID: <20181218115959.GA9090@e107981-ln.cambridge.arm.com>
References: <20181218025606.32668-1-okaya@kernel.org>
 <20181218025606.32668-7-okaya@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181218025606.32668-7-okaya@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 02:56:05AM +0000, Sinan Kaya wrote:
> Remove PCI dependent code out of iort.c when CONFIG_PCI is not defined.
> A quick search reveals the following functions:
> 1. pci_request_acs()
> 2. pci_domain_nr()
> 3. pci_is_root_bus()
> 4. to_pci_dev()
> 
> Both pci_domain_nr() and pci_is_root_bus() are defined in linux/pci.h.
> pci_domain_nr() is a stub function when CONFIG_PCI is not set and
> pci_is_root_bus() just returns a reference to a structure member which
> is still valid without CONFIG_PCI set.
> 
> to_pci_dev() is a macro that expands to container_of.
> 
> pci_request_acs() is the only code that gets pulled in from drivers/pci/*.c

I am not a big fan of these assumptions but we can stub all code
relying on those behind the CONFIG_PCI guard later, which would result
in cleaner code too.

> 
> Signed-off-by: Sinan Kaya <okaya@kernel.org>
> ---
>  drivers/acpi/arm64/iort.c | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index 70f4e80b9246..beb7e4c05bf5 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -1435,8 +1435,14 @@ static int __init iort_add_platform_device(struct acpi_iort_node *node,
>  	return ret;
>  }
>  
> -static bool __init iort_enable_acs(struct acpi_iort_node *iort_node)
> +#ifdef CONFIG_PCI
> +static void __init iort_enable_acs(struct acpi_iort_node *iort_node)
>  {
> +	static bool acs_enabled __initdata;
> +
> +	if (acs_enabled)
> +		return;
> +
>  	if (iort_node->type == ACPI_IORT_NODE_PCI_ROOT_COMPLEX) {
>  		struct acpi_iort_node *parent;
>  		struct acpi_iort_id_mapping *map;
> @@ -1458,13 +1464,16 @@ static bool __init iort_enable_acs(struct acpi_iort_node *iort_node)
>  			if ((parent->type == ACPI_IORT_NODE_SMMU) ||
>  				(parent->type == ACPI_IORT_NODE_SMMU_V3)) {
>  				pci_request_acs();
> -				return true;
> +				acs_enabled = true;
> +				return;
>  			}
>  		}
>  	}
> -
> -	return false;
> +	return;

Remove this return;

With that updated:

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

>  }
> +#else
> +static inline void iort_enable_acs(struct acpi_iort_node *iort_node) { }
> +#endif
>  
>  static void __init iort_init_platform_devices(void)
>  {
> @@ -1472,7 +1481,6 @@ static void __init iort_init_platform_devices(void)
>  	struct acpi_table_iort *iort;
>  	struct fwnode_handle *fwnode;
>  	int i, ret;
> -	bool acs_enabled = false;
>  	const struct iort_dev_config *ops;
>  
>  	/*
> @@ -1493,8 +1501,7 @@ static void __init iort_init_platform_devices(void)
>  			return;
>  		}
>  
> -		if (!acs_enabled)
> -			acs_enabled = iort_enable_acs(iort_node);
> +		iort_enable_acs(iort_node);
>  
>  		ops = iort_get_dev_cfg(iort_node);
>  		if (ops) {
> -- 
> 2.19.0
> 
