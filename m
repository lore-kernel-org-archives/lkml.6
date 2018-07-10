Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90FEDC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 11:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45E2920871
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 11:35:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DzSXVhpx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45E2920871
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754265AbeGJLfB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 07:35:01 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:37260 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751515AbeGJLe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 07:34:59 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w6ABYmnl031964;
        Tue, 10 Jul 2018 06:34:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1531222488;
        bh=05xhS9MFlo8Y3DUpXE//IJhf+NVYKtcyU/3nuthZong=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=DzSXVhpx+5o2ie165geFrisc+yKCRYgxW8jX2B6SczUazMTv9pxpWx2FT1TTBQyex
         9I8DeBdvv60eFq3SHIbP+kp8rC4RTNcd+YyHqbYC7oKkQeOmHMsITRu6qZ1x0u1SkJ
         aYv05SsSc2+g9SfvmUHaGOvAzWDrzeDTZ9/9mi9M=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6ABYm0E023984;
        Tue, 10 Jul 2018 06:34:48 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 10
 Jul 2018 06:34:47 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 10 Jul 2018 06:34:47 -0500
Received: from [172.24.190.215] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6ABYifq009102;
        Tue, 10 Jul 2018 06:34:45 -0500
Subject: Re: [PATCH v2] can: m_can: Move accessing of message ram to after
 clocks are enabled
To:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-can@vger.kernel.org>, <linux-omap@vger.kernel.org>
CC:     <wg@grandegger.com>, <mkl@pengutronix.de>, <davem@davemloft.net>
References: <20180703111710.27084-1-faiz_abbas@ti.com>
From:   Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <6e702a44-c2c3-30ff-58cd-761b667a1e56@ti.com>
Date:   Tue, 10 Jul 2018 17:06:33 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180703111710.27084-1-faiz_abbas@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tuesday 03 July 2018 04:47 PM, Faiz Abbas wrote:
> MCAN message ram should only be accessed once clocks are enabled.
> Therefore, move the call to parse/init the message ram to after
> clocks are enabled.
> 
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> ---
> Changes in v2:
> 
> rebased to latest mainline
> 
>  drivers/net/can/m_can/m_can.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
> index ac4c6dc2f8c8..04c48371ab2a 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -1644,8 +1644,6 @@ static int m_can_plat_probe(struct platform_device *pdev)
>  	priv->can.clock.freq = clk_get_rate(cclk);
>  	priv->mram_base = mram_addr;
>  
> -	m_can_of_parse_mram(priv, mram_config_vals);
> -
>  	platform_set_drvdata(pdev, dev);
>  	SET_NETDEV_DEV(dev, &pdev->dev);
>  
> @@ -1668,6 +1666,8 @@ static int m_can_plat_probe(struct platform_device *pdev)
>  		goto clk_disable;
>  	}
>  
> +	m_can_of_parse_mram(priv, mram_config_vals);
> +
>  	devm_can_led_init(dev);
>  
>  	of_can_transceiver(dev);
> @@ -1715,8 +1715,6 @@ static __maybe_unused int m_can_resume(struct device *dev)
>  
>  	pinctrl_pm_select_default_state(dev);
>  
> -	m_can_init_ram(priv);
> -
>  	priv->can.state = CAN_STATE_ERROR_ACTIVE;
>  
>  	if (netif_running(ndev)) {
> @@ -1726,6 +1724,7 @@ static __maybe_unused int m_can_resume(struct device *dev)
>  		if (ret)
>  			return ret;
>  
> +		m_can_init_ram(priv);
>  		m_can_start(ndev);
>  		netif_device_attach(ndev);
>  		netif_start_queue(ndev);
> 

Gentle ping.

Thanks,
Faiz
