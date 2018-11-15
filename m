Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A0F1C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 09:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DFA021780
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 09:16:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="TAnBqoMK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DFA021780
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729085AbeKOTXH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 14:23:07 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51480 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728719AbeKOTXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 14:23:06 -0500
Received: by mail-wm1-f67.google.com with SMTP id w7-v6so18024232wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 01:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=Zff/tGd24lFzVIkipQ3x+FartP13WBDgPgNlWhi41us=;
        b=TAnBqoMK7KKdBvaQyfrc3RyAaM7MhkUCZjPUWZCbr8YBAXzcLP1wkIMfmnK6KC2A9S
         pM0ZDAVcwtG4/2N9s/vnfBAhf3QAVITL2+2IZvApzUm1PFHmQK8y6OI6M+RXEcqtyL0m
         h7mwvZFz5sIXVTTS+LbhXEcVVF6Y7Ug5kA5hTDStqJF5/K6U+AhKxS5y3Ak+KWbTRd4g
         BpnOZY0+1GBMeJT6rSlrfFKrr8IUQzKPcoPsVAjp0/gorj0EvNtSGM1gqneJuklbdHLI
         2y9CZ2TypLu721BVN7AGIvyWdgAd5uc8if0979uq14qzosDK0hqMrolPOu7vXuxP05Al
         KyzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=Zff/tGd24lFzVIkipQ3x+FartP13WBDgPgNlWhi41us=;
        b=Lf430r4MCyYaVd72sNK9Xx8+AE25KIuw8I03ZU4O7Ff2iTFG1XMmDXy8tY68QaVHEP
         WIxWkMZDYH/b3plq/rhGg2tdi0UVhTSn7PubAsNqA1JhSj3M/gmpEUAt4GxbgI0AZIE8
         5g8OZHchFlCwpTS/jOnUm0v18htX2srXvLuiNJ9Rw2QAePYmeZ+XJwTgq2iYrw9qu40b
         N+X3l9QUMsCQidTISXXCfsW5l4WHGiOa5PmHxgtiFtvTw8kLd9tkqgEdITTFlwk/788M
         dXlrPZNKkF/sy96G09a7qbOUexLwV84qxreLRTmvBrrMUg8UMAw+Bzll+ZWG4+/7TlqF
         R/Qw==
X-Gm-Message-State: AGRZ1gIPTHgJ6T+HmSwBf0soGzC58C1sBTk5SXROFkhzvPThE5hS+yLE
        /+lM2zUVqkQ/Hxmn8lQaMKD8NA==
X-Google-Smtp-Source: AJdET5f4MEKmhKXu4JBJrSF182R44kTlUO2OxQCkwS0ifJIooxM1IpVlFFuAtIGble4+qVexHN7vPg==
X-Received: by 2002:a1c:414:: with SMTP id 20mr3269959wme.67.1542273367169;
        Thu, 15 Nov 2018 01:16:07 -0800 (PST)
Received: from boomer.baylibre.com ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.gmail.com with ESMTPSA id b5-v6sm20662014wma.17.2018.11.15.01.16.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Nov 2018 01:16:06 -0800 (PST)
Message-ID: <3741d17870e51342e7251118f73845667c0f7e14.camel@baylibre.com>
Subject: Re: [RFC v1 4/7] clk: meson: clk-pll: add the is_enabled function
 in the clk_ops
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        narmstrong@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org
Date:   Thu, 15 Nov 2018 10:16:04 +0100
In-Reply-To: <20181114225725.2821-5-martin.blumenstingl@googlemail.com>
References: <20181114225725.2821-1-martin.blumenstingl@googlemail.com>
         <20181114225725.2821-5-martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-11-14 at 23:57 +0100, Martin Blumenstingl wrote:
> Now that we have a utility function to check whether the PLL is enabled
> we can also pass that to our clk_ops to let the common clock framework
> know about the status of the hardware clock.
> For now this is of limited use since the only common clock framework's

Still, it is nice to have ;)

> internal "disabled unused clocks" mechanism checks for this. Everything
> else still uses the ref-counting (internal to the common clock
> framework) when clk_enable is called.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  drivers/clk/meson/clk-pll.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/clk/meson/clk-pll.c b/drivers/clk/meson/clk-pll.c
> index b46cca953f4f..65eeae0989d9 100644
> --- a/drivers/clk/meson/clk-pll.c
> +++ b/drivers/clk/meson/clk-pll.c
> @@ -309,10 +309,12 @@ const struct clk_ops meson_clk_pll_ops = {
>  	.recalc_rate	= meson_clk_pll_recalc_rate,
>  	.round_rate	= meson_clk_pll_round_rate,
>  	.set_rate	= meson_clk_pll_set_rate,
> +	.is_enabled	= meson_clk_pll_is_enabled,
>  	.enable		= meson_clk_pll_enable,
>  	.disable	= meson_clk_pll_disable
>  };
>  
>  const struct clk_ops meson_clk_pll_ro_ops = {
>  	.recalc_rate	= meson_clk_pll_recalc_rate,
> +	.is_enabled	= meson_clk_pll_is_enabled,
>  };

Looks good to me
Feel free to squash this with patch 3.

Jerome

