Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E8C2C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6426D20870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:28:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bEpkBLfY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6426D20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729490AbeLMN2I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 08:28:08 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38370 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729467AbeLMN2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 08:28:07 -0500
Received: by mail-wr1-f65.google.com with SMTP id v13so2015856wrw.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 05:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=++tRpRVFmyDdNBbWnm7w53xwo4Ppov3K25bE9jo+hkY=;
        b=bEpkBLfYKcwnFAJHZFxNN2ELYIerXSau8LGF5JLhFbI2FBdY1k267N2cWpHTDXSJnS
         wYa+hZZIHmpf67DMeiM46kS/0SDJh9TFIjPTDzzOkXNXbGuJDCZOcN8n5qPVTdsbw/yZ
         5lhi22uLeQ4j6+uJXT5icbdMT0CptBpmTFx9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=++tRpRVFmyDdNBbWnm7w53xwo4Ppov3K25bE9jo+hkY=;
        b=WwNuSIm+wxiqdOwyyyYnfnSB971MXfjyHBnSnhKREhzo41BX5QvACmtu/xfD4pY6Lu
         IHMKVEBd62sT2oLuwignuVav34z8pEz5osYuhJDU39Gh/Zf5TUtmjZ9KT8V/F4E4OPpU
         3/hT4Sg6glF6YxE4OOQOl+jaCaTlfGS2glmB0x7SUjLYyLQzyAEtEV89+IjJHAtKJl9b
         bZe9KDwIVUy36Wg/psA3WYa3XqIBq/y11LgzK6pGTNNAsMTjw+fM6AMC5Q6CLTZRId3x
         MIIHXK2M9KBi0ijpOgVX+sj7zWSZS2CMX9lmXOeVf31e9Nr1HyavyoD93CSNrvKwsAqU
         Txjg==
X-Gm-Message-State: AA+aEWaWPNRZApxxHydtadeeWtjD1T0sPngkvjdVDwIZw4FpMGOvpFhZ
        hVlVlJxb1JRRnQtiXlTBf55fyg==
X-Google-Smtp-Source: AFSGD/UBBBTchFxEtrQ7Zc3RJYAZQX7ZpjFwSYd+W7XF8bmzCAvldJL3PiB4hQIeSJirpFpmYjVwpw==
X-Received: by 2002:adf:ee46:: with SMTP id w6mr1609250wro.261.1544707685182;
        Thu, 13 Dec 2018 05:28:05 -0800 (PST)
Received: from dell (host109-155-202-221.range109-155.btcentralplus.com. [109.155.202.221])
        by smtp.gmail.com with ESMTPSA id z12sm2432990wrh.35.2018.12.13.05.28.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Dec 2018 05:28:04 -0800 (PST)
Date:   Thu, 13 Dec 2018 13:28:02 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Priit Laes <plaes@plaes.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Olliver Schinagl <oliver@schinagl.nl>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Subject: Re: [PATCH 1/8] mfd: axp20x: name voltage ramping define properly
Message-ID: <20181213132802.GQ4497@dell>
References: <cover.4110554ae84987dedb8b58888a8a63d6b7f98c72.1544466940.git-series.plaes@plaes.org>
 <01367c4f4f1e174fefbef9aac645f6792bda07e5.1544466940.git-series.plaes@plaes.org>
 <20181213115506.GD10669@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181213115506.GD10669@sirena.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Dec 2018, Mark Brown wrote:

> On Mon, Dec 10, 2018 at 08:42:12PM +0200, Priit Laes wrote:
> 
> > Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
> > Signed-off-by: Priit Laes <plaes@plaes.org>
> > Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> 
> What's going on with this patch?  Will you be applying it or is this an
> ack for it to be applied with the rest of the series?

I don't have anything else queued for include/linux/mfd/axp20x.h, so
you can take it if you want.  Just make sure you 's/-for-MFD//'. 

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
