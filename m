Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD49C46462
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 21:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EEC120870
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 21:13:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="b5hSoDT9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EEC120870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbeG2Wpq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 18:45:46 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:53623 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbeG2Wpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 18:45:46 -0400
Received: by mail-it0-f67.google.com with SMTP id 72-v6so14624700itw.3
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 14:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5gNxDYP8f1bF8Bl/sa2d4WEEauYaVxCms3equItjypM=;
        b=b5hSoDT9A6zqZfavzW/duijaMkbyQPrdrEATVRU80y7fQ/HKvItoYLY1eYeFfqe3Y1
         JeR7IBTvz+4vCF3XEUJMVRf2EHFg6MmPEc1wWFxspgnxBn3ud1eSE6A58u8v1k0os1X1
         +gEP69VxuQkWrIyAStaQoGvY1ranEh6b9zhnA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5gNxDYP8f1bF8Bl/sa2d4WEEauYaVxCms3equItjypM=;
        b=VjAFgr9Pkf8zDF8z1uGQrkDclSrpRP7C41+kBkuC08DUAfYmLf2JKXPTE+P4VF40SX
         gMe0cjZoNq3ml1udCoKz4m8rCyVx36Hp5EWed6InbS5JYnO38fxRA2bg2oFE10tXGHNM
         Aku5ZRcq5W+Ck5WWSQhr3C7gNINqiCzUqoQ8j94Ccbed7HK3ODxw2Bo005vyVEGZiu1v
         i8EwlKsM2sdHqIZE7owHnSEnHst6Zl/z8hcdOpDnKiVK7dys+m1xjY/5Mct+iB52UR6m
         kTWyTK5elHhEyC9RlKpUgmS8f2BVIE6I8vexV1kcOOXD2+st0fe7hPK24wnieqFC4YEY
         pdqQ==
X-Gm-Message-State: AOUpUlHWFZ7p67nrW7fA4AaHyIIujZ1BQrv2YXsmja9NR8yXLIegNz9W
        gjWrOMUjnunDYJlCK7aGwkGpqQIxVXQQczD65pVAXOob
X-Google-Smtp-Source: AAOMgpcb+QDP8Fh4r5DlWju2AQh7VXw16+rEMkHOjkpRDx82XeEGl5MbsCMlTbtESYOiFeJ8OrXeJb85Fe4b6jprADI=
X-Received: by 2002:a24:2c49:: with SMTP id i70-v6mr12590639iti.135.1532898834034;
 Sun, 29 Jul 2018 14:13:54 -0700 (PDT)
MIME-Version: 1.0
References: <20180723165330.25213-1-vasilyev@ispras.ru>
In-Reply-To: <20180723165330.25213-1-vasilyev@ispras.ru>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 29 Jul 2018 23:13:42 +0200
Message-ID: <CACRpkdZ1RuSOFh8_w0Ds4sC2rpJhVEEtuo=SzVxFLk4OggM7_A@mail.gmail.com>
Subject: Re: [PATCH] gpio: ml-ioh: Fix buffer underwrite on probe error path
To:     vasilyev@ispras.ru
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        ldv-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 6:54 PM Anton Vasilyev <vasilyev@ispras.ru> wrote:

> If ioh_gpio_probe() fails on devm_irq_alloc_descs() then chip may point
> to any element of chip_save array, so reverse iteration from pointer chip
> may become chip_save[-1] and gpiochip_remove() will operate with wrong
> memory.
>
> The patch fix the error path of ioh_gpio_probe() to correctly bypass
> chip_save array.
>
> Found by Linux Driver Verification project (linuxtesting.org).
>
> Signed-off-by: Anton Vasilyev <vasilyev@ispras.ru>

Patch applied, nice work!

Yours,
Linus Walleij
