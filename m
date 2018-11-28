Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB6DC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C1DD208E7
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:31:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eb6Jno3N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C1DD208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728391AbeK1UcP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 15:32:15 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44870 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728123AbeK1UcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 15:32:14 -0500
Received: by mail-wr1-f68.google.com with SMTP id z5so21219121wrt.11
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 01:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=GeHRq/JY98mF5CvbyFvwQS02qsxFZnKeNmR3jRz+fmA=;
        b=eb6Jno3NnJorkXwUrEn5eHZQwHH4z7nEC/K1SN7KkvsARWaFSfzi7LPdtv5TcDVV9B
         sNrSPV/SoefoPIIugu6Dba/tU9KWwqvRpolm0Y0rNYLn4pFc2yl7bRUGbRdv72l1MH34
         S5ASN69iiYooLLfeO6Eew5bFNAkEKOQVfF12o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=GeHRq/JY98mF5CvbyFvwQS02qsxFZnKeNmR3jRz+fmA=;
        b=j9/kRLNQYaTB182/d1McihcOVLHwmgH46lI0l5UkxqHBzu4gEm38VTH3OS6rUFaHX9
         zBaofclyEzV9RbGKV72v4gXunDzMdNWbAbWcgR9auw4/Z2NptbmVVYrUAOY1FmNMkWgq
         btt6EfVtMegM8gkWhFCG3pNYkYp8mfdCdRXDgwvOBO9lsERYBk3kZ2QQfWbeFZgpqf1y
         e/acF9ZyuwgaPAX5s8wmtNhmFXXHsRc1KKr8lxX5aOia9Y64NYTDdJGDmWP0ayEvIAD+
         CzXCYMSZ+1H5RPn05+bTKgXONCh/Ulg7w73R8MI0AKWepwvgzUmnDq9lCnRaAL88n6zm
         xmTA==
X-Gm-Message-State: AA+aEWYsZDll9UVajvIWndFX2DCtXRilPE6GI/qEkBIZnqhQ6ungKEfc
        W2kPJ/iLzMAUZst6xn0JY24JaA==
X-Google-Smtp-Source: AFSGD/Xhep6T3pZBfICLIAZblFt2RTG4zbn9afhguVd12TDubDefZVvQpRgC4muSHEzsLQs1GYqRdA==
X-Received: by 2002:adf:f009:: with SMTP id j9mr29873790wro.170.1543397473642;
        Wed, 28 Nov 2018 01:31:13 -0800 (PST)
Received: from dell ([2.31.167.233])
        by smtp.gmail.com with ESMTPSA id 14sm2657091wmv.36.2018.11.28.01.31.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Nov 2018 01:31:13 -0800 (PST)
Date:   Wed, 28 Nov 2018 09:31:11 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Priit Laes <plaes@plaes.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sebastian Reichel <sre@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        Olliver Schinagl <oliver@schinagl.nl>
Subject: Re: [PATCH 07/14] dt-bindings: mfd: axp20x: Add software based
 soft_start for AXP209 LDO3
Message-ID: <20181128093111.GZ4272@dell>
References: <cover.156212c9c5df493e098556cad9793a07dcab5e32.1543245984.git-series.plaes@plaes.org>
 <2cd75ee27982f3be0d86104d80eaa13efeb2c65d.1543245984.git-series.plaes@plaes.org>
 <20181126165822.GJ9715@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181126165822.GJ9715@sirena.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Nov 2018, Mark Brown wrote:

> On Mon, Nov 26, 2018 at 05:27:48PM +0200, Priit Laes wrote:
> 
> > +- regulator-soft-start:	enable the output at the lowest possible voltage and
> > +			only then set the desired voltage
> > +			AXP20x/LDO3
> 
> This is a generic property, there is no need to document it in each
> device binding.

It's not unwelcome here though.

Particularly with such a nicely written up commit messages.

I'll leave it up to you, but it's fine by me.

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
