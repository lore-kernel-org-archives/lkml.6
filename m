Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2AF5C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 04:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64FC021722
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 04:09:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eyrAH/T5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64FC021722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbeH0HyM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 03:54:12 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:39490 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbeH0HyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 03:54:12 -0400
Received: by mail-yb0-f194.google.com with SMTP id c4-v6so5564016ybl.6
        for <linux-kernel@vger.kernel.org>; Sun, 26 Aug 2018 21:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OmTBuW/bSAbmuYJgadsh/FjHeD8xf9g4Gf+TfKj8leM=;
        b=eyrAH/T5wuvRVAzP1ITMZ3KL8Yne2Erjwu84dP+jL2WaM5u+cXV9iLe9q/XLH7X2x6
         cgR22kA+Anca+6pT4lSaP0H513MxuubXhe5phcNLPYr8I+Kdk0viQr233QBpdpENWs1F
         z7zFFFHkzv3pelNc+pQksTFx6KVw9H2RZI1Cg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OmTBuW/bSAbmuYJgadsh/FjHeD8xf9g4Gf+TfKj8leM=;
        b=FeGFYOImC8bjMcK9USUNueLTuquRj0hYl37aUCqI3Lr+CMtHKT22qg2yfmu0kK47n3
         H4NzEKDuP2e0hUOh+DasDYPBMfi6UVHQE0IH8LQbBHPIBnudiJzMMkXGb5EcLlu8GM27
         aqD75xazYZ8+VFDEWu79+e1csUWzw+a1eiMvG0NPTDIRR6qOJn8h1dpD0pQKGm3i8pA4
         DRXpQi451pidFpkSVbSMjgLtls74Y5Zb5T4hEhTYvgys3+0Abu4B5BLzLwj3oEZECUjn
         9U4DGYgtNUky5cUQlNMkOtBLtHp8fMFr+9o4GEnmnwy3zn8W4MZEQ+h46KmFAnqTzg4t
         xUhA==
X-Gm-Message-State: APzg51DpeywwDlqIQ2bXPF6KgpqfywU7zcpAQfwWn9VZOKtlGUDJSvgs
        T+ruCP5FASGEfPACZatQwHHyLQ54HvKymg==
X-Google-Smtp-Source: ANB0VdYkqL1y3Bw62AL/Wna98hYmGQTFn+bmQnpbssSFFZPQWVzkIUzCKm2dwpRgeBbbGqWnioV37Q==
X-Received: by 2002:a25:9b08:: with SMTP id y8-v6mr6101236ybn.260.1535342960556;
        Sun, 26 Aug 2018 21:09:20 -0700 (PDT)
Received: from mail-yb0-f172.google.com (mail-yb0-f172.google.com. [209.85.213.172])
        by smtp.gmail.com with ESMTPSA id f5-v6sm6324458ywa.39.2018.08.26.21.09.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Aug 2018 21:09:19 -0700 (PDT)
Received: by mail-yb0-f172.google.com with SMTP id d34-v6so5570064yba.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Aug 2018 21:09:18 -0700 (PDT)
X-Received: by 2002:a25:d816:: with SMTP id p22-v6mr6146507ybg.285.1535342958293;
 Sun, 26 Aug 2018 21:09:18 -0700 (PDT)
MIME-Version: 1.0
References: <20180724140621.59624-1-tfiga@chromium.org> <20180724140621.59624-2-tfiga@chromium.org>
 <37a8faea-a226-2d52-36d4-f9df194623cc@xs4all.nl> <CAAFQd5BgGEBmd8gNGc-qqtUtLo=Mh8U+TVTWRsKYMv1LmeBQMA@mail.gmail.com>
 <a6af3dc9-1d09-a414-ce31-bc1b3e69894f@xs4all.nl> <CAAFQd5AnC+hWy4QUGE-s+qgRvvgGC7rMhH6x8koTfYJzTLw8Cg@mail.gmail.com>
 <f0aa7c84-08e3-9b04-8d1b-95f741d6817b@xs4all.nl> <CAAFQd5ACWO0FxzZdxf-N-GStCMOSWzxKxhcpCRUh=BqT7jLJWw@mail.gmail.com>
 <41ee7486-9c7c-51ea-9355-1bf6c44f1639@linaro.org>
In-Reply-To: <41ee7486-9c7c-51ea-9355-1bf6c44f1639@linaro.org>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Mon, 27 Aug 2018 13:09:07 +0900
X-Gmail-Original-Message-ID: <CAAFQd5BSCGYS6_oPzv9xCsb3X-b3q5B3e4qe_Jbeeuixb0UT4g@mail.gmail.com>
Message-ID: <CAAFQd5BSCGYS6_oPzv9xCsb3X-b3q5B3e4qe_Jbeeuixb0UT4g@mail.gmail.com>
Subject: Re: [PATCH 1/2] media: docs-rst: Document memory-to-memory video
 decoder interface
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Pawel Osciak <posciak@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>, kamil@wypas.org,
        a.hajda@samsung.com, Kyungmin Park <kyungmin.park@samsung.com>,
        jtp.park@samsung.com, Philipp Zabel <p.zabel@pengutronix.de>,
        =?UTF-8?B?VGlmZmFueSBMaW4gKOael+aFp+ePiik=?= 
        <tiffany.lin@mediatek.com>,
        =?UTF-8?B?QW5kcmV3LUNUIENoZW4gKOmZs+aZuui/qik=?= 
        <andrew-ct.chen@mediatek.com>, todor.tomov@linaro.org,
        nicolas@ndufresne.ca,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dave.stevenson@raspberrypi.org,
        Ezequiel Garcia <ezequiel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2018 at 8:29 PM Stanimir Varbanov
<stanimir.varbanov@linaro.org> wrote:
>
> Hi Tomasz,
>
> On 08/08/2018 05:55 AM, Tomasz Figa wrote:
> > On Tue, Aug 7, 2018 at 4:37 PM Hans Verkuil <hverkuil@xs4all.nl> wrote:
>
> >>>>>>> +7.  If all the following conditions are met, the client may resume the
> >>>>>>> +    decoding instantly, by using :c:func:`VIDIOC_DECODER_CMD` with
> >>>>>>> +    ``V4L2_DEC_CMD_START`` command, as in case of resuming after the drain
> >>>>>>> +    sequence:
> >>>>>>> +
> >>>>>>> +    * ``sizeimage`` of new format is less than or equal to the size of
> >>>>>>> +      currently allocated buffers,
> >>>>>>> +
> >>>>>>> +    * the number of buffers currently allocated is greater than or equal to
> >>>>>>> +      the minimum number of buffers acquired in step 6.
> >>>>>>
> >>>>>> You might want to mention that if there are insufficient buffers, then
> >>>>>> VIDIOC_CREATE_BUFS can be used to add more buffers.
> >>>>>>
> >>>>>
> >>>>> This might be a bit tricky, since at least s5p-mfc and coda can only
> >>>>> work on a fixed buffer set and one would need to fully reinitialize
> >>>>> the decoding to add one more buffer, which would effectively be the
> >>>>> full resolution change sequence, as below, just with REQBUFS(0),
> >>>>> REQBUFS(N) replaced with CREATE_BUFS.
> >>>>
> >>>> What happens today in those drivers if you try to call CREATE_BUFS?
> >>>
> >>> s5p-mfc doesn't set the .vidioc_create_bufs pointer in its
> >>> v4l2_ioctl_ops, so I suppose that would be -ENOTTY?
> >>
> >> Correct for s5p-mfc.
> >
> > As Philipp clarified, coda supports adding buffers on the fly. I
> > briefly looked at venus and mtk-vcodec and they seem to use m2m
> > implementation of CREATE_BUFS. Not sure if anyone tested that, though.
> > So the only hardware I know for sure cannot support this is s5p-mfc.
>
> In Venus case CREATE_BUFS is tested with Gstreamer.

Stanimir: Alright. Thanks for confirmation.

Hans: Technically, we could still implement CREATE_BUFS for s5p-mfc,
but it would need to be restricted to situations where it's possible
to reinitialize the whole hardware buffer queue, i.e.
- before initial STREAMON(CAPTURE) after header parsing,
- after a resolution change and before following STREAMON(CAPTURE) or
DECODER_CMD_START (to ack resolution change without buffer
reallocation).

Would that work for your original suggestion?

Best regards,
Tomasz
