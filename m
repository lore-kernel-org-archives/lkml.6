Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42EC3C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 09:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F176420676
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 09:20:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TtYkCx5B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F176420676
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbeHXMyK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 08:54:10 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:40803 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbeHXMyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 08:54:10 -0400
Received: by mail-wm0-f66.google.com with SMTP id 207-v6so953702wme.5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 02:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=4XSlZzbgQGXSqpJ4cHS9qSVl5WxfOUQj4oVmGUPKb2g=;
        b=TtYkCx5BMeFhNmRRs3gJ6IGZaP0auubhQO83C4eEtmxgN1iAMnkhRKNGmPYPJKZiB2
         YTLkgllckFBiHvY+DlsOAhqbtl13cL0JdeSvxDJ8NtzdnR9h2K8V4wXeAdZfJN0NNoOp
         D+bHECtA/Ii+RuuqMjG3PKRL1vZF91bE1QX40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=4XSlZzbgQGXSqpJ4cHS9qSVl5WxfOUQj4oVmGUPKb2g=;
        b=StLsi3ZgPs2L+xrc1uwclRDIpu2K8gTo/s0a+lqoGxBQvzUAqUFgr/7UQQDdydb7E9
         siuDMT5SM4+2AAfQkr4jRVIz0XFyZ9zy9VQCeBDvIzXvZOMZrVW7tLcW+zuofmH6kTwJ
         A6EVLkiJm0NfeQY7OdYmwTqOtBAZq08nTbR2mWXl+FTu/PrAjFl0LVyKUPK5QuA8YBCv
         DOUj4o/jPLBWm6hgt+ZF4FZIy+CzA5TYdIXvxLSzDjaETJY8MIWJtjqtrvmGj7z7RIX5
         91s+IpiR3LPcKqKswaKh3Xgvxx3zmWjvBIFwjCm9Gcie6FFhfblXzXHEdfV3YmfKnWf4
         YPYg==
X-Gm-Message-State: APzg51B2Bw/heGc2A0RCO9IbK4GSm3Z2bBevf9rEx/MwoVbE2pAAsnzA
        uXTz84855QPXawpSp+N7ilqSJnqY4Z7ZYMGW
X-Google-Smtp-Source: ANB0Vda+g/4xinulbuXwRMN6cunXl6TsQLWkhDmW1/nx2ATGfRjUCERnPRbOi83CfzE5Fn2YsSutQQ==
X-Received: by 2002:a1c:8c08:: with SMTP id o8-v6mr814959wmd.60.1535102423595;
        Fri, 24 Aug 2018 02:20:23 -0700 (PDT)
Received: from dell ([2.27.167.102])
        by smtp.gmail.com with ESMTPSA id w18-v6sm16791652wrc.38.2018.08.24.02.20.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 Aug 2018 02:20:22 -0700 (PDT)
Date:   Fri, 24 Aug 2018 10:20:21 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sangbeom Kim <sbkim73@samsung.com>,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH 2/4] mfd: maxim: Add SPDX license identifiers
Message-ID: <20180824092021.GD28860@dell>
References: <20180807161125.18155-1-krzk@kernel.org>
 <20180807161125.18155-2-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180807161125.18155-2-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Aug 2018, Krzysztof Kozlowski wrote:

> Replace GPL v2.0+ license statements with SPDX license identifiers.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/mfd/max14577.c               | 28 +++++++++-------------------
>  drivers/mfd/max77686.c               | 32 +++++++++-----------------------
>  drivers/mfd/max77693.c               | 34 ++++++++++------------------------
>  drivers/mfd/max77843.c               | 19 +++++++------------
>  drivers/mfd/max8997-irq.c            | 30 ++++++++----------------------
>  drivers/mfd/max8997.c                | 30 ++++++++----------------------
>  drivers/mfd/max8998-irq.c            | 18 ++++++------------
>  drivers/mfd/max8998.c                | 28 +++++++---------------------
>  include/linux/mfd/max14577-private.h | 11 +----------
>  include/linux/mfd/max14577.h         | 11 +----------
>  include/linux/mfd/max77686-private.h | 15 +--------------
>  include/linux/mfd/max77686.h         | 15 +--------------
>  include/linux/mfd/max77693-common.h  |  6 +-----
>  include/linux/mfd/max77693-private.h | 15 +--------------
>  include/linux/mfd/max77693.h         | 15 +--------------
>  include/linux/mfd/max77843-private.h |  6 +-----
>  include/linux/mfd/max8997-private.h  | 15 +--------------
>  include/linux/mfd/max8997.h          | 15 +--------------
>  include/linux/mfd/max8998-private.h  | 15 +--------------
>  include/linux/mfd/max8998.h          | 15 +--------------
>  20 files changed, 76 insertions(+), 297 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
