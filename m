Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F29D3C67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 06:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FE6F2083C
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 06:15:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BN306rLx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FE6F2083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbeJVOcF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 10:32:05 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37751 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbeJVOcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 10:32:05 -0400
Received: by mail-ot1-f66.google.com with SMTP id o14so38870959oth.4
        for <linux-kernel@vger.kernel.org>; Sun, 21 Oct 2018 23:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rr8ud3auYv7UA7pl8xEnAzbmFLmXE+t6cvdcTn8uo9A=;
        b=BN306rLxNh22XZfZ6n+z51i52Tbh9QnSP37iMdbBH0nlk2pXyWVFaJxTxgSGlurIAw
         Sdic7XM3V+Ypa1eo0XF7tIfv3pcs+5EJadaM73ZC+wxfFqlgG3SZJqhlaTzHZ48PEvVT
         ndEQvqpq0JymO8MZX5jZy/hBpJm2TMDXhUVYM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rr8ud3auYv7UA7pl8xEnAzbmFLmXE+t6cvdcTn8uo9A=;
        b=J19FzO80D6hg4zBCiVC8+Q0+osDKvL/TQIGOsm984jgPry84b9574Oc7s1AMjJ7r2Z
         tIdphd//my/WDLjV5j319kK190t0dWSIf92qNAicNkNuBFD2O+S5wtqP1J/FPsCfmnWi
         xDaUVW9AWA4+3xkIwRXrJdwI7Ve23dhTVw6e7vHZZdZ/QDpE9XhxsgQLxUmMRVernlHp
         yy8ykPljnbwylvT+sRcisE/iaR1skkgx1ciyJtLtz//mWj8sPLqeTucNGWKA+KmcuniL
         grt959OpFmubpCZQY6hf0arWFlSuljDGyKjE9O94Md9hbrSOrSluVhagR4DLK0tqB37L
         wRwA==
X-Gm-Message-State: ABuFfoimrCNAjxrWj54f+6vCs+ykPStaThg608fadJsaq0lHHHPgpCxj
        JZNO8d+tQcGd9GTgAfkjxiK3VcvNBetOKI7a
X-Google-Smtp-Source: ACcGV60JU6R2dOXi3LgF4hI1bDGFPHEklJrMWk6G9X4UeMVIqUIv1j0g9WmTHr6NnJ34vQTlp8Ej0g==
X-Received: by 2002:a9d:cd4:: with SMTP id o20mr29889985otd.207.1540188898073;
        Sun, 21 Oct 2018 23:14:58 -0700 (PDT)
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com. [209.85.210.52])
        by smtp.gmail.com with ESMTPSA id z44sm11910689oti.38.2018.10.21.23.14.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Oct 2018 23:14:57 -0700 (PDT)
Received: by mail-ot1-f52.google.com with SMTP id u22so38812322ota.12
        for <linux-kernel@vger.kernel.org>; Sun, 21 Oct 2018 23:14:57 -0700 (PDT)
X-Received: by 2002:a9d:2147:: with SMTP id l7mr29829412otd.302.1540188897212;
 Sun, 21 Oct 2018 23:14:57 -0700 (PDT)
MIME-Version: 1.0
References: <1539071634-1644-1-git-send-email-mgottam@codeaurora.org>
 <CAPBb6MUt_V4zEKGcRYXRXNRVdjF2uspOvEj0T-dH6dBZ9ya9CA@mail.gmail.com>
 <f1bb2ead-fe8e-af6a-1b96-9460a7b01f29@linaro.org> <CAPBb6MXxaGMCY43fXwWYZmYmiVwDA6kdJRwWZGqUHhWOGXSz7Q@mail.gmail.com>
 <40d15ea4-48e2-b2c7-1d70-68dcc1b08990@linaro.org>
In-Reply-To: <40d15ea4-48e2-b2c7-1d70-68dcc1b08990@linaro.org>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Mon, 22 Oct 2018 15:14:45 +0900
X-Gmail-Original-Message-ID: <CAPBb6MU9mV9_iq6cf-BzzhTFsed5vtjTui669jxq2uF8KenhQQ@mail.gmail.com>
Message-ID: <CAPBb6MU9mV9_iq6cf-BzzhTFsed5vtjTui669jxq2uF8KenhQQ@mail.gmail.com>
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

On Fri, Oct 12, 2018 at 5:10 PM Stanimir Varbanov
<stanimir.varbanov@linaro.org> wrote:
>
>
>
> On 10/12/2018 11:06 AM, Alexandre Courbot wrote:
> > On Fri, Oct 12, 2018 at 4:37 PM Stanimir Varbanov
> > <stanimir.varbanov@linaro.org> wrote:
> >>
> >> Hi Alex,
> >>
> >> On 10/12/2018 08:26 AM, Alexandre Courbot wrote:
> >>> On Tue, Oct 9, 2018 at 4:54 PM Malathi Gottam <mgottam@codeaurora.org> wrote:
> >>>>
> >>>> When client requests for a keyframe, set the property
> >>>> to hardware to generate the sync frame.
> >>>>
> >>>> Signed-off-by: Malathi Gottam <mgottam@codeaurora.org>
> >>>> ---
> >>>>  drivers/media/platform/qcom/venus/venc_ctrls.c | 13 +++++++++++++
> >>>>  1 file changed, 13 insertions(+)
> >>>>
> >>>> diff --git a/drivers/media/platform/qcom/venus/venc_ctrls.c b/drivers/media/platform/qcom/venus/venc_ctrls.c
> >>>> index 45910172..f332c8e 100644
> >>>> --- a/drivers/media/platform/qcom/venus/venc_ctrls.c
> >>>> +++ b/drivers/media/platform/qcom/venus/venc_ctrls.c
> >>>> @@ -81,6 +81,8 @@ static int venc_op_s_ctrl(struct v4l2_ctrl *ctrl)
> >>>>         struct venc_controls *ctr = &inst->controls.enc;
> >>>>         u32 bframes;
> >>>>         int ret;
> >>>> +       void *ptr;
> >>>> +       u32 ptype;
> >>>>
> >>>>         switch (ctrl->id) {
> >>>>         case V4L2_CID_MPEG_VIDEO_BITRATE_MODE:
> >>>> @@ -173,6 +175,14 @@ static int venc_op_s_ctrl(struct v4l2_ctrl *ctrl)
> >>>>
> >>>>                 ctr->num_b_frames = bframes;
> >>>>                 break;
> >>>> +       case V4L2_CID_MPEG_VIDEO_FORCE_KEY_FRAME:
> >>>> +               ptype = HFI_PROPERTY_CONFIG_VENC_REQUEST_SYNC_FRAME;
> >>>> +               ret = hfi_session_set_property(inst, ptype, ptr);
> >>>
> >>> The test bot already said it, but ptr is passed to
> >>> hfi_session_set_property() uninitialized. And as can be expected the
> >>> call returns -EINVAL on my board.
> >>>
> >>> Looking at other uses of HFI_PROPERTY_CONFIG_VENC_REQUEST_SYNC_FRAME I
> >>> see that the packet sent to the firmware does not have room for an
> >>> argument, so I tried to pass NULL but got the same result.
> >>
> >> yes, because pdata cannot be NULL. I'd suggest to make a pointer to
> >> struct hfi_enable and pass it to the set_property function.
> >
> > FWIW I also tried doing this and got the same error, strange...
> >
>
> OK, when you calling the v4l control? It makes sense when you calling
> it, because set_property checks does the session is on START state (i.e.
> streamon on both queues).

Do you mean that the property won't be actually applied unless both
queues are streaming? In that case maybe it would make sense for the
driver to save controls set before that and apply them when the
conditions allow them to be effective?
