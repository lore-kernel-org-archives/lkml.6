Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4DDDC46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 07:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BA5F20880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 07:43:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BA5F20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbeILMrG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 08:47:06 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:9966 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbeILMrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 08:47:06 -0400
X-IronPort-AV: E=Sophos;i="5.53,363,1531810800"; 
   d="scan'208";a="19810976"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 12 Sep 2018 00:43:49 -0700
Received: from [10.145.4.48] (10.10.76.4) by chn-sv-exch05.mchp-main.com
 (10.10.76.106) with Microsoft SMTP Server id 14.3.352.0; Wed, 12 Sep 2018
 00:43:48 -0700
Subject: Re: [PATCH] staging: wilc1000: fix null checks on wilc
To:     Colin King <colin.king@canonical.com>,
        Aditya Shankar <aditya.shankar@microchip.com>,
        Ganesh Krishna <ganesh.krishna@microchip.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-wireless@vger.kernel.org>, <devel@driverdev.osuosl.org>
CC:     <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20180911173851.17567-1-colin.king@canonical.com>
From:   Claudiu Beznea <Claudiu.Beznea@microchip.com>
Message-ID: <d6520e83-68d4-1c32-5291-74163b74e249@microchip.com>
Date:   Wed, 12 Sep 2018 10:43:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180911173851.17567-1-colin.king@canonical.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11.09.2018 20:38, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently the pointer wilc is being null checked several times
> and yet not checked for the final workqueue flush and destroy
> (which can lead to a null pointer dereference if wilc is null);
> these missing null checks were overlooked in an earlier core
> refactoring commit.
> 
> Clean up the code by checking wilc at the start and bailing out
> early if it is null allowing the subsequent null checks to be
> removed, this also fixes the potential null pointer deferences
> on the workqueue flush and destroy calls.
> 
> Detected by CoverityScan, CID#1473305 ("Dereference after null check")
> 
> Fixes: b3ee105c332e ("staging: wilc1000: refactor code to move initilization in wilc_netdev_init()")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Reviewed-by: Claudiu Beznea <claudiu.beznea@microchip.com>

> ---
>  drivers/staging/wilc1000/linux_wlan.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/wilc1000/linux_wlan.c b/drivers/staging/wilc1000/linux_wlan.c
> index a498321c908b..49afda669393 100644
> --- a/drivers/staging/wilc1000/linux_wlan.c
> +++ b/drivers/staging/wilc1000/linux_wlan.c
> @@ -1015,15 +1015,18 @@ void wilc_netdev_cleanup(struct wilc *wilc)
>  {
>  	int i;
>  
> -	if (wilc && (wilc->vif[0]->ndev || wilc->vif[1]->ndev))
> +	if (!wilc)
> +		return;
> +
> +	if (wilc->vif[0]->ndev || wilc->vif[1]->ndev)
>  		unregister_inetaddr_notifier(&g_dev_notifier);
>  
> -	if (wilc && wilc->firmware) {
> +	if (wilc->firmware) {
>  		release_firmware(wilc->firmware);
>  		wilc->firmware = NULL;
>  	}
>  
> -	if (wilc && (wilc->vif[0]->ndev || wilc->vif[1]->ndev)) {
> +	if (wilc->vif[0]->ndev || wilc->vif[1]->ndev) {
>  		for (i = 0; i < NUM_CONCURRENT_IFC; i++)
>  			if (wilc->vif[i]->ndev)
>  				if (wilc->vif[i]->mac_opened)
> 
