Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2BFFC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9C9C2085B
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:13:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbfA2LN1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:13:27 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:39350 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725808AbfA2LN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:13:27 -0500
X-UUID: d226aa9a63de47d28b351ba2576174d4-20190129
X-UUID: d226aa9a63de47d28b351ba2576174d4-20190129
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 533111281; Tue, 29 Jan 2019 19:13:23 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 29 Jan 2019 19:13:21 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 29 Jan 2019 19:13:21 +0800
Message-ID: <1548760401.11055.14.camel@mtksdaap41>
Subject: Re: [PATCH 09/10] soc: mediatek: change the argument of write and
 write_mask API
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
Date:   Tue, 29 Jan 2019 19:13:21 +0800
In-Reply-To: <1548747128-60136-10-git-send-email-bibby.hsieh@mediatek.com>
References: <1548747128-60136-1-git-send-email-bibby.hsieh@mediatek.com>
         <1548747128-60136-10-git-send-email-bibby.hsieh@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: 433790CE84CD2A062C8E9A921330B0CEFFF4AA745752DFB3361EC0CCBE68712F2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Bibby:

On Tue, 2019-01-29 at 15:32 +0800, Bibby Hsieh wrote:
> In order to enhance the convienience of client usage,
> we change the input argument from subsys and offset to
> struct cmdq_base and dma_addr_t.
> 
> Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
> ---
>  drivers/soc/mediatek/mtk-cmdq-helper.c | 24 +++++++++++++++++-------
>  include/linux/soc/mediatek/mtk-cmdq.h  | 16 ++++++++--------
>  2 files changed, 25 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/mediatek/mtk-cmdq-helper.c
> index 923a815..34ae712 100644
> --- a/drivers/soc/mediatek/mtk-cmdq-helper.c
> +++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
> @@ -238,8 +238,13 @@ static int cmdq_pkt_append_command(struct cmdq_pkt *pkt, s16 arg_c, s16 arg_b,
>  	return 0;
>  }
>  
> -int cmdq_pkt_write(struct cmdq_pkt *pkt, u8 subsys, u16 offset, u32 value)
> +int cmdq_pkt_write(struct cmdq_pkt *pkt, struct cmdq_base *clt_base,
> +		   dma_addr_t addr, u32 value)
>  {
> +	const u32 base = (addr >> 32) ? 0 : addr & 0xFFFF0000;
> +	u8 subsys = cmdq_subsys_base_to_id(clt_base, base);

I don't understand why this would let client more convenient?  Every
time client call cmdq_pkt_write(), cmdq_subsys_base_to_id() would search
again. Why do we need such frequently search?

Regards,
CK

> +	s16 offset = addr & 0x0000FFFF;
> +
>  	return cmdq_pkt_append_command(pkt, CMDQ_GET_ARG_C(value),
>  				       CMDQ_GET_ARG_B(value), offset, subsys,
>  				       CMDQ_IMMEDIATE_VALUE,
> @@ -248,21 +253,26 @@ int cmdq_pkt_write(struct cmdq_pkt *pkt, u8 subsys, u16 offset, u32 value)
>  }
>  EXPORT_SYMBOL(cmdq_pkt_write);
>  
> -int cmdq_pkt_write_mask(struct cmdq_pkt *pkt, u8 subsys, u16 offset,
> -			u32 value, u32 mask)
> +int cmdq_pkt_write_mask(struct cmdq_pkt *pkt, struct cmdq_base *clt_base,
> +			dma_addr_t addr, u32 value, u32 mask)
>  {
> -	u32 offset_mask = offset;
> +	const u32 base = (addr >> 32) ? 0 : addr & 0xFFFF0000;
> +	u8 subsys = cmdq_subsys_base_to_id(clt_base, base);
> +	s16 offset = addr & 0x0000FFFF;
>  	int err = 0;
>  
>  	if (mask != 0xffffffff) {
>  		err = cmdq_pkt_append_command(pkt, CMDQ_GET_ARG_C(~mask),
>  					      CMDQ_GET_ARG_B(~mask), 0, 0, 0, 0,
>  					      0, CMDQ_CODE_MASK);
> -		offset_mask |= CMDQ_WRITE_ENABLE_MASK;
> +		offset |= CMDQ_WRITE_ENABLE_MASK;
>  	}
> -	err |= cmdq_pkt_write(pkt, subsys, offset_mask, value);
>  
> -	return err;
> +	return cmdq_pkt_append_command(pkt, CMDQ_GET_ARG_C(value),
> +				       CMDQ_GET_ARG_B(value), offset, subsys,
> +				       CMDQ_IMMEDIATE_VALUE,
> +				       CMDQ_IMMEDIATE_VALUE,
> +				       CMDQ_IMMEDIATE_VALUE, CMDQ_CODE_WRITE);
>  }
>  EXPORT_SYMBOL(cmdq_pkt_write_mask);
>  
> diff --git a/include/linux/soc/mediatek/mtk-cmdq.h b/include/linux/soc/mediatek/mtk-cmdq.h
> index e4d1876..230bc2b 100644
> --- a/include/linux/soc/mediatek/mtk-cmdq.h
> +++ b/include/linux/soc/mediatek/mtk-cmdq.h
> @@ -70,26 +70,26 @@ struct cmdq_client *cmdq_mbox_create(struct device *dev, int index,
>  /**
>   * cmdq_pkt_write() - append write command to the CMDQ packet
>   * @pkt:	the CMDQ packet
> - * @subsys:	the CMDQ sub system code
> - * @offset:	register offset from CMDQ sub system
> + * @cmdq_base:	the CMDQ sub system code and base address
> + * @addr:	register address
>   * @value:	the specified target register value
>   *
>   * Return: 0 for success; else the error code is returned
>   */
> -int cmdq_pkt_write(struct cmdq_pkt *pkt, u8 subsys, u16 offset, u32 value);
> -
> +int cmdq_pkt_write(struct cmdq_pkt *pkt, struct cmdq_base *clt_base,
> +		   dma_addr_t addr, u32 value);
>  /**
>   * cmdq_pkt_write_mask() - append write command with mask to the CMDQ packet
>   * @pkt:	the CMDQ packet
> - * @subsys:	the CMDQ sub system code
> - * @offset:	register offset from CMDQ sub system
> + * @cmdq_base:	the CMDQ sub system code and base address
> + * @addr:	register address
>   * @value:	the specified target register value
>   * @mask:	the specified target register mask
>   *
>   * Return: 0 for success; else the error code is returned
>   */
> -int cmdq_pkt_write_mask(struct cmdq_pkt *pkt, u8 subsys, u16 offset,
> -			u32 value, u32 mask);
> +int cmdq_pkt_write_mask(struct cmdq_pkt *pkt, struct cmdq_base *clt_base,
> +			dma_addr_t addr, u32 value, u32 mask);
>  
>  /**
>   * cmdq_pkt_wfe() - append wait for event command to the CMDQ packet


