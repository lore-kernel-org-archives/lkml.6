Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 797BFECDFAA
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 10:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FE972086B
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 10:17:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CjM4kIwP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FE972086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbeGNKfZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 06:35:25 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:35048 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbeGNKfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 06:35:25 -0400
Received: by mail-io0-f196.google.com with SMTP id q4-v6so33430221iob.2
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jul 2018 03:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QO9BTGPtSnXoyIZDKfFGEXpcZP/Btky/KGEjrvP3hfY=;
        b=CjM4kIwP80wKHjPS4U38nm5J9OCUYmEEvCeg2QRfCCcXDRQi7GvSTebzWktJXLyA1I
         6Br2jqJqqJSL/KfOH8BfGT42IX0xE96VIHOx2QIxDy5HEnZSSOID3I97tIGPo2VfD4ah
         0HJba2zagy6+364DQVMQPFv4UaFNmtDz2+9Cg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QO9BTGPtSnXoyIZDKfFGEXpcZP/Btky/KGEjrvP3hfY=;
        b=sUAHu5TNsA35TETgAPdSHO5IzsB+G3m2UfUWAsNw0d7V411yUTHa6Sf/AkzW+/tMFF
         FNAITluZZJ7O1zYrTiY6WqRObKRWGQnOjLyRM4COzGgsmgCLzEKGWqCIOXVBI+/TETPe
         P+eKC0bZS5dbia2nlVwSSy+17gnQZZ10LJT74fJ8XUYPun98My9vcffdyPia6adK2jWv
         jR8oABJUUk0eKY0uAS6Pm1CFiUmBsru/8Is0HbcSrb5e+96rPeg5s25GpnIWAP9fMpSL
         6hufoMc8hwL7UulLsFLnQbUOH9zw17r6CklFXtNcRxIez9otHbzc3kGqT8SJOfGparWx
         f/Nw==
X-Gm-Message-State: APt69E0zQN8LHvg5JSDQ84k6aRmnxJLMnNQGoq+qZhI0bXiOf7y4L1gP
        wEWmQCOzk2B7wXhhMMRdQRT6Zcko+zMSmklF1hdnUw==
X-Google-Smtp-Source: AAOMgpc4DLuva886bV1nNqU+59flkb5GjIKmXGCePPJo/rKJC8v9Dp6V0JO2rKjtdqubw5AjKuhL/lWopZRURFzVyAc=
X-Received: by 2002:a6b:6c0b:: with SMTP id a11-v6mr33548491ioh.175.1531563409841;
 Sat, 14 Jul 2018 03:16:49 -0700 (PDT)
MIME-Version: 1.0
References: <20180709061925.20276-1-vkoul@kernel.org> <20180709061925.20276-4-vkoul@kernel.org>
In-Reply-To: <20180709061925.20276-4-vkoul@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 14 Jul 2018 12:16:37 +0200
Message-ID: <CACRpkdYk11wNMFFFqbVXgRtPCrvq25MOHDrG_dikCr31oUWyqA@mail.gmail.com>
Subject: Re: [PATCH v5 3/6] crypto: Add Qcom prng driver
To:     vkoul@kernel.org
Cc:     linux-crypto@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>, linux-arm-msm@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>,
        Timur Tabi <timur@codeaurora.org>, jhugo@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 9, 2018 at 8:20 AM Vinod Koul <vkoul@kernel.org> wrote:

> This ports the Qcom prng from older hw_random driver.
>
> No change of functionality and move from hw_random to crypto
> APIs is done.
>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>

FWIW:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>


> +config CRYPTO_DEV_QCOM_RNG
> +       tristate "Qualcomm Randon Number Generator Driver"

Random speling error.

> +#include <linux/of_device.h>

Do you need this? It seems like a platform device fair and square.

Yours,
Linus Walleij
