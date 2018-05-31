Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754343AbeEaJwB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 05:52:01 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:43627 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754188AbeEaJv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 05:51:56 -0400
X-Google-Smtp-Source: ADUXVKLp75B/3Z+H/9ff3CgWk8VTbQlCLp1gZ2S1mOPDX0lKiArBkUVoub5fOcLDMi2UKgSVhmkHCA==
MIME-Version: 1.0
References: <20180515075859.17217-1-stanimir.varbanov@linaro.org> <20180515075859.17217-28-stanimir.varbanov@linaro.org>
In-Reply-To: <20180515075859.17217-28-stanimir.varbanov@linaro.org>
From: Tomasz Figa <tfiga@chromium.org>
Date: Thu, 31 May 2018 18:51:41 +0900
X-Gmail-Original-Message-ID: <CAAFQd5Cyk2=YG+LVGt0qEcrRGdarpHJDJ73AzG1iWBbyhr+nAA@mail.gmail.com>
Message-ID: <CAAFQd5Cyk2=YG+LVGt0qEcrRGdarpHJDJ73AzG1iWBbyhr+nAA@mail.gmail.com>
Subject: Re: [PATCH v2 27/29] venus: implementing multi-stream support
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

On Tue, May 15, 2018 at 5:00 PM Stanimir Varbanov
<stanimir.varbanov@linaro.org> wrote:
>
> This is implementing a multi-stream decoder support. The multi
> stream gives an option to use the secondary decoder output
> with different raw format (or the same in case of crop).
>
> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
> ---
>  drivers/media/platform/qcom/venus/core.h    |   1 +
>  drivers/media/platform/qcom/venus/helpers.c | 204 +++++++++++++++++++++++++++-
>  drivers/media/platform/qcom/venus/helpers.h |   6 +
>  drivers/media/platform/qcom/venus/vdec.c    |  91 ++++++++++++-
>  drivers/media/platform/qcom/venus/venc.c    |   1 +
>  5 files changed, 299 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
> index 4d6c05f156c4..85e66e2dd672 100644
> --- a/drivers/media/platform/qcom/venus/core.h
> +++ b/drivers/media/platform/qcom/venus/core.h
> @@ -259,6 +259,7 @@ struct venus_inst {
>         struct list_head list;
>         struct mutex lock;
>         struct venus_core *core;
> +       struct list_head dpbbufs;
>         struct list_head internalbufs;
>         struct list_head registeredbufs;
>         struct list_head delayed_process;
> diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
> index ed569705ecac..87dcf9973e6f 100644
> --- a/drivers/media/platform/qcom/venus/helpers.c
> +++ b/drivers/media/platform/qcom/venus/helpers.c
> @@ -85,6 +85,112 @@ bool venus_helper_check_codec(struct venus_inst *inst, u32 v4l2_pixfmt)
>  }
>  EXPORT_SYMBOL_GPL(venus_helper_check_codec);
>
> +static int venus_helper_queue_dpb_bufs(struct venus_inst *inst)
> +{
> +       struct intbuf *buf;
> +       int ret = 0;
> +
> +       if (list_empty(&inst->dpbbufs))
> +               return 0;

Does this special case give us anything other than few more source lines?

> +
> +       list_for_each_entry(buf, &inst->dpbbufs, list) {
> +               struct hfi_frame_data fdata;
> +
> +               memset(&fdata, 0, sizeof(fdata));
> +               fdata.alloc_len = buf->size;
> +               fdata.device_addr = buf->da;
> +               fdata.buffer_type = buf->type;
> +
> +               ret = hfi_session_process_buf(inst, &fdata);
> +               if (ret)
> +                       goto fail;
> +       }
> +
> +fail:
> +       return ret;
> +}
> +
> +int venus_helper_free_dpb_bufs(struct venus_inst *inst)
> +{
> +       struct intbuf *buf, *n;
> +
> +       if (list_empty(&inst->dpbbufs))
> +               return 0;

Ditto.

> +
> +       list_for_each_entry_safe(buf, n, &inst->dpbbufs, list) {
> +               list_del_init(&buf->list);
> +               dma_free_attrs(inst->core->dev, buf->size, buf->va, buf->da,
> +                              buf->attrs);
> +               kfree(buf);
> +       }
> +
> +       INIT_LIST_HEAD(&inst->dpbbufs);
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(venus_helper_free_dpb_bufs);
[snip]
> +int venus_helper_get_out_fmts(struct venus_inst *inst, u32 v4l2_fmt,
> +                             u32 *out_fmt, u32 *out2_fmt, bool ubwc)
> +{
> +       struct venus_core *core = inst->core;
> +       struct venus_caps *caps;
> +       u32 ubwc_fmt, fmt = to_hfi_raw_fmt(v4l2_fmt);
> +       bool found, found_ubwc;
> +
> +       *out_fmt = *out2_fmt = 0;
> +
> +       if (!fmt)
> +               return -EINVAL;
> +
> +       caps = venus_caps_by_codec(core, inst->hfi_codec, inst->session_type);
> +       if (!caps)
> +               return -EINVAL;
> +
> +       if (ubwc) {
> +               ubwc_fmt = fmt | HFI_COLOR_FORMAT_UBWC_BASE;

Does the UBWC base format have to be the same as fmt? Looking at
HFI_COLOR_FORMAT_* macros, UBWC variants seem to exist only for few
selected raw formats, for example there is none for NV21.

Best regards,
Tomasz
