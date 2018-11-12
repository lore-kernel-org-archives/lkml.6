Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37638C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 08:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDFC421722
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 08:12:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lZkOfhga"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDFC421722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbeKLSE0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 13:04:26 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:45876 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727996AbeKLSEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 13:04:25 -0500
Received: by mail-oi1-f196.google.com with SMTP id p144-v6so6436030oic.12
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 00:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nzbsk/bOFk8/i7j3o7JZPo8TdZ/5fbTkMiMFdETMO5Q=;
        b=lZkOfhgal5Y/eHaqtLQLq0ocXIebiubf3vMGLRwVELlJbe0/IKSHSSu+HqYINMBhyx
         NntHfuhsbMxtX5K0XPfdPSQafi3ZAH38zM57snuSpq76q7RKTrQPE5jS+DO1dbt7i5nd
         xu0JA7tqgxwukNowhbzJ0abQXS4N9WekU0az4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nzbsk/bOFk8/i7j3o7JZPo8TdZ/5fbTkMiMFdETMO5Q=;
        b=hmREygh+JPe7IPEzUD6/c4mTVyTkAoXGiiG4JFp9TBh/jTufKvSIggYgb92mWWAOtj
         yV6NDh73/H7tHBCCs0Wi33HNZkbVz2lfErJB2NuUnYItPGaKy1kzFDc39M5lTkL5sxp7
         H0dKqvOa2w4JAjAVXy3it12beyYcYeLk16XrqLx9a2WJwxH129vadMTDIsxS+09ZU1fY
         6TYDrP+L22TA8xx4onZq5V++GKvdGu7hlFPfrh25UmRc9jAlAPVD8q7p/oDqMOg7X2BY
         X3dHRsjuaQZ6Gd8PLENzN6RKD8dYebFcblr9gUvqtGQuyOZWfuw30Xlk++eL6vMjKRWZ
         6OQA==
X-Gm-Message-State: AGRZ1gJBocQv6+WsW1vMkHsLU3ySvJefInNyYtRTcxc4299emJyTuXvs
        dLcb6M0xO/6Eo0Q3UFg7yx1csEEcG+G+1g==
X-Google-Smtp-Source: AJdET5fWVobTF8wRfEtFA17XUc0qIJ8uip0OCOsidL/GUYiuTdJ5cXAIkKCGdMUPlb5uw5sT6dOjOA==
X-Received: by 2002:aca:4a10:: with SMTP id x16-v6mr9906814oia.11.1542010340047;
        Mon, 12 Nov 2018 00:12:20 -0800 (PST)
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com. [209.85.167.180])
        by smtp.gmail.com with ESMTPSA id j197-v6sm6605209oih.22.2018.11.12.00.12.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 00:12:18 -0800 (PST)
Received: by mail-oi1-f180.google.com with SMTP id v198-v6so6475092oif.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 00:12:18 -0800 (PST)
X-Received: by 2002:aca:6ad3:: with SMTP id f202-v6mr4092oic.50.1542010338068;
 Mon, 12 Nov 2018 00:12:18 -0800 (PST)
MIME-Version: 1.0
References: <1538222432-25894-1-git-send-email-sgorle@codeaurora.org>
 <1538222432-25894-6-git-send-email-sgorle@codeaurora.org> <a331a717-199d-6d6c-c88d-54f911b942d4@linaro.org>
In-Reply-To: <a331a717-199d-6d6c-c88d-54f911b942d4@linaro.org>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Mon, 12 Nov 2018 17:12:06 +0900
X-Gmail-Original-Message-ID: <CAPBb6MVio_kYK-P+eASFMzdxbvBMWwQC7-ZjPxP3aaqpMsnEdA@mail.gmail.com>
Message-ID: <CAPBb6MVio_kYK-P+eASFMzdxbvBMWwQC7-ZjPxP3aaqpMsnEdA@mail.gmail.com>
Subject: Re: [PATCH v1 5/5] media: venus: update number of bytes used field
 properly for EOS frames
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     sgorle@codeaurora.org, Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, vgarodia@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stan,

On Thu, Nov 8, 2018 at 7:16 PM Stanimir Varbanov
<stanimir.varbanov@linaro.org> wrote:
>
> Hi,
>
> On 9/29/18 3:00 PM, Srinu Gorle wrote:
> > - In video decoder session, update number of bytes used for
> >   yuv buffers appropriately for EOS buffers.
> >
> > Signed-off-by: Srinu Gorle <sgorle@codeaurora.org>
> > ---
> >  drivers/media/platform/qcom/venus/vdec.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> NACK, that was already discussed see:
>
> https://patchwork.kernel.org/patch/10630411/

I believe you are referring to this discussion?

https://lkml.org/lkml/2018/10/2/302

In this case, with https://patchwork.kernel.org/patch/10630411/
applied, I am seeing the troublesome case of having the last (empty)
buffer being returned with a payload of obs_sz, which I believe is
incorrect. The present patch seems to restore the correct behavior.

An alternative would be to set the payload as follows:

vb2_set_plane_payload(vb, 0, bytesused);

This works for SDM845, but IIRC we weren't sure that this would
display the correct behavior with all firmware versions?

>
> >
> > diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
> > index 311f209..a48eed1 100644
> > --- a/drivers/media/platform/qcom/venus/vdec.c
> > +++ b/drivers/media/platform/qcom/venus/vdec.c
> > @@ -978,7 +978,7 @@ static void vdec_buf_done(struct venus_inst *inst, unsigned int buf_type,
> >
> >               if (vbuf->flags & V4L2_BUF_FLAG_LAST) {
> >                       const struct v4l2_event ev = { .type = V4L2_EVENT_EOS };
> > -
> > +                     vb->planes[0].bytesused = bytesused;
> >                       v4l2_event_queue_fh(&inst->fh, &ev);
> >               }
> >       } else {
> >
>
> --
> regards,
> Stan
