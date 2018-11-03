Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B666BC6786F
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 03:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7784520840
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 03:01:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Q5y3dPsW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7784520840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbeKCMLC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 08:11:02 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:43223 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbeKCMLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 08:11:01 -0400
Received: by mail-yb1-f194.google.com with SMTP id g75-v6so1589184yba.10
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 20:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5ejElUlTe1dJGyBNwUiijwKD1sWTh+8xR5Xzryv3fAk=;
        b=Q5y3dPsWS+fyZUKwUfbYnUM95B4+fG8DvwrkJrmGBvMFve81+CfjctOyMhdWlkelyF
         XO5UE+bs0ikwmP7nuzf4qwfDE6Z/QdLqcDI+zO8dDZyZ4VI8ZXO8zkpg7wRJWXo9PJzL
         6qPjxMqVyztuqAUaPHJz4+0msOZQL8m+9Dc54=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5ejElUlTe1dJGyBNwUiijwKD1sWTh+8xR5Xzryv3fAk=;
        b=tO/qKia0l9Lm6yykNIVwYWUzRob65QJ3iWRM2yC1sf/o78tVHpYYv5bqNw9ehjYBCN
         Cu+sO+bXKBFSrHXwpKAmkiCPHE0696cy1tRjKRv8QT9DbeJALLBhGlc90hRnwSd1BtmH
         0AqndYf8S3SN1uRYSZgIs3eHuzmzcwReLjv8vu378RCDDZfIT+83aSnATYy1NCwr12zJ
         ANl2ZNg4JKtpPG72w6yNXmb0Iqx03xI33dHMT9BePqXJFsYCwU2t5G7HvWLHFnMZu2F0
         K/YEHaiKGnwsPSv/kUKMGnqJrsl2RPtrJr1EkKcmvbzD8c8bDrd2kfbiawEslZXKfqvv
         ysAg==
X-Gm-Message-State: AGRZ1gIiYGRebU6uUugfXyk4slxJ6MI6hCUcQEguDUC3tjZ+ekcVGjJZ
        KndJEI2t7eAwD/PkAuQlQ+8CSnauMXw=
X-Google-Smtp-Source: AJdET5eGkjRiZhBEM1Za/vgVtq3u2Q66lfPyRm9hKXsqzblIueSpI7JjTE9e/Nhd4y2ClyxbTai9sw==
X-Received: by 2002:a25:adc4:: with SMTP id d4-v6mr14641798ybe.319.1541214075657;
        Fri, 02 Nov 2018 20:01:15 -0700 (PDT)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id h3-v6sm5390376ywf.44.2018.11.02.20.01.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Nov 2018 20:01:14 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id u103-v6so52675ybi.5
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 20:01:13 -0700 (PDT)
X-Received: by 2002:a25:2407:: with SMTP id k7-v6mr13824748ybk.373.1541214073364;
 Fri, 02 Nov 2018 20:01:13 -0700 (PDT)
MIME-Version: 1.0
References: <1541163476-23249-1-git-send-email-mgottam@codeaurora.org>
In-Reply-To: <1541163476-23249-1-git-send-email-mgottam@codeaurora.org>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Sat, 3 Nov 2018 12:01:01 +0900
X-Gmail-Original-Message-ID: <CAAFQd5D=hNdkEovonE6GOaYvq9dBbQwSZ=95V9a80e-sLp7cYg@mail.gmail.com>
Message-ID: <CAAFQd5D=hNdkEovonE6GOaYvq9dBbQwSZ=95V9a80e-sLp7cYg@mail.gmail.com>
Subject: Re: [PATCH v3] media: venus: add support for key frame
To:     mgottam@codeaurora.org
Cc:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        vgarodia@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Malathi,

On Fri, Nov 2, 2018 at 9:58 PM Malathi Gottam <mgottam@codeaurora.org> wrote:
>
> When client requests for a keyframe, set the property
> to hardware to generate the sync frame.
>
> Signed-off-by: Malathi Gottam <mgottam@codeaurora.org>
> ---
>  drivers/media/platform/qcom/venus/venc_ctrls.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/media/platform/qcom/venus/venc_ctrls.c b/drivers/media/platform/qcom/venus/venc_ctrls.c
> index 45910172..59fe7fc 100644
> --- a/drivers/media/platform/qcom/venus/venc_ctrls.c
> +++ b/drivers/media/platform/qcom/venus/venc_ctrls.c
> @@ -79,8 +79,10 @@ static int venc_op_s_ctrl(struct v4l2_ctrl *ctrl)
>  {
>         struct venus_inst *inst = ctrl_to_inst(ctrl);
>         struct venc_controls *ctr = &inst->controls.enc;
> +       struct hfi_enable en = { .enable = 1 };
>         u32 bframes;
>         int ret;
> +       u32 ptype;
>
>         switch (ctrl->id) {
>         case V4L2_CID_MPEG_VIDEO_BITRATE_MODE:
> @@ -173,6 +175,19 @@ static int venc_op_s_ctrl(struct v4l2_ctrl *ctrl)
>
>                 ctr->num_b_frames = bframes;
>                 break;
> +       case V4L2_CID_MPEG_VIDEO_FORCE_KEY_FRAME:
> +               mutex_lock(&inst->lock);
> +               if (inst->streamon_out && inst->streamon_cap) {

We had a discussion on this in v2. I don't remember seeing any conclusion.

Obviously the hardware should generate a keyframe naturally when the
CAPTURE streaming starts, which is where the encoding starts, but the
state of the OUTPUT queue should not affect this.

The application is free to stop and start streaming on the OUTPUT
queue as it goes and it shouldn't imply any side effects in the
encoded bitstream (e.g. a keyframe inserted). So:
- a sequence of STREAMOFF(OUTPUT),
S_CTRL(V4L2_CID_MPEG_VIDEO_FORCE_KEY_FRAME), STREAMON(OUTPUT) should
explicitly generate a keyframe,
- a sequence of STREAMOFF(OUTPUT), STREAMON(OUTPUT) should _not_
explicitly generate a keyframe (the hardware may generate one, if the
periodic keyframe counter is active or a scene detection algorithm
decides so).

Please refer to the specification (v2 is the latest for the time being
-> https://lore.kernel.org/patchwork/patch/1002476/) for further
details and feel free to leave any comment for it.

Best regards,
Tomasz
