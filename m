Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 855D7C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F08720850
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:07:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TJWwnZNP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F08720850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbeH2QEB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 12:04:01 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:40450 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727322AbeH2QEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 12:04:01 -0400
Received: by mail-io0-f193.google.com with SMTP id l14-v6so4254467iob.7
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 05:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=krdFtVzvmU5wgkuZYkUMCx/jc89hjFY1HwZO2lVlNaI=;
        b=TJWwnZNPzT8lQ5+Ed5oCYrXYRsoTxz6+G6nZKEuDZ4zy9TBEFloxEzeJRTBymCyik1
         rOeI1BBhk5oT4hrHe3V0Je/idconxu6dzG106wmARphlUWs6ZBK/888ota231m2rU57d
         2RzIa26Wm2QFrLgFzpsUG12NFbzlEOQSrL0y4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=krdFtVzvmU5wgkuZYkUMCx/jc89hjFY1HwZO2lVlNaI=;
        b=hrcC9apuJTCXwOaM4gsfk28rEfqpRGZWqF3IgoX8DjIRibclxfsyZ2IkeUULdiiAy6
         nlXARNma8HptCEDkNUtbthwMyCV8NNo3QO7CaBMbsuxbJZh9Acjseg+JZAUdO0lnjy7o
         SqeW2Ac84QN6TKCSxLqY4iDqvgWcn5V4mUHAeDGH9QHRSsDJs2cXvYmHz//2MwFY6+9J
         MFbrzrYeZE2i1orU/ctbItmX3Ts4EXJoaB8SLhQbXdc6lJomb3RoA5E3w1A3P5A6Atse
         JtlwVpjFZBOU0S+H5VaP60txfOgDtJ8fwrXHQx3FJvAboQdQLVJq2OX+Fp3wqQiiTVSr
         drmA==
X-Gm-Message-State: APzg51D9OmRt4zQcP/zXVFEfOCAMvLmWXbjaE/IucfvEyGS3yNQ9eVNW
        BQwCcbhbyQ93x0EqHtlQC36fZaI/qqFytRLLwTqMqw==
X-Google-Smtp-Source: ANB0VdY661w5neXOqgdXwcFUsN+c8DzdLpM+Nwn68RpWoN/GkgQH5CcBDqvszRIryHmBp+1GgzXSj61FHRLnJq1jLb0=
X-Received: by 2002:a6b:630a:: with SMTP id p10-v6mr4798460iog.175.1535544445313;
 Wed, 29 Aug 2018 05:07:25 -0700 (PDT)
MIME-Version: 1.0
References: <20180828015252.28511-1-robh@kernel.org> <20180828015252.28511-40-robh@kernel.org>
In-Reply-To: <20180828015252.28511-40-robh@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 29 Aug 2018 14:07:12 +0200
Message-ID: <CACRpkdY-ChkLS39vz6rDUdnR7zuxfu=aD7tky__26fjMP+th1w@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: Convert to using %pOFn instead of device_node.name
To:     Rob Herring <robh@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Sascha Hauer <kernel@pengutronix.de>,
        Sean Wang <sean.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        ext Tony Lindgren <tony@atomide.com>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        Patrice CHOTARD <patrice.chotard@st.com>,
        Barry Song <baohua@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 3:55 AM Rob Herring <robh@kernel.org> wrote:

> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>

Patch applied along with the thundering hoard of ACKs.

Yours,
Linus Walleij
