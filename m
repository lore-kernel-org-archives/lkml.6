Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3281C04EBC
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 06:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CAE8223CB
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 06:03:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ej9bvfA6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CAE8223CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389288AbeKPQOE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 11:14:04 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:40826 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389244AbeKPQOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 11:14:03 -0500
Received: by mail-yb1-f196.google.com with SMTP id g9-v6so9359173ybh.7
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 22:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AEwO2Nt6Oog03FWVOC+zH1A7JQnnDytf6rVOuWD3fRw=;
        b=ej9bvfA6N0WvX9q18TgdbEpnmyKJ5cDy+GfxP0C2Ca5J+TpJYYSMxOujuYKyJ+p7Bi
         QFARQtqe9CwRaUrSwa4YoMa1vxU677OdZXdXu1uwXrQS/tzgpkoWPXbZ17cjrL9ue3wM
         JldtDeeIHL0vw08iXqnoG//lbJaYFuIm1YSQ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AEwO2Nt6Oog03FWVOC+zH1A7JQnnDytf6rVOuWD3fRw=;
        b=KcZ+2xm1vO+fUi2JDSkbtv82EYhAOZTVf/9++QYXR1BSJL/fo5jt3kF8Bsuo+dMTPq
         Fh6synzcu4Gci2RJSvcZLk4Vyv+ZTpQcOMvOS0/Oxc4l4e5I0I+6zdHv9v91A0pa0kFu
         fmdgLtSXp9AI79UpLir+9qvc5z5GWFs4gWjE3ieI47SkNi9oBufMIccmlCSjlsttJdkH
         hQIW1QwxhjkuZ5afqG93/8vtH6b/el5uUXRSs/K5xjWG0E/V1BfnLERuDqTe0ZA0kbb4
         FtWdXvoErXazhTWV9SV4mDy27dKzG2LqUPpx+HgjA1mPXwxUJjXsDzifRh3s047sjSvv
         myLA==
X-Gm-Message-State: AGRZ1gJR/h5tnG8ioZ2fyPZXtzNkSDAcpJG9YJLtBc7CuJke7NW1pfLf
        dqV0zalWbp4myyTd06QCeMUT/bP8Ens=
X-Google-Smtp-Source: AJdET5etAr/VbedbxMm0z/2OyOVmFPspI8n0c9EW9+ePmRFjX+hQpBBDolYp/FUp57A1gPNQLGtyPw==
X-Received: by 2002:a25:3d83:: with SMTP id k125-v6mr8818638yba.26.1542348183730;
        Thu, 15 Nov 2018 22:03:03 -0800 (PST)
Received: from mail-yw1-f42.google.com (mail-yw1-f42.google.com. [209.85.161.42])
        by smtp.gmail.com with ESMTPSA id 123-v6sm8726913ywu.91.2018.11.15.22.03.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Nov 2018 22:03:02 -0800 (PST)
Received: by mail-yw1-f42.google.com with SMTP id v8-v6so9689582ywh.6
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 22:03:02 -0800 (PST)
X-Received: by 2002:a81:a8e:: with SMTP id 136-v6mr4169102ywk.92.1542348182051;
 Thu, 15 Nov 2018 22:03:02 -0800 (PST)
MIME-Version: 1.0
References: <1539071530-1441-1-git-send-email-mgottam@codeaurora.org>
 <CAAFQd5BcFr11Hpngpn6hNL91OibAxUv25yh2qMohgfxsKusACw@mail.gmail.com>
 <8fe1d205-c5e7-01a0-9569-d3268911cddd@linaro.org> <38dfc098517b3ddb5d96195f2e27429d@codeaurora.org>
 <86714c89-20ec-07c8-2569-65e78e8d584d@linaro.org> <CAAFQd5DXWUCB7HvsLyVYU+h=2j6y1v3kcsTtHfNZYjfbHEgWGw@mail.gmail.com>
 <da2e7cef-5ade-7d43-92c1-f728644e61c9@linaro.org> <CAAFQd5AhepthKo4ShsfFQwB4=ALyRZFf6zzEf99DEEBt2gX_jw@mail.gmail.com>
 <544e62014dc3dab6c13714226157909c@codeaurora.org>
In-Reply-To: <544e62014dc3dab6c13714226157909c@codeaurora.org>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Fri, 16 Nov 2018 15:02:50 +0900
X-Gmail-Original-Message-ID: <CAAFQd5BOiAd5vgxZVzP83zZ565py0ovr5hR_SqLitxPoz_8eFA@mail.gmail.com>
Message-ID: <CAAFQd5BOiAd5vgxZVzP83zZ565py0ovr5hR_SqLitxPoz_8eFA@mail.gmail.com>
Subject: Re: [PATCH] media: venus: amend buffer size for bitstream plane
To:     mgottam@codeaurora.org
Cc:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        vgarodia@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 1:35 PM <mgottam@codeaurora.org> wrote:
>
> On 2018-11-14 09:21, Tomasz Figa wrote:
> > On Tue, Nov 13, 2018 at 7:46 PM Stanimir Varbanov
> > <stanimir.varbanov@linaro.org> wrote:
> >>
> >> Hi Tomasz,
> >>
> >> On 11/13/18 11:13 AM, Tomasz Figa wrote:
> >> > On Tue, Nov 13, 2018 at 5:12 PM Stanimir Varbanov
> >> > <stanimir.varbanov@linaro.org> wrote:
> >> >>
> >> >> Hi Malathi,
> >> >>
> >> >> On 11/13/18 9:28 AM, mgottam@codeaurora.org wrote:
> >> >>> On 2018-11-12 18:04, Stanimir Varbanov wrote:
> >> >>>> Hi Tomasz,
> >> >>>>
> >> >>>> On 10/23/2018 05:50 AM, Tomasz Figa wrote:
> >> >>>>> Hi Malathi,
> >> >>>>>
> >> >>>>> On Tue, Oct 9, 2018 at 4:58 PM Malathi Gottam
> >> >>>>> <mgottam@codeaurora.org> wrote:
> >> >>>>>>
> >> >>>>>> For lower resolutions, incase of encoder, the compressed
> >> >>>>>> frame size is more than half of the corresponding input
> >> >>>>>> YUV. Keep the size as same as YUV considering worst case.
> >> >>>>>>
> >> >>>>>> Signed-off-by: Malathi Gottam <mgottam@codeaurora.org>
> >> >>>>>> ---
> >> >>>>>>  drivers/media/platform/qcom/venus/helpers.c | 2 +-
> >> >>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >> >>>>>>
> >> >>>>>> diff --git a/drivers/media/platform/qcom/venus/helpers.c
> >> >>>>>> b/drivers/media/platform/qcom/venus/helpers.c
> >> >>>>>> index 2679adb..05c5423 100644
> >> >>>>>> --- a/drivers/media/platform/qcom/venus/helpers.c
> >> >>>>>> +++ b/drivers/media/platform/qcom/venus/helpers.c
> >> >>>>>> @@ -649,7 +649,7 @@ u32 venus_helper_get_framesz(u32 v4l2_fmt, u32
> >> >>>>>> width, u32 height)
> >> >>>>>>         }
> >> >>>>>>
> >> >>>>>>         if (compressed) {
> >> >>>>>> -               sz = ALIGN(height, 32) * ALIGN(width, 32) * 3 / 2 / 2;
> >> >>>>>> +               sz = ALIGN(height, 32) * ALIGN(width, 32) * 3 / 2;
> >> >>>>>>                 return ALIGN(sz, SZ_4K);
> >> >>>>>>         }
> >> >>>>>
> >> >>>>> Note that the driver should not enforce one particular buffer size for
> >> >>>>> bitstream buffers unless it's a workaround for broken firmware or
> >> >>>>> hardware. The userspace should be able to select the desired size.
> >> >>>>
> >> >>>> Good point! Yes, we have to extend set_fmt to allow bigger sizeimage for
> >> >>>> the compressed buffers (not only for encoder).
> >> >>>
> >> >>> So Stan you meant to say that we should allow s_fmt to accept client
> >> >>> specified size?
> >> >>
> >> >> yes but I do expect:
> >> >>
> >> >> new_sizeimage = max(user_sizeimage, venus_helper_get_framesz)
> >> >>
> >> >> and also user_sizeimage should be sanitized.
> >> >>
> >> >>> If so should we set the inst->input_buf_size here in venc_s_fmt?
> >> >>>
> >> >>> @@ -333,10 +333,10 @@static const struct venus_format *
> >> >>> venc_try_fmt_common(struct venus_inst *inst, struct v4l2_format *f)
> >> >>>
> >> >>>         pixmp->num_planes = fmt->num_planes;
> >> >>>         pixmp->flags = 0;
> >> >>> -
> >> >>> -       pfmt[0].sizeimage = venus_helper_get_framesz(pixmp->pixelformat,
> >> >>> -                                                    pixmp->width,
> >> >>> -                                                    pixmp->height);
> >> >>> +       if (!pfmt[0].sizeimage)
> >> >>> +               pfmt[0].sizeimage =
> >> >>> venus_helper_get_framesz(pixmp->pixelformat,
> >> >>> +                                                            pixmp->width,
> >> >>> +
> >> >>> pixmp->height);
> >> >>
> >> >> yes, but please make
> >> >>
> >> >> pfmt[0].sizeimage = max(pfmt[0].sizeimage, venus_helper_get_framesz)
> >> >>
> >> >> and IMO this should be only for CAPTURE queue i.e. inst->output_buf_size
> >> >>
> >> >> I'm still not sure do we need it for OUTPUT encoder queue.
> >> >>
> >> >
> >> > This would be indeed only for the queues that operate on a coded
> >> > bitstream, i.e. both encoder CAPTURE and decoder OUTPUT.
> >>
> >> Thanks for the confirmation.
>
> So in case of encoder, adhering to the above comments
>
> @@ -333,10 +333,10 @@static const struct venus_format *
> venc_try_fmt_common(struct venus_inst *inst, struct v4l2_format *f)
>
> +       sizeimage = venus_helper_get_framesz(pixmp->pixelformat,
>                                                       pixmp->width,
>                                                       pixmp->height);

Note that in current version of the specification the application is
not expected to provide the width and height on the CAPTURE queue for
the encoder, so you would end up with 0 here. That said, I can see a
value in setting those as a hint to the driver, so perhaps it's not a
bad idea to add it to the API.

> +       pfmt[0].sizeimage = max(ALIGN(pfmt[0].sizeimage, SZ_4K),
> sizeimage);
>
> @@ -408,8 +412,10 @@ static int venc_s_fmt(struct file *file, void *fh,
> struct v4l2_format *f)
>
>          if (f->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE)
>                  inst->fmt_out = fmt;
> -       else if (f->type == V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE)
> +       else if (f->type == V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE) {
>                  inst->fmt_cap = fmt;
> +               inst->output_buf_size = pixmp->plane_fmt[0].sizeimage;
> +       }
>
>
> >>
> >> >
> >> > For image formats, sizeimage should be calculated by the driver based
> >> > on the bytesperline and height. (Bytesperline may be fixed, if the
> >> > hardware doesn't support flexible strides, but if it does, it's
> >> > strongly recommended to use the bytesperline coming from the
> >> > application as the stride +/- any necessary sanity checks.)
> >>
> >> the hw should support stride but I'm not sure is that exposed by the
> >> firmware interface.
> >
> > After thinking a bit more on this, there is actually some redundancy
> > between format width and crop width, since one should be normally able
> > to just set the format width to the buffer stride and crop to the
> > buffer width and have arbitrary strides supported (+/- hw alignment
> > requirements, but that's something that has to always be accounted
> > for).
> >
> > Best regards,
> > Tomasz
>
> I hope the above change, takes into consideration the application
> provided format width and also uses it in calculation of sizeimage which
> is compared against application provided size aligned.
>

I think it should work +/- the one minor remark above. Thanks.

Best regards,
Tomasz
