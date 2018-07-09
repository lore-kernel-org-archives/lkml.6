Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F57C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 13:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DE0C20881
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 13:18:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="J/IeoFsO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DE0C20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754521AbeGINSS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 09:18:18 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:33263 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754334AbeGINSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 09:18:16 -0400
Received: by mail-io0-f193.google.com with SMTP id z20-v6so17015737iol.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 06:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S6MNXx28OtzqQeC0kFhQz+d0hmFk7XZHg1N0DAiX9+E=;
        b=J/IeoFsO7gOLaO94y1voIWoBGvLbOSkYgtHNChJ8L4BywR4OWGe3K7fv+RxxGsI5kn
         /WY1TVhTVxE4bHVwq00+M7PgfPkaV/bZAIwzzCrv+Ci9ThwUqVwjwKfhRddSsMFq+uyV
         nGxTR/Jy9unjZFc8/HH307vDCxtBTioQ8iH0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S6MNXx28OtzqQeC0kFhQz+d0hmFk7XZHg1N0DAiX9+E=;
        b=ZFTp6mBXbGJMMQN7qebwHXRxwfPI4Xja3KOSBx3dwC/kHyQUEGXY7jC09OObiUbEWH
         9mJYyde7UK1iLv0YbCdZXUkhvmYZQrw7ENpwI7mE5BlGNp46dD/Ntan9aNGZEJTjP3x4
         7fMDF1zXo2Y0i6UwwaJvTadFZIIN9VjQzDXXTIGTiaVTEuFezaVLig1wliZOTmB/LdLa
         t6qzyo82qAYX0uav+euVTourW1PqaZxiMtwv6ZtYCzR5ADv9uZkfYO5E1e9PuPob8GMX
         s1RrCHWjpnCQKErG0MHTya5lCgTdfkeuHHlfAKkqiCiud2TgUZl4oHoURchtmX+xTG6f
         kLwQ==
X-Gm-Message-State: APt69E3xzvaJN7ZJz105kFhLT5aETFSVAWYA0y1h/J3LqSSESnyDaoNl
        i+5vFZr5Sk/xWQP7wfop+uKMbJhvvr8UPM9OofaLIg==
X-Google-Smtp-Source: AAOMgpeVyFIeD2jfok20cObDRDAhxW5htFjFHQlHkCz8yHDQ7ZXCmVYbGU0ohAAo3ibW/qwqZsgQsZ0f/GQ9JPQaV2o=
X-Received: by 2002:a6b:4a15:: with SMTP id w21-v6mr15949161iob.277.1531142296339;
 Mon, 09 Jul 2018 06:18:16 -0700 (PDT)
MIME-Version: 1.0
References: <20180703172635.32508-1-jmkrzyszt@gmail.com> <20180703221819.1825-1-jmkrzyszt@gmail.com>
In-Reply-To: <20180703221819.1825-1-jmkrzyszt@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 9 Jul 2018 15:18:04 +0200
Message-ID: <CACRpkdZ4P+PhKCb=2rmT5unrzJLkYkCiWDBDMptxZVp7OdcGBg@mail.gmail.com>
Subject: Re: [PATCH v2] gpiolib: Defer on non-DT find_chip_by_name() failure
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 4, 2018 at 12:18 AM Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:

> Avoid replication of error code conversion in non-DT GPIO consumers'
> code by returning -EPROBE_DEFER from gpiod_find() in case a chip
> identified by its label in a registered lookup table is not ready.
>
> See https://lkml.org/lkml/2018/5/30/176 for example case.
>
> Suggested-by: Boris Brezillon <boris.brezillon@bootlin.com>
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>
> ---
> Changelog
> v2: fix typo (latar -> later) - thanks Boris and Andy for catching this

Patch applied as the discussion seems to conclude this should
work fine, I hope we will notice if it doesn't!

Yours,
Linus Walleij
