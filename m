Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09085C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 14:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9BE8205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 14:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YM3Dljt1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9BE8205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728765AbeKAXf0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 19:35:26 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:34316 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728626AbeKAXf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 19:35:26 -0400
Received: by mail-yw1-f68.google.com with SMTP id v199-v6so7979428ywg.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 07:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mt/1G68mUgUFqNWUpBHL3CxO8gcc9613By/+y7nYDwY=;
        b=YM3Dljt1Zch4O6HF0kE5WjrJE6x4J+L4HfIyeufpC+xAoApc6zS0uwRinYbPtnUmpw
         pRNqad3nrouZU0y7pj2P7KyqZ3lpEt3WhbMoWhWD6aeN4/rt3L4eL+7iWFu1LLTlwQ4E
         cMtd2fo8lxk35H6AWgkSl+OVyJlhW1T6ToC+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mt/1G68mUgUFqNWUpBHL3CxO8gcc9613By/+y7nYDwY=;
        b=C7draCwwnKs3x+g7lO7hFKpzF0iQTT7j+CDm4ISt318Y2XDb0v5pWiGaA3fuJqITlE
         tQFkwkNiY2aER4pwHr5/xW+2ZBMOiRxSY/uU6t5ukB+8AzgJICJnG28zR8GvbDRxpYHX
         xusG+VLH4y4ObXWCA5eoJ7fwBTJBRtgaauIjVAUVHnQBkT+0QXuvKzemnu5Canr20hCC
         8PpBzmD6l1l895bl+RmyfM0wRCbifQfXPtuSfBekHk5w6rSE8nmCfKFpxD87yBI8tc4l
         T5qYafzii4CZPiZ4y5GLL3wylhDjpElFTTm6nmNikakkyu7i9DEuBTGxjhovjtUCCD/Y
         5nRA==
X-Gm-Message-State: AGRZ1gLzgrMlRe6ibOdnSCZ63Ffm/PavNPaGMovaDquj9VkdPxID3DeD
        LrLRYIpEoEfP5rnCchXfX8tbMizgzws=
X-Google-Smtp-Source: AJdET5f80wno9OQgLl4IDNYsgNZvM8ixDMIRSZX/629HfXUid+ycIqvvUC2bODj3Yg4X6DDHQnJmIQ==
X-Received: by 2002:a0d:ff46:: with SMTP id p67-v6mr7751700ywf.338.1541082732105;
        Thu, 01 Nov 2018 07:32:12 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id k85-v6sm7644720ywa.76.2018.11.01.07.32.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 07:32:11 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id g9-v6so8179698ybh.7
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 07:32:10 -0700 (PDT)
X-Received: by 2002:a25:f626:: with SMTP id t38-v6mr7863016ybd.285.1541082729784;
 Thu, 01 Nov 2018 07:32:09 -0700 (PDT)
MIME-Version: 1.0
References: <1540971728-26789-1-git-send-email-mgottam@codeaurora.org>
 <3ff2c3dd-434d-960b-6806-f4bb8ec0d954@linaro.org> <3364115421e89c7710725c06b820f8c6@codeaurora.org>
 <CAAFQd5A+9GWmn4aD4D2JMf1e1m-6Dtc3xUdMZsf8fPtgi34QVQ@mail.gmail.com> <ba1453b6868e97b96e0345129153b819@codeaurora.org>
In-Reply-To: <ba1453b6868e97b96e0345129153b819@codeaurora.org>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Thu, 1 Nov 2018 23:31:57 +0900
X-Gmail-Original-Message-ID: <CAAFQd5DuEqTiJbp5wR=_V0zVkVXTJPuMxDaJoTYFvVYfUA8U8g@mail.gmail.com>
Message-ID: <CAAFQd5DuEqTiJbp5wR=_V0zVkVXTJPuMxDaJoTYFvVYfUA8U8g@mail.gmail.com>
Subject: Re: [PATCH] media: venus: dynamic handling of bitrate
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

On Thu, Nov 1, 2018 at 11:23 PM Vikash Garodia <vgarodia@codeaurora.org> wrote:
>
> On 2018-11-01 19:23, Tomasz Figa wrote:
> > On Thu, Nov 1, 2018 at 10:01 PM <mgottam@codeaurora.org> wrote:
> >>
> >> On 2018-11-01 17:48, Stanimir Varbanov wrote:
> >> > Hi Malathi,
> >> >
> >> > Thanks for the patch!
> >> >
> >> > On 10/31/18 9:42 AM, Malathi Gottam wrote:
> >> >> Any request for a change in bitrate after both planes
> >> >> are streamed on is handled by setting the target bitrate
> >> >> property to hardware.
> >> >>
> >> >> Signed-off-by: Malathi Gottam <mgottam@codeaurora.org>
> >> >> ---
> >> >>  drivers/media/platform/qcom/venus/venc_ctrls.c | 11 +++++++++++
> >> >>  1 file changed, 11 insertions(+)
> >> >>
> >> >> diff --git a/drivers/media/platform/qcom/venus/venc_ctrls.c
> >> >> b/drivers/media/platform/qcom/venus/venc_ctrls.c
> >> >> index 45910172..54f310c 100644
> >> >> --- a/drivers/media/platform/qcom/venus/venc_ctrls.c
> >> >> +++ b/drivers/media/platform/qcom/venus/venc_ctrls.c
> >> >> @@ -79,7 +79,9 @@ static int venc_op_s_ctrl(struct v4l2_ctrl *ctrl)
> >> >>  {
> >> >>      struct venus_inst *inst = ctrl_to_inst(ctrl);
> >> >>      struct venc_controls *ctr = &inst->controls.enc;
> >> >> +    struct hfi_bitrate brate;
> >> >>      u32 bframes;
> >> >> +    u32 ptype;
> >> >>      int ret;
> >> >>
> >> >>      switch (ctrl->id) {
> >> >> @@ -88,6 +90,15 @@ static int venc_op_s_ctrl(struct v4l2_ctrl *ctrl)
> >> >>              break;
> >> >>      case V4L2_CID_MPEG_VIDEO_BITRATE:
> >> >>              ctr->bitrate = ctrl->val;
> >> >> +            if (inst->streamon_out && inst->streamon_cap) {
> >> >
> >> > Hmm, hfi_session_set_property already checks the instance state so I
> >> > don't think those checks are needed. Another thing is that we need to
> >> > take the instance mutex to check the instance state.
> >>
> >> Yes Stan, "hfi_session_set_property" this property check the instance
> >> state,
> >> but returns EINVAL if this is set at UNINIT instance state.
> >>
> >> Controls initialization happens much earlier than session init and
> >> instance init.
> >> So the instance is still in UNINIT state which causes failure while
> >> setting.
> >>
> >> Through this patch we try to meet the client request of changing
> >> bitrate
> >> only
> >> when both planes are streamed on.
> >
> > Where does this requirement come from? It should be possible to set
> > the control at any time and it should apply to any encoding happening
> > after the control is set.
> >
> With the patch, now video driver will set the control whenever client
> sets
> and will apply to encoder.

That's good, thanks for clarifying. I guess I misunderstood Malathi's comment.

Best regards,
Tomasz
