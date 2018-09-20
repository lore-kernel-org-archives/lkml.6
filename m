Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE915C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 03:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 763D321522
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 03:02:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fKrFWAAm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 763D321522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732713AbeITInx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:43:53 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:41976 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730446AbeITInw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:43:52 -0400
Received: by mail-yw1-f65.google.com with SMTP id q129-v6so3176867ywg.8
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 20:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=og13gTBJ4YCJ6/6HXAWAI/PXTEqh5+EDcfQi7Z8j7Yo=;
        b=fKrFWAAmqXvWIN7L/o/eRwL1CUOOCduWshYOJFm98jG+3WMfca/x9faYQhocI7bad9
         lStvIeDx6sCo1UHOFNGft0/j2YRcsSOAKtU+BzmiZi9Tg/siaXfSs0Vy0rrOUn/0NkEK
         th2vk1l9Bedw5vaWbg+Tm/hsDpEFd0gUcRGgw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=og13gTBJ4YCJ6/6HXAWAI/PXTEqh5+EDcfQi7Z8j7Yo=;
        b=YY7bZ5WJAN6BkbVJ0vLV/zspShMD0u/x624wB9xt50fQCqKWTRmRF1wRDJom6O8pmE
         pt3p7BX0tBT980WYMXlkIK0VlwY6kw9xBRM3U/rhC5/WcO0EWFyZRFK4iYO1FNe/WNUa
         /vrdolyjFYDXePBfOUIa5IRlpF19R6Q3S4N3futgpBQx37+E7tlT9BmBQgAtL2xs4Yhq
         HydmJBMgtboBt7dj4imHzPDKnK7g68fZYqQWlzecQ6tAu2qShQpo+lIYo+1DHqXUOVlp
         wS0WLGTfwjhhZMA1MgcUviTDNdq1BIQZ6rh9fipqqalYGXzLrzWPwwQiYzQMm4xTb+qX
         KfZA==
X-Gm-Message-State: APzg51DYw/fPiBRpWfQcAZdJfqusS6TwT7FmC6LFUFv0jTBXHhl5oiVI
        qoGWc6Dse36772NHmoG2o51jk99qhg8Iwg==
X-Google-Smtp-Source: ANB0Vdajx/JtI0R6vDIDvIHL/ag3bmN8c7mcrcNM2DAz6aqnlZJMkbb8hcWiF1xg2EnBVMSBXvMsQA==
X-Received: by 2002:a81:9a44:: with SMTP id r65-v6mr16115985ywg.165.1537412566048;
        Wed, 19 Sep 2018 20:02:46 -0700 (PDT)
Received: from mail-yw1-f43.google.com (mail-yw1-f43.google.com. [209.85.161.43])
        by smtp.gmail.com with ESMTPSA id p126-v6sm4231001ywf.22.2018.09.19.20.02.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Sep 2018 20:02:44 -0700 (PDT)
Received: by mail-yw1-f43.google.com with SMTP id k130-v6so675689ywe.6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 20:02:44 -0700 (PDT)
X-Received: by 2002:a81:6ec5:: with SMTP id j188-v6mr15617673ywc.92.1537412564118;
 Wed, 19 Sep 2018 20:02:44 -0700 (PDT)
MIME-Version: 1.0
References: <1530517447-29296-1-git-send-email-vgarodia@codeaurora.org>
 <01451f8e-aea3-b276-cb01-b0666a837d62@linaro.org> <4ce55726d810e308a2cae3f84bca7140bed48c7d.camel@ndufresne.ca>
 <92f6f79a-02ae-d23e-1b97-fc41fd921c89@linaro.org> <33e8d8e3-138e-0031-5b75-4bef114ac75e@xs4all.nl>
 <36b42952-982c-9048-77fb-72ca45cc7476@linaro.org> <051af6fb-e0e8-4008-99c5-9685ac24e454@xs4all.nl>
 <CAPBb6MVupMsdhF6Rtk4fm8JeVurrK+ZsuxAQ-BwrTzdSP1xP0Q@mail.gmail.com>
 <6d65ac0d-80a0-88fe-ed19-4785f2675e36@linaro.org> <bec2edfda26ecbac928871ad14d768790e3175a8.camel@ndufresne.ca>
In-Reply-To: <bec2edfda26ecbac928871ad14d768790e3175a8.camel@ndufresne.ca>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Thu, 20 Sep 2018 12:02:32 +0900
X-Gmail-Original-Message-ID: <CAAFQd5DoabbMiiDKOeAuwOztxamFUAoMD3_9Harpvd5O935WvQ@mail.gmail.com>
Message-ID: <CAAFQd5DoabbMiiDKOeAuwOztxamFUAoMD3_9Harpvd5O935WvQ@mail.gmail.com>
Subject: Re: [PATCH] venus: vdec: fix decoded data size
To:     nicolas@ndufresne.ca,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Alexandre Courbot <acourbot@chromium.org>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>, vgarodia@codeaurora.org,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 12:53 AM Nicolas Dufresne <nicolas@ndufresne.ca> wr=
ote:
>
> Le mercredi 19 septembre 2018 =C3=A0 18:02 +0300, Stanimir Varbanov a
> =C3=A9crit :
> > > --- a/drivers/media/platform/qcom/venus/vdec.c
> > > +++ b/drivers/media/platform/qcom/venus/vdec.c
> > > @@ -943,8 +943,7 @@ static void vdec_buf_done(struct venus_inst
> > > *inst,
> > > unsigned int buf_type,
> > >                 unsigned int opb_sz =3D
> > > venus_helper_get_opb_size(inst);
> > >
> > >                 vb =3D &vbuf->vb2_buf;
> > > -               vb->planes[0].bytesused =3D
> > > -                       max_t(unsigned int, opb_sz, bytesused);
> > > +                vb2_set_plane_payload(vb, 0, bytesused ? :
> > > opb_sz);
> > >                 vb->planes[0].data_offset =3D data_offset;
> > >                 vb->timestamp =3D timestamp_us * NSEC_PER_USEC;
> > >                 vbuf->sequence =3D inst->sequence_cap++;
> > >
> > > It works fine for me, and should not return 0 more often than it
> > > did
> > > before (i.e. never). In practice I also never see the firmware
> > > reporting a payload of zero on SDM845, but maybe older chips
> > > differ?
> >
> > yes, it looks fine. Let me test it with older versions.
>
> What about removing the allow_zero_bytesused flag on this specific
> queue ? Then you can leave it to 0, and the framework will change it to
> the buffer size.

First of all, why we would ever have 0 in bytesused?

That should never happen normally in the middle of decoding and if it
happens, then perhaps such buffer should be returned by the driver
with ERROR state or maybe just silently reused for further decoding.

The only cases where the value of 0 could happen could be EOS or end
of the drain sequence (explicit by STOP command or by resolution
change). In both cases, having 0 bytesused returned from the driver to
vb2 is perfectly fine, because such buffer would have the
V4L2_BUF_FLAG_LAST flag set anyway.

Best regards,
Tomasz
