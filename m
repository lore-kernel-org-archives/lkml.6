Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB29C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 08:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3A132098A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 08:06:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BMvBw36Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3A132098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbeJLPhh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 11:37:37 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:40642 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727151AbeJLPhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 11:37:37 -0400
Received: by mail-io1-f65.google.com with SMTP id w16-v6so8608197iom.7
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 01:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CEw4XGDZWJoIw+L5XfFfLpFOsrwabqrICLfsQN69xlM=;
        b=BMvBw36ZxXqv6aMdLQNQd2NLYGcb47R65KY5h52bcvM6EjV3d5oJJHpbo6kqxFBqDL
         jzyQ10tzXIyBaZgt/Xg/job3r6ni1Lmtq3NmNmY+F+SWWCrzII9XHK1Khk6uFlqvRezk
         +OoucSfHaRzoCKFvYZBJGiO+zJYVH3QP77Ctc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CEw4XGDZWJoIw+L5XfFfLpFOsrwabqrICLfsQN69xlM=;
        b=oJ3G0CtZUzKdL/uWyS6sSuvDWByMJFCw+OFR6jbJHSmxRawgEUSOmUbtMhzeYTKA8G
         SxE9VLw5nTKxZEMCqewefjymCUOjIHSg3OmQawNHOGhzvrrmVt5OpoaE2N0q+6V6bG78
         5sqk4fyuUD2isOF6lZDh2TvZS7vqgr0Saoa6gTLo0svlonxQOZKG5bXYoOKD90b3O/8L
         NAUF4AHZjn/ZkjH3O3kUqZ7t+rjEG11HYetiFSBkk5zxmTZlosiDXbyFmoO+RaD6YYk8
         vg/ymybCgIQ1aZcw6n2mJCHJbNDNFWbcpaMBXcGG5MHGQn1oFsxaDWXpI9yWV7mOvTgW
         Mpuw==
X-Gm-Message-State: ABuFfojvGTUllnI+Ny3IKZW3ObR3Mj4hV/F/vPdc7Jp2IPN2iyX5CIIJ
        sJkWG6W98PgpgWx0iKXOJdPwFVOQjWhmFA==
X-Google-Smtp-Source: ACcGV62t+1u5zFnm6uaMXsQ5kNzEaNQprpZe0CcmLJz37dRgLTwuAurmNU3H+CVWf5KU0aS6x4dSWg==
X-Received: by 2002:a6b:8d53:: with SMTP id p80-v6mr3183012iod.98.1539331582089;
        Fri, 12 Oct 2018 01:06:22 -0700 (PDT)
Received: from mail-it1-f179.google.com (mail-it1-f179.google.com. [209.85.166.179])
        by smtp.gmail.com with ESMTPSA id d75-v6sm307327itc.41.2018.10.12.01.06.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Oct 2018 01:06:21 -0700 (PDT)
Received: by mail-it1-f179.google.com with SMTP id c23-v6so17481185itd.5
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 01:06:21 -0700 (PDT)
X-Received: by 2002:a24:c5c7:: with SMTP id f190-v6mr3782840itg.172.1539331580712;
 Fri, 12 Oct 2018 01:06:20 -0700 (PDT)
MIME-Version: 1.0
References: <1539071634-1644-1-git-send-email-mgottam@codeaurora.org>
 <CAPBb6MUt_V4zEKGcRYXRXNRVdjF2uspOvEj0T-dH6dBZ9ya9CA@mail.gmail.com> <f1bb2ead-fe8e-af6a-1b96-9460a7b01f29@linaro.org>
In-Reply-To: <f1bb2ead-fe8e-af6a-1b96-9460a7b01f29@linaro.org>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Fri, 12 Oct 2018 17:06:09 +0900
X-Gmail-Original-Message-ID: <CAPBb6MXxaGMCY43fXwWYZmYmiVwDA6kdJRwWZGqUHhWOGXSz7Q@mail.gmail.com>
Message-ID: <CAPBb6MXxaGMCY43fXwWYZmYmiVwDA6kdJRwWZGqUHhWOGXSz7Q@mail.gmail.com>
Subject: Re: [PATCH] media: venus: add support for key frame
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     mgottam@codeaurora.org, Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, vgarodia@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 4:37 PM Stanimir Varbanov
<stanimir.varbanov@linaro.org> wrote:
>
> Hi Alex,
>
> On 10/12/2018 08:26 AM, Alexandre Courbot wrote:
> > On Tue, Oct 9, 2018 at 4:54 PM Malathi Gottam <mgottam@codeaurora.org> wrote:
> >>
> >> When client requests for a keyframe, set the property
> >> to hardware to generate the sync frame.
> >>
> >> Signed-off-by: Malathi Gottam <mgottam@codeaurora.org>
> >> ---
> >>  drivers/media/platform/qcom/venus/venc_ctrls.c | 13 +++++++++++++
> >>  1 file changed, 13 insertions(+)
> >>
> >> diff --git a/drivers/media/platform/qcom/venus/venc_ctrls.c b/drivers/media/platform/qcom/venus/venc_ctrls.c
> >> index 45910172..f332c8e 100644
> >> --- a/drivers/media/platform/qcom/venus/venc_ctrls.c
> >> +++ b/drivers/media/platform/qcom/venus/venc_ctrls.c
> >> @@ -81,6 +81,8 @@ static int venc_op_s_ctrl(struct v4l2_ctrl *ctrl)
> >>         struct venc_controls *ctr = &inst->controls.enc;
> >>         u32 bframes;
> >>         int ret;
> >> +       void *ptr;
> >> +       u32 ptype;
> >>
> >>         switch (ctrl->id) {
> >>         case V4L2_CID_MPEG_VIDEO_BITRATE_MODE:
> >> @@ -173,6 +175,14 @@ static int venc_op_s_ctrl(struct v4l2_ctrl *ctrl)
> >>
> >>                 ctr->num_b_frames = bframes;
> >>                 break;
> >> +       case V4L2_CID_MPEG_VIDEO_FORCE_KEY_FRAME:
> >> +               ptype = HFI_PROPERTY_CONFIG_VENC_REQUEST_SYNC_FRAME;
> >> +               ret = hfi_session_set_property(inst, ptype, ptr);
> >
> > The test bot already said it, but ptr is passed to
> > hfi_session_set_property() uninitialized. And as can be expected the
> > call returns -EINVAL on my board.
> >
> > Looking at other uses of HFI_PROPERTY_CONFIG_VENC_REQUEST_SYNC_FRAME I
> > see that the packet sent to the firmware does not have room for an
> > argument, so I tried to pass NULL but got the same result.
>
> yes, because pdata cannot be NULL. I'd suggest to make a pointer to
> struct hfi_enable and pass it to the set_property function.

FWIW I also tried doing this and got the same error, strange...
