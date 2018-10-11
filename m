Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D9AC32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 06:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ED132077C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 06:50:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AKOt2nzP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ED132077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727622AbeJKOQL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 10:16:11 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:44438 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726907AbeJKOQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 10:16:10 -0400
Received: by mail-io1-f65.google.com with SMTP id x26-v6so5786143iog.11
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 23:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b5slhGgdclu9R9MfgAJPuj3IJ5j1meMS8MnYMCKwAUc=;
        b=AKOt2nzPNa0DghYgeQ5x+AKa1sLd4lUdQ5TnZPK29aulJe6u/3X0Y9z8R5qpolzR0X
         57WJejxX5eqv+JixsRmRKlPiAm6PlM4+HlhcSVsvty6frGaK+zv4xzf04t+iMWXU703L
         svWAceQbNYDI+qh//CCiH5+JRfHIRBjBGXlHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b5slhGgdclu9R9MfgAJPuj3IJ5j1meMS8MnYMCKwAUc=;
        b=WLfxMZlxU5sLQ8fq0tVeAfhlZrgtYlJRyrgoS0yd9aDvb29uW0L2lLXeaQoT2oE500
         athUNR8AmBDripx6kwjtVi9xpLdqAw1NA557MSGHDEH0hiy4K72jni08WdLkBzgyHK3T
         yww3QIuo/efMM/6bK4W/w/oD/7ESeGXvFMeXNGs0ev5XH34PKCZPFadwKro8goLQqY12
         nlpiA+2BfvhFYzNDFxGt3owY0GdSa4EZ+sQzf4AaBSmJCYvK28wcoD2Yxo0G022d+6nv
         MkUK+NxUswikTqfoNqkZLnHSMKrql422NKiEAoxP3uOHtR13RGiivItVlw+aVNj+pqXj
         cnsA==
X-Gm-Message-State: ABuFfoizcqh7qzjcNyP9Oe3YpTQdcavRoQCuUnNI+zh1OMh+GPQ8PkkA
        5MlCUeHDyBKNEmAQ1M5z57QY9YK42JMJqg==
X-Google-Smtp-Source: ACcGV62gNXm+ckE2Agb/bVayX1K9SB8kGDdpO10lAhBSVHuuZHyKXIAY3g7ME0GTaTDcYTLNEUOc4g==
X-Received: by 2002:a5e:c117:: with SMTP id v23-v6mr221880iol.155.1539240618158;
        Wed, 10 Oct 2018 23:50:18 -0700 (PDT)
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com. [209.85.166.54])
        by smtp.gmail.com with ESMTPSA id x193-v6sm4487808ite.43.2018.10.10.23.50.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Oct 2018 23:50:17 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id w11-v6so5804655iob.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 23:50:17 -0700 (PDT)
X-Received: by 2002:a6b:7846:: with SMTP id h6-v6mr209353iop.204.1539240616925;
 Wed, 10 Oct 2018 23:50:16 -0700 (PDT)
MIME-Version: 1.0
References: <20181011064608.37435-1-acourbot@chromium.org>
In-Reply-To: <20181011064608.37435-1-acourbot@chromium.org>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Thu, 11 Oct 2018 15:50:05 +0900
X-Gmail-Original-Message-ID: <CAPBb6MXXwCOP6w7WdAFXdbmBLWKFp9gVDUW=uE=UFGiq_jPakg@mail.gmail.com>
Message-ID: <CAPBb6MXXwCOP6w7WdAFXdbmBLWKFp9gVDUW=uE=UFGiq_jPakg@mail.gmail.com>
Subject: Re: [PATCH] media: venus: support VB2_USERPTR IO mode
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please ignore this patch - I did not notice that a similar one has
been sent before. >_<
On Thu, Oct 11, 2018 at 3:46 PM Alexandre Courbot <acourbot@chromium.org> wrote:
>
> The venus codec can work just fine with USERPTR buffers. Enable this
> possibility.
>
> Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
> ---
>  drivers/media/platform/qcom/venus/vdec.c | 4 ++--
>  drivers/media/platform/qcom/venus/venc.c | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
> index 33320c5025313f..dfc2260e8d213a 100644
> --- a/drivers/media/platform/qcom/venus/vdec.c
> +++ b/drivers/media/platform/qcom/venus/vdec.c
> @@ -984,7 +984,7 @@ static int m2m_queue_init(void *priv, struct vb2_queue *src_vq,
>         int ret;
>
>         src_vq->type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE;
> -       src_vq->io_modes = VB2_MMAP | VB2_DMABUF;
> +       src_vq->io_modes = VB2_MMAP | VB2_USERPTR | VB2_DMABUF;
>         src_vq->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_COPY;
>         src_vq->ops = &vdec_vb2_ops;
>         src_vq->mem_ops = &vb2_dma_sg_memops;
> @@ -999,7 +999,7 @@ static int m2m_queue_init(void *priv, struct vb2_queue *src_vq,
>                 return ret;
>
>         dst_vq->type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE;
> -       dst_vq->io_modes = VB2_MMAP | VB2_DMABUF;
> +       dst_vq->io_modes = VB2_MMAP | VB2_USERPTR | VB2_DMABUF;
>         dst_vq->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_COPY;
>         dst_vq->ops = &vdec_vb2_ops;
>         dst_vq->mem_ops = &vb2_dma_sg_memops;
> diff --git a/drivers/media/platform/qcom/venus/venc.c b/drivers/media/platform/qcom/venus/venc.c
> index d2805b5e28a1b2..71ca59a24991be 100644
> --- a/drivers/media/platform/qcom/venus/venc.c
> +++ b/drivers/media/platform/qcom/venus/venc.c
> @@ -1073,7 +1073,7 @@ static int m2m_queue_init(void *priv, struct vb2_queue *src_vq,
>         int ret;
>
>         src_vq->type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE;
> -       src_vq->io_modes = VB2_MMAP | VB2_DMABUF;
> +       src_vq->io_modes = VB2_MMAP | VB2_USERPTR | VB2_DMABUF;
>         src_vq->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_COPY;
>         src_vq->ops = &venc_vb2_ops;
>         src_vq->mem_ops = &vb2_dma_sg_memops;
> @@ -1090,7 +1090,7 @@ static int m2m_queue_init(void *priv, struct vb2_queue *src_vq,
>                 return ret;
>
>         dst_vq->type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE;
> -       dst_vq->io_modes = VB2_MMAP | VB2_DMABUF;
> +       dst_vq->io_modes = VB2_MMAP | VB2_USERPTR | VB2_DMABUF;
>         dst_vq->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_COPY;
>         dst_vq->ops = &venc_vb2_ops;
>         dst_vq->mem_ops = &vb2_dma_sg_memops;
> --
> 2.19.0.605.g01d371f741-goog
>
