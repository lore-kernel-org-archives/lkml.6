Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF272C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 09:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F86120868
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 09:25:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NoRlnHdO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F86120868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726008AbeLGJZD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 04:25:03 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40888 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbeLGJZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 04:25:02 -0500
Received: by mail-lj1-f195.google.com with SMTP id n18-v6so2942253lji.7
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 01:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zXC9LUrlJf/PtZJogUUiTtxM3XLzHY1q8x70moGfCHM=;
        b=NoRlnHdOweaAEgmwzuh9itIFct2xEkh5WBgh87BImTTgAaoRzLylIGLfcbDikfAaTg
         cGcc7h6Xt9O41ZZTcg8N/CcFbq1Ae/hXUCHS9RlGdk68PvineyZ60IUgDVgt14jWlrgo
         2FBM+AI2OjWcaVD1jG+TrG7F4p29fiDxR707E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zXC9LUrlJf/PtZJogUUiTtxM3XLzHY1q8x70moGfCHM=;
        b=ciQSG5RGIWop8Q6TBNulMYrL5u82Al0I4rIHTUulfhBTqV/7N8lATjaOleUkqwgW9E
         cb4lMh84xAbM9do5qFGDLFtPChi0Pg4fERvRQ0r/YvWv74hHhcYw/KJO/RLaq3wgyws/
         /YTxPYsc0s3bc0Zl3Aml5Cyp3+F3BHfL+pRnjpW+REE5nZvVu9aOZzL0DeVqJ9PfDnqF
         IBO6slfLQ4Xv24033Uu6ME+7V5n6cvPRad8+IjUoU0Y6hwD0vpFiu6Snn4uwhhE69lYM
         ecP5yYvJi6GUOw4efjuOahfbUjzTrP69oPwrwHF6HHSasmUpNNaNJFsD4wzydRZVq+nz
         2DUQ==
X-Gm-Message-State: AA+aEWZQuf3bv9ugSSharxNbZeFrosaF9uXXaf3QPhRh5wWYkwPw3Abe
        /kXdBiNk+HxHvg2KOxy8+JYSz5yoT86sOJignNWtVg==
X-Google-Smtp-Source: AFSGD/Wc5U/dKbiNc9D9vFjjmVJ5YbXRxEJIBKA1ZEXMwNcpnENlodPcHBsUDLJ27XfopFzMKINTZDtx9DxrbwRN2/w=
X-Received: by 2002:a2e:710a:: with SMTP id m10-v6mr868542ljc.66.1544174700690;
 Fri, 07 Dec 2018 01:25:00 -0800 (PST)
MIME-Version: 1.0
References: <1543077033-7016-1-git-send-email-hofrat@osadl.org>
In-Reply-To: <1543077033-7016-1-git-send-email-hofrat@osadl.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 7 Dec 2018 10:24:49 +0100
Message-ID: <CACRpkda6ketyah+L7VbGNHjgh85DffaAkQmeEpjTO08Zb_Wbag@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: rza1: report if devm_kasptrinf() fails
To:     Nicholas Mc Guire <hofrat@osadl.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Jacopo Mondi <jacopo+renesas@jmondi.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 24, 2018 at 5:34 PM Nicholas Mc Guire <hofrat@osadl.org> wrote:

> devm_kasprintf() may return NULL on failure of internal allocation
> thus the assignments are not safe if not checked. On error
> rza1_pinctrl_register() respectively rza1_parse_gpiochip() return
> negative values so -ENOMEM in the (unlikely) failure case of
> devm_kasprintf() should be fine here.
>
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> Fixes: 5a49b644b307 ("pinctrl: Renesas RZ/A1 pin and gpio controller")

This patch needs to be handled by Geert Uytterhoeven,
who maintain the Renesas pin controllers.

If he didn't get it you might have to resend the patch to him.

Yours,
Linus Walleij
