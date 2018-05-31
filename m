Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754255AbeEaI4g (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 04:56:36 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:45425 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754179AbeEaI4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 04:56:32 -0400
X-Google-Smtp-Source: ADUXVKIdGVExg4YcctWUlFL6OfH6RwjiF7v8V6c+HduEnTUt70R4knwcooFiyuRwbH0zUR3tDwu8Mg==
MIME-Version: 1.0
References: <20180515075859.17217-1-stanimir.varbanov@linaro.org> <20180515075859.17217-17-stanimir.varbanov@linaro.org>
In-Reply-To: <20180515075859.17217-17-stanimir.varbanov@linaro.org>
From: Tomasz Figa <tfiga@chromium.org>
Date: Thu, 31 May 2018 17:56:18 +0900
X-Gmail-Original-Message-ID: <CAAFQd5B+DH3+2-7VcqJ5J4VxmftUCgS18qmfRJVzNAA+6u1NxQ@mail.gmail.com>
Message-ID: <CAAFQd5B+DH3+2-7VcqJ5J4VxmftUCgS18qmfRJVzNAA+6u1NxQ@mail.gmail.com>
Subject: Re: [PATCH v2 16/29] venus: add a helper function to set dynamic
 buffer mode
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

On Tue, May 15, 2018 at 5:05 PM Stanimir Varbanov
<stanimir.varbanov@linaro.org> wrote:
>
> Adds a new helper function to set dynamic buffer mode if it is
> supported by current HFI version.
>
> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
> ---
>  drivers/media/platform/qcom/venus/helpers.c | 22 ++++++++++++++++++++++
>  drivers/media/platform/qcom/venus/helpers.h |  1 +
>  drivers/media/platform/qcom/venus/vdec.c    | 15 +++------------
>  3 files changed, 26 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
> index 1eda19adbf28..824ad4d2d064 100644
> --- a/drivers/media/platform/qcom/venus/helpers.c
> +++ b/drivers/media/platform/qcom/venus/helpers.c
> @@ -522,6 +522,28 @@ int venus_helper_set_color_format(struct venus_inst *inst, u32 pixfmt)
>  }
>  EXPORT_SYMBOL_GPL(venus_helper_set_color_format);
>
> +int venus_helper_set_dyn_bufmode(struct venus_inst *inst)
> +{
> +       u32 ptype = HFI_PROPERTY_PARAM_BUFFER_ALLOC_MODE;
> +       struct hfi_buffer_alloc_mode mode;
> +       int ret;
> +
> +       if (!is_dynamic_bufmode(inst))
> +               return 0;
> +
> +       mode.type = HFI_BUFFER_OUTPUT;
> +       mode.mode = HFI_BUFFER_MODE_DYNAMIC;
> +
> +       ret = hfi_session_set_property(inst, ptype, &mode);
> +       if (ret)
> +               return ret;
> +
> +       mode.type = HFI_BUFFER_OUTPUT2;
> +
> +       return hfi_session_set_property(inst, ptype, &mode);

The function now sets HFI_BUFFER_OUTPUT2 in addition to
HFI_BUFFER_OUTPUT only, as set by orignal code. Is it intentional? I
guess we could have this mentioned in commit message.

Best regards,
Tomasz
