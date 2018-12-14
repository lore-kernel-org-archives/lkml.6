Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2836CC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 21:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5135D2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 21:56:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KmrSt/LS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731176AbeLNV4n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 16:56:43 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42114 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730887AbeLNV4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 16:56:42 -0500
Received: by mail-lj1-f195.google.com with SMTP id l15-v6so6137064lja.9
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 13:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z7b7MDcKHXLL8mJGaRJQExofHqN08iwchL4Zcr9axrQ=;
        b=KmrSt/LS6T5Jbwmc6OKFeKjce6RCmZVUgt8sEuSGV7mig+Z8t7eNz6zvV8gc5aWjp1
         75JaT/BIxgx4sx89uMVO4TdxIIIgdlcZUlitklvSQ9ttgMbJpOgwq87k9fPW/x2I/z/A
         Fh6AQSULojiXA5vz8xGSW8LMPhSIczHrfz+wc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z7b7MDcKHXLL8mJGaRJQExofHqN08iwchL4Zcr9axrQ=;
        b=Q/Y9eM8q1qSWjrgS0GIFvUkFBhSg9L32YiG5Qd9mYVkYyVpMo2qxlpgPnsui9JfVAh
         AYU/e59yFoEhHdX/GO1yoEtsNqqzCsuj4OsP9KUhiGg6ujS+c+JwDaaq63rFcLsjqlDw
         vRXOesTPxVkGD4tZORNkakVEz9tWYkmAAIiV/MpYm7rVeoZhXa0U8ADq3Ozk2aviV5DE
         Ofy4boANis+zvtyMg1fWrJRXy+fJzX2/nrmKuDBReFyM4EgYD5OpLFKJfUJtBW7vxKI2
         TbG86EBOedfMPBUwHmkFyYHYomxxiO82vbtX37FPFnIN6oCpPuAuxHE1CrSBKVoc5r3j
         uxLQ==
X-Gm-Message-State: AA+aEWa/WVG0B0n5vZzq+scJU8JbL52Z1whL2aJwQpPHbyjVA7zqYiKn
        P932xIV5b94Ck7Cg/fZYviklgFzrWkQGR4IuAHm3EFb/dYg=
X-Google-Smtp-Source: AFSGD/VsT6JEn5seHFNZoPjAKoOfX/Lpl7nZSQNHRV2gTE3XuwtXNhK4sw9oypnL4Y0sM2+ExGm8Cg4BwCM+h5PBQ+s=
X-Received: by 2002:a2e:9107:: with SMTP id m7-v6mr2817639ljg.23.1544824599964;
 Fri, 14 Dec 2018 13:56:39 -0800 (PST)
MIME-Version: 1.0
References: <20181213013858.23996-1-sebastian.reichel@collabora.com>
In-Reply-To: <20181213013858.23996-1-sebastian.reichel@collabora.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 14 Dec 2018 22:56:28 +0100
Message-ID: <CACRpkdaEXJqpzmbnJpxkZewwCwLbekwwn1QnANOXP5pgnHfU8w@mail.gmail.com>
Subject: Re: [PATCH] power: supply: isp1704: switch to gpiod API
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 2:39 AM Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:

> This migrates isp1704 driver from old GPIO API to new descriptor
> based GPIO API and drops useless platform data as a side-effect.
>
> Migration is simple, since all mainline users are DT based and
> DT API does not change. Out of tree users of the platform data
> need to migrate to gpiod_lookup_table as described here:
>
> Documentation/driver-api/gpio/board.rst
>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Excellent work!

Yours,
Linus Walleij
