Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19839C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 10:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B67522150B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 10:33:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QLY+aAm+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B67522150B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731296AbeISQKS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 12:10:18 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:36647 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728059AbeISQKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 12:10:18 -0400
Received: by mail-it0-f65.google.com with SMTP id u13-v6so7064119iti.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 03:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+whcbEtiso7xBU8IunThNHksp1Pg3mtlTeqwibEiKxA=;
        b=QLY+aAm+UOrJaHioyf26aayK3dKYxzthEbE0mqQzXnUjYlFN4IsDZvtEoj4P6NbJsP
         rl7SOC4mlJ2mV4mljolMpgm0J76LKRuKWj9xwMxAXN18FNT9Z1ND8567buoAEjp+XBAT
         ATwTNOA0/LNa5gwBqC1Qb1HoUS/uUo6bVUcpE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+whcbEtiso7xBU8IunThNHksp1Pg3mtlTeqwibEiKxA=;
        b=BTbWgfdhvhM6lxfXHDidwgVV4BFRY9dFT7Ef6h9QomdUp9vGTc+expHAZmQ+OLoLxD
         0wwRolOJoBJBQx2NSU5UxCKWxhh3fyy17pIp6fvPDeox2n6s63xXhhS7DN71dMz5FjT8
         R1p4qy9N9ZizJQrgos6jDrayfkGP08/+7YvGgOU1eWnZ+EhTuDwa86C5qtP+kC+kY4N5
         WF98tEb+KHP8j1+i2Gx9sbMlxxuCT8IvBM+CUSlBl47X57v1s52J6cEK+kj7bGgry2i1
         Seqtuvwodsw+2YrjybIBqGoLIK1m1Moaj1+/8NYJihTL4SMdCE/8+uMHzHE3g0BeiISb
         Q0cw==
X-Gm-Message-State: APzg51CjUO9BQ0uIKpj8CsTKL7a7CpMSHgbymGYY/TN67mqbYlPNpv0s
        xa8hm5/bSV7Lne5369fSLtlHUPLsqJ04Cw==
X-Google-Smtp-Source: ANB0VdaTsKaL/ylltaOpt/TDa7M1ZMeanoLduSfBLavbhfE+5DFNfK6HMoQCvlJPsTSiTzSSY1dlOg==
X-Received: by 2002:a02:94e5:: with SMTP id x92-v6mr29806jah.67.1537353180768;
        Wed, 19 Sep 2018 03:33:00 -0700 (PDT)
Received: from mail-it0-f44.google.com (mail-it0-f44.google.com. [209.85.214.44])
        by smtp.gmail.com with ESMTPSA id j78-v6sm6464585itj.44.2018.09.19.03.32.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Sep 2018 03:32:59 -0700 (PDT)
Received: by mail-it0-f44.google.com with SMTP id 139-v6so7065771itf.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 03:32:59 -0700 (PDT)
X-Received: by 2002:a24:b842:: with SMTP id m63-v6mr19741635ite.31.1537353178909;
 Wed, 19 Sep 2018 03:32:58 -0700 (PDT)
MIME-Version: 1.0
References: <1530517447-29296-1-git-send-email-vgarodia@codeaurora.org>
 <01451f8e-aea3-b276-cb01-b0666a837d62@linaro.org> <4ce55726d810e308a2cae3f84bca7140bed48c7d.camel@ndufresne.ca>
 <92f6f79a-02ae-d23e-1b97-fc41fd921c89@linaro.org> <33e8d8e3-138e-0031-5b75-4bef114ac75e@xs4all.nl>
 <36b42952-982c-9048-77fb-72ca45cc7476@linaro.org> <051af6fb-e0e8-4008-99c5-9685ac24e454@xs4all.nl>
In-Reply-To: <051af6fb-e0e8-4008-99c5-9685ac24e454@xs4all.nl>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Wed, 19 Sep 2018 19:32:46 +0900
X-Gmail-Original-Message-ID: <CAPBb6MVupMsdhF6Rtk4fm8JeVurrK+ZsuxAQ-BwrTzdSP1xP0Q@mail.gmail.com>
Message-ID: <CAPBb6MVupMsdhF6Rtk4fm8JeVurrK+ZsuxAQ-BwrTzdSP1xP0Q@mail.gmail.com>
Subject: Re: [PATCH] venus: vdec: fix decoded data size
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        vgarodia@codeaurora.org,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 11:33 PM Hans Verkuil <hverkuil@xs4all.nl> wrote:
>
> On 09/17/2018 04:30 PM, Stanimir Varbanov wrote:
> > Hi Hans,
> >
> > On 09/17/2018 01:00 PM, Hans Verkuil wrote:
> >> On 07/18/2018 04:37 PM, Stanimir Varbanov wrote:
> >>> Hi,
> >>>
> >>> On 07/18/2018 04:26 PM, Nicolas Dufresne wrote:
> >>>> Le mercredi 18 juillet 2018 =C3=A0 14:31 +0300, Stanimir Varbanov a =
=C3=A9crit :
> >>>>> Hi Vikash,
> >>>>>
> >>>>> On 07/02/2018 10:44 AM, Vikash Garodia wrote:
> >>>>>> Exisiting code returns the max of the decoded
> >>>>>> size and buffer size. It turns out that buffer
> >>>>>> size is always greater due to hardware alignment
> >>>>>> requirement. As a result, payload size given to
> >>>>>> client is incorrect. This change ensures that
> >>>>>> the bytesused is assigned to actual payload size.
> >>>>>>
> >>>>>> Change-Id: Ie6f3429c0cb23f682544748d181fa4fa63ca2e28
> >>>>>> Signed-off-by: Vikash Garodia <vgarodia@codeaurora.org>
> >>>>>> ---
> >>>>>>  drivers/media/platform/qcom/venus/vdec.c | 2 +-
> >>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>>>
> >>>>>> diff --git a/drivers/media/platform/qcom/venus/vdec.c
> >>>>>> b/drivers/media/platform/qcom/venus/vdec.c
> >>>>>> index d079aeb..ada1d2f 100644
> >>>>>> --- a/drivers/media/platform/qcom/venus/vdec.c
> >>>>>> +++ b/drivers/media/platform/qcom/venus/vdec.c
> >>>>>> @@ -890,7 +890,7 @@ static void vdec_buf_done(struct venus_inst
> >>>>>> *inst, unsigned int buf_type,
> >>>>>>
> >>>>>>                  vb =3D &vbuf->vb2_buf;
> >>>>>>                  vb->planes[0].bytesused =3D
> >>>>>> -                        max_t(unsigned int, opb_sz, bytesused);
> >>>>>> +                        min_t(unsigned int, opb_sz, bytesused);
> >>>>>
> >>>>> Most probably my intension was to avoid bytesused =3D=3D 0, but tha=
t is
> >>>>> allowed from v4l2 driver -> userspace direction
> >>>>
> >>>> It remains bad practice since it was used by decoders to indicate th=
e
> >>>> last buffer. Some userspace (some GStreamer versions) will stop work=
ing
> >>>> if you start returning 0.
> >>>
> >>> I think it is legal v4l2 driver to return bytesused =3D 0 when usersp=
ace
> >>> issues streamoff on both queues before EOS, no? Simply because the
> >>> capture buffers are empty.
> >>>
> >>
> >> Going through some of the older pending patches I found this one:
> >>
> >> So is this patch right or wrong?
> >
> > I'm not sure either, let's not applying it for now (if Nicolas is right
> > this will break gstreamer plugin).
> >
>
> OK, I marked this as Rejected. If you change your mind it can be reposted=
 :-)

Mmm I'm not saying it has to be done in the current form, but at the
moment the returned bytesused seems to be wrong (at least Chrome is
not happy). We are returning the total size of the buffer instead of
the actually useful payload.

If the intent is to avoid returning bytesused =3D=3D 0 except for the
special case of the last buffer, how about the following?

--- a/drivers/media/platform/qcom/venus/vdec.c
+++ b/drivers/media/platform/qcom/venus/vdec.c
@@ -943,8 +943,7 @@ static void vdec_buf_done(struct venus_inst *inst,
unsigned int buf_type,
               unsigned int opb_sz =3D venus_helper_get_opb_size(inst);

               vb =3D &vbuf->vb2_buf;
-               vb->planes[0].bytesused =3D
-                       max_t(unsigned int, opb_sz, bytesused);
+                vb2_set_plane_payload(vb, 0, bytesused ? : opb_sz);
               vb->planes[0].data_offset =3D data_offset;
               vb->timestamp =3D timestamp_us * NSEC_PER_USEC;
               vbuf->sequence =3D inst->sequence_cap++;

It works fine for me, and should not return 0 more often than it did
before (i.e. never). In practice I also never see the firmware
reporting a payload of zero on SDM845, but maybe older chips differ?
