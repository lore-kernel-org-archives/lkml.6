Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A555C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F64F2084D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:53:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JBTpf3Da"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F64F2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbeH2MtA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 08:49:00 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:37899 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727530AbeH2MtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 08:49:00 -0400
Received: by mail-io0-f193.google.com with SMTP id y3-v6so3827181ioc.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 01:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0k4jr4FBzca5jWQm4p0IqphPVgUnL3faQmSv/TK/1vs=;
        b=JBTpf3DalA3Hsc97np9RkwdqW75yQ/mbTdRXol3yxIirCGetjiyfTsy6QmC8xI/bFO
         3gkr8diuc0Gvi9/aDtMHcGTKQ6TTC7UWIxvgHvYEjQ+ZLPh7DBEOQzs1+yQWprczZ6dG
         LjhVYNa93LNk4u2c+9izUHXg1f3F1PBxcTrug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0k4jr4FBzca5jWQm4p0IqphPVgUnL3faQmSv/TK/1vs=;
        b=MAVi8uTFK3+co7XoqCNXo84qDg4zSPxN9rtOAKdnC5K8/64JnCoizzEcw0Vv8rYynA
         X7o2bv3K/9aZxX72HJkpQKrAUI8JziIQajr40+EVUeMbEMuiKe4lN2H5ISpJyfdVogfN
         hbKF8FP6uRKhdwLdDEtoh0d6JRVYmvvcxEIGuUTS1xQewrWrFk705merbyRzHl3oXVBo
         blmNezN+7o31jHAcsF0F6kYF6Z39fZILdxy/8S7waLns407hTfm6EyKo51UKK7bsSxLF
         xSLOthbqtbmcnqiB6/OuO0AK7cm+Z9v/RfQ5X3/BVSrCX2gOOh+GsJNyFP472GzUD8G3
         5HjQ==
X-Gm-Message-State: APzg51AYNUvbXqKi8GVy9cWRFriMDGMepQu8aQ2HmR1z2TzTp39XynWQ
        Q8P47hkcxZ6ASZc6QYk+KgQ8hRpX3JDihCGYnJVSSA==
X-Google-Smtp-Source: ANB0VdaAYt0ZOcN+5JLsEV/g7ZQ7RgP9vcADaMoAX0Bj3NVgVO3iq4yCXKNqyfYgG0Z3vn4k3KOIqDK3+/Qj870qJ7A=
X-Received: by 2002:a6b:c3c4:: with SMTP id t187-v6mr4306378iof.304.1535532787511;
 Wed, 29 Aug 2018 01:53:07 -0700 (PDT)
MIME-Version: 1.0
References: <c4904283-37d1-08d7-feb3-4dc7ef0bea0a@gmail.com>
In-Reply-To: <c4904283-37d1-08d7-feb3-4dc7ef0bea0a@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 29 Aug 2018 10:52:55 +0200
Message-ID: <CACRpkdYhSdO1etL=PwE09zYYdRN+W_vzUqRiiCpUjfv8-jKQJg@mail.gmail.com>
Subject: Re: [BUG] gpio: gpiolib: possible sleep-in-atomic-context bugs in gpiochip_lock_as_irq()
To:     baijiaju1990@gmail.com, Hans Verkuil <hans.verkuil@cisco.com>
Cc:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-tegra@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jia-Ju,

Hans Verkuil is working on revamping the IRQ locking API for GPIO,
and I think these semantic problems will simply disappear when that
is done.

Yours,
Linus Walleij

On Sat, Aug 11, 2018 at 4:22 AM Jia-Ju Bai <baijiaju1990@gmail.com> wrote:
>
> The driver may sleep with holding a spinlock.
>
> The function call paths (from bottom to top) in Linux-4.16 are:
>
> [FUNC] mutex_lock_nested
> drivers/gpio/gpio-exar.c, 69: mutex_lock_nested in exar_get
> drivers/gpio/gpio-exar.c, 83: exar_get in exar_get_direction
> drivers/gpio/gpiolib.c, 3103: [FUNC_PTR]exar_get_direction in gpiochip_lock_as_irq
> drivers/gpio/gpio-tegra.c, 326: gpiochip_lock_as_irq in tegra_gpio_irq_set_type
> kernel/irq/chip.c, 1335: [FUNC_PTR]tegra_gpio_irq_set_type in irq_chip_set_type_parent
> kernel/irq/manage.c, 686: [FUNC_PTR]irq_chip_set_type_parent in __irq_set_trigger
> kernel/irq/manage.c, 1350: __irq_set_trigger in __setup_irq
> kernel/irq/manage.c, 1238: _raw_spin_lock_irqsave in __setup_irq
>
> [FUNC] mutex_lock_nested
> drivers/gpio/gpio-pca953x.c, 372: mutex_lock_nested in pca953x_gpio_get_direction
> drivers/gpio/gpiolib.c, 3103: [FUNC_PTR]pca953x_gpio_get_direction in gpiochip_lock_as_irq
> drivers/gpio/gpio-tegra.c, 326: gpiochip_lock_as_irq in tegra_gpio_irq_set_type
> kernel/irq/chip.c, 1335: [FUNC_PTR]tegra_gpio_irq_set_type in irq_chip_set_type_parent
> kernel/irq/manage.c, 686: [FUNC_PTR]irq_chip_set_type_parent in __irq_set_trigger
> kernel/irq/manage.c, 1350: __irq_set_trigger in __setup_irq
> kernel/irq/manage.c, 1238: _raw_spin_lock_irqsave in __setup_irq
>
> [FUNC] mutex_lock_nested
> drivers/mfd/stmpe.c, 170: mutex_lock_nested in stmpe_reg_read
> drivers/gpio/gpio-stmpe.c, 83: stmpe_reg_read in stmpe_gpio_get_direction
> drivers/gpio/gpiolib.c, 3103: [FUNC_PTR]stmpe_gpio_get_direction in gpiochip_lock_as_irq
> drivers/gpio/gpio-tegra.c, 326: gpiochip_lock_as_irq in tegra_gpio_irq_set_type
> kernel/irq/chip.c, 1335: [FUNC_PTR]tegra_gpio_irq_set_type in irq_chip_set_type_parent
> kernel/irq/manage.c, 686: [FUNC_PTR]irq_chip_set_type_parent in __irq_set_trigger
> kernel/irq/manage.c, 1350: __irq_set_trigger in __setup_irq
> kernel/irq/manage.c, 1238: _raw_spin_lock_irqsave in __setup_irq
>
> Note that [FUNC_PTR] means a function pointer call is used.
>
> I do not find a good way to fix, so I only report.
> This is found by my static analysis tool (DSAC).
>
>
> Best wishes,
> Jia-Ju Bai
