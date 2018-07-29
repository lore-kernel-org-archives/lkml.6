Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C850BC46461
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 20:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E76C20857
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 20:21:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KkrPBS+l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E76C20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728975AbeG2VxQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 17:53:16 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:38968 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbeG2VxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 17:53:15 -0400
Received: by mail-it0-f66.google.com with SMTP id g141-v6so14104867ita.4
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 13:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zOHestrr6EbTJ4V/5ohxj1NYbd2aG0Vyt5k0Jjdy+RE=;
        b=KkrPBS+ly1V91BIZIYuLJe322f4JFlf3ti3FdNjzkTmfIP7rsvoB1+7hvDqaVIvBGX
         rohuSBL6csbg478jGQfp/sv9TaPZzsEhlobZpTiLS/aazryFU+URZ0q7QXVH4FMDl/m3
         hIoVO9XHTGtmmA0Iaulu8u+Ec4jJ6s9yMJTgc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zOHestrr6EbTJ4V/5ohxj1NYbd2aG0Vyt5k0Jjdy+RE=;
        b=U04zfo+KXN9+XkMAJU/N3zIOsRJVGFzF3nZFLPzty7zQvOj7bs/7ZXWVydLkX1emMJ
         etgNmk+6e2HW/6JpbCEcPloGGhMAA6LXMNHREUaef/fje60E0P/BX+tJOvXYP953S3Q7
         C3iwJ+MsQR0Fo9C7AmzwPnWZD1j3DH6ri73rIeqp99VpwPm8MvO2m18XSDKUX1rYPD28
         vQ65tHXrELLC0eAg9q3+o9tBymv/Ia4hYQc2cIA9S2/ACZOp/ltleaLh622MmV2zHcbo
         a90MGQKGomkn49J71b7gdYa4zdsvl0At0h4fOWC296oO65wW7AcWI2LZRJJ1yiOp138Y
         hkYg==
X-Gm-Message-State: AOUpUlFpZv7PrVHagR2wBKAJsBlQEfzQKPVnLJbAIjTfz2mPpdEMkBum
        m3cl3wajNE+onSeP6M92VXpddUQz9rwXaRN5smxffg==
X-Google-Smtp-Source: AAOMgpcT5S2X0KGYS2wnkw7L+xQ4cudMlkZB9weM2T5G/UNTHA741eeQNC2bRbZ24kdnkoJ9gwJiYXVrRqeufDRKpfA=
X-Received: by 2002:a02:2505:: with SMTP id g5-v6mr13932517jag.112.1532895694047;
 Sun, 29 Jul 2018 13:21:34 -0700 (PDT)
MIME-Version: 1.0
References: <20180717010742.1847-1-djkurtz@chromium.org>
In-Reply-To: <20180717010742.1847-1-djkurtz@chromium.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 29 Jul 2018 22:21:22 +0200
Message-ID: <CACRpkdYi_Zb9T4q5i3-KcFrvZyuhuTw4Ys9zg7mk1VD5S-Myyg@mail.gmail.com>
Subject: Re: [PATCH] pinctrl/amd: fix gpio irq level in debugfs
To:     Daniel Kurtz <djkurtz@chromium.org>
Cc:     "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>,
        Ken Xue <Ken.Xue@amd.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 3:07 AM Daniel Kurtz <djkurtz@chromium.org> wrote:

> According to the AMD BKDG, the GPIO ActiveLevel bits (10:9) map to:
>  00 Active High
>  01 Active Low
>  10 Active on both edges iff LevelTrig (bit 8) == 0
>  11 Reserved
>
> The current code has a bug where it interprets 00 => Active Low, and
> 01 => Active High.
>
> Fix the bug, restrict "Active on both" to just the edge trigger case, and
> refactor a bit to make the logic more readable.
>
> Change-Id: Id7775ae4cb61d193fa7fbb83967a8c5a7cdd0de6

I stripped that off.

> Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>

Patch applied!

Thanks for your fixing and attention to detail!

Yours,
Linus Walleij
