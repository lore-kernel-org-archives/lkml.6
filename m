Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85AF3C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 09:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53FD9206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 09:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="egquyVnI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbfAJJT5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 04:19:57 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39213 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbfAJJT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 04:19:56 -0500
Received: by mail-wm1-f65.google.com with SMTP id y8so586492wmi.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 01:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OD1+wIfwZ2uNgOTjuWtkujAAZ4dcxoAtRZ4lNOYiVCc=;
        b=egquyVnId82EkIKvId07s+fSw7l+2AjlQqHNCecA4S2nQDHzff2QlVWSfUM2xHimB9
         /WakPwhibPhy73FCxFurUDmLbaP+Uc5Is3SyfEVoMqZgrx2DcBRW/jeKTDCIAjBtN3ZT
         28Ldaz61ImMMUnsT8DmFnCoYZkH015Epcx2rg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OD1+wIfwZ2uNgOTjuWtkujAAZ4dcxoAtRZ4lNOYiVCc=;
        b=dMW+b8Xd9F2Kyx4wUTkvfUVI/8NpJ0NCRVccVOoQK/Fg63evIauaHEdoleEZXY54nh
         wG+8zETcn5kN8MckMuDNCFo3pLEotqSvkc7v2d3VBlBRes+mVoClvYKLocORTxLrn1jd
         8g+oojv9sQ+lqUrD2okioASPtVXyX5GhHkb3UhC8YXZ2eipQcSJfRlAtMnl0IoQdqlNY
         cXPP2UQjmWdwYrlME3CWjhC5lXIqA4HyD8H2Jgkbpy0ZOAibUb2534HyjA1Z4pI9Xy63
         ubaY6lVV3x5h3XpXsqWFPn5HFg6c3Y4an8teIwOiJit9c/K3H3ssUR73BhCdVwelQkvO
         v3hw==
X-Gm-Message-State: AJcUukeWr3qF7nFX9XTvlb5CviT5FIFQdQpwVw/+SsY6GeY08Ttx5GFN
        Uoo23u7drMxUotjf7vwUnwU5L/PjMBI=
X-Google-Smtp-Source: ALg8bN6tEh5EhBT5omEz7Hlc8aEQQx5yjIeWSrZgfyhC4eiRkPaneW9viQlLWuEP53B7ZVwmHacr6w==
X-Received: by 2002:a1c:e287:: with SMTP id z129mr8908212wmg.71.1547111994333;
        Thu, 10 Jan 2019 01:19:54 -0800 (PST)
Received: from [192.168.0.41] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id q14sm49768464wrw.39.2019.01.10.01.19.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 01:19:53 -0800 (PST)
Subject: Re: [PATCH] clocksource: sun5i: fail gracefully when clock rate is
 unavailable
To:     Chen-Yu Tsai <wens@csie.org>, Thomas Gleixner <tglx@linutronix.de>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190110062207.18787-1-wens@csie.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <0f9b4bc0-6969-97d3-8ac6-63931ea6db92@linaro.org>
Date:   Thu, 10 Jan 2019 10:19:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190110062207.18787-1-wens@csie.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/01/2019 07:22, Chen-Yu Tsai wrote:
> If the clock tree is not fully populated when the timer-sun5i init code
> is called, attempts to get the clock rate for the timer would fail and
> return 0.
> 
> Make the init code for both clock events and clocksource check the
> returned clock rate and fail gracefully if the result is 0, instead of
> causing a divide by 0 exception later on.
> 
> Fixes: 4a59058f0b09 ("clocksource/drivers/sun5i: Refactor the current code")
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---

Applied thanks.
-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

