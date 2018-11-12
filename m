Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A4FAC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 15:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF0432243E
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 15:37:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF0432243E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaiser.cx
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729530AbeKMBbN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 20:31:13 -0500
Received: from viti.kaiser.cx ([85.214.81.225]:60460 "EHLO viti.kaiser.cx"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726981AbeKMBbN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 20:31:13 -0500
Received: from martin by viti.kaiser.cx with local (Exim 4.89)
        (envelope-from <martin@viti.kaiser.cx>)
        id 1gMEHB-0000FA-OY; Mon, 12 Nov 2018 16:37:21 +0100
Date:   Mon, 12 Nov 2018 16:37:21 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     "A.s. Dong" <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH] pinctrl: imx: make sure that maps are fully initialized
Message-ID: <20181112153721.ekgpql3pj3bbv6ee@viti.kaiser.cx>
References: <1541871439-4882-1-git-send-email-martin@kaiser.cx>
 <AM0PR04MB4290D734ED5D039A903DA2DBEEC00@AM0PR04MB4290.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM0PR04MB4290D734ED5D039A903DA2DBEEC00@AM0PR04MB4290.eurprd04.prod.outlook.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leonard,

Thus wrote Leonard Crestez (leonard.crestez@nxp.com):

> On 11/10/18 7:37 PM, Martin Kaiser wrote:
> > The commit that added scu based pinctrl support introduced a regression
> > for the mmio case. In the for-loop where the maps are initialized, we
> > end up creating a partially initialized map in some cases. This causes a
> > kernel panic when such a map is used at a later stage.

> > Fixes: b96eea718bf6 ("pinctrl: fsl: add scu based pinctrl support")
> > Cc: A.s. Dong <aisheng.dong@nxp.com>

> > diff --git a/drivers/pinctrl/freescale/pinctrl-imx.c b/drivers/pinctrl/freescale/pinctrl-imx.c
> > @@ -108,9 +108,6 @@ static int imx_dt_node_to_map(struct pinctrl_dev *pctldev,
> >   	new_map++;
> >   	for (i = j = 0; i < grp->num_pins; i++) {
> >   		pin = &((struct imx_pin *)(grp->data))[i];
> > -		new_map[j].type = PIN_MAP_TYPE_CONFIGS_PIN;
> > -		new_map[j].data.configs.group_or_pin =
> > -					pin_get_name(pctldev, pin->pin);

> >   		if (info->flags & IMX_USE_SCU) {
> >   			/*
> > @@ -126,7 +123,12 @@ static int imx_dt_node_to_map(struct pinctrl_dev *pctldev,
> >   			new_map[j].data.configs.num_configs = 1;
> >   		}

> > -		j++;
> > +		if (new_map[j].data.configs.num_configs) {
> > +			new_map[j].type = PIN_MAP_TYPE_CONFIGS_PIN;
> > +			new_map[j].data.configs.group_or_pin =
> > +				pin_get_name(pctldev, pin->pin);
> > +			j++;
> > +		}

> Sorry but I don't think this is correct.

> The new_map array is allocated with kmalloc_array so we can't rely on 
> new_map[j].data.configs.num_configs being initialized to zero unless 
> assigned to.

you're right. There's no guarantee that the memory area is initialized
to 0.

Regards,
Martin
