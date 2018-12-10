Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE993C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 22:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 940CE2084E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 22:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544480716;
	bh=zUzqBMo5HosPJC13PQKICKEd2+pHMWc+ygGlXcmYU/g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=juCkWKy688J49Tc6Q8bMQSYlI2rHdcfisCY69nqWeLj65BW3FUyM4EIdyTIGsdMlP
	 A2inzTwuOr4GzMmU0dxgTilNBx8+YNAndfmDEnlJzseljatzOj5veSD9jcixQ2csY6
	 39kDKY7BxdduK5cA98F0m2FuH28EmnwLZApQT1Ig=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 940CE2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729480AbeLJWZP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 17:25:15 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36929 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbeLJWZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 17:25:15 -0500
Received: by mail-oi1-f195.google.com with SMTP id y23so10401652oia.4;
        Mon, 10 Dec 2018 14:25:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DPnX9FgNasZsQgRsZ+0K4q5mDFGqah2kTqdXu776lCU=;
        b=ChmyYnmfGoyMWcRF9/VFYjWHkDvlf0LV0sdJvKdZEhjg4lybAxiLc7dNEaDRwoSdt9
         0CZuaWdeGZ9Q+PZa7DW7A3hgK0DRpa0I47BUNWp/OHEwbUXxTm+kilWB+0QFU/9rdPgk
         Vo83sG/FpK2qr6/aubfYc5bZJcduBDMRXkSWdevb1TXE0lT47knFycc3sy5m2tzsZwgF
         JggZQBfOXRZWFBub/q/b7TmYWK7jTR+JerFpg8v2phQmJE/BaLPX24TC1ZO57qqF+2Th
         Cv3nG5tTM07U/z7sQXsJdRGvwbx1HRnGhNidy0Dhe6R0rrTSH2f/NYMURgm/XkVfNCaz
         UJlw==
X-Gm-Message-State: AA+aEWbk4YrhZzMhj3xIGuIcXuSt4C6d6MwWRx6K2Ma4hUi1+ny2Xg1N
        Kfx3GFHaxzog0asCU4ss8g==
X-Google-Smtp-Source: AFSGD/V0RicQnLBkvZ9ouH3JjTzPSMQ+izc06d5U503qFczusrs/bjBf5ykmPw41R+0rT0O9iecaew==
X-Received: by 2002:aca:5508:: with SMTP id j8mr8873898oib.240.1544480714127;
        Mon, 10 Dec 2018 14:25:14 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t201sm6357180oie.37.2018.12.10.14.25.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Dec 2018 14:25:13 -0800 (PST)
Date:   Mon, 10 Dec 2018 16:25:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     olof@lixom.net, arnd@arndb.de, robh+dt@kernel.org,
        tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        daniel.lezcano@linaro.org, gregkh@linuxfoundation.org,
        jslaby@suse.com, linux-unisoc@lists.infradead.org,
        afaerber@suse.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, amit.kucheria@linaro.org,
        linus.walleij@linaro.org, zhao_steven@263.net,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v4 09/15] dt-bindings: timer: Document RDA8810PL SoC timer
Message-ID: <20181210222513.GA1326@bogus>
References: <20181210173550.29643-1-manivannan.sadhasivam@linaro.org>
 <20181210173550.29643-10-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181210173550.29643-10-manivannan.sadhasivam@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Dec 2018 23:05:44 +0530, Manivannan Sadhasivam wrote:
> Document RDA Micro RDA8810PL SoC timer.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  .../bindings/timer/rda,8810pl-timer.txt       | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/rda,8810pl-timer.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
