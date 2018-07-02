Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA38C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 09:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF4A125BE6
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 09:38:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hGes0rje"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF4A125BE6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965269AbeGBJiD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 05:38:03 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:39433 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933679AbeGBJh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 05:37:57 -0400
Received: by mail-yw0-f194.google.com with SMTP id 81-v6so6444086ywb.6
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 02:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k23BH3UnEaboTgtLzDrT6o8k8D0+sTXkBi51nRnOdaw=;
        b=hGes0rjeMPe72uyS+3pbszFfn4cC8+TBjzWdAv3aOO2WpCxqQJVvlQe/MutCWbN+oA
         wQySvjLui0SPtdIZscmKq6eUykCoBaGZ947B3g7bh4dOHG5qigdUjMNn4wHTrXRH1mzq
         LD+eRXjkgczvfuRPDlLJA0pLuarDXFbauM15U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k23BH3UnEaboTgtLzDrT6o8k8D0+sTXkBi51nRnOdaw=;
        b=ud4vM1ClyDymo0yemkRzUJif+LcmlPuTY1AiNscNee0aMyar4IjvQFPaDar9AHlCcz
         6eM/MlAfy4XbxgiraSOyyp569NwVOoGJznQxSEWzFKwMM1o+A+DjReCkBXVI3XwqR7/C
         u/mabNYr2Wo7caP6dsQ2ike4GdKqfjKAYy/heJdtPGeFRSqXE/CNKhvUJcOSpch88rKh
         Lhg36V+apkMiBLPmA4tm7oOWsJx8rEs3W3zudw3NxsNdUzldHj10jLqwKcy2oZAcZ/5D
         xWZBoOYbWpVcfxCD3vCrW6F5OxNLIHsLDwVn4E2mQz9n/sIjna2jz4m6R2DDl60wCUCf
         0VWw==
X-Gm-Message-State: APt69E1tYOujhaMW3QFl0BVOq5/tTsKEEIXcZwqwUX341YZEpR4yUp/n
        wDfHV9L84G0ewaPcSo96uCC/PSjV1W8=
X-Google-Smtp-Source: AAOMgpcdkDKb8rwcyO7CR8jjp0vtouxendS1DPtnmcvkd+tBmPcT5cOmtLaOdxpmuijAW0njEPvVBg==
X-Received: by 2002:a0d:e8d7:: with SMTP id r206-v6mr8057392ywe.86.1530524276047;
        Mon, 02 Jul 2018 02:37:56 -0700 (PDT)
Received: from mail-yb0-f175.google.com (mail-yb0-f175.google.com. [209.85.213.175])
        by smtp.gmail.com with ESMTPSA id p3-v6sm6053926ywh.36.2018.07.02.02.37.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 02:37:54 -0700 (PDT)
Received: by mail-yb0-f175.google.com with SMTP id s8-v6so1252083ybe.8
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 02:37:54 -0700 (PDT)
X-Received: by 2002:a25:588a:: with SMTP id m132-v6mr12012379ybb.405.1530524273996;
 Mon, 02 Jul 2018 02:37:53 -0700 (PDT)
MIME-Version: 1.0
References: <20180627152725.9783-1-stanimir.varbanov@linaro.org>
 <20180627152725.9783-25-stanimir.varbanov@linaro.org> <CAPBb6MVPrparfoAMaVwsDrwPO1K8cnWb24WdZFGeU5aoEqDt5w@mail.gmail.com>
 <4e22af7d7ef9037996b606892ed25b36@codeaurora.org>
In-Reply-To: <4e22af7d7ef9037996b606892ed25b36@codeaurora.org>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Mon, 2 Jul 2018 18:37:42 +0900
X-Gmail-Original-Message-ID: <CAAFQd5AgZVu5ZpfE0ZxtAxR6hx3-C5hj0iAz15mBhvzoymiobg@mail.gmail.com>
Message-ID: <CAAFQd5AgZVu5ZpfE0ZxtAxR6hx3-C5hj0iAz15mBhvzoymiobg@mail.gmail.com>
Subject: Re: [PATCH v4 24/27] venus: helpers: move frame size calculations on
 common place
To:     vgarodia@codeaurora.org
Cc:     Alexandre Courbot <acourbot@chromium.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-media-owner@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 2, 2018 at 6:35 PM Vikash Garodia <vgarodia@codeaurora.org> wrote:
>
> On 2018-07-02 14:16, Alexandre Courbot wrote:
> > On Thu, Jun 28, 2018 at 12:28 AM Stanimir Varbanov
> > <stanimir.varbanov@linaro.org> wrote:
> >>
> >> This move the calculations of raw and compressed buffer sizes
> >> on common helper and make it identical for encoder and decoder.
> >>
> >> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
> >> ---
> >>  drivers/media/platform/qcom/venus/helpers.c | 98
> >> +++++++++++++++++++++++++++++
> >>  drivers/media/platform/qcom/venus/helpers.h |  2 +
> >>  drivers/media/platform/qcom/venus/vdec.c    | 54 ++++------------
> >>  drivers/media/platform/qcom/venus/venc.c    | 56 ++++-------------
> >>  4 files changed, 126 insertions(+), 84 deletions(-)
> >>
> >> diff --git a/drivers/media/platform/qcom/venus/helpers.c
> >> b/drivers/media/platform/qcom/venus/helpers.c
> >> index 6b31c91528ed..a342472ae2f0 100644
> >> --- a/drivers/media/platform/qcom/venus/helpers.c
> >> +++ b/drivers/media/platform/qcom/venus/helpers.c
> >> @@ -452,6 +452,104 @@ int venus_helper_get_bufreq(struct venus_inst
> >> *inst, u32 type,
> >>  }
> >>  EXPORT_SYMBOL_GPL(venus_helper_get_bufreq);
> >>
> >> +static u32 get_framesize_raw_nv12(u32 width, u32 height)
> >> +{
> >> +       u32 y_stride, uv_stride, y_plane;
> >> +       u32 y_sclines, uv_sclines, uv_plane;
> >> +       u32 size;
> >> +
> >> +       y_stride = ALIGN(width, 128);
> >> +       uv_stride = ALIGN(width, 128);
> >> +       y_sclines = ALIGN(height, 32);
> >> +       uv_sclines = ALIGN(((height + 1) >> 1), 16);
> >> +
> >> +       y_plane = y_stride * y_sclines;
> >> +       uv_plane = uv_stride * uv_sclines + SZ_4K;
> >> +       size = y_plane + uv_plane + SZ_8K;
> >
> > Do you know the reason for this extra 8K at the end?
>
> As explained about the hardware requirement over bug [1], 8k is not
> needed.
> I am working on a patch to fix the alignment requirement for ubwc format
> as
> well.
> In downstream driver, this 8k was added to accomodate the video
> extradata.
>
> [1] https://partnerissuetracker.corp.google.com/u/1/issues/110448791

Thanks Vikash.

I'd also ask the same question about the extra 4K at the end of UV plane.

Best regards,
Tomasz
