Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 156AEC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 02:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA79A21A6A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 02:37:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA79A21A6A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbeHGEth (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 00:49:37 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:62538 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725815AbeHGEtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 00:49:36 -0400
X-UUID: d5beb64d61ca4622836c5819ed1a79e5-20180807
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 75825378; Tue, 07 Aug 2018 10:37:28 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Tue, 7 Aug 2018 10:37:24 +0800
Received: from [172.21.77.4] (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Tue, 7 Aug 2018 10:37:24 +0800
Message-ID: <1533609444.8365.1.camel@mtksdaap41>
Subject: Re: [PATCH v3 05/13] drm/mediatek: add memory mode and layer_config
 for RDMA
From:   CK Hu <ck.hu@mediatek.com>
To:     Stu Hsieh <stu.hsieh@mediatek.com>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>
Date:   Tue, 7 Aug 2018 10:37:24 +0800
In-Reply-To: <1533556700-26525-6-git-send-email-stu.hsieh@mediatek.com>
References: <1533556700-26525-1-git-send-email-stu.hsieh@mediatek.com>
         <1533556700-26525-6-git-send-email-stu.hsieh@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Stu:

On Mon, 2018-08-06 at 19:58 +0800, Stu Hsieh wrote:
> This patch add memory mode for RDMA and layer_config for RDMA
> 
> If use RDMA to read data from memory, it should set memory mode to RDMA
> 
> Layer config set the data address and pitch to RDMA from plane setting.
> 
> Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>

Reviewed-by: CK Hu <ck.hu@mediatek.com>

> ---
>  drivers/gpu/drm/mediatek/mtk_disp_rdma.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
> index 585943c81e1f..08866550740f 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
> @@ -31,14 +31,20 @@
>  #define RDMA_REG_UPDATE_INT				BIT(0)
>  #define DISP_REG_RDMA_GLOBAL_CON		0x0010
>  #define RDMA_ENGINE_EN					BIT(0)
> +#define RDMA_MODE_MEMORY				BIT(1)
>  #define DISP_REG_RDMA_SIZE_CON_0		0x0014
>  #define DISP_REG_RDMA_SIZE_CON_1		0x0018
>  #define DISP_REG_RDMA_TARGET_LINE		0x001c
> +#define DISP_RDMA_MEM_SRC_PITCH			0x002c
> +#define DISP_RDMA_MEM_GMC_SETTING_0		0x0030
>  #define DISP_REG_RDMA_FIFO_CON			0x0040
>  #define RDMA_FIFO_UNDERFLOW_EN				BIT(31)
>  #define RDMA_FIFO_PSEUDO_SIZE(bytes)			(((bytes) / 16) << 16)
>  #define RDMA_OUTPUT_VALID_FIFO_THRESHOLD(bytes)		((bytes) / 16)
>  #define RDMA_FIFO_SIZE(rdma)			((rdma)->data->fifo_size)
> +#define DISP_RDMA_MEM_START_ADDR		0x0f00
> +
> +#define RDMA_MEM_GMC				0x40402020
>  
>  struct mtk_disp_rdma_data {
>  	unsigned int fifo_size;
> @@ -138,12 +144,27 @@ static void mtk_rdma_config(struct mtk_ddp_comp *comp, unsigned int width,
>  	writel(reg, comp->regs + DISP_REG_RDMA_FIFO_CON);
>  }
>  
> +static void mtk_rdma_layer_config(struct mtk_ddp_comp *comp, unsigned int idx,
> +				  struct mtk_plane_state *state)
> +{
> +	struct mtk_plane_pending_state *pending = &state->pending;
> +	unsigned int addr = pending->addr;
> +	unsigned int pitch = pending->pitch & 0xffff;
> +
> +	writel_relaxed(addr, comp->regs + DISP_RDMA_MEM_START_ADDR);
> +	writel_relaxed(pitch, comp->regs + DISP_RDMA_MEM_SRC_PITCH);
> +	writel(RDMA_MEM_GMC, comp->regs + DISP_RDMA_MEM_GMC_SETTING_0);
> +	rdma_update_bits(comp, DISP_REG_RDMA_GLOBAL_CON,
> +			 RDMA_MODE_MEMORY, RDMA_MODE_MEMORY);
> +}
> +
>  static const struct mtk_ddp_comp_funcs mtk_disp_rdma_funcs = {
>  	.config = mtk_rdma_config,
>  	.start = mtk_rdma_start,
>  	.stop = mtk_rdma_stop,
>  	.enable_vblank = mtk_rdma_enable_vblank,
>  	.disable_vblank = mtk_rdma_disable_vblank,
> +	.layer_config = mtk_rdma_layer_config,
>  };
>  
>  static int mtk_disp_rdma_bind(struct device *dev, struct device *master,


