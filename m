Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751949AbeEGLC5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 07:02:57 -0400
Received: from lb1-smtp-cloud9.xs4all.net ([194.109.24.22]:45612 "EHLO
        lb1-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751345AbeEGLC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 07:02:56 -0400
Subject: Re: [PATCH v9 09/15] vb2: mark codec drivers as unordered
To: Ezequiel Garcia <ezequiel@collabora.com>, linux-media@vger.kernel.org
Cc: kernel@collabora.com, Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
        Shuah Khan <shuahkh@osg.samsung.com>, Pawel Osciak <pawel@osciak.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Brian Starkey <brian.starkey@arm.com>, linux-kernel@vger.kernel.org,
        Gustavo Padovan <gustavo.padovan@collabora.com>
References: <20180504200612.8763-1-ezequiel@collabora.com>
 <20180504200612.8763-10-ezequiel@collabora.com>
From: Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <cd197170-983d-c981-9463-3d4df64d4329@xs4all.nl>
Date: Mon, 7 May 2018 13:02:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180504200612.8763-10-ezequiel@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfKuiiivN3Dt0hn8zzGKb6FJgVgtUA297wbkPm9craeVi6+fNfiOhcE1Ac2aZ1p5onFp7qiKf3k9gAFoMhYVXSPTMzBS2uCxzx0MpQepQ+WiuIdGg7Xnl
 zZo9wMGUQQ62yhgu1qMM3KXZL+B8Tiu+e2VahlmkAj1qc7gEKmzHj5I3fI3L7p34ljyS038gAKf+gYuHhKPaT5mB3wM0fNwN6BAsxeW9yUcLA/IsE9p0TWSq
 thJ58mbIXj2nFfVR/y03ues5gGJmkXXKVi609Y/v03WMAF8Kdqj+Wx24Ia8GuTeyv9yN//+ekkk1uthexVc5ZoGhpYoNAmhZyJZ4oSbxK2Bg6StdmBEFYikW
 KpHoKNDkmMtOs+FaaAJEQZCxJhnEL4InU2MpQ6hpXPym12hxMJXArw3ev9XM2teSg4o3TXZNsaZEXcAxaHnfjRydEi7rroeiqucE7Awe4sjCfbn+8atEjVxV
 +LQWW+VRHXK92a5QDX/Hwp55iob1e7hmaOnStxP0scndpK9UTLpO6TPTOEA=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/18 22:06, Ezequiel Garcia wrote:
> From: Gustavo Padovan <gustavo.padovan@collabora.com>
> 
> In preparation to have full support to explicit fence we are
> marking codec as non-ordered preventively. It is easier and safer from an
> uAPI point of view to move from unordered to ordered than the opposite.
> 
> v3: set property instead of callback
> v2: mark only codec drivers as unordered (Nicolas and Hans)
> 
> Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.com>
> Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
> ---
>  drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c | 2 ++
>  drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c | 1 +
>  drivers/media/platform/qcom/venus/venc.c           | 2 ++
>  drivers/media/platform/s5p-mfc/s5p_mfc.c           | 2 ++

Why were coda, exynos-gsc, exynos4-is and venus/vdec.c removed?
Those were patched in v8.

Regards,

	Hans

>  4 files changed, 7 insertions(+)
> 
> diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c
> index 86f0a7134365..c03cefde0c28 100644
> --- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c
> +++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c
> @@ -1498,6 +1498,7 @@ int mtk_vcodec_dec_queue_init(void *priv, struct vb2_queue *src_vq,
>  	src_vq->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_COPY;
>  	src_vq->lock		= &ctx->dev->dev_mutex;
>  	src_vq->dev             = &ctx->dev->plat_dev->dev;
> +	src_vq->unordered       = 1;
>  
>  	ret = vb2_queue_init(src_vq);
>  	if (ret) {
> @@ -1513,6 +1514,7 @@ int mtk_vcodec_dec_queue_init(void *priv, struct vb2_queue *src_vq,
>  	dst_vq->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_COPY;
>  	dst_vq->lock		= &ctx->dev->dev_mutex;
>  	dst_vq->dev             = &ctx->dev->plat_dev->dev;
> +	src_vq->unordered       = 1;
>  
>  	ret = vb2_queue_init(dst_vq);
>  	if (ret) {
> diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
> index 1b1a28abbf1f..81751c9aa19d 100644
> --- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
> +++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
> @@ -1340,6 +1340,7 @@ int mtk_vcodec_enc_queue_init(void *priv, struct vb2_queue *src_vq,
>  	dst_vq->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_COPY;
>  	dst_vq->lock		= &ctx->dev->dev_mutex;
>  	dst_vq->dev		= &ctx->dev->plat_dev->dev;
> +	dst_vq->unordered	= 1;
>  
>  	return vb2_queue_init(dst_vq);
>  }
> diff --git a/drivers/media/platform/qcom/venus/venc.c b/drivers/media/platform/qcom/venus/venc.c
> index 6b2ce479584e..17ec2d218aa5 100644
> --- a/drivers/media/platform/qcom/venus/venc.c
> +++ b/drivers/media/platform/qcom/venus/venc.c
> @@ -1053,6 +1053,7 @@ static int m2m_queue_init(void *priv, struct vb2_queue *src_vq,
>  	src_vq->buf_struct_size = sizeof(struct venus_buffer);
>  	src_vq->allow_zero_bytesused = 1;
>  	src_vq->min_buffers_needed = 1;
> +	src_vq->unordered = 1;
>  	src_vq->dev = inst->core->dev;
>  	if (inst->core->res->hfi_version == HFI_VERSION_1XX)
>  		src_vq->bidirectional = 1;
> @@ -1069,6 +1070,7 @@ static int m2m_queue_init(void *priv, struct vb2_queue *src_vq,
>  	dst_vq->buf_struct_size = sizeof(struct venus_buffer);
>  	dst_vq->allow_zero_bytesused = 1;
>  	dst_vq->min_buffers_needed = 1;
> +	src_vq->unordered = 1;
>  	dst_vq->dev = inst->core->dev;
>  	ret = vb2_queue_init(dst_vq);
>  	if (ret) {
> diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc.c b/drivers/media/platform/s5p-mfc/s5p_mfc.c
> index a80251ed3143..6a4251f988ab 100644
> --- a/drivers/media/platform/s5p-mfc/s5p_mfc.c
> +++ b/drivers/media/platform/s5p-mfc/s5p_mfc.c
> @@ -863,6 +863,7 @@ static int s5p_mfc_open(struct file *file)
>  	q->dma_attrs = DMA_ATTR_ALLOC_SINGLE_PAGES;
>  	q->mem_ops = &vb2_dma_contig_memops;
>  	q->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_COPY;
> +	q->unordered = 1;
>  	ret = vb2_queue_init(q);
>  	if (ret) {
>  		mfc_err("Failed to initialize videobuf2 queue(capture)\n");
> @@ -898,6 +899,7 @@ static int s5p_mfc_open(struct file *file)
>  	q->dma_attrs = DMA_ATTR_ALLOC_SINGLE_PAGES;
>  	q->mem_ops = &vb2_dma_contig_memops;
>  	q->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_COPY;
> +	q->unordered = 1;
>  	ret = vb2_queue_init(q);
>  	if (ret) {
>  		mfc_err("Failed to initialize videobuf2 queue(output)\n");
> 
