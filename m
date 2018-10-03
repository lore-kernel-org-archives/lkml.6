Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF6A1C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 17:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76802213A2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 17:45:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VNkPIQXB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76802213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbeJDAek (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 20:34:40 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:45701 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbeJDAek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 20:34:40 -0400
Received: by mail-vs1-f66.google.com with SMTP id g201so3731794vsd.12
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 10:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YOUAzLexp0jWuOvCu4XLmmjhqC5LfxLq3vt68Tl0uZI=;
        b=VNkPIQXBJ+EdWW4FqCSg4phL5Liq97osJCkca0khk7BrLEEOe4foUougLCuxBUcHhz
         tTMpubvGgFFGYD7OMl8FGo1/Nmu7rIvrLJo3WPxGkk5txuYSKtsrWCH+dqH9zsqsgFN4
         ALUriWJiIoOSmF7Ym6FDYYtpd0Ehxx/SmqbUU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YOUAzLexp0jWuOvCu4XLmmjhqC5LfxLq3vt68Tl0uZI=;
        b=jW1F1TBS+LGC5tz5Hvd9Jjwn8qDCVGy70F7V6SBled35hJLpgJ4s2wAhU8Sgh3bhNk
         1p3EYUzTjtuMOQ/y8HChdYbVLD2AvyYGYo3hYawOGSnbs398YU58em1bHOo9Yyfcr639
         dO70wyRuu89q7qGT1HOsWRWHnlpxx+p4sRmWmVfsP5hLEzWgQnHTyOPs8EzKwtnusGqH
         ZhMoG8uwqLAGV0hzV6oH/yrOBeyZeGcAK2D0M3CygwLM63pisTKnxOFeICWon3a+nj3I
         aC61gSv8rnb2DjgAGTwju3P8ipBvtVDjzW2nGv7Rz1/hxqsKrBzOKkkQ3Jcsoi0Vri7E
         LdOA==
X-Gm-Message-State: ABuFfoh8hP6k1P8iP5W/2Jw6tWREvLz8KOcJfQQy5zLl4vJ63FodxpFr
        v7cbTRPeKt2yfc+n4gHTVCh3kd9mWEo=
X-Google-Smtp-Source: ACcGV6345exJBR+8Hy8v2lMRfJwaySx9KwotSi8clPhnS/Oyh7w1v/Mo9fMVBPwwV5klok5dL/CRBg==
X-Received: by 2002:a67:4dc7:: with SMTP id i68mr1013920vsg.46.1538588715463;
        Wed, 03 Oct 2018 10:45:15 -0700 (PDT)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com. [209.85.217.43])
        by smtp.gmail.com with ESMTPSA id r76sm450672vsa.12.2018.10.03.10.45.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 10:45:14 -0700 (PDT)
Received: by mail-vs1-f43.google.com with SMTP id z130-v6so3747428vsc.7
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 10:45:14 -0700 (PDT)
X-Received: by 2002:a67:83d5:: with SMTP id f204-v6mr999348vsd.6.1538588713891;
 Wed, 03 Oct 2018 10:45:13 -0700 (PDT)
MIME-Version: 1.0
References: <1538569430-32374-1-git-send-email-alokc@codeaurora.org>
In-Reply-To: <1538569430-32374-1-git-send-email-alokc@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 3 Oct 2018 10:45:02 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XnkGA-3LOxJUVoYbSQ5QwVk21_N=pVLhfQySCG30heAw@mail.gmail.com>
Message-ID: <CAD=FV=XnkGA-3LOxJUVoYbSQ5QwVk21_N=pVLhfQySCG30heAw@mail.gmail.com>
Subject: Re: [PATCH] soc: qcom: Add irq clear handling during SE init
To:     alokc@codeaurora.org
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Dilip Kota <dkota@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Oct 3, 2018 at 5:24 AM Alok Chauhan <alokc@codeaurora.org> wrote:
>
> when the kernel inits a SE, its quite possible we have pending interrupts
> from bootloaders which did not handle/clear them. So do this in kernel at
> the SE init, to avoid some of it causing bad behavior, while at it also
> club all the register writes needed to clear the se irqs into a function
> to avoid repeating it over.
>
> Signed-off-by: Alok Chauhan <alokc@codeaurora.org>
> ---
>  drivers/soc/qcom/qcom-geni-se.c | 25 +++++++++++++------------
>  1 file changed, 13 insertions(+), 12 deletions(-)

This looks fine to me.  To clarify this doesn't fix any known issues
and it just fixes the theoretical case where somehow a IRQ was sitting
around (maybe left by the firmware) so we want to make really certain
that we start with a clean state at init time.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
