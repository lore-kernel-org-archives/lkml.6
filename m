Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D387C2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAC622085A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:34:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jBiFa/YC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728980AbfAUNec (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:34:32 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40914 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728648AbfAUNec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:34:32 -0500
Received: by mail-lj1-f194.google.com with SMTP id n18-v6so17534220lji.7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 05:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BxTRymD9NPejeDgo/hQMc453bmZ43wDOpUttCi4YEtE=;
        b=jBiFa/YCdOIoSnxj/1hUdZy0SMw+hgY+nTUhrpG/+AI7JAeiRUiDusSDg6fyn5zw5Y
         tNiTitwJ9R65cBN7DlW/rNaLiAjG6pV0J2CWSj9uLBt6od/23SYud4t/E4G2FC1hBTJ3
         +u9vsSmRKnQRirj/+QBw6KnMkI0ta+lda4R2s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BxTRymD9NPejeDgo/hQMc453bmZ43wDOpUttCi4YEtE=;
        b=H3iV6yRmPvi6lK9G+8RoUSS7Jvi3Z2Qcd5XTZTPyZE2wpCXi0VraTUZGa8fj9Rjvgr
         mM4n8Nbeh+TXLmFxIctctswRrQjE6RlinRVsyElvH59i1VruppHrVbX//3JXAk4d0ekc
         vQZtF6W9cI318hLo9sDkGjPizcZ+bInlavnYfXCLhiESb5yU6DHrOUUYbGdW+QBGaanz
         y22uTqeLisPqmQzmUJXNCrZf7zLOXmwNpCRoK0Q1v9De9VniYfGKx0OoLcaMAFZiPu21
         c7bqdR1iCjG1h1//X5VK/PqcQQmNb4/MddX0DMQZD3PlrO28Aw8McNWTPQEo3hderDEv
         URlg==
X-Gm-Message-State: AJcUukcVWkwkyFGuc4vVo45kmoFw8Bxmn6TXG2VxUmE1aUY75o9VOzu/
        +8Nv50cFk2zcztGWVLtPeTlzP6JBn1K9Fn4DO2fADTTH
X-Google-Smtp-Source: ALg8bN4ZTnP0g3feHqVSXm1xHMxV69HDK5Yuvh3qlTqRRnD41ufg5zby+fncAHOGx3m1aAL8ul2Vzda67z0iPuZNjiM=
X-Received: by 2002:a2e:7e04:: with SMTP id z4-v6mr5934765ljc.97.1548077670129;
 Mon, 21 Jan 2019 05:34:30 -0800 (PST)
MIME-Version: 1.0
References: <20190114191450.11597-1-j.neuschaefer@gmx.net> <20190114191450.11597-2-j.neuschaefer@gmx.net>
In-Reply-To: <20190114191450.11597-2-j.neuschaefer@gmx.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 21 Jan 2019 14:34:18 +0100
Message-ID: <CACRpkdaK1KZUqNfxnpmZ4UD+rYjvcdK7LreGZwhbXfUxb9UWnA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] gpio: hlwd: Add basic IRQ support
To:     =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 8:15 PM Jonathan Neusch=C3=A4fer
<j.neuschaefer@gmx.net> wrote:

> This patch implements level-triggered IRQs in the Hollywood GPIO driver.
> Edge triggered interrupts are not supported in this GPIO controller, so
> I moved their emulation into a separate patch.
>
> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> ---
>
> v2:
> - Changed register addresses to io{read,write}32be() instead of
>   hlwd->gpioc.{read,write}_reg, as suggested by Linus Walleij.
> - Changed the IRQ chip's name from "GPIO" to dev_name(&pdev->dev), which
>   is "d8000c0.gpio" for the one GPIO controller in the Wii, but might
>   help tell the two GPIO controllers in the Wii U apart.
>   (also suggested by Linus Walleij)

Excellent work, patch applied!

Yours,
Linus Walleij
