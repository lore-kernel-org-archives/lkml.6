Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A208C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 10:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1810121872
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 10:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HEI7GnxF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbfBGKzZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 05:55:25 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:47640 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbfBGKzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 05:55:24 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x17AtMcP085200;
        Thu, 7 Feb 2019 04:55:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1549536922;
        bh=2bxrrISIoGGUEqxqDAh5JhOxJ38tUroms65YKkxiZ6M=;
        h=Subject:To:References:CC:From:Date:In-Reply-To;
        b=HEI7GnxFXWgMnqpt5C2uk2Pk7A4JK6NfePGIzo4juCOsTnPMN2zWvqbrR+VLnXOcV
         XzsabeKrZXO5gIqNi/cgfGgOP7r1zL8lOsvnG2s6FALhqkumxSY2nr+ugv/DoGspyR
         wj2/bwPEpDNtUrHjbGLRVKQHQnT7XT+5ipbSZTnE=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x17AtMwD035082
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 7 Feb 2019 04:55:22 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 7
 Feb 2019 04:55:19 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 7 Feb 2019 04:55:19 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x17AtGOJ011014;
        Thu, 7 Feb 2019 04:55:17 -0600
Subject: Re: [PATCH v2 1/4] phy: core: Add *release* phy_ops invoked when the
 consumer relinquishes PHY
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>
References: <20190206110753.28738-1-kishon@ti.com>
 <20190206110753.28738-2-kishon@ti.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <5C5C0E94.4090401@ti.com>
Date:   Thu, 7 Feb 2019 12:55:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <20190206110753.28738-2-kishon@ti.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kishon,

On 06/02/19 13:07, Kishon Vijay Abraham I wrote:
> Add a new phy_ops *release* invoked when the consumer relinquishes the
> PHY using phy_put/devm_phy_put. The initializations done by the PHY
> driver in of_xlate call back can be can be cleaned up here.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/phy/phy-core.c  | 5 +++++
>  include/linux/phy/phy.h | 2 ++
>  2 files changed, 7 insertions(+)
> 
> diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
> index 19b05e824ee4..d4bd85afdc91 100644
> --- a/drivers/phy/phy-core.c
> +++ b/drivers/phy/phy-core.c
> @@ -564,6 +564,11 @@ void phy_put(struct phy *phy)
>  	if (!phy || IS_ERR(phy))
>  		return;
>  
> +	mutex_lock(&phy->mutex);
> +	if (phy->ops->release)
> +		phy->ops->release(phy);
> +	mutex_unlock(&phy->mutex);
> +
>  	module_put(phy->ops->owner);
>  	put_device(&phy->dev);
>  }
> diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
> index e8e118d70fd7..feb8dce54ac2 100644
> --- a/include/linux/phy/phy.h
> +++ b/include/linux/phy/phy.h
> @@ -63,6 +63,7 @@ union phy_configure_opts {
>   * @set_mode: set the mode of the phy
>   * @reset: resetting the phy
>   * @calibrate: calibrate the phy
> + * @release: ops to be performed while the consumer reliquishes the PHY

s/reliquishes/relinquishes

>   * @owner: the module owner containing the ops
>   */
>  struct phy_ops {
> @@ -104,6 +105,7 @@ struct phy_ops {
>  			    union phy_configure_opts *opts);
>  	int	(*reset)(struct phy *phy);
>  	int	(*calibrate)(struct phy *phy);
> +	void	(*release)(struct phy *phy);
>  	struct module *owner;
>  };
>  
> 

cheers,
-roger
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
