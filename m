Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75FB5C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 10:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 387A020840
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 10:24:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="flgpJDpI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 387A020840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727475AbeJYS4E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 14:56:04 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40747 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727437AbeJYS4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 14:56:03 -0400
Received: by mail-wr1-f67.google.com with SMTP id d2-v6so8714598wro.7
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 03:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=IFTJBIqkm5uhvn71bhSAZXj0DCHQvpLAR+sphKQTGcw=;
        b=flgpJDpISvo5WpuJUaeOkjKIiPRByog+BVjwENMM2GR7CAbVgNzu7sB90OdQQr9SZ8
         HkQ+V93EBJYOXQ+Cu/yDSPRNygPV8RTOvac9osv9RbAJbco7XFjTClX939szK6Q8lr4e
         /z3Wq4IeFyOfc8hIL4reEKokHAKWPQ0I2bD/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=IFTJBIqkm5uhvn71bhSAZXj0DCHQvpLAR+sphKQTGcw=;
        b=Ya9tpdPU9Iz2JKtSeguwcSuVJkpl3H3EKvlvXdcvoYZsTpFi0OjMmaSeDiKN2/oEBt
         rtwA/3M9ndF7z8Z64PnRIaDo3A61lupHhzeFqavhhKUBCx7YF1OHiWfJbt1E9F9atlhb
         FGCi1p+akAoKXjsAuC2lhoyFUPa2/oMnCvOSEOyyBOOyKiFNebhLLWCWzyogYHExAoXI
         xbUMHLXlWfBUjRGVoPMOxx7iPSNSm1PIN0J85PP/s0DP+mm1cQ3CFduSx8sLfPbAzpBa
         wCzQk/AYRhBUByJkntcMTXa91Tzal+UK0sUYhGWZG+HjrEFS3GKcgDUPkDX+LIHaCwV6
         JVfQ==
X-Gm-Message-State: AGRZ1gLAe2jcUuy2MFuaJyMOSY89+EQQAuumHEIRMmwUSHAkytolvLWl
        pHEpe/2YGISILryuqmD8IqJlFA==
X-Google-Smtp-Source: AJdET5cqtByrIwaSmLazUSk9nvl8CvSCiLAXFUyX7hxBLkxoYkZmPn9OuMuUfNEQKndTTrNdY7gDSw==
X-Received: by 2002:adf:9563:: with SMTP id 90-v6mr1324412wrs.60.1540463035417;
        Thu, 25 Oct 2018 03:23:55 -0700 (PDT)
Received: from dell ([2.31.167.182])
        by smtp.gmail.com with ESMTPSA id z4-v6sm1350337wmz.14.2018.10.25.03.23.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 03:23:54 -0700 (PDT)
Date:   Thu, 25 Oct 2018 11:23:51 +0100
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
Subject: Re: [PATCH v5 10/11] mfd: axp20x: Add AC power supply cell for AXP813
Message-ID: <20181025102351.GT4939@dell>
References: <20181023185330.10472-1-oskari@lemmela.net>
 <20181023185330.10472-11-oskari@lemmela.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181023185330.10472-11-oskari@lemmela.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Oct 2018, Oskari Lemmela wrote:

> As axp20x-ac-power-supply now supports AXP813, add a cell for it.
> 
> Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
> Reviewed-by: Quentin Schulz <quentin.schulz@bootlin.com>
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> Tested-by: Vasily Khoruzhick <anarsoul@gmail.com>
> ---
>  drivers/mfd/axp20x.c | 5 +++++
>  1 file changed, 5 insertions(+)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
