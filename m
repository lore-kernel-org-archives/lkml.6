Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E636BC32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 08:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A77542087D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 08:40:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jixjxk9W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A77542087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbeJKQGi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 12:06:38 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:37751 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbeJKQGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 12:06:37 -0400
Received: by mail-io1-f67.google.com with SMTP id m16-v6so5990342ioj.4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 01:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FcykFZeYZ4ioCagMTiF+1qbXALsjWce15a48uHVgIj4=;
        b=jixjxk9WbGaeV0jr0UCG10wvkNQfkk60g9HJhCpbY8k426cDE7BXRlt1yD2r6DbYPa
         ghUZvTfCq08RwkQKvF3CApZ8CXiBJbCswJRHCkNTh8wkRajlmRSVQ9CmUkPHOEQCiy+b
         LHCvXOlZqDCBgkZczTCu0fMzPZ3ja5jh+XjqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FcykFZeYZ4ioCagMTiF+1qbXALsjWce15a48uHVgIj4=;
        b=GBN9pmrOUj5AS+gdgJM7l/kNa8Ki/MD7Dyxm74ZCwejmefRyLbZ410Poju99ITmf2c
         z5MMdeBoZv0qtdCVPDElrj8BtowA2p50bdVUGx3d7YKgzPmXxAwluP5zoNTJN0SjK4QM
         wK7PjvNyJ8u+cdoq5jey3g9qZpG7NoFGZZ3w1ICC5NFz3RCKd+lHRJ4AL1RdOOfYH6bC
         wmTBVOujBdVpNT9YeI9/rgB09vRMOor9ngT/7YkcmHOTNbCccmG9fX5QvVlk/lfFiVng
         RX/C+YLGJ6m/RVhwwBQRadBu0GQ9UtEVuamtvWAkNTwu8qtWzEbUT/C5y9PnNWZNJQEk
         WFLA==
X-Gm-Message-State: ABuFfohel3KU2ZKBrtAgpPbH+nUMaACeAHeqrGR9Bj9Xeomviugy+14M
        i+ApctBg97p3cGRuSv2qEIFnuzzLuNswcF8BhNZBI8bk
X-Google-Smtp-Source: ACcGV63nIeSePohS58Y7yneEWg3WiLy6brB4eUPvNZfKenk5pQuomFJ4pilrrZ5/+uWKjuiELTBmzxt5UImgUWlKdPc=
X-Received: by 2002:a6b:c3c4:: with SMTP id t187-v6mr418921iof.304.1539247221368;
 Thu, 11 Oct 2018 01:40:21 -0700 (PDT)
MIME-Version: 1.0
References: <20181010151313.GA16854@embeddedor.com>
In-Reply-To: <20181010151313.GA16854@embeddedor.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 11 Oct 2018 10:40:08 +0200
Message-ID: <CACRpkda8Fo6ubO9XuDXC9tcLWPNp_6TMf6-g9DUxdU6JXa0Veg@mail.gmail.com>
Subject: Re: [PATCH v2] pinctrl: madera: Fix uninitialized variable bug in madera_mux_set_mux
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>, patches@opensource.cirrus.com,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 5:13 PM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:

> There is a potential execution path in which variable *ret* is checked
> in an IF statement, and then its value is used to report an error at
> line 659 without being properly initialized previously:
>
> 659 if (ret)
> 660     dev_err(priv->dev, "Failed to write to 0x%x (%d)\n", reg, ret);
>
> Fix this by initializing variable *ret* to 0 in order to
> avoid unpredictable or unintended results.
>
> Addresses-Coverity-ID: 1471969 ("Uninitialized scalar variable")
> Fixes: 218d72a77b0b ("pinctrl: madera: Add driver for Cirrus Logic Madera codecs")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
> Changes in v2:
>  - Initialize variable ret to 0 instead of -1. Thanks to Charles Keepax
>    for pointing this out.
>  - Update subject and commit log.

Patch applied with Charles' ACK.

Yours,
Linus Walleij
