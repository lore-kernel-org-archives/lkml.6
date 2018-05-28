Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753957AbeE1HsF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 03:48:05 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:31363 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753668AbeE1HsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 03:48:04 -0400
X-UUID: 72df2bdd77f74a16bd91c427f15417c3-20180528
Message-ID: <1527493677.24367.10.camel@mtksdaap41>
Subject: Re: [PATCH v4 8/9] drm/mediatek: add third ddp path
From: CK Hu <ck.hu@mediatek.com>
To: Stu Hsieh <stu.hsieh@mediatek.com>
CC: Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <srv_heupstream@mediatek.com>
Date: Mon, 28 May 2018 15:47:57 +0800
In-Reply-To: <1527489507-24453-9-git-send-email-stu.hsieh@mediatek.com>
References: <1527489507-24453-1-git-send-email-stu.hsieh@mediatek.com>
         <1527489507-24453-9-git-send-email-stu.hsieh@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Stu:

One inline comment.

On Mon, 2018-05-28 at 14:38 +0800, Stu Hsieh wrote:
> This patch create third crtc by third ddp path
> 
> Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 3 +++
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c  | 5 +++++
>  drivers/gpu/drm/mediatek/mtk_drm_drv.h  | 7 +++++--
>  3 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> index 658b8dd45b83..2d6aa150a9ff 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> @@ -539,6 +539,9 @@ int mtk_drm_crtc_create(struct drm_device *drm_dev,
>  	int ret;
>  	int i;
>  
> +	if (!path)
> +		return 0;
> +
>  	for (i = 0; i < path_len; i++) {
>  		enum mtk_ddp_comp_id comp_id = path[i];
>  		struct device_node *node;
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> index 08d5d0b47bfe..3d279a299383 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -232,6 +232,11 @@ static int mtk_drm_kms_init(struct drm_device *drm)
>  	if (ret < 0)
>  		goto err_component_unbind;
>  
> +	ret = mtk_drm_crtc_create(drm, private->data->third_path,
> +				  private->data->third_len);
> +	if (ret < 0)
> +		goto err_component_unbind;
> +
>  	/* Use OVL device for all DMA memory allocations */
>  	np = private->comp_node[private->data->main_path[0]] ?:
>  	     private->comp_node[private->data->ext_path[0]];
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.h b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
> index c3378c452c0a..d867e2683923 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.h
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
> @@ -17,8 +17,8 @@
>  #include <linux/io.h>
>  #include "mtk_drm_ddp_comp.h"
>  
> -#define MAX_CRTC	2
> -#define MAX_CONNECTOR	2
> +#define MAX_CRTC	3
> +#define MAX_CONNECTOR	3

MAX_CONNECTOR is useless, maybe we just need to remove it in a clean up
patch. Or you could keep its value.

Regards,
CK

>  
>  struct device;
>  struct device_node;
> @@ -33,6 +33,9 @@ struct mtk_mmsys_driver_data {
>  	unsigned int main_len;
>  	const enum mtk_ddp_comp_id *ext_path;
>  	unsigned int ext_len;
> +	const enum mtk_ddp_comp_id *third_path;
> +	unsigned int third_len;
> +
>  	bool shadow_register;
>  };
>  
