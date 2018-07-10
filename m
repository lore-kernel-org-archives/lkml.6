Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F057C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 11:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A55C2075C
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 11:35:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="IJU4Z7ju"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A55C2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933229AbeGJLfV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 07:35:21 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:59040 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932710AbeGJLfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 07:35:19 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w6ABZ9bq026066;
        Tue, 10 Jul 2018 06:35:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1531222509;
        bh=8jHYb8pSkbZpoNscD1FLbKe4HPbxVp8bp+8iyX8XiZc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=IJU4Z7juueCrQVJf/D3Br8YBx6l2NZDkWS9WLdz9sVDID4PPxTe/czq2jNh50t+W/
         xbh+cQEKdUw/ijptWc8m3nG7imKPzmj69EP3nxsYl1sSPr46Wb1DMkzcoHpcKK+gO1
         qDNoXm3WM8cMov5CwYq61kBWFvtQ8fUulR7Lgjbk=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6ABZ9xZ011422;
        Tue, 10 Jul 2018 06:35:09 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 10
 Jul 2018 06:35:08 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 10 Jul 2018 06:35:08 -0500
Received: from [172.24.190.215] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6ABZ5mc009601;
        Tue, 10 Jul 2018 06:35:06 -0500
Subject: Re: [PATCH v2] can: m_can: Fix runtime resume call
To:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-can@vger.kernel.org>, <linux-omap@vger.kernel.org>
CC:     <wg@grandegger.com>, <mkl@pengutronix.de>, <davem@davemloft.net>
References: <20180703111102.26502-1-faiz_abbas@ti.com>
From:   Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <6af0c052-b349-967a-c86c-370aba374318@ti.com>
Date:   Tue, 10 Jul 2018 17:06:54 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180703111102.26502-1-faiz_abbas@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tuesday 03 July 2018 04:41 PM, Faiz Abbas wrote:
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
> 
> Changes in v2:
> 
> rebased to latest mainline
> 
>  drivers/net/can/m_can/m_can.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
> index b397a33f3d32..ac4c6dc2f8c8 100644
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
