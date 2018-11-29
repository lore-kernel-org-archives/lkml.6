Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEDF9C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 19:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 764362082F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 19:40:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nowF+d5/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 764362082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbeK3Gqv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 01:46:51 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:44266 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbeK3Gqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 01:46:51 -0500
Received: by mail-yw1-f66.google.com with SMTP id i22so954961ywa.11
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 11:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TnfYTPGh25KsZII77vxbBaSF/fh/tY3BbTHq6Jxn/2s=;
        b=nowF+d5/GUtSt9HSeXRIH7fQhSDy0k5T9a+3zwbWI6jeDPBBGglLBvMNBN8zvWRzhT
         uNalDcpXg1JXzupE+NR6aH1N8F9c9N1PXkly8FboxZ2IsLQ4RogUrItUbbnESaAt9fhc
         qx3VXqVlvZcDq1w2qDzbw2v3Sv2TiNkx3dz+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TnfYTPGh25KsZII77vxbBaSF/fh/tY3BbTHq6Jxn/2s=;
        b=gO29QNjtRtdFqw+bGeqFK0Hj2htSD5j6jiiewabZJhIJ+zYfv7REW8YZqj4KC4n0Fi
         L3gIyY7Oxk1sFRyUfFWbJHV+qn3zNAy83z0qSPH+rydsyNWnOxm/0oxtHwnqqqKF7iCr
         KYXLpxA2ptZ1N/HyHuN8sxpwSW/78jjaTZIyv6CIktcOSXZsVxTO9akgVCzUeN2sjCGW
         9ls5HsSr7PC9oVTKT7P3m9J8P1Uv3Yr6qDkdS5c/45b6+f5F+1GVi1I/qXn8TG2FaSYN
         ObJ/gA8crwm6QEs/cKRSCOhfyIX5h28L7zgO8EBd3jByYdkJfBSV8jLRU32+F3KWqHDx
         /0qw==
X-Gm-Message-State: AA+aEWYkX1S+VQlthRrvSZN02BS1GYgGYDZSSJkHdmBgC2pYnJPrKf6P
        sgoh38Ssya3XzfoVGLPXLUO/5cUYVCY=
X-Google-Smtp-Source: AFSGD/U2WHo//nhRF/Og0G5XRRY8gdwBe8C4l/S0uTSZVohnlwq444AfAHEvnobLfaJZTBJVSUettg==
X-Received: by 2002:a0d:dd52:: with SMTP id g79mr2827340ywe.29.1543520418916;
        Thu, 29 Nov 2018 11:40:18 -0800 (PST)
Received: from mail-yw1-f41.google.com (mail-yw1-f41.google.com. [209.85.161.41])
        by smtp.gmail.com with ESMTPSA id l7sm842998ywk.24.2018.11.29.11.40.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 11:40:16 -0800 (PST)
Received: by mail-yw1-f41.google.com with SMTP id j6so1267872ywj.6
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 11:40:16 -0800 (PST)
X-Received: by 2002:a81:3dc4:: with SMTP id k187-v6mr2858410ywa.415.1543520416173;
 Thu, 29 Nov 2018 11:40:16 -0800 (PST)
MIME-Version: 1.0
References: <1541163476-23249-1-git-send-email-mgottam@codeaurora.org>
 <CAAFQd5D=hNdkEovonE6GOaYvq9dBbQwSZ=95V9a80e-sLp7cYg@mail.gmail.com>
 <4767b56f-420b-dc0c-0ae9-44dbf6dcd0b1@linaro.org> <6d765e0d7d6b873e087a3db823cb1b29@codeaurora.org>
In-Reply-To: <6d765e0d7d6b873e087a3db823cb1b29@codeaurora.org>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Thu, 29 Nov 2018 11:40:04 -0800
X-Gmail-Original-Message-ID: <CAAFQd5Ask-mw+uEE0OAEabjaAAYcJyCeexaofOAg1bp2NtvpKA@mail.gmail.com>
Message-ID: <CAAFQd5Ask-mw+uEE0OAEabjaAAYcJyCeexaofOAg1bp2NtvpKA@mail.gmail.com>
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

On Thu, Nov 29, 2018 at 3:10 AM <mgottam@codeaurora.org> wrote:
>
>
> Hi Stan,
>
> On 2018-11-29 16:01, Stanimir Varbanov wrote:
> > Hi Tomasz,
> >
> > On 11/3/18 5:01 AM, Tomasz Figa wrote:
> >> Hi Malathi,
> >>
> >> On Fri, Nov 2, 2018 at 9:58 PM Malathi Gottam <mgottam@codeaurora.org>
> >> wrote:
> >>>
> >>> When client requests for a keyframe, set the property
> >>> to hardware to generate the sync frame.
> >>>
> >>> Signed-off-by: Malathi Gottam <mgottam@codeaurora.org>
> >>> ---
> >>>  drivers/media/platform/qcom/venus/venc_ctrls.c | 20
> >>> +++++++++++++++++++-
> >>>  1 file changed, 19 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/media/platform/qcom/venus/venc_ctrls.c
> >>> b/drivers/media/platform/qcom/venus/venc_ctrls.c
> >>> index 45910172..59fe7fc 100644
> >>> --- a/drivers/media/platform/qcom/venus/venc_ctrls.c
> >>> +++ b/drivers/media/platform/qcom/venus/venc_ctrls.c
> >>> @@ -79,8 +79,10 @@ static int venc_op_s_ctrl(struct v4l2_ctrl *ctrl)
> >>>  {
> >>>         struct venus_inst *inst = ctrl_to_inst(ctrl);
> >>>         struct venc_controls *ctr = &inst->controls.enc;
> >>> +       struct hfi_enable en = { .enable = 1 };
> >>>         u32 bframes;
> >>>         int ret;
> >>> +       u32 ptype;
> >>>
> >>>         switch (ctrl->id) {
> >>>         case V4L2_CID_MPEG_VIDEO_BITRATE_MODE:
> >>> @@ -173,6 +175,19 @@ static int venc_op_s_ctrl(struct v4l2_ctrl
> >>> *ctrl)
> >>>
> >>>                 ctr->num_b_frames = bframes;
> >>>                 break;
> >>> +       case V4L2_CID_MPEG_VIDEO_FORCE_KEY_FRAME:
> >>> +               mutex_lock(&inst->lock);
> >>> +               if (inst->streamon_out && inst->streamon_cap) {
> >>
> >> We had a discussion on this in v2. I don't remember seeing any
> >> conclusion.
> >>
> >> Obviously the hardware should generate a keyframe naturally when the
> >> CAPTURE streaming starts, which is where the encoding starts, but the
> >> state of the OUTPUT queue should not affect this.
> >>
> >> The application is free to stop and start streaming on the OUTPUT
> >> queue as it goes and it shouldn't imply any side effects in the
> >> encoded bitstream (e.g. a keyframe inserted). So:
> >> - a sequence of STREAMOFF(OUTPUT),
> >> S_CTRL(V4L2_CID_MPEG_VIDEO_FORCE_KEY_FRAME), STREAMON(OUTPUT) should
> >> explicitly generate a keyframe,
> >
> > I agree with you, but presently we don't follow strictly the stateful
> > encoder spec. In this spirit I think proposed patch is applicable to
> > the
> > current state of the encoder driver, and your comment should be
> > addressed in the follow-up patches where we have to re-factor a bit
> > start/stop_streaming according to the encoder documentation.
> >
> > But until then we have to get that patch.
>
> So I can see that this patch is good implementation of forcing sync
> frame
> under current encoder state.
>
> Can you please ack the same.

Okay, assuming that when you start streaming you naturally get a
keyframe, I'm okay with this patch, since it actually fixes the
missing key frame request, so from the general encoder interface point
of view:

Acked-by: Tomasz Figa <tfiga@chromium.org>

Best regards,
Tomasz
