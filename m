Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE28C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11BCE21104
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="da7P2cV1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11BCE21104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728192AbeK1UfQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 15:35:16 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40887 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727803AbeK1UfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 15:35:15 -0500
Received: by mail-wm1-f65.google.com with SMTP id q26so1798486wmf.5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 01:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=xeEL5AiDDpS3uWc6kXgAMTIV4QPEcs7rg+eQpW7gDco=;
        b=da7P2cV1oY8xGtaEyrZHE5xclVq9WUWvst1ZIxxBZQ8p3hho/dKGWKKwEY8pHRZxqM
         khE0KaFISYCFlVCKnNdtgA1smFZwO46fRBvRGocuAKg2a/bWKbCOzOR5e9vCyqVR69ud
         pi1+8yK3jsNLtK5MrJAABt9l6tIQlN4e/D14Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=xeEL5AiDDpS3uWc6kXgAMTIV4QPEcs7rg+eQpW7gDco=;
        b=d19YuKSSZVfEw7B+Q+FAP1PVBMW/sNhNKie4jZXoprgFykWxDkmdnrBOPBq4Zf0/tW
         fRV77taip24bfxyZBZn8bTjln6cmXG86hEVtcOiUQcMmUFbUxmpsO/BAGwR6Xw/RHlVP
         rRlrZy2/hwU3phT8QLxZjqD9ec9QiLeUqf3oXY/kWyDi9yFiiixW4LsdtSvGhpu8yX18
         Ww5X6O8MI9N53y6wsYkke/P/l9XHZUGAqNuao3YvV04twfLnwLmCSqRTFUhYLv7yJRTd
         gXYCg8RT7s9VihmGRDaMTpMOsGwQo+lpg2Nml4Xgq14eEVaitmbHUtuQ+IaO0YUgbJg5
         471w==
X-Gm-Message-State: AA+aEWYLbtGlOl6D6H+JwN2FFRSe51dZY1OP9crXH31jJ2729FpkEeqg
        aQhhZbErIHhA6IymfbWM3cKJBQ==
X-Google-Smtp-Source: AFSGD/XhPs8Th7MSxOpZ0I48D72FyVn3oBo8HJXu+V0/W4hkVl1Z8t8VTTlpX1i9LDWOU8xVqwRDJg==
X-Received: by 2002:a1c:8484:: with SMTP id g126mr2111316wmd.117.1543397654034;
        Wed, 28 Nov 2018 01:34:14 -0800 (PST)
Received: from dell ([2.31.167.233])
        by smtp.gmail.com with ESMTPSA id i16sm2424058wmd.28.2018.11.28.01.34.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Nov 2018 01:34:13 -0800 (PST)
Date:   Wed, 28 Nov 2018 09:34:11 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Cheng-Yi Chiang <cychiang@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        alsa-devel@alsa-project.org, dgreid@chromium.org,
        tzungbi@chromium.org, Rohit kumar <rohitkr@codeaurora.org>
Subject: Re: [PATCH 1/3] mfd: cros_ec: Add commands to control codec
Message-ID: <20181128093411.GC4272@dell>
References: <20181127120041.90759-1-cychiang@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181127120041.90759-1-cychiang@chromium.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Nov 2018, Cheng-Yi Chiang wrote:

> Add EC host commands to control codec on EC.
> 
> Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
> ---
>  include/linux/mfd/cros_ec_commands.h | 94 ++++++++++++++++++++++++++++
>  1 file changed, 94 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
