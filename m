Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751918AbeDIHCi (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 03:02:38 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39088 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751458AbeDIHCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 03:02:36 -0400
X-Google-Smtp-Source: AIpwx49KRo41oV8+kbMoTlrgnj+8Bv5xDLhu1SOw2XraDL/BdY6YBuOum+4iSIzZmAblPHZUWsfBJg==
Subject: Re: [PATCH] Revert "ata: ahci-platform: add reset control support"
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org
Cc: Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1523237554-7928-1-git-send-email-hayashi.kunihiko@socionext.com>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <c8ec7474-7eb4-24cf-1f53-b4bcee5508dd@redhat.com>
Date: Mon, 9 Apr 2018 09:02:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1523237554-7928-1-git-send-email-hayashi.kunihiko@socionext.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI,

On 09-04-18 03:32, Kunihiko Hayashi wrote:
> This reverts commit f0f56716fc3e5d547fd7811eb218a30ed0695605.
> 
> According to Thierry's view,
> https://www.spinics.net/lists/linux-ide/msg55357.html
> some hardware-specific drivers already use their own resets,
> and the common reset might make a path to occur double controls of resets.
> 
> For now, revert the commit that adds reset control support to ahci-platform,
> and hold until the solution is confirmed not be affect all hardware-specific
> drivers.
> 
> Fixes: f0f56716fc3e ("ata: ahci-platform: add reset control support")
> Reported-by: Thierry Reding <thierry.reding@gmail.com>
> Suggested-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>   .../devicetree/bindings/ata/ahci-platform.txt      |  1 -
>   drivers/ata/ahci.h                                 |  1 -
>   drivers/ata/libahci_platform.c                     | 24 +++-------------------
>   3 files changed, 3 insertions(+), 23 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.txt b/Documentation/devicetree/bindings/ata/ahci-platform.txt
> index f4006d3..c760ecb 100644
> --- a/Documentation/devicetree/bindings/ata/ahci-platform.txt
> +++ b/Documentation/devicetree/bindings/ata/ahci-platform.txt
> @@ -30,7 +30,6 @@ compatible:
>   Optional properties:
>   - dma-coherent      : Present if dma operations are coherent
>   - clocks            : a list of phandle + clock specifier pairs
> -- resets            : a list of phandle + reset specifier pairs
>   - target-supply     : regulator for SATA target power
>   - phys              : reference to the SATA PHY node
>   - phy-names         : must be "sata-phy"
> diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
> index 4356ef1..a9d996e 100644
> --- a/drivers/ata/ahci.h
> +++ b/drivers/ata/ahci.h
> @@ -350,7 +350,6 @@ struct ahci_host_priv {
>   	u32			em_msg_type;	/* EM message type */
>   	bool			got_runtime_pm; /* Did we do pm_runtime_get? */
>   	struct clk		*clks[AHCI_MAX_CLKS]; /* Optional */
> -	struct reset_control	*rsts;		/* Optional */
>   	struct regulator	**target_pwrs;	/* Optional */
>   	/*
>   	 * If platform uses PHYs. There is a 1:1 relation between the port number and
> diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
> index 46a7624..30cc8f1 100644
> --- a/drivers/ata/libahci_platform.c
> +++ b/drivers/ata/libahci_platform.c
> @@ -25,7 +25,6 @@
>   #include <linux/phy/phy.h>
>   #include <linux/pm_runtime.h>
>   #include <linux/of_platform.h>
> -#include <linux/reset.h>
>   #include "ahci.h"
>   
>   static void ahci_host_stop(struct ata_host *host);
> @@ -196,8 +195,7 @@ EXPORT_SYMBOL_GPL(ahci_platform_disable_regulators);
>    * following order:
>    * 1) Regulator
>    * 2) Clocks (through ahci_platform_enable_clks)
> - * 3) Resets
> - * 4) Phys
> + * 3) Phys
>    *
>    * If resource enabling fails at any point the previous enabled resources
>    * are disabled in reverse order.
> @@ -217,19 +215,12 @@ int ahci_platform_enable_resources(struct ahci_host_priv *hpriv)
>   	if (rc)
>   		goto disable_regulator;
>   
> -	rc = reset_control_deassert(hpriv->rsts);
> -	if (rc)
> -		goto disable_clks;
> -
>   	rc = ahci_platform_enable_phys(hpriv);
>   	if (rc)
> -		goto disable_resets;
> +		goto disable_clks;
>   
>   	return 0;
>   
> -disable_resets:
> -	reset_control_assert(hpriv->rsts);
> -
>   disable_clks:
>   	ahci_platform_disable_clks(hpriv);
>   
> @@ -248,15 +239,12 @@ EXPORT_SYMBOL_GPL(ahci_platform_enable_resources);
>    * following order:
>    * 1) Phys
>    * 2) Clocks (through ahci_platform_disable_clks)
> - * 3) Resets
> - * 4) Regulator
> + * 3) Regulator
>    */
>   void ahci_platform_disable_resources(struct ahci_host_priv *hpriv)
>   {
>   	ahci_platform_disable_phys(hpriv);
>   
> -	reset_control_assert(hpriv->rsts);
> -
>   	ahci_platform_disable_clks(hpriv);
>   
>   	ahci_platform_disable_regulators(hpriv);
> @@ -405,12 +393,6 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev)
>   		hpriv->clks[i] = clk;
>   	}
>   
> -	hpriv->rsts = devm_reset_control_array_get_optional_shared(dev);
> -	if (IS_ERR(hpriv->rsts)) {
> -		rc = PTR_ERR(hpriv->rsts);
> -		goto err_out;
> -	}
> -
>   	hpriv->nports = child_nodes = of_get_child_count(dev->of_node);
>   
>   	/*
> 
