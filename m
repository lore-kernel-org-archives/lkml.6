Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C3BC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC53920660
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:26:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eP71WwXN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC53920660
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbeK1U1h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 15:27:37 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51268 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727662AbeK1U1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 15:27:37 -0500
Received: by mail-wm1-f67.google.com with SMTP id s14so1552961wmh.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 01:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=bQ0PvKV8MmLUXYapH9qXp2B/KT0NYSi+FvGczcnm2Og=;
        b=eP71WwXNRY1aK/HDTU0E3ATVDrl6vFY7xM2SYxbRPcgA6DjY0/TofDZRjpqNauAkFA
         BOsrxcspAtVjXQzNGuhBYIk/aQxPeXQ31t+aPNb41Oxi39ZD7QCbwQnvLf86e92yYXn7
         jKO1t5xae/I7sz4L3fyyjUJPstX2/0lzWGAZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=bQ0PvKV8MmLUXYapH9qXp2B/KT0NYSi+FvGczcnm2Og=;
        b=nXJEhoDLqfHPkAi4Ruz4UnsgFhWvM84N9EpPPixxygqKEPi5PCZrRLGQnM6Mg5+28m
         8+aUbyfvHT0Kvwz/iw2hgRvIHHwdcIiBPVceyOBiKU6+rL8aULSQIrSDnHc/5EVMJkPq
         D9zkNozZb+nML6HE6sRhf4AMoGaoZAG6Jsl6Gcr+sRs60SEHKr6Iyd0oVX0d6gxn7OhC
         KNkAV/EZFtIrd7YES873brAvtZK3HwCbzeeFJa/8tKp7g+4PTwGmi8r+ntcuXU+pO9Iq
         52rpp8I7Kldw5AEzDH+Wvjrw8/oTBmETvJIWvWAFVDeqX6EuejeabhWc2bUC07C9sRut
         rCqA==
X-Gm-Message-State: AA+aEWa4keh7y/Cfr2EwbjLwSZ8xwpoZUjqYoSiIKc2/VUD3pA2R/eSv
        bhZZdmdbVr4Uj3MPXGRihAppcA==
X-Google-Smtp-Source: AFSGD/UeA9cNNRu0dP/hlgXgXzoZGsgEMhJxUzcL9JzqIu+dPDBoVY86OXDppNZjOxEzlkxxc3jhDg==
X-Received: by 2002:a7b:c191:: with SMTP id y17mr2022605wmi.10.1543397196697;
        Wed, 28 Nov 2018 01:26:36 -0800 (PST)
Received: from dell ([2.31.167.233])
        by smtp.gmail.com with ESMTPSA id r76-v6sm1873668wmb.21.2018.11.28.01.26.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Nov 2018 01:26:36 -0800 (PST)
Date:   Wed, 28 Nov 2018 09:26:34 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Priit Laes <plaes@plaes.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sebastian Reichel <sre@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, Olliver Schinagl <oliver@schinagl.nl>
Subject: Re: [PATCH 02/14] regulator: axp20x: name voltage ramping define
 properly
Message-ID: <20181128092634.GX4272@dell>
References: <cover.156212c9c5df493e098556cad9793a07dcab5e32.1543245984.git-series.plaes@plaes.org>
 <66ac03ac0e34e196e0469927c0feb3c98bc35837.1543245984.git-series.plaes@plaes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <66ac03ac0e34e196e0469927c0feb3c98bc35837.1543245984.git-series.plaes@plaes.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Nov 2018, Priit Laes wrote:

> From: Olliver Schinagl <oliver@schinagl.nl>
> 
> The current axp20x names the ramping register 'scal' which probably
> means scaling. Since the register really has nothing to do with
> scaling, but really is the voltage ramp we rename it appropriately.
> 
> Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
> Signed-off-by: Priit Laes <plaes@plaes.org>
> ---
>  include/linux/mfd/axp20x.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

This is clearly not a regulator patch.

Please change the subject line to "mfd", 

Once changed you can add my:

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
