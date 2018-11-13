Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C67DC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 09:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6138D2250E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 09:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XTjQzpe1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6138D2250E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731652AbeKMT30 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 14:29:26 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39450 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731271AbeKMT30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 14:29:26 -0500
Received: by mail-ot1-f65.google.com with SMTP id g27so10700674oth.6
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 01:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KcuopUe8+golCkSVu4l0ldOgD6hHzm9csnMSHD/yrNs=;
        b=XTjQzpe1LLyxOvaodojWLesEEgtS/JYJHBkKfIM1MUvZOAqBtRlKrKvql6YG8D7ZDC
         QHnIcwnPvJBu+qlKwcdyCOrNLbjbIqP5IO5FTCsskli7PCPMvw2lBvLes7xppRC4P1Mp
         YjZIZgpWLEnldnoPOR0RLzg/E76IkPbfFCEJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KcuopUe8+golCkSVu4l0ldOgD6hHzm9csnMSHD/yrNs=;
        b=VQiua6enEl2Ak8iL3Zn6aAegvJqpQ90wNwqZTMzEMIi4qcxBDPY2d2AkNlrbu6Irgi
         RwdCokfEMvfvXdb2s97j6gh4KDSfkH5zmqNnjMklalaalurhug/O5OBT87u85v7ADCzf
         xwWEekL9hyDpe+lwbsuETB0gMlgItgA9kf+OVHUF7PBWyUBc0T5fH1AskNeDnULGV/ge
         8CCW3vX4M7wZQFaYY1ZuuYyEj6MFG4vZ/o9/BZIUopgA3oq0YEYBm83FE83vVWu2ouoA
         tMtyFgfhr1wZ5TNrmiLLhGXxeeUvZMVbWTu92Dx8qSyMJMR6mPcnUYX7Fo/4+owHi0T+
         prCg==
X-Gm-Message-State: AGRZ1gJh9g+iQPllJNcqhKyZdahaWZwCT5bbCq/qgA9qs+dmwT8c56KK
        xmBQw1EakxJvonyerCiG2kzbNPAc5U2GUg==
X-Google-Smtp-Source: AJdET5clfwSDaixKBx/f52d4UM+DsXU+bL4j+bPqQdhvyL+ybY3r2kEmf4CDgiEQMAhHylDMMMk2Uw==
X-Received: by 2002:a9d:76c8:: with SMTP id p8mr2489161otl.113.1542101531614;
        Tue, 13 Nov 2018 01:32:11 -0800 (PST)
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com. [209.85.210.43])
        by smtp.gmail.com with ESMTPSA id z16sm6796659otc.22.2018.11.13.01.32.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 01:32:10 -0800 (PST)
Received: by mail-ot1-f43.google.com with SMTP id z33so10685354otz.11
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 01:32:10 -0800 (PST)
X-Received: by 2002:a9d:1715:: with SMTP id i21mr2552850ota.149.1542101530126;
 Tue, 13 Nov 2018 01:32:10 -0800 (PST)
MIME-Version: 1.0
References: <1538222432-25894-1-git-send-email-sgorle@codeaurora.org>
 <1538222432-25894-6-git-send-email-sgorle@codeaurora.org> <a331a717-199d-6d6c-c88d-54f911b942d4@linaro.org>
 <CAPBb6MVio_kYK-P+eASFMzdxbvBMWwQC7-ZjPxP3aaqpMsnEdA@mail.gmail.com> <3097b9b9-e065-e42f-5b19-849313df38c2@linaro.org>
In-Reply-To: <3097b9b9-e065-e42f-5b19-849313df38c2@linaro.org>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Tue, 13 Nov 2018 18:31:58 +0900
X-Gmail-Original-Message-ID: <CAPBb6MWS9aDMTVwG3cdSq-p=tU-1qhTSj5seXFwDBFROpDrhRw@mail.gmail.com>
Message-ID: <CAPBb6MWS9aDMTVwG3cdSq-p=tU-1qhTSj5seXFwDBFROpDrhRw@mail.gmail.com>
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

On Mon, Nov 12, 2018 at 9:20 PM Stanimir Varbanov
<stanimir.varbanov@linaro.org> wrote:
>
> Hi Alex,
>
> On 11/12/18 10:12 AM, Alexandre Courbot wrote:
> > Hi Stan,
> >
> > On Thu, Nov 8, 2018 at 7:16 PM Stanimir Varbanov
> > <stanimir.varbanov@linaro.org> wrote:
> >>
> >> Hi,
> >>
> >> On 9/29/18 3:00 PM, Srinu Gorle wrote:
> >>> - In video decoder session, update number of bytes used for
> >>>   yuv buffers appropriately for EOS buffers.
> >>>
> >>> Signed-off-by: Srinu Gorle <sgorle@codeaurora.org>
> >>> ---
> >>>  drivers/media/platform/qcom/venus/vdec.c | 2 +-
> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> NACK, that was already discussed see:
> >>
> >> https://patchwork.kernel.org/patch/10630411/
> >
> > I believe you are referring to this discussion?
> >
> > https://lkml.org/lkml/2018/10/2/302
> >
> > In this case, with https://patchwork.kernel.org/patch/10630411/
> > applied, I am seeing the troublesome case of having the last (empty)
> > buffer being returned with a payload of obs_sz, which I believe is
> > incorrect. The present patch seems to restore the correct behavior.
>
> Sorry, I thought that this solution was suggested (and tested on Venus
> v4) by you, right?

That's correct. >_< Looks like I overlooked this case.

>
> >
> > An alternative would be to set the payload as follows:
> >
> > vb2_set_plane_payload(vb, 0, bytesused);
> >
> > This works for SDM845, but IIRC we weren't sure that this would
> > display the correct behavior with all firmware versions?
>
> OK if you are still seeing issues I think we can switch to
> vb2_set_plane_payload(vb, 0, bytesused); for all buffers? I.e. not only
> for buffers with flag V4L2_BUF_FLAG_LAST set.

That's the fix I am currently using in my source tree and it indeed
seems to be ok. I also agree it is better than special-casing EOS
buffers. I have sent a patch for this.

Thanks and sorry for the confusion.
