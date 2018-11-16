Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D33D9C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 21:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FBF62087C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 21:43:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ekoh1pV9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FBF62087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbeKQH52 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 02:57:28 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37242 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbeKQH52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 02:57:28 -0500
Received: by mail-lf1-f67.google.com with SMTP id p17so17510643lfh.4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 13:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZbrlTl0TsZ6dTUygZdRq9fnv4yUdl+o/eDjNCiRMDNM=;
        b=Ekoh1pV9wQcS3e2LNrtyTBRRfr03jju3CjYfYkM0ZnpKF7kk2UrXGY4XCbhhwgyztW
         corFHuZSBekplSqZdypcVIypWwKs2Gnpys3Rujp3sP9T2brsk9anGrX0vdNtC9LpU4V+
         ZhcvjM02JpCPJE5oTyB3cS0/b1U4bgK3q4LYk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZbrlTl0TsZ6dTUygZdRq9fnv4yUdl+o/eDjNCiRMDNM=;
        b=GfVBg0Fde/61coidysQnKuvpEw9IzRML4VRcu94ce4LDgtz38FPvQ5vQSu98j3XBQM
         iY6wDXiM6Fs6w7b4Xp2m+SAdbH7x7UQRzD8zyu+Eizzh66kzIF5K/o/XFjtiuHKrsdew
         CqojMzm3lK8DZLDINrMyXpkdDXh99Gnu5GDaEEcGu9+geMUIUb0Ytx2qWhYquYoh7Nl4
         W9RFk00TyrZo7894VrX3cfBb6p7n7FCg+mF+9veEMJP6ei/vnj2cFrxKscdtn0uN4Dzg
         nsi8LBb/JC14bN0MCHcsjtCcIJHx2tdxrLYcX4h9j622QpULbh7rg1ILsj6Yn3LrTqFy
         79pw==
X-Gm-Message-State: AGRZ1gI8WjkvEq5z/OKuMVrvDUdwZOcRMSYVTLdeoCQLb7klwbpzJtvD
        pQkxY8+cEBJb0OICxcUXyOzxxk9Wn7OTSeLitZQlwQ==
X-Google-Smtp-Source: AJdET5dWSzHFShChkSICIf+lLOPY+B2oz14qCl1ESP2c9ORx1IVXMitvAZoa7cEovjZ1M8QOE5MBD0NtnLieRZs6wjE=
X-Received: by 2002:a19:4849:: with SMTP id v70mr4384121lfa.62.1542404600553;
 Fri, 16 Nov 2018 13:43:20 -0800 (PST)
MIME-Version: 1.0
References: <20181108165255.9940-1-brgl@bgdev.pl> <20181108165255.9940-3-brgl@bgdev.pl>
In-Reply-To: <20181108165255.9940-3-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 16 Nov 2018 22:43:08 +0100
Message-ID: <CACRpkdb71d2yCmxWDBaHY+60A9UDG1u0ACuXUq9pcH13_yA6-g@mail.gmail.com>
Subject: Re: [PATCH 2/3] gpio: mockup: add locking
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Bamvor Jian Zhang <bamv2005@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 8, 2018 at 5:53 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> While no user reported any race condition problems with gpio-mockup,
> let's be on the safe side and use a mutex when performing any changes
> on the dummy chip structures.
>
> Suggested-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>

I tried to apply this but it failed, does it require patch 1?

I can pull in the next -rc after I merged the fix in that case
and we can apply on top.

__gpio_*
I tend to dislike __underscore_notation because I feel it
is semantically ambguous. I prefer a proper name, even
to the point that I prefer inner_function_foo over __foo,
but it's your driver and I might be a bit grumpy. :)

Yours,
Linus Walleij
