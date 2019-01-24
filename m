Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD34C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 08:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D38EA21872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 08:43:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aZexlr0g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbfAXIn4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 03:43:56 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:41675 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727596AbfAXInm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 03:43:42 -0500
Received: by mail-oi1-f193.google.com with SMTP id j21so4194562oii.8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 00:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ubufKBDUBrGmg37+ox2VVswr1sZmB/KKaxi8VgKVCLg=;
        b=aZexlr0gKprhmeni93G0ze+OooktnLIlR8ePBrlhkEOlsqRgcQbqm8ZES2bxOWCfs9
         FUAa1rFOVwEhJ4vuqOi44nGU4TP4SEbVbuR4BhvGMTFhLqLZA/JdY3QsImyCFXIO823N
         l/xMO2140vBA83/npx384f5ztcK9a/gziuswU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ubufKBDUBrGmg37+ox2VVswr1sZmB/KKaxi8VgKVCLg=;
        b=erWAIgfSrC2xF9bme9mTnvSydpUhMXnYjSTVYcLv/alo86kb5KmCHoOL2BF5GDHHgg
         8/8GRsEZymDlZWwVM/Zr6nuij84BRupHSTvNhxWVw1EKd1RX9K9diBeVeCHmxkXtgFi5
         /5o+B0jU394+DRBuLvi4AU0drXK5BWuvv1pvuAwp0xcNvjK3AZIhzkZe3cZ5rrGfUN0e
         IVGvWL8sbC26b7OA2G7ck6bwvPUvbvlF0aAr/VVunI1y9xzESFwGiFTdGuRjpLtwsamV
         t4PvoHV0AwF8H0KXoZcAh0WhzEIaM5qynUF6VYN7DQy3W+BhTrxq8hqM1RU6z/PkPITS
         lPQQ==
X-Gm-Message-State: AJcUukcgoHx4KhG5MmkKMsgUv1Ov1H+H3yvxZgqgvKwEgO7OhMQHEk+v
        qy5LJMOxwHyVNRdNNXfHknKznw0ljtc=
X-Google-Smtp-Source: AHgI3Ia7T1qpHhbpBBeak1tq2Aulm+OuPHAasE+Dn2euuGOHOr3oWfcykLxrg0Gam6GiDSo3ShpqWA==
X-Received: by 2002:aca:4c02:: with SMTP id z2mr519613oia.318.1548319420716;
        Thu, 24 Jan 2019 00:43:40 -0800 (PST)
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com. [209.85.167.176])
        by smtp.gmail.com with ESMTPSA id y80sm9743881oie.40.2019.01.24.00.43.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 00:43:39 -0800 (PST)
Received: by mail-oi1-f176.google.com with SMTP id v6so4224064oif.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 00:43:39 -0800 (PST)
X-Received: by 2002:aca:ad14:: with SMTP id w20mr532308oie.3.1548319419319;
 Thu, 24 Jan 2019 00:43:39 -0800 (PST)
MIME-Version: 1.0
References: <20190117162008.25217-1-stanimir.varbanov@linaro.org> <20190117162008.25217-9-stanimir.varbanov@linaro.org>
In-Reply-To: <20190117162008.25217-9-stanimir.varbanov@linaro.org>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Thu, 24 Jan 2019 17:43:28 +0900
X-Gmail-Original-Message-ID: <CAPBb6MWJXWLcGh3dbejiYzyqT6OB1_FN6zrcZFO5DbxqXSAWjQ@mail.gmail.com>
Message-ID: <CAPBb6MWJXWLcGh3dbejiYzyqT6OB1_FN6zrcZFO5DbxqXSAWjQ@mail.gmail.com>
Subject: Re: [PATCH 08/10] venus: vdec_ctrls: get real minimum buffers for capture
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
> Until now we returned num_output_bufs set during reqbuf but
> that could be wrong when we implement stateful Codec API. So
> get the minimum buffers for capture from HFI. This is supposed
> to be called after stream header parsing, i.e. after dequeue
> v4l2 event for change resolution.
>
> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
> ---
>  drivers/media/platform/qcom/venus/vdec_ctrls.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/media/platform/qcom/venus/vdec_ctrls.c b/drivers/media/platform/qcom/venus/vdec_ctrls.c
> index f4604b0cd57e..e1da87bf52bc 100644
> --- a/drivers/media/platform/qcom/venus/vdec_ctrls.c
> +++ b/drivers/media/platform/qcom/venus/vdec_ctrls.c
> @@ -16,6 +16,7 @@
>  #include <media/v4l2-ctrls.h>
>
>  #include "core.h"
> +#include "helpers.h"
>  #include "vdec.h"
>
>  static int vdec_op_s_ctrl(struct v4l2_ctrl *ctrl)
> @@ -47,7 +48,9 @@ static int vdec_op_g_volatile_ctrl(struct v4l2_ctrl *ctrl)
>  {
>         struct venus_inst *inst = ctrl_to_inst(ctrl);
>         struct vdec_controls *ctr = &inst->controls.dec;
> +       struct hfi_buffer_requirements bufreq;
>         union hfi_get_property hprop;
> +       enum hfi_version ver = inst->core->res->hfi_version;
>         u32 ptype = HFI_PROPERTY_PARAM_PROFILE_LEVEL_CURRENT;
>         int ret;
>
> @@ -71,7 +74,9 @@ static int vdec_op_g_volatile_ctrl(struct v4l2_ctrl *ctrl)
>                 ctrl->val = ctr->post_loop_deb_mode;
>                 break;
>         case V4L2_CID_MIN_BUFFERS_FOR_CAPTURE:
> -               ctrl->val = inst->num_output_bufs;
> +               ret = venus_helper_get_bufreq(inst, HFI_BUFFER_OUTPUT, &bufreq);
> +               if (!ret)
> +                       ctrl->val = HFI_BUFREQ_COUNT_MIN(&bufreq, ver);

What happens if venus_helper_get_bufreq() returns an error? It seems
that we just happily continue with whatever the previous value of
ctrl->val was. It seems like we do the same with other controls as
well.

I think you can fix this globally by initializing ret to 0 at the
beginning of the function, and then returning ret instead of 0 at the
end. That way all errors would be propagated. Of course please check
that this is relevant for other controls following this scheme before
doing so. :)
