Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 927FDC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 08:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58CBF21872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 08:43:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QgFqV6Wz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727587AbfAXInj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 03:43:39 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43921 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727572AbfAXIni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 03:43:38 -0500
Received: by mail-oi1-f196.google.com with SMTP id u18so4183236oie.10
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 00:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WdibVqAgbR5ok31tdt/O+WwBRfsYGvLwJnb1/CwmST4=;
        b=QgFqV6WzKgpjdFy8xOlY7wKGE4wo8hKQpaBCLDmH/VH+sKxK5DMPTb4rAd8AKAHWK/
         RK6ylLa+fF5AbTabu0OBYUBMzlPS9rxThwEJLAsDzVSbizvyMPYpIsSBMLcTvmBGbwOW
         KfiOeCIOBSJ8F0mHQVzu1Pqn37n9OJzQHKkNg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WdibVqAgbR5ok31tdt/O+WwBRfsYGvLwJnb1/CwmST4=;
        b=nYFE3I7z5pGqx4zNjjpLkdNGMIypgmK/+cs6gLIMtJLQrYWEDJo+wWvJrXE3753CI6
         dBiK1J651Gxb6D0u3Glu9cDoTIsPbSi6j1+djHWXwVMt3NohQkdptY9waW0IM7Yvy85n
         tMAFUt965PHxMUNg0SXP3yTcak7ZyRqPXdEnfZsUyfhdssvJzLijF0YphTvuCRooTFor
         al9rV+VWuQunRvUgYvCk9rfTWiC4+NrmqdBon9O9R1FQriPa/iUej8dRGHWlkq5VvVV6
         lQ73TqbVO327Rml7Og0c2PIcK2zMM82GXYwq39PFpd08QMmasrNjpuiAC3qqm5VQFHI2
         HQwg==
X-Gm-Message-State: AJcUukd3UJztWOlxouT4fU90GY5qtJwXxcewykLhgYParg3A9VZ4XBjj
        8eG2jH9tjqMloWfa2Va4mxrA0unaxt0=
X-Google-Smtp-Source: ALg8bN5WTUTxbXqECpaqtk49Xsa9BBGz4bROcF14xIZ8jUbMeMfx6rpDh/r+x6u06GwRcAhWcyi0QQ==
X-Received: by 2002:a54:4f86:: with SMTP id g6mr533155oiy.205.1548319416724;
        Thu, 24 Jan 2019 00:43:36 -0800 (PST)
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com. [209.85.167.175])
        by smtp.gmail.com with ESMTPSA id r1sm8521110oti.44.2019.01.24.00.43.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 00:43:36 -0800 (PST)
Received: by mail-oi1-f175.google.com with SMTP id c206so4242090oib.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 00:43:35 -0800 (PST)
X-Received: by 2002:a54:4486:: with SMTP id v6mr555965oiv.233.1548319415393;
 Thu, 24 Jan 2019 00:43:35 -0800 (PST)
MIME-Version: 1.0
References: <20190117162008.25217-1-stanimir.varbanov@linaro.org> <20190117162008.25217-8-stanimir.varbanov@linaro.org>
In-Reply-To: <20190117162008.25217-8-stanimir.varbanov@linaro.org>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Thu, 24 Jan 2019 17:43:24 +0900
X-Gmail-Original-Message-ID: <CAPBb6MVPhpZkCLFhAfPhE83TSpnCjH4Zy4-Mage5s=LkU9_RzA@mail.gmail.com>
Message-ID: <CAPBb6MVPhpZkCLFhAfPhE83TSpnCjH4Zy4-Mage5s=LkU9_RzA@mail.gmail.com>
Subject: Re: [PATCH 07/10] venus: helpers: add three more helper functions
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Malathi Gottam <mgottam@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 1:21 AM Stanimir Varbanov
<stanimir.varbanov@linaro.org> wrote:
>
> This adds three more helper functions:
>  * for internal buffers reallocation, applicable when we are doing
> dynamic resolution change
>  * for initial buffer processing of capture and output queue buffer
> types
>
> All of them will be needed for stateful Codec API support.
>
> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
> ---
>  drivers/media/platform/qcom/venus/helpers.c | 82 +++++++++++++++++++++
>  drivers/media/platform/qcom/venus/helpers.h |  2 +
>  2 files changed, 84 insertions(+)
>
> diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
> index f33bbfea3576..637ce7b82d94 100644
> --- a/drivers/media/platform/qcom/venus/helpers.c
> +++ b/drivers/media/platform/qcom/venus/helpers.c
> @@ -322,6 +322,52 @@ int venus_helper_intbufs_free(struct venus_inst *inst)
>  }
>  EXPORT_SYMBOL_GPL(venus_helper_intbufs_free);
>
> +int venus_helper_intbufs_realloc(struct venus_inst *inst)

Does this function actually reallocate buffers? It seems to just free
what we had previously.


> +{
> +       enum hfi_version ver = inst->core->res->hfi_version;
> +       struct hfi_buffer_desc bd;
> +       struct intbuf *buf, *n;
> +       int ret;
> +
> +       list_for_each_entry_safe(buf, n, &inst->internalbufs, list) {
> +               if (buf->type == HFI_BUFFER_INTERNAL_PERSIST ||
> +                   buf->type == HFI_BUFFER_INTERNAL_PERSIST_1)
> +                       continue;
> +
> +               memset(&bd, 0, sizeof(bd));
> +               bd.buffer_size = buf->size;
> +               bd.buffer_type = buf->type;
> +               bd.num_buffers = 1;
> +               bd.device_addr = buf->da;
> +               bd.response_required = true;
> +
> +               ret = hfi_session_unset_buffers(inst, &bd);
> +
> +               dma_free_attrs(inst->core->dev, buf->size, buf->va, buf->da,
> +                              buf->attrs);
> +
> +               list_del_init(&buf->list);
> +               kfree(buf);
> +       }
> +
> +       ret = intbufs_set_buffer(inst, HFI_BUFFER_INTERNAL_SCRATCH(ver));
> +       if (ret)
> +               goto err;
> +
> +       ret = intbufs_set_buffer(inst, HFI_BUFFER_INTERNAL_SCRATCH_1(ver));
> +       if (ret)
> +               goto err;
> +
> +       ret = intbufs_set_buffer(inst, HFI_BUFFER_INTERNAL_SCRATCH_2(ver));
> +       if (ret)
> +               goto err;
> +
> +       return 0;
> +err:
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(venus_helper_intbufs_realloc);
> +
>  static u32 load_per_instance(struct venus_inst *inst)
>  {
>         u32 mbs;
> @@ -1050,6 +1096,42 @@ void venus_helper_vb2_stop_streaming(struct vb2_queue *q)
>  }
>  EXPORT_SYMBOL_GPL(venus_helper_vb2_stop_streaming);
>
> +int venus_helper_process_initial_cap_bufs(struct venus_inst *inst)
> +{
> +       struct v4l2_m2m_ctx *m2m_ctx = inst->m2m_ctx;
> +       struct v4l2_m2m_buffer *buf, *n;
> +       int ret;
> +
> +       v4l2_m2m_for_each_dst_buf_safe(m2m_ctx, buf, n) {
> +               ret = session_process_buf(inst, &buf->vb);
> +               if (ret) {
> +                       return_buf_error(inst, &buf->vb);
> +                       return ret;
> +               }
> +       }
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(venus_helper_process_initial_cap_bufs);
> +
> +int venus_helper_process_initial_out_bufs(struct venus_inst *inst)
> +{
> +       struct v4l2_m2m_ctx *m2m_ctx = inst->m2m_ctx;
> +       struct v4l2_m2m_buffer *buf, *n;
> +       int ret;
> +
> +       v4l2_m2m_for_each_src_buf_safe(m2m_ctx, buf, n) {
> +               ret = session_process_buf(inst, &buf->vb);
> +               if (ret) {
> +                       return_buf_error(inst, &buf->vb);
> +                       return ret;
> +               }
> +       }
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(venus_helper_process_initial_out_bufs);
> +
>  int venus_helper_vb2_start_streaming(struct venus_inst *inst)
>  {
>         struct venus_core *core = inst->core;
> diff --git a/drivers/media/platform/qcom/venus/helpers.h b/drivers/media/platform/qcom/venus/helpers.h
> index 24faae5abd93..2ec1c1a8b416 100644
> --- a/drivers/media/platform/qcom/venus/helpers.h
> +++ b/drivers/media/platform/qcom/venus/helpers.h
> @@ -69,4 +69,6 @@ int venus_helper_intbufs_realloc(struct venus_inst *inst);
>  int venus_helper_queue_dpb_bufs(struct venus_inst *inst);
>  int venus_helper_unregister_bufs(struct venus_inst *inst);
>  int venus_helper_load_scale_clocks(struct venus_core *core);
> +int venus_helper_process_initial_cap_bufs(struct venus_inst *inst);
> +int venus_helper_process_initial_out_bufs(struct venus_inst *inst);
>  #endif
> --
> 2.17.1
>
