Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB03C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 08:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4F8F2088E
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 08:27:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RBGe4Uc8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4F8F2088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730001AbeG0Jr5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 05:47:57 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:40372 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729431AbeG0Jr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 05:47:57 -0400
Received: by mail-wm0-f66.google.com with SMTP id y9-v6so4595399wma.5
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 01:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=PuGq1tbjCZwK/sq7lvHLI+L+W1AXG4/N2vYnAmAEOYs=;
        b=RBGe4Uc8BElDDKkWNlNiGNNr/rsA/4sqI3dKn+4cObhGh0DeATHRxJs+gF0Ab2ka7L
         Oqm3liT1Pc4vOYwEkqepvo3E9C6xazs4OKFZdPQthOVwfo3B623Ss5lp5kl3D0FaADBA
         2lpyn0hx+/dZOtzqslakVuTfx7VQaafEst/+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=PuGq1tbjCZwK/sq7lvHLI+L+W1AXG4/N2vYnAmAEOYs=;
        b=UacIjo7xyy7tY1mRR0SZ4aqPg07mrG4zLuyAMe8Sszb3l8coxVEi1cEOzJs32RdK9l
         kPg4zklMWDMaZXAe5OAStce9zu1F3RBlmqk/dTldaUEkbnuy24+wvonbiTHm674rDLRI
         nfzGN0v5AMefhqdrZtzhWtbzS4AizNDeigk4D0u8TlLKLdlR5kS8J+6vJJSw+xDW00qq
         xEAKNx6dMMiX8m48aIQKFdSIKpYw/7rajFWMZoF+7HvU2cgjtw0F0QJXm+H1pibM1Eul
         TNj3oPPycuT9AWHYV/VFdmIaurtK7TSiCt7Cm1R4MkbchXfYfSPEnrMG6ltqvAiES7m4
         M4Qw==
X-Gm-Message-State: AOUpUlEdCxMCgf3oMOH62C9vQxSkNTWBfucAca4NbPRv0vB4CYTsXHl8
        PeWnYaHrLON82iFAhu/wylIY6A==
X-Google-Smtp-Source: AAOMgpfc/QEIjk+J4xvpEfK9XdzxpBtbxU9iaQft+RtVUGicp3/0Y43pDzZK/ZiAAahASBnB92lyig==
X-Received: by 2002:a1c:ac42:: with SMTP id v63-v6mr3741696wme.92.1532680028902;
        Fri, 27 Jul 2018 01:27:08 -0700 (PDT)
Received: from dell (host109-153-79-7.range109-153.btcentralplus.com. [109.153.79.7])
        by smtp.gmail.com with ESMTPSA id n12-v6sm7695167wrm.62.2018.07.27.01.27.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Jul 2018 01:27:08 -0700 (PDT)
Date:   Fri, 27 Jul 2018 09:27:06 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Sangbeom Kim <sbkim73@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH] mfd: sec: Export OF module alias table
Message-ID: <20180727082706.GF4628@dell>
References: <20180725155302.4718-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180725155302.4718-1-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Jul 2018, Krzysztof Kozlowski wrote:

> In case of Device Tree platforms, even though the Samsung PMIC sec
> device is instantiated from DT, the driver is still matched through I2C
> module alias.  That is because I2C core always reports an I2C module
> alias instead of DT one.
> 
> This could change in the future so export DT module alias.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/mfd/sec-core.c | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
