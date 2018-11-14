Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4649BC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 11:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01A1E2146D
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 11:02:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EPeIyzYQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01A1E2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732121AbeKNVFL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 16:05:11 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:46270 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbeKNVFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 16:05:11 -0500
Received: by mail-yw1-f65.google.com with SMTP id t13so2905445ywe.13
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 03:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3luqmgOSX8Shw9TxWy+EH5ZXftdtNaey1WJAwsx5HUY=;
        b=EPeIyzYQi9jSUB7GH3Kk6Aq81uCcKS9GOlOfFeXkKZTqLj9JDIg6yKf3wa8LiJdcB5
         z23mhHclh64iKeoUjO1bJqxs8r0V+PO0cyfLsR8/cFXmiiJCWvGqrFfAevlF45di7BJw
         xJIxoQ3WCxLFmIVoOZpG0orj45LLQ33QvJneY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3luqmgOSX8Shw9TxWy+EH5ZXftdtNaey1WJAwsx5HUY=;
        b=VXfMFsWpViKcU6RNZDAMb7pQuwQBYO9h9gc1yEqV60EqoeyRDCU+iTAxGBAnrZ7cYS
         Jz5ew9AqbSr89oc8lsLqdqXnLvQv+I/DMQ1ZH9c0xcih8uL+76Ch4pqVAJwV8OlW5Psa
         lCXwFCb4FqNPbBlpHMFVHGBcf+RL/LJRgCBKcpw8QrJuqFCeEZ8EDdFMa1r2Ux7yz8Mj
         5YXKg7ppLZ78tfrPgX7QkxPoLEy9H6fIReNUaJJAZ1lBxIH1Hz9Qk2FnqVYY5iaARsW1
         FXFyaWXianHrg2pluKBn4CSHBr6ZGPwqJI6X6Veu0Z+v0b/IaDxA8LLgwLBkEFVNVfDL
         lU5Q==
X-Gm-Message-State: AGRZ1gIlLNeGIPgVE3AWopdsohRtCQXnbhFFmdJkahkOrrh4wkT5fvC1
        1ie2wpKtiT+PvIrNf06QR68MXNgCbYo=
X-Google-Smtp-Source: AJdET5cHGd6aa5b2jlilPsx4iPECiM66Z3gRfcAMT41t9tKWZndFBOj5yf2lL9F43im0NjSpFvAI6A==
X-Received: by 2002:a81:2591:: with SMTP id l139-v6mr979535ywl.322.1542193344399;
        Wed, 14 Nov 2018 03:02:24 -0800 (PST)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id r5-v6sm6987751ywr.80.2018.11.14.03.02.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 03:02:23 -0800 (PST)
Received: by mail-yb1-f171.google.com with SMTP id i78-v6so6736568ybg.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 03:02:23 -0800 (PST)
X-Received: by 2002:a25:6101:: with SMTP id v1-v6mr984341ybb.293.1542193342371;
 Wed, 14 Nov 2018 03:02:22 -0800 (PST)
MIME-Version: 1.0
References: <1538222432-25894-1-git-send-email-sgorle@codeaurora.org>
 <1538222432-25894-4-git-send-email-sgorle@codeaurora.org> <d8cb0c47-a3f7-314b-c65d-3c8eca724e6a@linaro.org>
In-Reply-To: <d8cb0c47-a3f7-314b-c65d-3c8eca724e6a@linaro.org>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Wed, 14 Nov 2018 20:02:10 +0900
X-Gmail-Original-Message-ID: <CAAFQd5BYVpTZ3sUhLPtaGV7tVNQirW79RY0pPLWYCt3ygVxJBg@mail.gmail.com>
Message-ID: <CAAFQd5BYVpTZ3sUhLPtaGV7tVNQirW79RY0pPLWYCt3ygVxJBg@mail.gmail.com>
Subject: Re: [PATCH v1 3/5] media: venus: do not destroy video session during
 queue setup
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     sgorle@codeaurora.org, Hans Verkuil <hverkuil@xs4all.nl>,
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

On Fri, Nov 9, 2018 at 7:00 PM Stanimir Varbanov
<stanimir.varbanov@linaro.org> wrote:
>
> Hi Srinu,
>
> On 9/29/18 3:00 PM, Srinu Gorle wrote:
> > - open and close video sessions for plane properties is incorrect.
>
> Could you rephrase this statement? I really don't understand what you mean.
>
> > - add check to ensure, same instance persist from driver open to close.
>
> This assumption is wrong. The v4l client can change the codec by SFMT
> without close the device node, in that case we have to destroy and
> create a new session with new codec.

Right.

[snip]
> > +
> >       inst->hfi_codec = to_codec_type(pixfmt);
> >       reinit_completion(&inst->done);
> >
> > diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
> > index afe3b36..0035cf2 100644
> > --- a/drivers/media/platform/qcom/venus/vdec.c
> > +++ b/drivers/media/platform/qcom/venus/vdec.c
> > @@ -700,6 +700,8 @@ static int vdec_num_buffers(struct venus_inst *inst, unsigned int *in_num,
> >
> >       *out_num = HFI_BUFREQ_COUNT_MIN(&bufreq, ver);
> >
> > +     return 0;
>
> OK in present implementation I decided that the codec is settled when
> streamon on both queues is called (i.e. the final session_init is made
> in streamon). IMO the correct one is to init the session in
> reqbuf(output) and deinit session in reqbuf(output, count=0)?
>

Depending on what you mean by "settled" that could be fine.

Generally for initialization, one would typically use REQBUFS(OUTPUT,
>0) (since it's not possible to change the format after the
allocation) or STREAMON(OUTPUT) (to defer the hardware operations
until really necessary).

Since STREAMOFF(OUTPUT) is expected to just trigger a seek,
termination should be done in REQBUFS(OUTPUT, 0) indeed and after that
one should be able to switch to another codec (OUTPUT format).

Best regards,
Tomasz
