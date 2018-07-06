Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 487A3C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:09:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA4D4214C5
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:09:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QLVx3b4Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA4D4214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933708AbeGFRJe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 13:09:34 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:38934 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933275AbeGFRJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 13:09:32 -0400
Received: by mail-it0-f65.google.com with SMTP id p185-v6so18089281itp.4
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 10:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0fNycbxrc7kKPPMgogWYvHpFyDd4YmuWn9GrpP9XZXc=;
        b=QLVx3b4YD6Hz2Bgf2VG92NFtpfJGliqWZ6Z9Jr32xDYlqMnGFKC3IN0ZzsO7cTdxNR
         mrnQl6mUm4Uu7ggFylLExvjyFIzNEE7ontYtKHzfJQ/0ixQD+4ueUczbPCgPSk2RChHS
         odImUlg8Tn2K7iqzjIYot3EcnsvsEn6+gzRws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0fNycbxrc7kKPPMgogWYvHpFyDd4YmuWn9GrpP9XZXc=;
        b=nraz4VVaQvdKWA28oGhLMaN5UMdHNxP5wopigl2BBhIV7n7956BwKfqYfR6Qr/cEcS
         z4wOZnpWlmgRYdfS6lct4Es7rm53AOgfOSCskznuc556h4uGOHtJBXuS5K5v+XWsUgwu
         JTMq7QThLKzeSeG+cpwgyQye5RGtGqKoQDmxCVVjpi9oOFR+qdhw9puoOp41Jtj6jJSd
         UX92g/Zdjn9yBgYE04gZ/n28x9n+A2uxZrRhXcm6aO+7wUKYICNOV3EfHzcpIltYaH1A
         bLOBb0zHOEzMBKMXf1woPp876zqeqogtQ6TXv3Ci5hsi7gxcS2z8xTrClqdY/tT9uEiq
         rGSg==
X-Gm-Message-State: APt69E3dKEPWBf2+3XD76ybxn/aOHANoQOZnX0f92Y2wbHu57L4gpQGQ
        W/VRouJ1fPDBQhK8omhXioqFCw97c0s=
X-Google-Smtp-Source: AAOMgpfsPC5yPxYCrjBHkv3Po+9qM/RTJr0huGcB4LOePhqVzB9/FaSvmJuC8v6Qk04iA1IFXAtjGA==
X-Received: by 2002:a24:fa0b:: with SMTP id v11-v6mr8425790ith.62.1530896971883;
        Fri, 06 Jul 2018 10:09:31 -0700 (PDT)
Received: from mail-io0-f171.google.com (mail-io0-f171.google.com. [209.85.223.171])
        by smtp.gmail.com with ESMTPSA id k20-v6sm4368070iok.9.2018.07.06.10.09.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Jul 2018 10:09:30 -0700 (PDT)
Received: by mail-io0-f171.google.com with SMTP id z19-v6so11465899ioh.4
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 10:09:30 -0700 (PDT)
X-Received: by 2002:a6b:b342:: with SMTP id c63-v6mr8996409iof.204.1530896969754;
 Fri, 06 Jul 2018 10:09:29 -0700 (PDT)
MIME-Version: 1.0
References: <1530517447-29296-1-git-send-email-vgarodia@codeaurora.org>
 <CAPBb6MUBi+Dn5v4PKngxztFgKd6CA7bC1pKvWd1GMY9NJFoyZQ@mail.gmail.com> <b26cb8df-fac3-5941-9941-a6b3ca8af62e@linaro.org>
In-Reply-To: <b26cb8df-fac3-5941-9941-a6b3ca8af62e@linaro.org>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Sat, 7 Jul 2018 02:09:17 +0900
X-Gmail-Original-Message-ID: <CAPBb6MW0RryRBHCNMS71MJy7Dy6wyiJMoPRwPCQOK3Ui8CfKOg@mail.gmail.com>
Message-ID: <CAPBb6MW0RryRBHCNMS71MJy7Dy6wyiJMoPRwPCQOK3Ui8CfKOg@mail.gmail.com>
Subject: Re: [PATCH] venus: vdec: fix decoded data size
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     vgarodia@codeaurora.org,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 7, 2018, 00:12 Stanimir Varbanov
<stanimir.varbanov@linaro.org> wrote:
>
> Hi Alex,
>
> On 07/02/2018 11:51 AM, Alexandre Courbot wrote:
> > On Mon, Jul 2, 2018 at 4:44 PM Vikash Garodia <vgarodia@codeaurora.org> wrote:
> >>
> >> Exisiting code returns the max of the decoded
> >
> > s/Exisiting/Existing
> >
> > Also the lines of your commit message look pretty short - I think the
> > standard for kernel log messges is 72 chars?
> >
> >> size and buffer size. It turns out that buffer
> >> size is always greater due to hardware alignment
> >> requirement. As a result, payload size given to
> >> client is incorrect. This change ensures that
> >> the bytesused is assigned to actual payload size.
> >>
> >> Change-Id: Ie6f3429c0cb23f682544748d181fa4fa63ca2e28
> >> Signed-off-by: Vikash Garodia <vgarodia@codeaurora.org>
> >> ---
> >>  drivers/media/platform/qcom/venus/vdec.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
> >> index d079aeb..ada1d2f 100644
> >> --- a/drivers/media/platform/qcom/venus/vdec.c
> >> +++ b/drivers/media/platform/qcom/venus/vdec.c
> >> @@ -890,7 +890,7 @@ static void vdec_buf_done(struct venus_inst *inst, unsigned int buf_type,
> >>
> >>                 vb = &vbuf->vb2_buf;
> >>                 vb->planes[0].bytesused =
> >> -                       max_t(unsigned int, opb_sz, bytesused);
> >> +                       min_t(unsigned int, opb_sz, bytesused);
> >
> > Reviewed-by: Alexandre Courbot <acourbot@chromium.org>
> > Tested-by: Alexandre Courbot <acourbot@chromium.org>
> >
> > This indeed reports the correct size to the client. If bytesused were
> > larger than the size of the buffer we would be having some trouble
> > anyway.
> >
> > Actually in my tree I was using the following patch:
> >
> > --- a/drivers/media/platform/qcom/venus/vdec.c
> > +++ b/drivers/media/platform/qcom/venus/vdec.c
> > @@ -924,13 +924,12 @@ static void vdec_buf_done(struct venus_inst
> > *inst, unsigned int buf_type,
> >
> >                vb = &vbuf->vb2_buf;
> >                vb->planes[0].bytesused =
> > -                       max_t(unsigned int, opb_sz, bytesused);
> > +                       min_t(unsigned int, opb_sz, bytesused);
> >                vb->planes[0].data_offset = data_offset;
> >                vb->timestamp = timestamp_us * NSEC_PER_USEC;
> >                vbuf->sequence = inst->sequence_cap++;
> >                if (vbuf->flags & V4L2_BUF_FLAG_LAST) {
> >                        const struct v4l2_event ev = { .type = V4L2_EVENT_EOS };
> > -                       vb->planes[0].bytesused = bytesused;
>
> Actually this line doesn't exist in mainline driver. And I don't see a
> reason why to set bytesused twice.

Apologies for being careless - this came from an out-of-tree patch.

>
> >                        v4l2_event_queue_fh(&inst->fh, &ev);
> >
> > Given that we are now taking the minimum of these two values, it seems
> > to me that we don't need to set bytesused again in case we are dealing
> > with the last buffer? Stanimir, what do you think?
> >
>
> --
> regards,
> Stan
