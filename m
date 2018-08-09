Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A4DC4646D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 02:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0676121C2B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 02:41:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0676121C2B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbeHIFED (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 01:04:03 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:6367 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725779AbeHIFEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 01:04:02 -0400
X-UUID: e3558f404bc54e48a04a38b7a7bd5483-20180809
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1682476938; Thu, 09 Aug 2018 10:41:27 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Thu, 9 Aug 2018 10:41:26 +0800
Received: from [172.21.77.4] (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Thu, 9 Aug 2018 10:41:26 +0800
Message-ID: <1533782486.29986.2.camel@mtksdaap41>
Subject: Re: [PATCH v4 08/14] drm/mediatek: add YUYV/UYVY color format
 support for RDMA
From:   CK Hu <ck.hu@mediatek.com>
To:     Stu Hsieh <stu.hsieh@mediatek.com>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>
Date:   Thu, 9 Aug 2018 10:41:26 +0800
In-Reply-To: <1533780949-30141-9-git-send-email-stu.hsieh@mediatek.com>
References: <1533780949-30141-1-git-send-email-stu.hsieh@mediatek.com>
         <1533780949-30141-9-git-send-email-stu.hsieh@mediatek.com>
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

On Thu, 2018-08-09 at 10:15 +0800, Stu Hsieh wrote:
> This patch add YUYV/UYVY color format support for RDMA
> and transform matrix for YUYV/UYVY.
> 
> Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>

Reviewed-by: CK Hu <ck.hu@mediatek.com>

> ---
>  drivers/gpu/drm/mediatek/mtk_disp_rdma.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
> index 1f57f86c7910..8b015c2d4418 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
> @@ -33,6 +33,8 @@
>  #define RDMA_ENGINE_EN					BIT(0)
>  #define RDMA_MODE_MEMORY				BIT(1)
>  #define DISP_REG_RDMA_SIZE_CON_0		0x0014
> +#define RDMA_MATRIX_ENABLE				BIT(17)
> +#define RDMA_MATRIX_INT_MTX_BT601_to_RGB		(6 << 20)
>  #define DISP_REG_RDMA_SIZE_CON_1		0x0018
>  #define DISP_REG_RDMA_TARGET_LINE		0x001c
>  #define DISP_RDMA_MEM_CON			0x0024
> @@ -46,12 +48,15 @@
>  #define RDMA_FIFO_SIZE(rdma)			((rdma)->data->fifo_size)
>  #define DISP_RDMA_MEM_START_ADDR		0x0f00
>  
> +#define RDMA_MATRIX_INT_MTX_SEL			GENMASK(23, 20)
>  #define RDMA_MEM_GMC				0x40402020
>  
>  #define MEM_MODE_INPUT_FORMAT_RGB565		0x0
>  #define MEM_MODE_INPUT_FORMAT_RGB888		(0x001 << 4)
>  #define MEM_MODE_INPUT_FORMAT_RGBA8888		(0x002 << 4)
>  #define MEM_MODE_INPUT_FORMAT_ARGB8888		(0x003 << 4)
> +#define MEM_MODE_INPUT_FORMAT_UYVY		(0x004 << 4)
> +#define MEM_MODE_INPUT_FORMAT_YUYV		(0x005 << 4)
>  
>  struct mtk_disp_rdma_data {
>  	unsigned int fifo_size;
> @@ -181,6 +186,10 @@ static unsigned int rdma_fmt_convert(struct mtk_disp_rdma *rdma,
>  	case DRM_FORMAT_XBGR8888:
>  	case DRM_FORMAT_ABGR8888:
>  		return MEM_MODE_INPUT_FORMAT_RGBA8888 | MEM_MODE_INPUT_SWAP;
> +	case DRM_FORMAT_UYVY:
> +		return MEM_MODE_INPUT_FORMAT_UYVY;
> +	case DRM_FORMAT_YUYV:
> +		return MEM_MODE_INPUT_FORMAT_YUYV;
>  	}
>  }
>  
> @@ -197,6 +206,17 @@ static void mtk_rdma_layer_config(struct mtk_ddp_comp *comp, unsigned int idx,
>  	con = rdma_fmt_convert(rdma, fmt);
>  	writel_relaxed(con, comp->regs + DISP_RDMA_MEM_CON);
>  
> +	if (fmt == DRM_FORMAT_UYVY || fmt == DRM_FORMAT_YUYV) {
> +		rdma_update_bits(comp, DISP_REG_RDMA_SIZE_CON_0,
> +				 RDMA_MATRIX_ENABLE, RDMA_MATRIX_ENABLE);
> +		rdma_update_bits(comp, DISP_REG_RDMA_SIZE_CON_0,
> +				 RDMA_MATRIX_INT_MTX_SEL,
> +				 RDMA_MATRIX_INT_MTX_BT601_to_RGB);
> +	} else {
> +		rdma_update_bits(comp, DISP_REG_RDMA_SIZE_CON_0,
> +				 RDMA_MATRIX_ENABLE, 0);
> +	}
> +
>  	writel_relaxed(addr, comp->regs + DISP_RDMA_MEM_START_ADDR);
>  	writel_relaxed(pitch, comp->regs + DISP_RDMA_MEM_SRC_PITCH);
>  	writel(RDMA_MEM_GMC, comp->regs + DISP_RDMA_MEM_GMC_SETTING_0);


