Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A85CC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19B2F20850
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:03:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fdGIpKVa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19B2F20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbeH2QAD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 12:00:03 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:50260 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727322AbeH2QAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 12:00:03 -0400
Received: by mail-it0-f67.google.com with SMTP id j81-v6so7282134ite.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 05:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ndSjRCgv8FANZkIZwgbVArQzZvMvEAxt0yz1wFbsNfI=;
        b=fdGIpKVaLKVdQtS/RCdvhTRX3do+QzLbOiEVU769PoCsz4XHFC3teig4e5Ul8n6h6E
         9WrbRci5kWnmCpP8hiSyNpaDtEQ70VMae2cZ9/9AmzqZq2hU1g/B0yFtOnaoeFSZBmVw
         5LLkDqEL6nPIxT087xXDDNSn4CesjXv3eND5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ndSjRCgv8FANZkIZwgbVArQzZvMvEAxt0yz1wFbsNfI=;
        b=Ihn4FWM0H6C/71SjLzusKbGIKeh8wqFM4E+yLzRmbQHMveODGClFfv9htLQqHLSFAq
         K/jXWV/C7QL17TKeDVv+9E1br6LVQBYcdpZJr27whbZsfmpWseJDaZdpmH7BNHT+C00C
         bQpoF0tSME7ONgbFOuJRjrBhaPiwrpzTO+8sBh3z4aV6hZC11lZ5O7XzTjMUlzzKd1bd
         1R60GPo8GW0SMiYXSHl/i7blyvUTaXnUC5FVHqBbzYELzq6lNiGNs8GQqhHXcVOmQZTK
         CJlLZxPKev87N+Zgv7o3oar2ylfN/J6S0RI+nUB+9NN9HYv7M98y+ggXBApUJ66P19Pk
         217A==
X-Gm-Message-State: APzg51CK6onkzFwdvbTbB+IYEkDk4J13N+jmOHQE4OfwuNwrWLLcitt+
        SiexI+P1khLfiMcmZPsHX/Lyvp8/wnUFxjCkn5fiaw2rdl0=
X-Google-Smtp-Source: ANB0VdZ42ezOlGAbgCvvrtiGQ6Al4b+LgB4ugyTvfjiGd/5RV7+E2LDh8Mk23twoQc4+nYl1tPD5QsJhZWAt/NOdzMA=
X-Received: by 2002:a24:144:: with SMTP id 65-v6mr4648664itk.62.1535544208515;
 Wed, 29 Aug 2018 05:03:28 -0700 (PDT)
MIME-Version: 1.0
References: <20180828084537.22960-1-rf@opensource.cirrus.com>
In-Reply-To: <20180828084537.22960-1-rf@opensource.cirrus.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 29 Aug 2018 14:03:16 +0200
Message-ID: <CACRpkdYhtBR2cBAFzgicEOHky=4aoaHegM7J6mLyGP_-gB305g@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: madera: Fix possible NULL pointer with pdata config
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     patches@opensource.cirrus.com,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 10:45 AM Richard Fitzgerald
<rf@opensource.cirrus.com> wrote:

> If we are being configured via pdata we don't necessarily have
> any gpio mappings being configured that way so pdata->gpio_config
> could be NULL.
>
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>

Patch applied for fixes.

Yours,
Linus Walleij
