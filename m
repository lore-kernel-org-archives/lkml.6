Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD78C65BAF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 06:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76C30205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 06:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="S1+lRXL1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76C30205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbeLJG1k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 01:27:40 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40827 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbeLJG1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 01:27:40 -0500
Received: by mail-wr1-f66.google.com with SMTP id p4so9173542wrt.7
        for <linux-kernel@vger.kernel.org>; Sun, 09 Dec 2018 22:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=GgtI/LiKafLWJ7kHLvEEuNGmxZPMICEtdKv4VHE8MM8=;
        b=S1+lRXL1DM/hVE5GXqSJmqrCRiGnRMaX2mSqbYLj0g4fuh7IKKGCUYA15s8E6VTaJk
         J9sBkoTbBOlsQcVxXoL/o1N8DA+5elfVXYAz+ogrec7aph47qHGWF9rzq0tk0qCzOQPp
         FODFTztHoNpAl6DXP7VXiQd8N6BJhgSLE86qk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=GgtI/LiKafLWJ7kHLvEEuNGmxZPMICEtdKv4VHE8MM8=;
        b=cc0QNdKU3ePX3UgRMHD6UoH9ykatiHY8+EPvkwsB0EaeprCXnVHc+owmqFGJXBFjY8
         QYVyVyfSGNwYg86gO+AznM3bSrWb+6RsCTd1ldPcbetGJi5Ny1C4H8EVcbDVzLtzaiO9
         xi8YVxm+dfqxaTgLJ0nzOc0kXrpfed2HjJGcJczNESDFIhq7qh9PP98V5mfxze/nU/Rp
         QB5Wb9fwhqZEupGTUWF2YZ0vMQrdcWnUqq9m0ovMj1uqVhpd9B/Ouee0p+jsVpO15NtT
         w7lQNMAvKoL2kA+9Fdro+vf212r8GOxWwcDYgoEJJ3ZD8Qz+sqJFE+iIS4xSQMhtEzOD
         TZZw==
X-Gm-Message-State: AA+aEWZh5AMDHhK62Xl9xj3R785Imc4Yk2SJNcgHLC5Mrs0WizwjpL7c
        3T5CeJ/eh5TrZZtSsiNss4+nCA==
X-Google-Smtp-Source: AFSGD/XQnhoOhg+tjB/LEQ/fOMwuNhYYeNsEnp2m+yryhmI7A6p5R9YahmhHUyJgeRgAj5v5qAsl5g==
X-Received: by 2002:adf:f401:: with SMTP id g1mr9001079wro.103.1544423258412;
        Sun, 09 Dec 2018 22:27:38 -0800 (PST)
Received: from dell (host109-155-202-221.range109-155.btcentralplus.com. [109.155.202.221])
        by smtp.gmail.com with ESMTPSA id h13sm7905806wrp.61.2018.12.09.22.27.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 09 Dec 2018 22:27:37 -0800 (PST)
Date:   Mon, 10 Dec 2018 06:27:39 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Oskari Lemmela <oskari@lemmela.net>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 8/8] mfd: axp20x: Add supported cells for AXP803
Message-ID: <20181210062739.GP26661@dell>
References: <20181120175211.3913-1-oskari@lemmela.net>
 <20181120175211.3913-9-oskari@lemmela.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181120175211.3913-9-oskari@lemmela.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Nov 2018, Oskari Lemmela wrote:

> Parts of the AXP803 are compatible with their counterparts on the AXP813.
> These include the GPIO, ADC, AC and battery power supplies.
> 
> Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> Tested-by: Vasily Khoruzhick <anarsoul@gmail.com>
> ---
>  drivers/mfd/axp20x.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
