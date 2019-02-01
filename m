Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4092BC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0665E2086C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:22:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dl7g3EkK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729301AbfBAJWM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 04:22:12 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52495 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfBAJWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 04:22:11 -0500
Received: by mail-wm1-f68.google.com with SMTP id m1so5302613wml.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 01:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=FrKtAAriWrDpqzLQBGDoEfdVX0JvI41I/eUwMG+NGXk=;
        b=Dl7g3EkKVgYXQg+miKwcUqwSvl8LoYdkq8iweCrryQM/+Kwm9xUzNL5KZN5Hb7OC7V
         bG1jOdW0fTsjgBN0byRgXJBxGXew8Ps7YBDzuYjvj7ZNhSYFjxqWGSeK8/5/Vq2CdAdw
         PdW2+ebuqJEzGLpYf828VNuNzOQUHLj2HOCbc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=FrKtAAriWrDpqzLQBGDoEfdVX0JvI41I/eUwMG+NGXk=;
        b=umzDoV2Q95uMpSw5kSX7Br9kXJmIR1YVEcJ9XH+kO8/wsnvByUgjrxdyfH5vosxw6p
         ZRZnsKqt2weycnYODQmfCklw+YUaZfl/GiqCmozI/schbnE9wDZYtR5Utczm5ClbMBy0
         WTIkHXeLEd1yYeTM7pUfqNHkDkZR8lm7hFQ7LCNWUlw6vuNVQ5DexTCnKT/I3MDvWhBZ
         YxTQOgDp+Dll13whcWAQ1dCglk7dWFhsLiWg1gJcX7Vg3lpkfd+D4pLTC4uPeiv+Iker
         jyNIstWab8toLgDqBxvSdmTtH9D0jdXWxgCMfaKYkU4JFoF+m4iCvLnUymgA8I3Vg8tf
         hpug==
X-Gm-Message-State: AHQUAuYxpAhaBwYL2VAm0XvJsynaV9dQMWvdxQqS81XK0R6GzwIhug3y
        bqE5qxtUjviN7k/xsfe0mF9QIQ==
X-Google-Smtp-Source: AHgI3Ib3jFSYWV9ucGK5PX4X8PtgVpvsSZ+RGlJMQqsQc3KWAsHPQ1yKQbOqnuJiSWqx99veGpRSIQ==
X-Received: by 2002:a1c:5984:: with SMTP id n126mr1499320wmb.62.1549012929552;
        Fri, 01 Feb 2019 01:22:09 -0800 (PST)
Received: from dell ([2.27.35.198])
        by smtp.gmail.com with ESMTPSA id g129sm1582925wmf.39.2019.02.01.01.22.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Feb 2019 01:22:09 -0800 (PST)
Date:   Fri, 1 Feb 2019 09:22:07 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Sangbeom Kim <sbkim73@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH 2/2] mfd: sec-core: Return gracefully instead of BUG() if
 device cannot match
Message-ID: <20190201092207.GF783@dell>
References: <1548761153-28114-1-git-send-email-krzk@kernel.org>
 <1548761153-28114-2-git-send-email-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1548761153-28114-2-git-send-email-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jan 2019, Krzysztof Kozlowski wrote:

> Replace impossible BUG() in probe with a proper return.  This can be
> triggered only in case of a clear bug (e.g. adding broken half-support
> for new S2MPSXX flavor) but BUG() is discouraged and the boot process
> can actually try to continue.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/mfd/sec-core.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
