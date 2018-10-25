Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D1AC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 07:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9076205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 07:31:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ltJzd6yg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9076205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbeJYQCn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 12:02:43 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:38276 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726538AbeJYQCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 12:02:43 -0400
Received: by mail-yw1-f68.google.com with SMTP id d126-v6so3199830ywa.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 00:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gGteqWKGyRq4CY8yG1kvZEa/GWFSb3wYHRS2RlHstxU=;
        b=ltJzd6ygYQpXgil0F8ltZuDWZ9W/iJYRyf8NOGJuRprR9zrYWSq87RkWW5irLRtEBM
         +dQjZMLZkINXt6tLi6NX1F15fzX/qqKKhJIduBNhiFpnnem5MjdNabKukeCnfv44MfSI
         bnMWmRXs9I9V0sz0r6/czpmJXKGOACTa+Ev/0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gGteqWKGyRq4CY8yG1kvZEa/GWFSb3wYHRS2RlHstxU=;
        b=fbVu1y+LRdKRb4EkR7BHc9ifnxPNtCU5DS386HVXccjpz9bRSr03A6Hsl9zenZ8Wuo
         MMD7dSq7aR0c2YRoNTFxVmrkYjcd12bNjoq5EabSxGIqOgm50TI9z1RO3+WtLT9n4mbo
         UkDEso2xPWP9yYal1TDQczNfa7BKUm9bcAhtCxrqMg5pzwUkGXasjtlHZ9giKXXsou+0
         jToPSUZyiivjfeS7VOHhfs3HyHPiTF+PhQDcutL1SAj2gDF4IDLeM/+5m59/JBwrOWJX
         HMRp2h+VLVatkebRNnZU8gywHpvq104L2VcDol+Ew6np7FxiqRfyDGcL0IqDPw6ZzqKT
         zzPQ==
X-Gm-Message-State: AGRZ1gIvjVZLUnagWGRsqg6Oyf9NUZLKtZq38qvkUVdkSeUH9TomtMvs
        btJBlCwnPVZJZWUb/3ijlnYoEuJuDw4TQw==
X-Google-Smtp-Source: AJdET5cCj7iDwlQRQYrkr01LQQHDnSUWUoMsJ1dMATOR/hAITdH0vUy/FoBTdh0am4ldK9u5GDTMPQ==
X-Received: by 2002:a81:e4d:: with SMTP id 74-v6mr365566ywo.162.1540452671929;
        Thu, 25 Oct 2018 00:31:11 -0700 (PDT)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id 80-v6sm2407500ywh.55.2018.10.25.00.31.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 00:31:10 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id n140-v6so3276073yba.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 00:31:10 -0700 (PDT)
X-Received: by 2002:a25:b083:: with SMTP id f3-v6mr338705ybj.293.1540452670045;
 Thu, 25 Oct 2018 00:31:10 -0700 (PDT)
MIME-Version: 1.0
References: <1540389162-30358-1-git-send-email-mgottam@codeaurora.org>
 <CAAFQd5CaYH-kxj+9cquObTHiRyA1VoEYHQmiQAGjdZm6J1ACfg@mail.gmail.com> <86344762e1eeab8fe8a940a1bfffa2c1@codeaurora.org>
In-Reply-To: <86344762e1eeab8fe8a940a1bfffa2c1@codeaurora.org>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Thu, 25 Oct 2018 16:30:58 +0900
X-Gmail-Original-Message-ID: <CAAFQd5BhVdnmaVriBHEEvqKqO1Aiky0RpTyKWuh4+r0tPovsCA@mail.gmail.com>
Message-ID: <CAAFQd5BhVdnmaVriBHEEvqKqO1Aiky0RpTyKWuh4+r0tPovsCA@mail.gmail.com>
Subject: Re: [PATCH v2] media: venus: add support for key frame
To:     vgarodia@codeaurora.org
Cc:     mgottam@codeaurora.org,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        linux-media-owner@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 4:23 PM Vikash Garodia <vgarodia@codeaurora.org> wrote:
>
> On 2018-10-24 20:02, Tomasz Figa wrote:
> > On Wed, Oct 24, 2018 at 10:52 PM Malathi Gottam
> > <mgottam@codeaurora.org> wrote:
> >>
> >> When client requests for a keyframe, set the property
> >> to hardware to generate the sync frame.
> >>
> >> Signed-off-by: Malathi Gottam <mgottam@codeaurora.org>
> >> ---
> >>  drivers/media/platform/qcom/venus/venc_ctrls.c | 16 +++++++++++++++-
> >>  1 file changed, 15 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/media/platform/qcom/venus/venc_ctrls.c
> >> b/drivers/media/platform/qcom/venus/venc_ctrls.c
> >> index 45910172..6c2655d 100644
> >> --- a/drivers/media/platform/qcom/venus/venc_ctrls.c
> >> +++ b/drivers/media/platform/qcom/venus/venc_ctrls.c
> >> @@ -79,8 +79,10 @@ static int venc_op_s_ctrl(struct v4l2_ctrl *ctrl)
> >>  {
> >>         struct venus_inst *inst = ctrl_to_inst(ctrl);
> >>         struct venc_controls *ctr = &inst->controls.enc;
> >> +       struct hfi_enable en = { .enable = 1 };
> >>         u32 bframes;
> >>         int ret;
> >> +       u32 ptype;
> >>
> >>         switch (ctrl->id) {
> >>         case V4L2_CID_MPEG_VIDEO_BITRATE_MODE:
> >> @@ -173,6 +175,15 @@ static int venc_op_s_ctrl(struct v4l2_ctrl *ctrl)
> >>
> >>                 ctr->num_b_frames = bframes;
> >>                 break;
> >> +       case V4L2_CID_MPEG_VIDEO_FORCE_KEY_FRAME:
> >> +               if (inst->streamon_out && inst->streamon_cap) {
> >> +                       ptype =
> >> HFI_PROPERTY_CONFIG_VENC_REQUEST_SYNC_FRAME;
> >> +                       ret = hfi_session_set_property(inst, ptype,
> >> &en);
> >> +
> >> +                       if (ret)
> >> +                               return ret;
> >> +               }
> >> +               break;
> >
> > This is still not the right way to handle this.
> >
> > Please see the documentation of this control [1]:
> >
> > "V4L2_CID_MPEG_VIDEO_FORCE_KEY_FRAME (button)
> > Force a key frame for the next queued buffer. Applicable to encoders.
> > This is a general, codec-agnostic keyframe control."
> >
> > Even if the driver is not streaming, it must remember that the
> > keyframe was requested for next buffer. The next time userspace QBUFs
> > an OUTPUT buffer, it should ask the hardware to encode that OUTPUT
> > buffer into a keyframe.
>
> That's correct. Driver can cache the client request and set it when the
> hardware
> is capable of accepting the property.
> Still the issue having the requested OUTPUT buffer to be encoded as sync
> frame will
> be there. If there are few frames queued before streamon, driver will
> only keep a
> note that it has to set the request for keyframe, but not the exact one
> which was
> requested.

The description (quoted above) specifies exactly that the control
applies only to the next queued buffer. It's a "button" control, so
when the application sets it (to 1), it triggers a call to driver's
s_ctrl callback and then resets to 0 automatically.

>
> > [1]
> > https://www.kernel.org/doc/html/latest/media/uapi/v4l/extended-controls.html?highlight=v4l2_cid_mpeg_video_force_key_frame
> >
> > But generally, the proper modern way for the userspace to request a
> > keyframe is to set the V4L2_BUF_FLAG_KEYFRAME flag in the
> > vb2_buffer_flag when queuing an OUTPUT buffer. It's the only
> > guaranteed way to ensure that the keyframe will be encoded exactly for
> > the selected frame. (The V4L2 control API doesn't guarantee any
> > synchronization between controls and buffers itself.)
>
> This is a better way to handle it to ensure exact buffer gets encoded as
> sync frame.

It was created later to solve this problem. For compatibility, we have
to keep supporting the control too.

Best regards,
Tomasz
