Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2AA2C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 16:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 767FF2171F
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 16:23:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qxmV1vr3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730435AbeLOQXg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 11:23:36 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44102 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730075AbeLOQXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 11:23:36 -0500
Received: by mail-pg1-f194.google.com with SMTP id t13so4095095pgr.11;
        Sat, 15 Dec 2018 08:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XEm2PpBIQgpJh9GL6682ebASDp09765BQCtLbhH+b1Y=;
        b=qxmV1vr3BMNbwNfeFATWXws7cjf9CqjjxdJzFEmnlYcMqVa6N3JWmON78A6GvusAWf
         BjnTR8JXrrV42UNZEFas+90miyBrln1P7GkzsEmeJN3tCMQKl6oI2nrJ0Ew1+H8gHmlU
         48pmfkFwrLoib/NEPt3af6o/C32E1RJXU4YkYkOGpENLGUBrExhpc/VSq9/EPTH85Qvg
         Gjeo3BzK7u8n7pcQg3S2AqW8GC08FlYj2c4VFIXJ6rg1PgozjARYsYEPojiyle2brxj6
         qb6IzSWhOCe1u29DCNe169HWanLB95lDQvg9KWpUR133ayMeMyRN0GSZjw8kGISOUPKd
         ZngQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=XEm2PpBIQgpJh9GL6682ebASDp09765BQCtLbhH+b1Y=;
        b=nRr3YQA9KL8yM1xRl6bgkWANfQLSRyguGRl8tr2lXBPy1nBID8hJuLC8Wdmo21yMEZ
         w5l2c2uFMikiJV1gXGSsJMmXH43Lupj9A9y0dP6Gm+oSpYdBZxDOMPesWrGs+ccVbzB2
         dbPYnylhrXaWqvnpez27jDh9gtL2mel4ETd3SAhnOzjTuXhGsjEXEUsBTiM8Ldzo0+Tu
         jWgy/NfenBOKCsIWOI0IrIofmBWS4reQp71tRqW2shfoO+zrzQzRU8an4IifcIwE08FY
         9MWpvjG0OweIHGc/k4P98MJ7IqiYXNsB3jFMM2uiHirtp4XlYORncvq9AeetIr922dHF
         +5Ng==
X-Gm-Message-State: AA+aEWZeFIVO8F0L1g/X8bslSInSIrKVsk8AfLR4VELsMQ/Eg8BaQ3Gi
        LyIYyxfGUE8YvgowO78zi8U=
X-Google-Smtp-Source: AFSGD/XfUPrWsHO376KJp2m+hT3VAujWA0Nnp1hEK/3b91dMyxJZQFoyXHdaNNu1JzA/pWEtthtZzQ==
X-Received: by 2002:a63:f710:: with SMTP id x16mr6568257pgh.322.1544891015157;
        Sat, 15 Dec 2018 08:23:35 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r6sm19873893pgk.91.2018.12.15.08.23.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Dec 2018 08:23:34 -0800 (PST)
Date:   Sat, 15 Dec 2018 08:23:32 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ryder Lee <ryder.lee@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-watchdog@vger.kernel.org,
        Weijie Gao <weijie.gao@mediatek.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: dt-bindings: watchdog: update bindings for MT7629 SoC
Message-ID: <20181215162332.GA30762@roeck-us.net>
References: <55d108719233b3c30c747e75a010b9e64681af09.1541573395.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55d108719233b3c30c747e75a010b9e64681af09.1541573395.git.ryder.lee@mediatek.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2018 at 03:10:36PM +0800, Ryder Lee wrote:
> This updates dt-binding documentation for MT7629 SoC
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  Documentation/devicetree/bindings/watchdog/mtk-wdt.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt b/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
> index 859dee1..8682d6a 100644
> --- a/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
> +++ b/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
> @@ -8,6 +8,7 @@ Required properties:
>  	"mediatek,mt6797-wdt", "mediatek,mt6589-wdt": for MT6797
>  	"mediatek,mt7622-wdt", "mediatek,mt6589-wdt": for MT7622
>  	"mediatek,mt7623-wdt", "mediatek,mt6589-wdt": for MT7623
> +	"mediatek,mt7629-wdt", "mediatek,mt6589-wdt": for MT7629
>  
>  - reg : Specifies base physical address and size of the registers.
>  
