Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D198C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 14:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61E3121479
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 14:35:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Vg7n7cF2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61E3121479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731084AbeKVBJl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 20:09:41 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:6746 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729658AbeKVBJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 20:09:40 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bf56d150001>; Wed, 21 Nov 2018 06:35:01 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 21 Nov 2018 06:35:00 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 21 Nov 2018 06:35:00 -0800
Received: from [10.21.132.148] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 21 Nov
 2018 14:34:59 +0000
Subject: Re: [PATCH] soc/tegra: refactor soc_is_tegra()
To:     Yangtao Li <tiny.windzz@gmail.com>, <thierry.reding@gmail.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20181121141204.22819-1-tiny.windzz@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <2d534bbb-7b75-8521-bf88-36b52c918d19@nvidia.com>
Date:   Wed, 21 Nov 2018 14:34:57 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181121141204.22819-1-tiny.windzz@gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1542810901; bh=OmfWy2Wi0lHqfh9vFgp9IB7ly+Cl2AdjxAabsSjCV2w=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=Vg7n7cF21S4urS1s+fwoucrdIrUF2EeN48ZBuziKxw+kusrv13oXUE5ufbwRxMfzu
         KzC10MJKz9U4rRyJ+mBx4ERGw3tbh/Ul8HMRjak976i2jKrSfijELT6TW78YoqQ09k
         CpytnWwTtVsxZbOc64Mo/+juiyEWAhXRJ6wtM1GE3On7GAKOlOX1uJ0DG4K+/t80gi
         Oh35BsZFWNbCQrvrkD5shxazgvV5tp7kvPgD0573ryotIJAwqOg8yIR/UUvoBCWEFi
         XVoNlZmJE5KmQkvyoqYpk7csx2Z4/6pIHYF2sAI5vq+4ym2VCOa82LQC/OjzoLLIoU
         zc1vVPAAA5btw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 21/11/2018 14:12, Yangtao Li wrote:
> of_find_node_by_path() acquires a reference to the node returned by
> it and that reference needs to be dropped by its caller.soc_is_tegra()
> doesn't do that, so fix it.Call of_machine_is_compatible() to refactor
> soc_is_tegra() whcih automatically manages the reference count.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/soc/tegra/common.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/soc/tegra/common.c b/drivers/soc/tegra/common.c
> index cd8f41351add..0b40700b672a 100644
> --- a/drivers/soc/tegra/common.c
> +++ b/drivers/soc/tegra/common.c
> @@ -22,11 +22,13 @@ static const struct of_device_id tegra_machine_match[] = {
>  
>  bool soc_is_tegra(void)
>  {
> -	struct device_node *root;
> +	struct of_device_id *match = tegra_machine_match;
>  
> -	root = of_find_node_by_path("/");
> -	if (!root)
> -		return false;
> +	while(match->compatible){
> +		if(of_machine_is_compatible(match->compatible))
> +			return true;
> +		match++;
> +	}
>  
> -	return of_match_node(tegra_machine_match, root) != NULL;
> +	return false;
>  }

Ugh ... sorry, I thought that of_machine_is_compatible() looped through
the matches. OK, let's stick with your initial fix.

Cheers
Jon

-- 
nvpublic
