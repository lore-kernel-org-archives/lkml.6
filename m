Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15672C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA37A2086D
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:44:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Q9dGnB55"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbfANJmf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 04:42:35 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:2716 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbfANJmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 04:42:33 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c3c596c0001>; Mon, 14 Jan 2019 01:42:04 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 14 Jan 2019 01:42:32 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 14 Jan 2019 01:42:32 -0800
Received: from [192.168.88.246] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 14 Jan
 2019 09:42:29 +0000
Subject: Re: [PATCH] regmap-irq: do not write mask register if mask_base is
 zero
To:     <broonie@kernel.org>, <gregkh@linuxfoundation.org>,
        <rafael@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <linux-tegra@vger.kernel.org>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Jinyoung Park <jinyoungp@nvidia.com>,
        Venkat Reddy Talla <vreddytalla@nvidia.com>
References: <20190114093258.28431-1-markz@nvidia.com>
From:   Mark Zhang <markz@nvidia.com>
Message-ID: <90be2d42-977b-10a9-8c56-0b7a5c61a765@nvidia.com>
Date:   Mon, 14 Jan 2019 17:42:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20190114093258.28431-1-markz@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1547458924; bh=j/8TEAgXqAtF9O1V7AMzI1KQqUQAWXSwDpfVzc3VtZE=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=Q9dGnB55poU9ZYEqutym8oWk5TUb40XoUPIpBcr/Aex6o4HFN/gPCSnOFG7kcow2F
         3aCX3ivwLSY3GksRaw/cKC0G+wgPo1xXDIGDwyr+FS2/3o3M5PDN9RNcJrrWKn32Hf
         Ut9EUsaSKCpNZCZdTRhm6j6UVAc6xc6jdJyAbzsEkdETtYfqsY77a+A+0VSqpf2If7
         4NYkdNCCLHWLmLQ9s3yixTFPyV6lL1D9ESgKQQSP6pneJcbratk/4B8I2VLZR2zPI1
         gbLyrjODZJEwk+YuHJVq9MfzLA5b8g8g/M3LAbuORUAmrY58mEh3czDMaEgRNgHxld
         5GNVT8E83JgPw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some background infos:
This patch fixes an issue when using max77620 gpio driver.
The issue is that, max77620 doesn't have a dedicated GPIO interrupt mask register.
If you want to mask a separate GPIO interrupt on max77620, you need to do that in
it's type register(starting from register address 0x36 - 0x3D).
So this means we can't find a proper register for "mask_base" property, while in current
regmap-irq.c, it updates mask registers assuming "mask_base" is always provided.

Maybe this patch is not the cleanest way to fix the issue, e.g: some chip's mask register
address is zero, in that case, could you help to suggest what is the right way?

Thanks,
Mark

On 1/14/2019 5:32 PM, Mark Zhang wrote:
> If client have not provided the mask base register then do not
> write into the mask register.
> 
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> Signed-off-by: Jinyoung Park <jinyoungp@nvidia.com>
> Signed-off-by: Venkat Reddy Talla <vreddytalla@nvidia.com>
> Signed-off-by: Mark Zhang <markz@nvidia.com>
> ---
>  drivers/base/regmap/regmap-irq.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
> index d2d0014b0d23..330c1f7e9665 100644
> --- a/drivers/base/regmap/regmap-irq.c
> +++ b/drivers/base/regmap/regmap-irq.c
> @@ -108,6 +108,9 @@ static void regmap_irq_sync_unlock(struct irq_data *data)
>  	 * suppress pointless writes.
>  	 */
>  	for (i = 0; i < d->chip->num_regs; i++) {
> +		if (!d->chip->mask_base)
> +			continue;
> +
>  		reg = d->chip->mask_base +
>  			(i * map->reg_stride * d->irq_reg_stride);
>  		if (d->chip->mask_invert) {
> @@ -588,6 +591,9 @@ int regmap_add_irq_chip(struct regmap *map, int irq, int irq_flags,
>  	/* Mask all the interrupts by default */
>  	for (i = 0; i < chip->num_regs; i++) {
>  		d->mask_buf[i] = d->mask_buf_def[i];
> +		if (!chip->mask_base)
> +			continue;
> +
>  		reg = chip->mask_base +
>  			(i * map->reg_stride * d->irq_reg_stride);
>  		if (chip->mask_invert)
> 
