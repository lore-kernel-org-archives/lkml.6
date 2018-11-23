Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63818C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C84220861
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:41:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iyCBDgIO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C84220861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502876AbeKWUYl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 15:24:41 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40067 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390381AbeKWUYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 15:24:40 -0500
Received: by mail-lf1-f66.google.com with SMTP id v5so8255291lfe.7
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 01:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kIj36/zyD1Ru52blSuw/L5cXp3mGSJ9KUJuFx9pDUQo=;
        b=iyCBDgIOkvgupqNK3ucwnaTmmTvHMX0edt1kADbFjbEhn46wM0+jm/+jxQfC0Npbj4
         EM0XclqlQPcIYXoO/tF6RzK7mOADC6rfB6bDgMJUF/Q+B4h2To1cDtwflR2DgMKPzTnj
         rzf1TYcoBXn+bNM/lPOTzTSWLuTJrkk+ofbdU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kIj36/zyD1Ru52blSuw/L5cXp3mGSJ9KUJuFx9pDUQo=;
        b=QR9Gtx/SdZrvWc0IlICWlZiW8U+5I10paOcNNau1vmtlCRS/5YsRY+Jf+MQRQgQ/PX
         +IF6RlaNoY2iPOImXV+AxMGql90nT/3QfyMxTy0DvQ3j8oAYUu1M4KVFI0TObwfd2Itw
         T09QG4sxpSl0ZwjDuRcFgyLJrSZvYa2MG7+r5JXkD3mY5FibWk+mjST/UKU8InnK6jNI
         UZ8I4XLJfp8U5AiCbN3fIJoqE3VutLAJkjMUl3Y1451IdQnvWL4b/0OduyQUnGBzrgZn
         y32AAzd64iXviRyQakfv/Sk8eig7y09mTC5jQGeeOCw00zpkIxPRMM+AM2+Fc1YSw5QJ
         AfsQ==
X-Gm-Message-State: AGRZ1gKtnAyaktBynGNs872MSpJtnP8EqD99XMf5qGDdp0Mrj8OuOLjK
        tC/t9nL3yFwov/1+CcxDSF7AnuLKwPpxX47h52k+OA==
X-Google-Smtp-Source: AJdET5djPTAEz7ZJAwu+0JCDkDHeegX6z/NYXjH2QjWicNbwTJ+mbDDOAg+ptYplKuBAI6EkRX2U0u4Qe8i7HnNDLDQ=
X-Received: by 2002:a19:2752:: with SMTP id n79mr9233667lfn.11.1542966068753;
 Fri, 23 Nov 2018 01:41:08 -0800 (PST)
MIME-Version: 1.0
References: <20181122173015.23905-1-ckeepax@opensource.cirrus.com> <20181122173015.23905-3-ckeepax@opensource.cirrus.com>
In-Reply-To: <20181122173015.23905-3-ckeepax@opensource.cirrus.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 23 Nov 2018 10:40:57 +0100
Message-ID: <CACRpkdZEu44WHScd5VibYT5C9RikqcvKsgpVOpkkdrYbLaV8Ng@mail.gmail.com>
Subject: Re: [PATCH 3/3] gpio: Add reference counting for non-exclusive GPIOs
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 6:30 PM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:

> Currently, a GPIO can be requested multiple times when the
> NONEXCLUSIVE flag is set, however it must still be freed a single
> time. This makes client code rather complex, since multiple drivers
> may request the GPIO but only a single one can free it. Rather than
> manually handling this in each driver add some basic reference
> counting into the core.  Currently, this is fairly primitive but
> so is the support for the NONEXCLUSIVE flag and the implementation
> covers those use-cases.
>
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>

This patch is not fixing anything right now, correct?

I discussed the notion of pulling reference counting for
nonexclusive GPIOs into gpiolib with Mark but the benefit is
a bit unclear: if the subsystem using nonexeclusive GPIOs
(currently only regulators) would still have to keep its own
reference count or somehow semantically know when
the last user is gone, the point is kind of moot.

I haven't looked closely at the regulators case but I got
the impression that it is more complex than just reference
counting so, currently I don't know if this is such a good
idea.

Anyway I would like to push this until we have cleaned
up with the rest of the series I have boiling, if you don't
mind.

(Patch 1+2 should be fine anyway.)

Yours,
Linus Walleij
