Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C1C1C67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 09:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF3F520779
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 09:15:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF3F520779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbeJVRdg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 13:33:36 -0400
Received: from mail.bootlin.com ([62.4.15.54]:44073 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727218AbeJVRdg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 13:33:36 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 6DCFC208C7; Mon, 22 Oct 2018 11:15:53 +0200 (CEST)
Received: from bbrezillon (aaubervilliers-681-1-25-52.w90-88.abo.wanadoo.fr [90.88.145.52])
        by mail.bootlin.com (Postfix) with ESMTPSA id 0D7442079D;
        Mon, 22 Oct 2018 11:15:43 +0200 (CEST)
Date:   Mon, 22 Oct 2018 11:15:43 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        "richard@nod.at" <richard@nod.at>, Mark Brown <broonie@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "cyrille.pitchen@microchip.com" <cyrille.pitchen@microchip.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "Cristian.Birsan@microchip.com" <Cristian.Birsan@microchip.com>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 1/2] mtd: spi-nor: add support to non-uniform SFDP
 SPI NOR flash memories
Message-ID: <20181022111543.2a607efc@bbrezillon>
In-Reply-To: <VI1PR04MB1038BD6103DD8BD6B6DEC2B899F40@VI1PR04MB1038.eurprd04.prod.outlook.com>
References: <20180911154007.17195-1-tudor.ambarus@microchip.com>
        <20180911154007.17195-2-tudor.ambarus@microchip.com>
        <VI1PR04MB103888BC18F3C5AD0C02DEF699FE0@VI1PR04MB1038.eurprd04.prod.outlook.com>
        <31a8f6a9-1459-443a-6ef8-2b2c17769ae4@microchip.com>
        <de0f7245-2557-12be-a306-67b08e55ae7b@wedev4u.fr>
        <VI1PR04MB1038AB25EABDC8507984ADC799FF0@VI1PR04MB1038.eurprd04.prod.outlook.com>
        <20181017090724.12f2cd79@bbrezillon>
        <20181017091045.124e0266@bbrezillon>
        <20181017092941.3658bd9a@bbrezillon>
        <VI1PR04MB1038EFA1E83AD78EBE84ECC499FF0@VI1PR04MB1038.eurprd04.prod.outlook.com>
        <20181017115237.07310b74@bbrezillon>
        <VI1PR04MB1038BD6103DD8BD6B6DEC2B899F40@VI1PR04MB1038.eurprd04.prod.outlook.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Oct 2018 06:04:13 +0000
Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:


> -       /* Find the matching configuration map */
> -       while (SMPT_MAP_ID(smpt[i]) != map_id) {
> -               if (smpt[i] & SMPT_DESC_END)
> -                       goto out;
> +       if (map_id_is_valid)
> +               pr_info("%s:%i map_id=%d\n", __func__, __LINE__, map_id);
> +       else
> +               pr_info("%s:%i NO map_id\n", __func__, __LINE__);
> +
> +       for (nmaps = 0; nmaps< smpt_len; nmaps++) {

Why did you change this for loop?

> +               if(!(smpt[nmaps] & SMPT_DESC_TYPE_MAP))
> +                       continue;
> +
> +               if(!map_id_is_valid) {
> +                       if (nmaps) {

With your change in the for () block, this test is no longer valid...

Please keep the original patch and patch the if () condition as
suggested.

> +                               ret = NULL;
> +                               break;
> +                       }
> +
> +                       ret = smpt+nmaps;
> +               } else if (map_id == SMPT_MAP_ID(smpt[nmaps])) {
> +                       ret = smpt+nmaps;
> +                       break;
> +               }
> +
>                 /* increment the table index to the next map */
> -               i += SMPT_MAP_REGION_COUNT(smpt[i]) + 1;
> +               nmaps += SMPT_MAP_REGION_COUNT(smpt[nmaps]) + 1;
>         }
> 
> -       ret = smpt + i;
>         /* fall through */
>  out:
>         nor->addr_width = addr_width;
