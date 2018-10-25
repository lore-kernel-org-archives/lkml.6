Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81655C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 10:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3076A20834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 10:23:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bjic2nMh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3076A20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbeJYSzf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 14:55:35 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41468 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727265AbeJYSzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 14:55:35 -0400
Received: by mail-wr1-f68.google.com with SMTP id q7-v6so8708317wrr.8
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 03:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=EBLRSkpQSau4aA1QfJ8E5nbsqXuPlwhDWiem3KyCFXw=;
        b=bjic2nMhkrMfTNc0UmPvpA73o1e+xEL7bLITHvuY/tsPnpxP1nlCD4FbZ3+oPHD3An
         hQHnArIle/Za/0yAqT3jqE4Qd6J2D9FL2bdTgSddUo1b58rKzLGirvxmP+hZd4jUalzh
         FlnGMixNA6I4GUqSTp16BSscWExhyRCvoOwfY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=EBLRSkpQSau4aA1QfJ8E5nbsqXuPlwhDWiem3KyCFXw=;
        b=pFjdebtw8wbBxprtoFrF1LYcc+OCggK8YubusSvOsReThjqZzJdJ746DuSv3q4DE1A
         5yEJ/8+JVsgt/IBDs7WkfzgMkjQwjPQ7haf97sMBEohzv8qlhgT9ciw8ItDhN7/S2xGw
         WpVvpyYeCecY28NITzmAox7szjjkRcrG/Xxqu+sazBs+RgzEFaeLeRhwZASMulBVCzNi
         qAI0zH1T34pU37RbpCOm+GzCkNBlzjN/PzQyjZnNByBy4oT1//4CdCwRd5crEvxdgBT1
         W+Kc6Kz8lgIxSprJ8Qn81j5Fu0ums4SvXZBeI+WhovvA6kmtcL7VeqJ+FcPXaH6Dmnea
         rKww==
X-Gm-Message-State: AGRZ1gJkWuj+aQnqLJyIV4tH/Gr0Iaa4m5NFlq6XxOItLcg/scyoXcwt
        PUBwG9OYIwrVaYkFmwkXSq2dXQ==
X-Google-Smtp-Source: AJdET5eUQJFWoyA2vgF6U54/ASTC/Xe9rKyzOXS08Udxzzb57hqJukX/9Gn+ClIMIDWscFMWUu4a2A==
X-Received: by 2002:a05:6000:111:: with SMTP id o17mr1270421wrx.279.1540463007831;
        Thu, 25 Oct 2018 03:23:27 -0700 (PDT)
Received: from dell ([2.31.167.182])
        by smtp.gmail.com with ESMTPSA id u13-v6sm4711211wrn.11.2018.10.25.03.23.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 03:23:26 -0700 (PDT)
Date:   Thu, 25 Oct 2018 11:23:24 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Oskari Lemmela <oskari@lemmela.net>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v5 09/11] power: supply: add AC power supply driver for
 AXP813
Message-ID: <20181025102324.GS4939@dell>
References: <20181023185330.10472-1-oskari@lemmela.net>
 <20181023185330.10472-10-oskari@lemmela.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181023185330.10472-10-oskari@lemmela.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Oct 2018, Oskari Lemmela wrote:

> AXP813 and AXP803 PMICs can control input current and minimum voltage.
> 
> Both of these values are configurable.
> 
> Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
> Reviewed-by: Quentin Schulz <quentin.schulz@bootlin.com>
> ---
>  drivers/power/supply/axp20x_ac_power.c | 94 ++++++++++++++++++++++++++

>  include/linux/mfd/axp20x.h             |  1 +

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
