Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9107EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 601782229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:13:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gmXPTPSM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394514AbfBNINi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 03:13:38 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37134 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394494AbfBNINi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 03:13:38 -0500
Received: by mail-lf1-f66.google.com with SMTP id n23so3869523lfl.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 00:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YEdqgPpBCRrbJZQuO5se9nNRWLljQ13oEHfjoBg90G8=;
        b=gmXPTPSMDXjhFxVRWHa3gXoBMReRpD0Qzy1nH2Vl9x3RcjQZPpieiCKZYc6UBsAUWt
         DQejRMnvGDx50lQcm6GzGHb+hUvAbDCCdF9KzSkmy1tadnKXEnbkp4N5sZ2+kVVUftOb
         TB6E3fXlYX0BSszGTGS7DY1PNcuOvUj/vCtUNjfep2HAR+Tl/tE8Mzv/hhc/CncaSu4c
         UfnqJmzqZ0ubijjRuTtM8EVNzqKwO2JPqe59SGZFljhzSgRa6n5dUDpKkeJ4GEizrf32
         NPIq231L+7POrnG4kdS70jyTN5PMAh/kJmsVGD8nB5w4ADqmqwmNb3bEN34+eG9TQcnn
         srYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YEdqgPpBCRrbJZQuO5se9nNRWLljQ13oEHfjoBg90G8=;
        b=CVBd9ZL4UP6CgsOXAKA/wjixdvySUoBwiF+4GC2i0gGsb92+4Nc+UPhnCq5Vw9LkWX
         NCnT4gkMbmo4hr+W2mQ69dQjtZ36VHrvSDJT1kfEN6oy49FwKu/GTQQWrfryNIHYuI9Q
         n22u/GiWpujaRGDYs4IXWycX3IraAys/VJbH3p47QGxLLTAjZ3Y+lm8FSIZHad2/bd0v
         TY9JOiQvBv+NsuCSXTXy2CCs1M8lXQXWReGlPa+I9WUS8majtZg+acEc8MHQMzWblnGt
         +40103o790tj7MvUSspI9BfSpbQlQXeVO9JBULD2Qyt4GR+svnMWXYk5jHEGgQ1lR3X4
         rgNw==
X-Gm-Message-State: AHQUAua63WvdK6yX40mKvPBvjOOYqJjEQGeiX+o+iIRqb6J+7YpH55+N
        fM/2bXMtJgEJZGOSi7ioAToZnQP/QJXce8mDvZahSw==
X-Google-Smtp-Source: AHgI3IaGGeUrrOqT96UkDoHfXwN3tHwS0h8H1sn3zRpD1jiTZecj+HRBqQMB2Cv69rL2yuVgxdeFqyfzhLRxXb7L0ao=
X-Received: by 2002:a19:ec0c:: with SMTP id b12mr1557547lfa.27.1550132015898;
 Thu, 14 Feb 2019 00:13:35 -0800 (PST)
MIME-Version: 1.0
References: <20190213230618.1907-1-lkundrak@v3.sk>
In-Reply-To: <20190213230618.1907-1-lkundrak@v3.sk>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 14 Feb 2019 09:13:24 +0100
Message-ID: <CACRpkdYyT20Um+5bDAiZAfB-A3M+q5DpUQS31+CkLUSb+qpQOw@mail.gmail.com>
Subject: Re: [PATCH] gpio: pxa: avoid attempting to set pin direction via
 pinctrl on MMP2
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Robert Jarzmik <robert.jarzmik@free.fr>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Pavel Machek <pavel@ucw.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 12:06 AM Lubomir Rintel <lkundrak@v3.sk> wrote:

> Similarly to PXA3xx, pinctrl-single can't set pin direction on MMP2 either.
> See also: commit 9dabfdd84bdfa ("gpio: pxa: disable pinctrl calls for
> PXA3xx")
>
> Fixes: a770d946371e ("gpio: pxa: add pin control gpio direction and request")
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> Acked-by: Pavel Machek <pavel@ucw.cz>

Patch applied for fixes.

Should this even go into stable?

Yours,
Linus Walleij
