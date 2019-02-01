Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4837C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 01:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADFF020B1F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 01:31:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbfBABb0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 20:31:26 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:37007 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725870AbfBABb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 20:31:26 -0500
X-UUID: 0c19a04efc4e49469a3c3261057127c0-20190201
X-UUID: 0c19a04efc4e49469a3c3261057127c0-20190201
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1676911109; Fri, 01 Feb 2019 09:31:12 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 1 Feb 2019 09:31:10 +0800
Received: from [172.21.77.4] (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 1 Feb 2019 09:31:10 +0800
Message-ID: <1548984670.7501.2.camel@mtksdaap41>
Subject: Re: [PATCH 06/10] soc: mediatek: add register device function
From:   CK Hu <ck.hu@mediatek.com>
To:     Bibby Hsieh <bibby.hsieh@mediatek.com>
CC:     Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        Nicolas Boichat <drinkcat@chromium.org>,
        "YT Shen" <yt.shen@mediatek.com>,
        Daoyuan Huang <daoyuan.huang@mediatek.com>,
        Jiaguang Zhang <jiaguang.zhang@mediatek.com>,
        Dennis-YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        <ginny.chen@mediatek.com>, <kendrick.hsu@mediatek.com>,
        Frederic Chen <Frederic.Chen@mediatek.com>
Date:   Fri, 1 Feb 2019 09:31:10 +0800
In-Reply-To: <1548747128-60136-7-git-send-email-bibby.hsieh@mediatek.com>
References: <1548747128-60136-1-git-send-email-bibby.hsieh@mediatek.com>
         <1548747128-60136-7-git-send-email-bibby.hsieh@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: 5F9CD66F38D58B2368783410EA4ADCE24611ACB8CD381CCC5FEA9C52371936CB2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Bibby:

On Tue, 2019-01-29 at 15:32 +0800, Bibby Hsieh wrote:
> GCE cannot know the register base address, we store the subsys-base address
> relationship in the device node, and store the relationship by
> cmdq_register_device function.
> 
> Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
> ---
>  drivers/soc/mediatek/mtk-cmdq-helper.c | 24 ++++++++++++++++++++++++
>  include/linux/soc/mediatek/mtk-cmdq.h  |  1 +
>  2 files changed, 25 insertions(+)
> 
> diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/mediatek/mtk-cmdq-helper.c
> index 6e4b85e..6ad997f 100644
> --- a/drivers/soc/mediatek/mtk-cmdq-helper.c
> +++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
> @@ -32,6 +32,30 @@ u8 cmdq_subsys_base_to_id(struct cmdq_base *clt_base, u32 base)
>  }
>  EXPORT_SYMBOL(cmdq_subsys_base_to_id);
>  
> +struct cmdq_base *cmdq_register_device(struct device *dev)
> +{
> +	struct cmdq_base *clt_base;
> +	struct of_phandle_args spec;
> +	u32 idx;
> +
> +	clt_base = devm_kzalloc(dev, sizeof(*clt_base), GFP_KERNEL);
> +	if (!clt_base)
> +		return NULL;
> +
> +	/* parse subsys */
> +	for (idx = 0; idx < ARRAY_SIZE(clt_base->subsys); idx++) {
> +		if (of_parse_phandle_with_args(dev->of_node, "gce-subsys",
> +		    "#gce-subsys-cells", idx, &spec))
> +			break;
> +		clt_base->subsys[idx].base = spec.args[0];
> +		clt_base->subsys[idx].id = spec.args[1];

This does not match the binding [1].

[1]
https://www.kernel.org/doc/Documentation/devicetree/bindings/mailbox/mtk-gce.txt

Regards,
CK

> +	}
> +	clt_base->count = idx;
> +
> +	return clt_base;
> +}
> +EXPORT_SYMBOL(cmdq_register_device);
> +
>  static void cmdq_client_timeout(struct timer_list *t)
>  {
>  	struct cmdq_client *client = from_timer(client, t, timer);
> diff --git a/include/linux/soc/mediatek/mtk-cmdq.h b/include/linux/soc/mediatek/mtk-cmdq.h
> index 0c7a6ee..a1f5eb6 100644
> --- a/include/linux/soc/mediatek/mtk-cmdq.h
> +++ b/include/linux/soc/mediatek/mtk-cmdq.h
> @@ -138,5 +138,6 @@ int cmdq_pkt_flush_async(struct cmdq_pkt *pkt, cmdq_async_flush_cb cb,
>  int cmdq_pkt_flush(struct cmdq_pkt *pkt);
>  
>  u8 cmdq_subsys_base_to_id(struct cmdq_base *clt_base, u32 base);
> +struct cmdq_base *cmdq_register_device(struct device *dev);
>  
>  #endif	/* __MTK_CMDQ_H__ */


