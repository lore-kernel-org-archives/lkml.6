Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5635CC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 08:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2487C206B2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 08:20:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2487C206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408500AbeKWTEH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 14:04:07 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36981 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731828AbeKWTEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 14:04:06 -0500
Received: by mail-qt1-f194.google.com with SMTP id z16so9707721qtq.4;
        Fri, 23 Nov 2018 00:20:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z9lQkKPWTyQAUWDXIrw00zI6J4137n+kAEljY1X7xJw=;
        b=ACR+czl+euW91P4fJt3hXcuM8W9ql/L3+y57UdUxJu8L42KPC8h1UJRA8UDHKAWEIf
         cmTPheX5wNVa7cL5qlHTMwycL+l9vpNCdqGXZW80Q4wpyeWvUAHRnotubBLS1Z3FtN6b
         km2SWjQpniDDnKMfHpB/v6PL0WRtCD+dQ5vSnT1zqyLxRa/DSgatVgMSB63xejxsIpIP
         zRsiMJGlvZJVql+fGuV20twmcMoiFb9APk1LpGwdvAHiAPHFfgpk5d1Fj3wjdXaLWtGL
         iUFTns7rVnD1+SzzqrqUf8xPRAqiiSz4LQsRdo7DjCFQ0FV3Jkmsvo68vBtwfZG3Ywqt
         NYkQ==
X-Gm-Message-State: AA+aEWYz+c0S1KmaA8sbF0cG5sE94ixXCwsqhKn/vXymihFN6O17gqvr
        cT6QwmGIjB0+3tQckEA67BwUs/S6xHSjJc4E3LY=
X-Google-Smtp-Source: AFSGD/UHdWeBlAPkoLxYd6Z6RP/ssclkEybjzank+W1ZxtQIgNcgnUFpXTgtY9V7+iLbvYI5mwzlnhvJfReHTtyGk08=
X-Received: by 2002:a0c:f50c:: with SMTP id j12mr13173342qvm.149.1542961254584;
 Fri, 23 Nov 2018 00:20:54 -0800 (PST)
MIME-Version: 1.0
References: <1542886753-17625-1-git-send-email-rogerq@ti.com> <1542886753-17625-12-git-send-email-rogerq@ti.com>
In-Reply-To: <1542886753-17625-12-git-send-email-rogerq@ti.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 23 Nov 2018 09:20:38 +0100
Message-ID: <CAK8P3a0Nvdtq-TjK+1CGaOB+voyr-eky+h01n5i0z=8rB9PaHw@mail.gmail.com>
Subject: Re: [PATCH 11/17] soc: ti: pruss: add pruss_get()/put() API
To:     Roger Quadros <rogerq@ti.com>
Cc:     Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>,
        "Beno??t Cousson" <bcousson@baylibre.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Suman Anna <s-anna@ti.com>, Sekhar Nori <nsekhar@ti.com>,
        Tero Kristo <t-kristo@ti.com>, nsaulnier@ti.com,
        jreeder@ti.com, Murali Karicheri <m-karicheri2@ti.com>,
        woods.technical@gmail.com, linux-omap <linux-omap@vger.kernel.org>,
        linux-remoteproc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 12:41 PM Roger Quadros <rogerq@ti.com> wrote:

> +
> +       if (IS_ERR_OR_NULL(rproc))
> +               return ERR_PTR(-EINVAL);


Any usage of  IS_ERR_OR_NULL() tends to be an indication of a badly
designed API. Please change this to allow only one of the two to be passed
around.

       Arnd
