Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD92ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 10:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90EED20C09
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 10:57:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90EED20C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731296AbeGQL31 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 07:29:27 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:2253 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729641AbeGQL31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 07:29:27 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b4dcb8c0000>; Tue, 17 Jul 2018 03:57:16 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 17 Jul 2018 03:57:23 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 17 Jul 2018 03:57:23 -0700
Received: from [10.21.26.144] (10.21.26.144) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 17 Jul
 2018 10:57:18 +0000
Subject: Re: [PATCH] Revert "ata: ahci_platform: convert kcalloc to
 devm_kcalloc"
To:     Corentin Labbe <clabbe@baylibre.com>, <hdegoede@redhat.com>,
        <tj@kernel.org>, <sfr@canb.auug.org.au>
CC:     <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1531824575-852-1-git-send-email-clabbe@baylibre.com>
From:   Mikko Perttunen <mperttunen@nvidia.com>
Message-ID: <c8a963fa-70c8-ea79-3c30-69bf723fb764@nvidia.com>
Date:   Tue, 17 Jul 2018 13:57:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1531824575-852-1-git-send-email-clabbe@baylibre.com>
X-Originating-IP: [10.21.26.144]
X-ClientProxiedBy: UKMAIL101.nvidia.com (10.26.138.13) To HQMAIL101.nvidia.com
 (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks!

Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>

On 17.07.2018 13:49, Corentin Labbe wrote:
> Since ahci_platform_put_resources() use target_pwrs after "devm_" freed
> it, we cannot use devm_kcalloc for allocating target_pwrs.
> 
> This reverts commit bd0038b1b4f499d814d8f33a55b1df5ea6cf3b85.
> 
> Reported-by: Mikko Perttunen <mperttunen@nvidia.com>
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>   drivers/ata/libahci_platform.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
> index fe8939e161ea..2ceebaf2ed56 100644
> --- a/drivers/ata/libahci_platform.c
> +++ b/drivers/ata/libahci_platform.c
> @@ -271,6 +271,8 @@ static void ahci_platform_put_resources(struct device *dev, void *res)
>   	for (c = 0; c < hpriv->nports; c++)
>   		if (hpriv->target_pwrs && hpriv->target_pwrs[c])
>   			regulator_put(hpriv->target_pwrs[c]);
> +
> +	kfree(hpriv->target_pwrs);
>   }
>   
>   static int ahci_platform_get_phy(struct ahci_host_priv *hpriv, u32 port,
> @@ -406,7 +408,11 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev)
>   		rc = -ENOMEM;
>   		goto err_out;
>   	}
> -	hpriv->target_pwrs = devm_kcalloc(dev, hpriv->nports, sizeof(*hpriv->target_pwrs), GFP_KERNEL);
> +	/*
> +	 * We cannot use devm_ here, since ahci_platform_put_resources() uses
> +	 * target_pwrs after devm_ have freed memory
> +	 */
> +	hpriv->target_pwrs = kcalloc(hpriv->nports, sizeof(*hpriv->target_pwrs), GFP_KERNEL);
>   	if (!hpriv->target_pwrs) {
>   		rc = -ENOMEM;
>   		goto err_out;
> 
