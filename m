Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754133AbeEaIAk (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 04:00:40 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:41178 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754072AbeEaIAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 04:00:05 -0400
X-Google-Smtp-Source: ADUXVKLRmEbadHiJ2Gu8EZkUJh3bZrnZrqziZ4iZDQl0ZH5Xap/k12gL+XdQWlRxaYkKJpaOKNgvWQ==
MIME-Version: 1.0
References: <20180515075859.17217-1-stanimir.varbanov@linaro.org> <20180515075859.17217-16-stanimir.varbanov@linaro.org>
In-Reply-To: <20180515075859.17217-16-stanimir.varbanov@linaro.org>
From: Tomasz Figa <tfiga@chromium.org>
Date: Thu, 31 May 2018 16:59:51 +0900
X-Gmail-Original-Message-ID: <CAAFQd5BgTB0s0Dp7rqAVqxrUA74KNZSCo67xwVBPoWnZHiudFQ@mail.gmail.com>
Message-ID: <CAAFQd5BgTB0s0Dp7rqAVqxrUA74KNZSCo67xwVBPoWnZHiudFQ@mail.gmail.com>
Subject: Re: [PATCH v2 15/29] venus: helpers: rename a helper function and use
 buffer mode from caps
To: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>, vgarodia@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2018 at 5:06 PM Stanimir Varbanov
<stanimir.varbanov@linaro.org> wrote:
>
> Rename is_reg_unreg_needed() to better name is_dynamic_bufmode() and
> use buffer mode from enumerated per codec capabilities.
>
> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
> ---
>  drivers/media/platform/qcom/venus/helpers.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
> index 2b21f6ed7502..1eda19adbf28 100644
> --- a/drivers/media/platform/qcom/venus/helpers.c
> +++ b/drivers/media/platform/qcom/venus/helpers.c
> @@ -354,18 +354,19 @@ session_process_buf(struct venus_inst *inst, struct vb2_v4l2_buffer *vbuf)
>         return 0;
>  }
>
> -static inline int is_reg_unreg_needed(struct venus_inst *inst)
> +static inline int is_dynamic_bufmode(struct venus_inst *inst)

nit: Could be made bool.

>  {
> -       if (inst->session_type == VIDC_SESSION_TYPE_DEC &&
> -           inst->core->res->hfi_version == HFI_VERSION_3XX)
> -               return 0;
> +       struct venus_core *core = inst->core;
> +       struct venus_caps *caps;
>
> -       if (inst->session_type == VIDC_SESSION_TYPE_DEC &&
> -           inst->cap_bufs_mode_dynamic &&
> -           inst->core->res->hfi_version == HFI_VERSION_1XX)
> +       caps = venus_caps_by_codec(core, inst->hfi_codec, inst->session_type);
> +       if (!caps)
>                 return 0;
>
> -       return 1;
> +       if (caps->cap_bufs_mode_dynamic)
> +               return 1;
> +
> +       return 0;

nit: return caps->cap_bufs_mode_dynamic;

Best regards,
Tomasz
