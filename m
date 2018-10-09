Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2687C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 07:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BD04204FD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 07:30:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kqWHSGuH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BD04204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbeJIOqL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 10:46:11 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:45902 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbeJIOqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 10:46:10 -0400
Received: by mail-yw1-f66.google.com with SMTP id v198-v6so233566ywg.12
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 00:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xSirOFYPA/vdNKtagbLa45bydrG32t5DjGbEkTA8qaU=;
        b=kqWHSGuHSJVFb8BloBr4YoLfRWhPr7f409ggsen/mVkD35acb8BSYDIRjsZFb/qGE9
         LJUMIoOAWPZ8z6n6E5VK11/y8PDHtZvfKrh51AC/Ng0d+s/VqLR+849Fjq6MwkBuSuOk
         n/x5/Qb7MUeSE44cMD97jA3C1Ua4tNtDmJqdc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xSirOFYPA/vdNKtagbLa45bydrG32t5DjGbEkTA8qaU=;
        b=rChW4RVxpU+oxN8yBrUtyfUf9hAtTaxmXvCaAP/bsenmq8pOXpJBRdeqsXGeH0HN7H
         Z+NMdRcj97B6jQIRLAUGskm2NwQLbjdyJ+RSDKLS8ycTFFR6I9ziMLIbNITCV7XbbRc/
         1wHJPRBAhqhJxMbv4RS04yjnbPqpIZRJ7AiZve8peaGCT0HwxSmVhD/qZ5So515uDwsA
         LVG6YgJecsgOQyOIZySVF/f4e72KS5X3MZgJM1dV4FWffeThgY6FKxmW37ijbTj0d+Ay
         UYLF/ACwWKr4JtUuB9xf9wx+JFAdQ2JBsT+QnWE/0ZzohYjfKazzDvowB9wp4OtCFII9
         7HRQ==
X-Gm-Message-State: ABuFfohp4BU0IbBD11bnTFxtpACnPMSMaeIm+nfhHNB2fmvYFKeGfLxy
        yytU56pLQL/7Us1EuC3xrVDbG0iFWgZMHQ==
X-Google-Smtp-Source: ACcGV61y7LC6GReenoiUlFqENPwWFQSKCn+jPSiOTu1LpTEAaJicBQ5ii5UoEYNSPkCJ8RLXpZVytg==
X-Received: by 2002:a81:1d96:: with SMTP id d144-v6mr14842974ywd.504.1539070235571;
        Tue, 09 Oct 2018 00:30:35 -0700 (PDT)
Received: from mail-yw1-f43.google.com (mail-yw1-f43.google.com. [209.85.161.43])
        by smtp.gmail.com with ESMTPSA id c128-v6sm7149045ywb.68.2018.10.09.00.30.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 00:30:34 -0700 (PDT)
Received: by mail-yw1-f43.google.com with SMTP id y14-v6so245421ywa.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 00:30:34 -0700 (PDT)
X-Received: by 2002:a81:8144:: with SMTP id r65-v6mr11881228ywf.403.1539070233976;
 Tue, 09 Oct 2018 00:30:33 -0700 (PDT)
MIME-Version: 1.0
References: <20181004081119.102575-1-acourbot@chromium.org> <f1fa989b372b514f0a7534057de80b0c453cc8a3.camel@paulk.fr>
In-Reply-To: <f1fa989b372b514f0a7534057de80b0c453cc8a3.camel@paulk.fr>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Tue, 9 Oct 2018 16:30:22 +0900
X-Gmail-Original-Message-ID: <CAAFQd5A4t1F9kqepJ+11GJj7zJWKTp-bD1aCNL0N1w9Qeqtmuw@mail.gmail.com>
Message-ID: <CAAFQd5A4t1F9kqepJ+11GJj7zJWKTp-bD1aCNL0N1w9Qeqtmuw@mail.gmail.com>
Subject: Re: [RFC PATCH v2] media: docs-rst: Document m2m stateless video
 decoder interface
To:     contact@paulk.fr
Cc:     Alexandre Courbot <acourbot@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Pawel Osciak <posciak@chromium.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 4, 2018 at 9:46 PM Paul Kocialkowski <contact@paulk.fr> wrote:
>
> Hi,
>
> Here are a few minor suggestion about H.264 controls.
>
> Le jeudi 04 octobre 2018 =C3=A0 17:11 +0900, Alexandre Courbot a =C3=A9cr=
it :
> > diff --git a/Documentation/media/uapi/v4l/extended-controls.rst b/Docum=
entation/media/uapi/v4l/extended-controls.rst
> > index a9252225b63e..9d06d853d4ff 100644
> > --- a/Documentation/media/uapi/v4l/extended-controls.rst
> > +++ b/Documentation/media/uapi/v4l/extended-controls.rst
> > @@ -810,6 +810,31 @@ enum v4l2_mpeg_video_bitrate_mode -
> >      otherwise the decoder expects a single frame in per buffer.
> >      Applicable to the decoder, all codecs.
> >
> > +.. _v4l2-mpeg-h264:
> > +
> > +``V4L2_CID_MPEG_VIDEO_H264_SPS``
> > +    Instance of struct v4l2_ctrl_h264_sps, containing the SPS of to us=
e with
> > +    the next queued frame. Applicable to the H.264 stateless decoder.
> > +
> > +``V4L2_CID_MPEG_VIDEO_H264_PPS``
> > +    Instance of struct v4l2_ctrl_h264_pps, containing the PPS of to us=
e with
> > +    the next queued frame. Applicable to the H.264 stateless decoder.
> > +
> > +``V4L2_CID_MPEG_VIDEO_H264_SCALING_MATRIX``
>
> For consistency with MPEG-2 and upcoming JPEG, I think we should call
> this "H264_QUANTIZATION".

I'd rather stay consistent with H.264 specification, which uses the
wording as defined in Alex's patch. Otherwise it would be difficult to
correlate between the controls and the specification, which is
something that the userspace developer would definitely need to
understand how to properly parse the stream and obtain the decoding
parameters.

>
> > +    Instance of struct v4l2_ctrl_h264_scaling_matrix, containing the s=
caling
> > +    matrix to use when decoding the next queued frame. Applicable to t=
he H.264
> > +    stateless decoder.
> > +
> > +``V4L2_CID_MPEG_VIDEO_H264_SLICE_PARAM``
>
> Ditto with "H264_SLICE_PARAMS".
>

It doesn't seem to be related to the spec in this case and "params"
sounds better indeed.

Best regards,
Tomasz
