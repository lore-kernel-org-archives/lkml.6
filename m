Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C25BCECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 15:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A77821523
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 15:17:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NM0TdlEp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A77821523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733306AbeITVBI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 17:01:08 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:37889 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733161AbeITVBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 17:01:08 -0400
Received: by mail-it0-f65.google.com with SMTP id p129-v6so12816005ite.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 08:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bEiGGwQI4T6vaaCpt2NhlU9HB7HNVkXDvLy0tbG34FU=;
        b=NM0TdlEpQDu0oyZzLdVBCXlwnsi0hJxHydkKs6D6lp6Y+nPwDG7MvNOj6i2MmU6fkj
         ZFg2fJTFSNokkO1LAta4L+zQRG6XKNRSlZehCvzyiKyA4YwC/cTUF5JVAhsBXa8OJ0g1
         2UBQdpvhla3V8xL+rmFi2ls0hfis60LNYEQkA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bEiGGwQI4T6vaaCpt2NhlU9HB7HNVkXDvLy0tbG34FU=;
        b=YQ0+bUcCn0/4sV1L8dNpDiPzVcANB8CUbESpAEHXxCNeN57XEcqh8U/tLE4h7z7E/L
         8bN+reoUEbiR56B7aB1btzPwluONJK8rYAzUbfu1Mpxz0tZSUBRTav8HEqwkEpegh2vv
         W0u0FhgVNz3wAiSNnK0moQYgiraRwjk/tAYpb6URZ6VKcYHc73spqpB9l7FJp242NHyA
         e7LgybsnIaS8Ty7WjEhMAGuq6jYEFFa0uYFneSY2TWgXMF3HHHlyN+uXFv/mf8hBYKCi
         nBpiPgOiZ7phPlguQWpp+lfb45eWtwWNjefZTAzY1TCdz+NOS0p5yAdYnrDBnPSl22T+
         skuA==
X-Gm-Message-State: APzg51DgKBilK9LOq8iPeD+vgi149mm8o5uGpnG1To7u9fNUdAWhcISR
        rXq3rDwRBua4mvUbCl6wXZD+4IJ3YPFeBf2UpXlS9Q==
X-Google-Smtp-Source: ANB0Vda7+/V67pu6GWac+7MS7h651AcJs0jnDmq/UWsfPStqQp6X7MsyifDHFixUEP4jpaHBpg6y9kW83SnIXpvPrXE=
X-Received: by 2002:a02:6c45:: with SMTP id w66-v6mr37121317jab.87.1537456630678;
 Thu, 20 Sep 2018 08:17:10 -0700 (PDT)
MIME-Version: 1.0
References: <20180919012427.12439-1-stefan@agner.ch> <20180919012427.12439-2-stefan@agner.ch>
In-Reply-To: <20180919012427.12439-2-stefan@agner.ch>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 20 Sep 2018 08:16:58 -0700
Message-ID: <CACRpkdYZFt-FEnF86GCKqiLjFa-n3wHYLjFbvwFDWEp+AsGCZw@mail.gmail.com>
Subject: Re: [PATCH 2/2] pinctrl: tegra: move probe to __init section
To:     Stefan Agner <stefan@agner.ch>
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

On Tue, Sep 18, 2018 at 6:24 PM Stefan Agner <stefan@agner.ch> wrote:

> The Tegra pinctrl drivers are always built-in. This allows to use
> platform_driver_probe() and mark several functions as __init.
> This allows the kernel to free about 1KiB of memory if Tegra
> pinctrl drivers are not used.
>
> Signed-off-by: Stefan Agner <stefan@agner.ch>

It appears the test robot complains about this patch, so I'll
wait for a v2!

Yours,
Linus Walleij
