Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA20C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 21:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F37220989
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 21:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gCBiuW0v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F37220989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728661AbeLEVuO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 16:50:14 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37435 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728083AbeLEVuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 16:50:13 -0500
Received: by mail-lf1-f67.google.com with SMTP id p17so15920541lfh.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 13:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3ZyoEpX7amuCB0Gxm7yXpO9olhP7DQ7AoyWy2ufqK8Y=;
        b=gCBiuW0vgkg6fz1q7sOj3pppKRGQ+NZN777LNWXfWY/GnyEXQ8iNCE7Dw8LvirVqnb
         U4nZFJc6P4YBqE//T+3pYRIqN6lkTz6XK8Efha9HibsetAwak3HmQN335I5S4zEMRDXR
         YIdPPpcrSWTK4kBBubzskqaDGqPcjU9z7E+LU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3ZyoEpX7amuCB0Gxm7yXpO9olhP7DQ7AoyWy2ufqK8Y=;
        b=YOxg99bhuMqmisFnqruixjF2CdcCaKHcY2g4mHLxFq+OnBq2Ml8wn5RyL8rPnBGusU
         UAW0GO6VOHgDeMB79W2NZCc6w7FYpnPjieMriniwSWXjhUjAllSvybd2Ev7Y/jhZHPnX
         kujlvMtdMOy1FqvKARl3XDOlUfE/VYnpLMWYhFVkOEohexOqiWm80eDfgURfBOR7mxJB
         YTeY3zigRbXAVLHJFqzcBsqI2kP7xJnz8FIrUbokI7zvYdhxzSjGncg0VSoAEUhbF5i8
         lQUJzCRprJHwH3h4AEnwEkquIE7ASpRoOu/1orSFuvYroZCJHmQcrWJS5mB3vireuzAf
         2sbw==
X-Gm-Message-State: AA+aEWZXHOC+Vns5eR6xqs0KhYYjSIKtWK//8x1eFQ/QI1RSoJu9T6mS
        lQqOCyB/DhY9ghbe6GxWSA3qc/sxl3GjALpi4ycEQA==
X-Google-Smtp-Source: AFSGD/Wr5zMbRsrWHLlQhzxudI+aQ9cxALSvh0qo6hyAFkO/15H1+vuBHIoof7PyF3JCMewzVBs0Wddu2ZoIEW3Di/M=
X-Received: by 2002:a19:8d01:: with SMTP id p1mr14457662lfd.149.1544046610844;
 Wed, 05 Dec 2018 13:50:10 -0800 (PST)
MIME-Version: 1.0
References: <20181016214659.22362-1-daniel.diaz@linaro.org>
In-Reply-To: <20181016214659.22362-1-daniel.diaz@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 5 Dec 2018 22:49:58 +0100
Message-ID: <CACRpkda1i_NDnBGgrEoY2ewdSvSnJFVLWWvmSGCu0sNS0hLyiQ@mail.gmail.com>
Subject: Re: [PATCH] selftests: gpio: Find libmount with pkg-config if available
To:     daniel.diaz@linaro.org, Anders Roxell <anders.roxell@linaro.org>,
        shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org,
        Bamvor Jian Zhang <bamv2005@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for top-posting,

I don't understand the selftest environment very well so I do not know
if this is the right thing to do.

I can merge the patch through the GPIO tree but I need a nod from
someone wise, like Shuah Khan or Anders Roxell (Anders has been
using the GPIO selftests) that this is the direction we want to go.

Yours,
Linus Walleij

On Tue, Oct 16, 2018 at 11:47 PM Daniel D=C3=ADaz <daniel.diaz@linaro.org> =
wrote:

> If pkg-config is available, use it to define the CFLAGS and
> LDLIBS needed for libmount; else, use the current hard-coded
> paths and options.
>
> Using pkg-config is very helpful for cross-compilation
> environments, and is sometimes readily available on developer
> boxes to ensure we get the right compiler/linker options for
> the given package.
>
> Signed-off-by: Daniel D=C3=ADaz <daniel.diaz@linaro.org>
> ---
>  tools/testing/selftests/gpio/Makefile | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/gpio/Makefile b/tools/testing/selfte=
sts/gpio/Makefile
> index 46648427d537..f22b22aef7bf 100644
> --- a/tools/testing/selftests/gpio/Makefile
> +++ b/tools/testing/selftests/gpio/Makefile
> @@ -1,7 +1,13 @@
>  # SPDX-License-Identifier: GPL-2.0
>
> -CFLAGS +=3D -O2 -g -std=3Dgnu99 -Wall -I../../../../usr/include/
> -LDLIBS +=3D -lmount -I/usr/include/libmount
> +MOUNT_CFLAGS :=3D $(shell pkg-config --cflags mount 2>/dev/null)
> +MOUNT_LDLIBS :=3D $(shell pkg-config --libs mount 2>/dev/null)
> +ifeq ($(MOUNT_LDLIBS),)
> +MOUNT_LDLIBS :=3D -lmount -I/usr/include/libmount
> +endif
> +
> +CFLAGS +=3D -O2 -g -std=3Dgnu99 -Wall -I../../../../usr/include/ $(MOUNT=
_CFLAGS)
> +LDLIBS +=3D $(MOUNT_LDLIBS)
>
>  TEST_PROGS :=3D gpio-mockup.sh
>  TEST_FILES :=3D gpio-mockup-sysfs.sh
> --
> 2.17.1
>
