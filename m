Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC53C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 04:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F8F421780
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 04:13:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CWNG3NPw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F8F421780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731126AbeKNOO1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 09:14:27 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42266 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727251AbeKNOO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 09:14:26 -0500
Received: by mail-oi1-f194.google.com with SMTP id x63-v6so12439120oix.9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 20:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pSciaaazLU+tsRiAXIAu1T0fgKnu1OCPXb5F+gL2BOQ=;
        b=CWNG3NPwF16VQ2F4n4I9v4PJAe0jn/GVB3N9nkNzNjLsHqDvbWUN+H8g2JnEEpowp/
         zv+JytzYuR/13ERA2gOIwSZDCfEnOoa/l0U4AhS6TOg0yZbPDRQepmOamRpkSICG5hFv
         OlvgyQ5qGrs0AXPYoWFDHJMXmwxT5wUwHwAbw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pSciaaazLU+tsRiAXIAu1T0fgKnu1OCPXb5F+gL2BOQ=;
        b=hsfP4J4icUOmPH7+IMbJACwAKKBiqz/mQdjZgCJgXkJ0A23DIJ1rhZapAWlLlFOrHr
         POeuUQb1GGc7GFtzY/X66DXujdD0gUilFoXW61AIuSaECF1gp9zkA186Z9+vnsUzG7wD
         6guZ2KXejvhTKf1HIscrH/xGODt4t0MJ90+r8Tx3MqD/MEPiGBllDx/CF/TAI95OomqN
         JrWW57fe8+bhz9lIibOYFsxfqk1kKu97nxf8yu/PGoBR1Go9BEZUFO4PE01ugjOOV56u
         ghrj28M9XV8ydh9cx4HObxIM0lkanScwNah0m4lB+3Rk19JAHMR0khlyzp1tWJlhTW1J
         0rkQ==
X-Gm-Message-State: AGRZ1gLNwN8cb7z5jxTHWuejLltrND4txjfmp1YTTtj59OSocZczSjpW
        R6ttUYynIx+XzE936YSkB/XzY61XGc5Zkg==
X-Google-Smtp-Source: AJdET5eNovwHnwU6gNZ2b3Q8vupxjwJUlI7BuBNfG4TBfglFxViZJXrbq673JvLpdD8uBR9E+6Gkrw==
X-Received: by 2002:aca:afcb:: with SMTP id y194-v6mr154265oie.199.1542168780063;
        Tue, 13 Nov 2018 20:13:00 -0800 (PST)
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com. [209.85.167.169])
        by smtp.gmail.com with ESMTPSA id p37sm15149594otc.27.2018.11.13.20.12.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 20:12:59 -0800 (PST)
Received: by mail-oi1-f169.google.com with SMTP id x63-v6so12439082oix.9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 20:12:58 -0800 (PST)
X-Received: by 2002:aca:5a41:: with SMTP id o62-v6mr146623oib.323.1542168778386;
 Tue, 13 Nov 2018 20:12:58 -0800 (PST)
MIME-Version: 1.0
References: <20181113093048.236201-1-acourbot@chromium.org> <CAKQmDh-91tHP1VxLisW1A3GR9G7du3F-Y2XrrgoFU=gvhGoP6w@mail.gmail.com>
In-Reply-To: <CAKQmDh-91tHP1VxLisW1A3GR9G7du3F-Y2XrrgoFU=gvhGoP6w@mail.gmail.com>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Wed, 14 Nov 2018 13:12:46 +0900
X-Gmail-Original-Message-ID: <CAPBb6MWJ1Qu9YoRRusOGiC7dioMkgvU=1dCF6XZ4xDUxp7ri9A@mail.gmail.com>
Message-ID: <CAPBb6MWJ1Qu9YoRRusOGiC7dioMkgvU=1dCF6XZ4xDUxp7ri9A@mail.gmail.com>
Subject: Re: [PATCH] media: venus: fix reported size of 0-length buffers
To:     Nicolas Dufresne <nicolas@ndufresne.ca>
Cc:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 3:54 AM Nicolas Dufresne <nicolas@ndufresne.ca> wro=
te:
>
>
>
> Le mar. 13 nov. 2018 04 h 30, Alexandre Courbot <acourbot@chromium.org> a=
 =C3=A9crit :
>>
>> The last buffer is often signaled by an empty buffer with the
>> V4L2_BUF_FLAG_LAST flag set. Such buffers were returned with the
>> bytesused field set to the full size of the OPB, which leads
>> user-space to believe that the buffer actually contains useful data. Fix
>> this by passing the number of bytes reported used by the firmware.
>
>
> That means the driver does not know on time which one is last. Why not ju=
st returned EPIPE to userspace on DQBUF and ovoid this useless roundtrip ?

Sorry, I don't understand what you mean. EPIPE is supposed to be
returned after a buffer with V4L2_BUF_FLAG_LAST is made available for
dequeue. This patch amends the code that prepares this LAST-flagged
buffer. How could we avoid a roundtrip in this case?

>
>>
>> Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
>> ---
>>  drivers/media/platform/qcom/venus/vdec.c | 4 +---
>>  1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/pl=
atform/qcom/venus/vdec.c
>> index 189ec975c6bb..282de21cf2e1 100644
>> --- a/drivers/media/platform/qcom/venus/vdec.c
>> +++ b/drivers/media/platform/qcom/venus/vdec.c
>> @@ -885,10 +885,8 @@ static void vdec_buf_done(struct venus_inst *inst, =
unsigned int buf_type,
>>         vbuf->field =3D V4L2_FIELD_NONE;
>>
>>         if (type =3D=3D V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE) {
>> -               unsigned int opb_sz =3D venus_helper_get_opb_size(inst);
>> -
>>                 vb =3D &vbuf->vb2_buf;
>> -               vb2_set_plane_payload(vb, 0, bytesused ? : opb_sz);
>> +               vb2_set_plane_payload(vb, 0, bytesused);
>>                 vb->planes[0].data_offset =3D data_offset;
>>                 vb->timestamp =3D timestamp_us * NSEC_PER_USEC;
>>                 vbuf->sequence =3D inst->sequence_cap++;
>> --
>> 2.19.1.930.g4563a0d9d0-goog
>>
