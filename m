Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E1FC004D3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 03:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3531C207DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 03:07:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lzO5cHwJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3531C207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbeJWL2l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 07:28:41 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:44884 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbeJWL2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 07:28:40 -0400
Received: by mail-yw1-f68.google.com with SMTP id t78-v6so2167941ywg.11
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 20:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kKjvu4olbLqWohXxpdkfNrj4VYbsEOY3MSVH0PNlsVM=;
        b=lzO5cHwJd7G06aullgDOIcnKS3GFO1b1JMKdQVDz127Lb2Y9Uzc9DIO6PrswprE9UC
         edVZOFSkfIsMi/Mx9WMwonkpn0NnWgPICsrgHHgMxADRKiAKZMoKN/s0/ot3clN72BpJ
         S+/Qgq9vL5Cb9YdBKzZybD1wr5+ZuC4KRjaNM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kKjvu4olbLqWohXxpdkfNrj4VYbsEOY3MSVH0PNlsVM=;
        b=IFOOSZQtRSq7xlv4pzmmV8WWBlRuRIGwsX2HwftAzf4DEcLm+1zkylPALhDF3gzUPc
         ZnTFESPrbm1oH1KoFtJ9IKY+sXmpT7rhbImv5F4tvdWY5v3oP6jhX27D9GaU2QR3vVqY
         O8VcWda39W+1Fe/EV4f3R9ML0eXnJ5IDWHU725EhjX8jrw8Wie+Qddqg++GFzNIMe9W0
         JqhMMZLwkQFNu149CkDjDVxYMXaBi9ySrylWJ1G6A5ruYN889jhlhl+SdhS1bFFdTUvD
         Qp4b93fDW1A/kkn8kPjXqcz2LxAZicq2FZ/KIBvLBrjUewqs3dchqsDKWuy25HPqza2m
         Aq1Q==
X-Gm-Message-State: ABuFfoiM634aeGMhutorAsQ5AjLy0DMIX6gZGSCiFj+3EN2e+8xOJgKf
        JtIj9/4kJBrSPtixkGhGbqbF9B7Lx56ZYw==
X-Google-Smtp-Source: ACcGV60Yq/NU+SvPkRh+1wiNR1BM9qL3XTRtsLHDaKnKptRY/FF3cOVlmow4EjkP8QMOfbKwodXpGQ==
X-Received: by 2002:a81:230a:: with SMTP id j10-v6mr33400699ywj.255.1540264038824;
        Mon, 22 Oct 2018 20:07:18 -0700 (PDT)
Received: from mail-yw1-f43.google.com (mail-yw1-f43.google.com. [209.85.161.43])
        by smtp.gmail.com with ESMTPSA id h68-v6sm2210826ywd.88.2018.10.22.20.07.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Oct 2018 20:07:17 -0700 (PDT)
Received: by mail-yw1-f43.google.com with SMTP id j75-v6so16864084ywj.10
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 20:07:17 -0700 (PDT)
X-Received: by 2002:a81:350c:: with SMTP id c12-v6mr15064278ywa.342.1540264036794;
 Mon, 22 Oct 2018 20:07:16 -0700 (PDT)
MIME-Version: 1.0
References: <1539071634-1644-1-git-send-email-mgottam@codeaurora.org>
 <CAPBb6MUt_V4zEKGcRYXRXNRVdjF2uspOvEj0T-dH6dBZ9ya9CA@mail.gmail.com>
 <f1bb2ead-fe8e-af6a-1b96-9460a7b01f29@linaro.org> <CAPBb6MXxaGMCY43fXwWYZmYmiVwDA6kdJRwWZGqUHhWOGXSz7Q@mail.gmail.com>
 <40d15ea4-48e2-b2c7-1d70-68dcc1b08990@linaro.org> <CAPBb6MU9mV9_iq6cf-BzzhTFsed5vtjTui669jxq2uF8KenhQQ@mail.gmail.com>
In-Reply-To: <CAPBb6MU9mV9_iq6cf-BzzhTFsed5vtjTui669jxq2uF8KenhQQ@mail.gmail.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Tue, 23 Oct 2018 12:07:05 +0900
X-Gmail-Original-Message-ID: <CAAFQd5BfNxBwEPaZvxbYpmvZw1WvynWV6NrUocm5vmXQNQf8uQ@mail.gmail.com>
Message-ID: <CAAFQd5BfNxBwEPaZvxbYpmvZw1WvynWV6NrUocm5vmXQNQf8uQ@mail.gmail.com>
Subject: Re: [PATCH] media: venus: add support for key frame
To:     Alexandre Courbot <acourbot@chromium.org>
Cc:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        mgottam@codeaurora.org, Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        vgarodia@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 22, 2018 at 3:15 PM Alexandre Courbot <acourbot@chromium.org> wrote:
>
> On Fri, Oct 12, 2018 at 5:10 PM Stanimir Varbanov
> <stanimir.varbanov@linaro.org> wrote:
> >
> >
> >
> > On 10/12/2018 11:06 AM, Alexandre Courbot wrote:
> > > On Fri, Oct 12, 2018 at 4:37 PM Stanimir Varbanov
> > > <stanimir.varbanov@linaro.org> wrote:
> > >>
> > >> Hi Alex,
> > >>
> > >> On 10/12/2018 08:26 AM, Alexandre Courbot wrote:
> > >>> On Tue, Oct 9, 2018 at 4:54 PM Malathi Gottam <mgottam@codeaurora.org> wrote:
> > >>>>
> > >>>> When client requests for a keyframe, set the property
> > >>>> to hardware to generate the sync frame.
> > >>>>
> > >>>> Signed-off-by: Malathi Gottam <mgottam@codeaurora.org>
> > >>>> ---
> > >>>>  drivers/media/platform/qcom/venus/venc_ctrls.c | 13 +++++++++++++
> > >>>>  1 file changed, 13 insertions(+)
> > >>>>
> > >>>> diff --git a/drivers/media/platform/qcom/venus/venc_ctrls.c b/drivers/media/platform/qcom/venus/venc_ctrls.c
> > >>>> index 45910172..f332c8e 100644
> > >>>> --- a/drivers/media/platform/qcom/venus/venc_ctrls.c
> > >>>> +++ b/drivers/media/platform/qcom/venus/venc_ctrls.c
> > >>>> @@ -81,6 +81,8 @@ static int venc_op_s_ctrl(struct v4l2_ctrl *ctrl)
> > >>>>         struct venc_controls *ctr = &inst->controls.enc;
> > >>>>         u32 bframes;
> > >>>>         int ret;
> > >>>> +       void *ptr;
> > >>>> +       u32 ptype;
> > >>>>
> > >>>>         switch (ctrl->id) {
> > >>>>         case V4L2_CID_MPEG_VIDEO_BITRATE_MODE:
> > >>>> @@ -173,6 +175,14 @@ static int venc_op_s_ctrl(struct v4l2_ctrl *ctrl)
> > >>>>
> > >>>>                 ctr->num_b_frames = bframes;
> > >>>>                 break;
> > >>>> +       case V4L2_CID_MPEG_VIDEO_FORCE_KEY_FRAME:
> > >>>> +               ptype = HFI_PROPERTY_CONFIG_VENC_REQUEST_SYNC_FRAME;
> > >>>> +               ret = hfi_session_set_property(inst, ptype, ptr);
> > >>>
> > >>> The test bot already said it, but ptr is passed to
> > >>> hfi_session_set_property() uninitialized. And as can be expected the
> > >>> call returns -EINVAL on my board.
> > >>>
> > >>> Looking at other uses of HFI_PROPERTY_CONFIG_VENC_REQUEST_SYNC_FRAME I
> > >>> see that the packet sent to the firmware does not have room for an
> > >>> argument, so I tried to pass NULL but got the same result.
> > >>
> > >> yes, because pdata cannot be NULL. I'd suggest to make a pointer to
> > >> struct hfi_enable and pass it to the set_property function.
> > >
> > > FWIW I also tried doing this and got the same error, strange...
> > >
> >
> > OK, when you calling the v4l control? It makes sense when you calling
> > it, because set_property checks does the session is on START state (i.e.
> > streamon on both queues).
>
> Do you mean that the property won't be actually applied unless both
> queues are streaming? In that case maybe it would make sense for the
> driver to save controls set before that and apply them when the
> conditions allow them to be effective?

Right. The driver cannot just drop a control setting on the floor if
it's not ready to apply it.

However, the V4L2 control framework already provides a tool to handle this:
 - the driver can ignore any .s_ctrl() calls when it can't apply the controls,
 - the driver must call v4l2_ctrl_handler_setup() when it initialized
the hardware, so that all the control values are applied in one go.

Best regards,
Tomasz
