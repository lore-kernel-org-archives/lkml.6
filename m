Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF74C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 14:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA0F7207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 14:32:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Mg5lTB1O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA0F7207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbeJXXA4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 19:00:56 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:45109 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbeJXXA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 19:00:56 -0400
Received: by mail-yw1-f67.google.com with SMTP id i185-v6so2139517ywa.12
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 07:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z7FjBXGdzQiGQliq95iKLgqKWbbPvwlesMKsOeKtB2o=;
        b=Mg5lTB1OznY7KmNXKoZwuwxE/zohBOH+oVxPyMTXQ4pTvfFrwIPTLYraJe3WgoYUtZ
         20b+zcnnVXDAJ9yIkD8K1lI9NBHWlSApPJ4Hr1j0nvgxZEhmsMKx2SPPgOScK6CaLN7u
         ncqoEECZbkR2LN8sPA6daoYHk99AZgYOdDn5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z7FjBXGdzQiGQliq95iKLgqKWbbPvwlesMKsOeKtB2o=;
        b=jVgER7Bn6dna5z3NpqS+I4BMDtTIhRN8AO3E50C6Jfi+EOEBaw4sKIIplwMHKNMtXL
         0aQ7ze7faPSP3Khu+I6voE5LSVHQLEqA6r9V8V+yvKiGCwcax6wqSb0UDd09QGDYnydV
         KuN0I4CyaaGqIun3+WXbXaaM2Nqd9kwApZqMlM59yEX39hlJgxGKV5krM+r3lp1jBn+w
         Z6p7NzCGboRxnHf7wN8U273B5nzz+kWsA5Sn89wtJnhPKuJ6w8YxxAqymirTJx5v91xs
         NvwtdB7gRpai0u5fBaHaCNxhT0LohaxO8TzenGlBCgEu3YhqoWKJg1IiykxKT9XAo3Bq
         vgzQ==
X-Gm-Message-State: AGRZ1gLUkh5xxBzRSPkIiQ3D3NOLIclbKbhQH2Tn+pZzfGWyrnCE95+e
        9tS/H+Lnfnsxx0Fbt1E8l3ZbHZYb4FoTVQ==
X-Google-Smtp-Source: AJdET5fel+odF2Xne3MGmjZDAtvfAB0mXTTAE/jaMTae6gxL0P1+WEBBPuBpkpgQJqTiu8FzzB6gJQ==
X-Received: by 2002:a81:1153:: with SMTP id 80-v6mr2479636ywr.302.1540391554391;
        Wed, 24 Oct 2018 07:32:34 -0700 (PDT)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id h68-v6sm1029812ywd.88.2018.10.24.07.32.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 07:32:33 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id v92-v6so2209268ybi.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 07:32:32 -0700 (PDT)
X-Received: by 2002:a25:b3c9:: with SMTP id x9-v6mr2399622ybf.508.1540391552203;
 Wed, 24 Oct 2018 07:32:32 -0700 (PDT)
MIME-Version: 1.0
References: <1540389162-30358-1-git-send-email-mgottam@codeaurora.org>
In-Reply-To: <1540389162-30358-1-git-send-email-mgottam@codeaurora.org>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Wed, 24 Oct 2018 23:32:19 +0900
X-Gmail-Original-Message-ID: <CAAFQd5CaYH-kxj+9cquObTHiRyA1VoEYHQmiQAGjdZm6J1ACfg@mail.gmail.com>
Message-ID: <CAAFQd5CaYH-kxj+9cquObTHiRyA1VoEYHQmiQAGjdZm6J1ACfg@mail.gmail.com>
Subject: Re: [PATCH v2] media: venus: add support for key frame
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

On Wed, Oct 24, 2018 at 10:52 PM Malathi Gottam <mgottam@codeaurora.org> wrote:
>
> When client requests for a keyframe, set the property
> to hardware to generate the sync frame.
>
> Signed-off-by: Malathi Gottam <mgottam@codeaurora.org>
> ---
>  drivers/media/platform/qcom/venus/venc_ctrls.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/media/platform/qcom/venus/venc_ctrls.c b/drivers/media/platform/qcom/venus/venc_ctrls.c
> index 45910172..6c2655d 100644
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
> @@ -173,6 +175,15 @@ static int venc_op_s_ctrl(struct v4l2_ctrl *ctrl)
>
>                 ctr->num_b_frames = bframes;
>                 break;
> +       case V4L2_CID_MPEG_VIDEO_FORCE_KEY_FRAME:
> +               if (inst->streamon_out && inst->streamon_cap) {
> +                       ptype = HFI_PROPERTY_CONFIG_VENC_REQUEST_SYNC_FRAME;
> +                       ret = hfi_session_set_property(inst, ptype, &en);
> +
> +                       if (ret)
> +                               return ret;
> +               }
> +               break;

This is still not the right way to handle this.

Please see the documentation of this control [1]:

"V4L2_CID_MPEG_VIDEO_FORCE_KEY_FRAME (button)
Force a key frame for the next queued buffer. Applicable to encoders.
This is a general, codec-agnostic keyframe control."

Even if the driver is not streaming, it must remember that the
keyframe was requested for next buffer. The next time userspace QBUFs
an OUTPUT buffer, it should ask the hardware to encode that OUTPUT
buffer into a keyframe.

[1] https://www.kernel.org/doc/html/latest/media/uapi/v4l/extended-controls.html?highlight=v4l2_cid_mpeg_video_force_key_frame

But generally, the proper modern way for the userspace to request a
keyframe is to set the V4L2_BUF_FLAG_KEYFRAME flag in the
vb2_buffer_flag when queuing an OUTPUT buffer. It's the only
guaranteed way to ensure that the keyframe will be encoded exactly for
the selected frame. (The V4L2 control API doesn't guarantee any
synchronization between controls and buffers itself.)

Best regards,
Tomasz
