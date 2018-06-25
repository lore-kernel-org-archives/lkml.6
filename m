Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8420BC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 23:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29744218E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 23:16:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="eqhgU38p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29744218E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755097AbeFYXQt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 19:16:49 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:35538 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752606AbeFYXQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 19:16:47 -0400
X-Greylist: delayed 377 seconds by postgrey-1.27 at vger.kernel.org; Mon, 25 Jun 2018 19:16:47 EDT
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w5PN9720034308;
        Mon, 25 Jun 2018 18:09:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1529968147;
        bh=JdcMAQgPmshjiCkKkFeHhwKQvvMCsM2p4t7bR2UDqXU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=eqhgU38pVaXpENVsAGKZXk2x6T8JhQ5GqVkp8nO5uJyEYHQnRBcDlzrKFpXZbEKr8
         cCYX8S767+3cQae0OjFSkFDv5c1CQKLgKFYlVZt8lduHyyb2OmXgxy2bhDHLz62E/R
         HG0UQdTawpyK3NfcIsNBemsK+F61tau0Zb3Pxf84=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5PN97M8011002;
        Mon, 25 Jun 2018 18:09:07 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 25
 Jun 2018 18:09:07 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 25 Jun 2018 18:09:07 -0500
Received: from [128.247.59.147] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5PN97ZY026248;
        Mon, 25 Jun 2018 18:09:07 -0500
Subject: Re: [PATCH 07/14] net: davinci_emac: use nvmem to retrieve the mac
 address
To:     Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        "David S . Miller" <davem@davemloft.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Lukas Wunner <lukas@wunner.de>, Rob Herring <robh@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        David Lechner <david@lechnology.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <netdev@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20180625155025.12567-1-brgl@bgdev.pl>
 <20180625155025.12567-8-brgl@bgdev.pl>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <590fd122-1c13-8958-7e84-dbc5c5ea65f3@ti.com>
Date:   Mon, 25 Jun 2018 18:09:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180625155025.12567-8-brgl@bgdev.pl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/25/2018 10:50 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> All users which store the MAC address in EEPROM now register relevant
> nvmem cells. Switch to retrieving the MAC address over the nvmem
> framework.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>   drivers/net/ethernet/ti/davinci_emac.c | 29 +++++++++++++++++---------
>   1 file changed, 19 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ti/davinci_emac.c b/drivers/net/ethernet/ti/davinci_emac.c
> index a1a6445b5a7e..22c2322e46be 100644
> --- a/drivers/net/ethernet/ti/davinci_emac.c
> +++ b/drivers/net/ethernet/ti/davinci_emac.c
> @@ -67,7 +67,7 @@
>   #include <linux/of_irq.h>
>   #include <linux/of_net.h>
>   #include <linux/mfd/syscon.h>
> -
> +#include <linux/nvmem-consumer.h>
>   #include <asm/irq.h>
>   #include <asm/page.h>
>   
> @@ -1696,7 +1696,6 @@ davinci_emac_of_get_pdata(struct platform_device *pdev, struct emac_priv *priv)
>   	const struct of_device_id *match;
>   	const struct emac_platform_data *auxdata;
>   	struct emac_platform_data *pdata = NULL;
> -	const u8 *mac_addr;
>   
>   	if (!IS_ENABLED(CONFIG_OF) || !pdev->dev.of_node)
>   		return dev_get_platdata(&pdev->dev);
> @@ -1708,12 +1707,6 @@ davinci_emac_of_get_pdata(struct platform_device *pdev, struct emac_priv *priv)
>   	np = pdev->dev.of_node;
>   	pdata->version = EMAC_VERSION_2;
>   
> -	if (!is_valid_ether_addr(pdata->mac_addr)) {
> -		mac_addr = of_get_mac_address(np);
> -		if (mac_addr)
> -			ether_addr_copy(pdata->mac_addr, mac_addr);
> -	}
> -

Not sure it is correct. of_get_mac_address() is called when board data doesn't
provide MAC address with expectation that MAC address is defined in DT (usually by u-boot).
Standard DT properties for MAC address "local-mac-address" and "mac-address".

So, you can't just drop it and replace with nvmem.

Two options are here:
1) try to read MAC-address from nvmem then try DT (as it's now)
2) try to read DT then try nvmem [then random MAC | fail]


>   	of_property_read_u32(np, "ti,davinci-ctrl-reg-offset",
>   			     &pdata->ctrl_reg_offset);
>   
> @@ -1783,7 +1776,9 @@ static int davinci_emac_probe(struct platform_device *pdev)
>   	struct cpdma_params dma_params;
>   	struct clk *emac_clk;
>   	unsigned long emac_bus_frequency;
> -
> +	struct nvmem_cell *cell;
> +	void *mac_addr;
> +	size_t mac_addr_len;
>   
>   	/* obtain emac clock from kernel */
>   	emac_clk = devm_clk_get(&pdev->dev, NULL);
> @@ -1815,8 +1810,22 @@ static int davinci_emac_probe(struct platform_device *pdev)
>   		goto err_free_netdev;
>   	}
>   
> +	cell = nvmem_cell_get(&pdev->dev, "mac-address");
> +	if (!IS_ERR(cell)) {
> +		mac_addr = nvmem_cell_read(cell, &mac_addr_len);
> +		if (!IS_ERR(mac_addr)) {
> +			if (is_valid_ether_addr(mac_addr)) {
> +				dev_info(&pdev->dev,
> +					 "Read MAC addr from EEPROM: %pM\n",
> +					 mac_addr);
> +				memcpy(priv->mac_addr, mac_addr, ETH_ALEN);
> +			}
> +			kfree(mac_addr);
> +		}
> +		nvmem_cell_put(cell);
> +	}
> +
>   	/* MAC addr and PHY mask , RMII enable info from platform_data */
> -	memcpy(priv->mac_addr, pdata->mac_addr, ETH_ALEN);
>   	priv->phy_id = pdata->phy_id;
>   	priv->rmii_en = pdata->rmii_en;
>   	priv->version = pdata->version;
> 

-- 
regards,
-grygorii
