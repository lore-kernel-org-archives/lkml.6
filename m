Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Qb6EI9rr"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 79FB8605BD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932487AbeFFHwH (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 03:52:07 -0400
Received: from lelnx194.ext.ti.com ([198.47.27.80]:47201 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932309AbeFFHwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 03:52:04 -0400
Subject: Re: [PATCH] can: m_can: Fix runtime resume call
To: <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>
CC: <mkl@pengutronix.de>, <wg@grandegger.com>
References: <20180529132426.31216-1-faiz_abbas@ti.com>
From: Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <cc569a2e-0075-bd9b-2f90-4c6427dc185c@ti.com>
Date: Wed, 6 Jun 2018 13:23:13 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180529132426.31216-1-faiz_abbas@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tuesday 29 May 2018 06:54 PM, Faiz Abbas wrote:
> pm_runtime_get_sync() returns a 1 if the state of the device is already
> 'active'. This is not a failure case and should return a success.
> 
> Therefore fix error handling for pm_runtime_get_sync() call such that
> it returns success when the value is 1.
> 
> Also cleanup the TODO for using runtime PM for sleep mode as that is
> implemented.
> 
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> ---
>  drivers/net/can/m_can/m_can.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
> index a9fbf81ac3d4..04c48371ab2a 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -634,10 +634,12 @@ static int m_can_clk_start(struct m_can_priv *priv)
>  	int err;
>  
>  	err = pm_runtime_get_sync(priv->device);
> -	if (err)
> +	if (err < 0) {
>  		pm_runtime_put_noidle(priv->device);
> +		return err;
> +	}
>  
> -	return err;
> +	return 0;
>  }
>  
>  static void m_can_clk_stop(struct m_can_priv *priv)
> @@ -1687,8 +1689,6 @@ static int m_can_plat_probe(struct platform_device *pdev)
>  	return ret;
>  }
>  
> -/* TODO: runtime PM with power down or sleep mode  */
> -
>  static __maybe_unused int m_can_suspend(struct device *dev)
>  {
>  	struct net_device *ndev = dev_get_drvdata(dev);
> 

Gentle ping.

Thanks,
Faiz
