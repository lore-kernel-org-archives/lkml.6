Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76BA6C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 13:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4077C214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 13:31:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="DXerm+Al"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4077C214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730796AbeKVAFi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 19:05:38 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:13499 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729421AbeKVAFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 19:05:37 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bf55e290000>; Wed, 21 Nov 2018 05:31:22 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 21 Nov 2018 05:31:13 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 21 Nov 2018 05:31:13 -0800
Received: from [10.21.132.148] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 21 Nov
 2018 13:31:12 +0000
Subject: Re: [PATCH] soc/tegra: add of_node_put()
To:     Yangtao Li <tiny.windzz@gmail.com>, <thierry.reding@gmail.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20181121124912.22074-1-tiny.windzz@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <f38e8b29-d1db-f915-6699-aec9013bfe7e@nvidia.com>
Date:   Wed, 21 Nov 2018 13:31:10 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181121124912.22074-1-tiny.windzz@gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1542807082; bh=VKtCNSsbJLExZbum/PysA4pC5T5tKljM4nq81ORk+Kg=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=DXerm+AlkuYmNrmc5Evv+/ijX4RB58AbEAw1inTVUwB7QuEiJW+kp2qqByzBDCfi2
         9+ehB9xcASJZ3Cp20fSgRNU8BkeWCtXIlszNX5N+U9OeDA7HUitt95RDouLF4ndtc+
         BVh2L9dn/ttA5Wiq85KkIWbrlMOyzZARN4ZJcZJwFNVWoEfzii2bU25q+Kps2FDsqN
         5wNn47qCuLVwLzSR80zFxuuRbuEQM1nefN1E4XO7W9jjikp0DLU44hs39jv+HHVtwW
         dCVQE5eQT41SCPqZq6P3cLO9AtH7s7JnPClqYReBVRDpeBBzK47zPqLeSG+/66ZXez
         rcTgc8mUL8rTw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 21/11/2018 12:49, Yangtao Li wrote:
> of_find_node_by_path() acquires a reference to the node
> returned by it and that reference needs to be dropped by its caller.
> bl_idle_init() doesn't do that, so fix it.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/soc/tegra/common.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/tegra/common.c b/drivers/soc/tegra/common.c
> index cd8f41351add..2e30604c9658 100644
> --- a/drivers/soc/tegra/common.c
> +++ b/drivers/soc/tegra/common.c
> @@ -23,10 +23,13 @@ static const struct of_device_id tegra_machine_match[] = {
>  bool soc_is_tegra(void)
>  {
>  	struct device_node *root;
> +	bool rc;
>  
>  	root = of_find_node_by_path("/");
>  	if (!root)
>  		return false;
>  
> -	return of_match_node(tegra_machine_match, root) != NULL;
> +	rc = of_match_node(tegra_machine_match, root) != NULL;
> +	of_node_put(root);
> +	return rc;
>  }

Thanks for the fix, however, I think it would be even simpler just to
call of_machine_is_compatible() here instead.

Cheers
Jon

-- 
nvpublic
