Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751812AbeCWITT (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 04:19:19 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52578 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751479AbeCWITR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 04:19:17 -0400
X-Google-Smtp-Source: AG47ELvV14JhJvBeQzuTEGQgwVDh8zGICqArKtxUw8wOmxnuXhnifc4owMxHd2IXcs87evNviI3/mQ==
Subject: Re: [PATCH] ata: ahci-platform: add reset control support
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Tejun Heo <tj@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc: linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1521768653-11824-1-git-send-email-hayashi.kunihiko@socionext.com>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <87cd10b9-38f8-4e16-cfcf-425e92fc126c@redhat.com>
Date: Fri, 23 Mar 2018 09:19:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1521768653-11824-1-git-send-email-hayashi.kunihiko@socionext.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 23-03-18 02:30, Kunihiko Hayashi wrote:
> Add support to get and control a list of resets for the device
> as optional and shared. These resets must be kept de-asserted until
> the device is enabled.
> 
> This is specified as shared because some SoCs like UniPhier series
> have common reset controls with all ahci controller instances.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

Patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>   .../devicetree/bindings/ata/ahci-platform.txt      |  1 +
>   drivers/ata/ahci.h                                 |  1 +
>   drivers/ata/libahci_platform.c                     | 24 +++++++++++++++++++---
>   3 files changed, 23 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.txt b/Documentation/devicetree/bindings/ata/ahci-platform.txt
> index c760ecb..f4006d3 100644
> --- a/Documentation/devicetree/bindings/ata/ahci-platform.txt
> +++ b/Documentation/devicetree/bindings/ata/ahci-platform.txt
> @@ -30,6 +30,7 @@ compatible:
>   Optional properties:
>   - dma-coherent      : Present if dma operations are coherent
>   - clocks            : a list of phandle + clock specifier pairs
> +- resets            : a list of phandle + reset specifier pairs
>   - target-supply     : regulator for SATA target power
>   - phys              : reference to the SATA PHY node
>   - phy-names         : must be "sata-phy"
> diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
> index 749fd94..47ec77a2 100644
> --- a/drivers/ata/ahci.h
> +++ b/drivers/ata/ahci.h
> @@ -347,6 +347,7 @@ struct ahci_host_priv {
>   	u32			em_msg_type;	/* EM message type */
>   	bool			got_runtime_pm; /* Did we do pm_runtime_get? */
>   	struct clk		*clks[AHCI_MAX_CLKS]; /* Optional */
> +	struct reset_control	*rsts;		/* Optional */
>   	struct regulator	**target_pwrs;	/* Optional */
>   	/*
>   	 * If platform uses PHYs. There is a 1:1 relation between the port number and
> diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
> index 341d0ef..3130db9 100644
> --- a/drivers/ata/libahci_platform.c
> +++ b/drivers/ata/libahci_platform.c
> @@ -25,6 +25,7 @@
>   #include <linux/phy/phy.h>
>   #include <linux/pm_runtime.h>
>   #include <linux/of_platform.h>
> +#include <linux/reset.h>
>   #include "ahci.h"
>   
>   static void ahci_host_stop(struct ata_host *host);
> @@ -195,7 +196,8 @@ EXPORT_SYMBOL_GPL(ahci_platform_disable_regulators);
>    * following order:
>    * 1) Regulator
>    * 2) Clocks (through ahci_platform_enable_clks)
> - * 3) Phys
> + * 3) Resets
> + * 4) Phys
>    *
>    * If resource enabling fails at any point the previous enabled resources
>    * are disabled in reverse order.
> @@ -215,12 +217,19 @@ int ahci_platform_enable_resources(struct ahci_host_priv *hpriv)
>   	if (rc)
>   		goto disable_regulator;
>   
> -	rc = ahci_platform_enable_phys(hpriv);
> +	rc = reset_control_deassert(hpriv->rsts);
>   	if (rc)
>   		goto disable_clks;
>   
> +	rc = ahci_platform_enable_phys(hpriv);
> +	if (rc)
> +		goto disable_resets;
> +
>   	return 0;
>   
> +disable_resets:
> +	reset_control_assert(hpriv->rsts);
> +
>   disable_clks:
>   	ahci_platform_disable_clks(hpriv);
>   
> @@ -239,12 +248,15 @@ EXPORT_SYMBOL_GPL(ahci_platform_enable_resources);
>    * following order:
>    * 1) Phys
>    * 2) Clocks (through ahci_platform_disable_clks)
> - * 3) Regulator
> + * 3) Resets
> + * 4) Regulator
>    */
>   void ahci_platform_disable_resources(struct ahci_host_priv *hpriv)
>   {
>   	ahci_platform_disable_phys(hpriv);
>   
> +	reset_control_assert(hpriv->rsts);
> +
>   	ahci_platform_disable_clks(hpriv);
>   
>   	ahci_platform_disable_regulators(hpriv);
> @@ -393,6 +405,12 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev)
>   		hpriv->clks[i] = clk;
>   	}
>   
> +	hpriv->rsts = devm_reset_control_array_get_optional_shared(dev);
> +	if (IS_ERR(hpriv->rsts)) {
> +		rc = PTR_ERR(hpriv->rsts);
> +		goto err_out;
> +	}
> +
>   	hpriv->nports = child_nodes = of_get_child_count(dev->of_node);
>   
>   	/*
> 
