Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C96C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B76F208E7
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:33:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="N+Oxe8Tp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B76F208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbeK1UeL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 15:34:11 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46132 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727678AbeK1UeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 15:34:10 -0500
Received: by mail-wr1-f66.google.com with SMTP id l9so25519466wrt.13
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 01:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=EuclJJAAMThTU9zqptis8KNBaDh0xTyk+XNoQVPuTno=;
        b=N+Oxe8TpG8N8ewgjva6w3NNHsopXrPJbiYwQbf6mRIR7lPFNiVULWmRUa7+favPd5c
         EZiYMN2vevjWMlIJVfkHe+7qqg367a2AXdaQstFEsDGbAX1zy0wOYHDmDgYKydd+S+0C
         aPUEIlNOroUO7XO2Cysh0I1BmJiptRl4OoAJc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=EuclJJAAMThTU9zqptis8KNBaDh0xTyk+XNoQVPuTno=;
        b=gzm25ZFKdf1aB0xaV/aucgBBh6SMDTKjuvuUCkWp722Xnaa1fDEh1N0Olom1kdhfOT
         wNXsxsLAQKVA+/qzKLhO0oywLPn3PJzN67nKDMCMWNVieO+5Lr2wdT9QDLbAWhIcx+DD
         wdhdyKXXpYjUPjf25mjm0yJXG8dRRKngMujPqrnrzKA/W1faW5cit9zNDa8mfgVlOEO5
         rT2D+FhsdfIEZozQ1B/jqSwduRwftcawDl93n/xJwiLZVtrwyIhTVEKzS1LU+Zmn6L2A
         X90iJd4nr790ERXZyFsUdpMYFkpqQYVZR6lR/Txzmm2Hw+aCxSMLGQgV+RkcQELeZuc0
         4G8w==
X-Gm-Message-State: AA+aEWb8sNT2vYscEsJ0HpSt/vtAwF5m4pPMDKYiZhSih1+EPe74Bz77
        SbLMYn08qccgulykfTFvW8RrVg==
X-Google-Smtp-Source: AFSGD/V28ycB3xNonmikRRNgX0ZBBJJZ6Lq2gpLG1kSIDX7pH7db1xByEW7bP0AB1hw6JVq3e6cqWQ==
X-Received: by 2002:adf:8421:: with SMTP id 30mr31313337wrf.153.1543397589321;
        Wed, 28 Nov 2018 01:33:09 -0800 (PST)
Received: from dell ([2.31.167.233])
        by smtp.gmail.com with ESMTPSA id b18sm4323684wrw.83.2018.11.28.01.33.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Nov 2018 01:33:08 -0800 (PST)
Date:   Wed, 28 Nov 2018 09:33:07 +0000
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
Subject: Re: [PATCH 11/14] mfd: axp20x: Clean up included headers
Message-ID: <20181128093306.GA4272@dell>
References: <cover.156212c9c5df493e098556cad9793a07dcab5e32.1543245984.git-series.plaes@plaes.org>
 <1567a4f47e802c592a3f109c7b5e0656528e2a5c.1543245984.git-series.plaes@plaes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1567a4f47e802c592a3f109c7b5e0656528e2a5c.1543245984.git-series.plaes@plaes.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Nov 2018, Priit Laes wrote:

> From: Olliver Schinagl <oliver@schinagl.nl>
> 
> Add the bitops.h header as we need it, alphabetize header order.
> 
> Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
> Signed-off-by: Priit Laes <plaes@plaes.org>
> ---
>  drivers/mfd/axp20x.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)

Nit: You are making 2 separate functional changes here.  In future
please submit functional changes in separate patches.

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
