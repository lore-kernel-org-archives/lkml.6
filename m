Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4180C67879
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 23:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 781EB2089D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 23:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CyXRP6jr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 781EB2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbeJIGcz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 02:32:55 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37502 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbeJIGcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 02:32:55 -0400
Received: by mail-pl1-f196.google.com with SMTP id az3-v6so10717664plb.4
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 16:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=5N2rcTAymvvqXEbaCzdGWGJ2kRxJVFJM+7dl+6sL3c4=;
        b=CyXRP6jrA+fQ5UjdNx2qXGzIP9Q7d2tthrTZjjZiHvjpvqZ+i+/EqvE6aF+4bSz0sD
         i/aKiVXZgLMX8v46C1lHwUkWxsxAeiUD6jzQ5+cuLxoVDjo3AVmZzxwCU4YzW3jZnaRi
         V94lGnUjMcwLmqsPHeD5VPiUq76BZD/L3U/EE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=5N2rcTAymvvqXEbaCzdGWGJ2kRxJVFJM+7dl+6sL3c4=;
        b=MEML6QXDHNfclgkOBvgzQNOy5MBuyPpopjGucbx0sHp63saTJasTr/IQuRs8PaeSDX
         EwopNJcne0frpZ7bNlH/6Y1Of22SbkqSuA5mA8+OrD91aEJDFmUHNZQvLPMRSLJO3zLB
         BP8BS32FkDY07+XCOe+9efUWkpj5LETZviIjwoC5MdwQPRH1XkjyxfD4yaZOI2ZvY4qk
         5s4ovr7pR8WCX8Ys7U5ba9edLDHiK6fmD/EJ92/J/B05mKn1JSkuQb0Lsn+17LTIOPWy
         KaQpuepxKQuHU8YtPUbbtppYPu4epTjXtsFDjoct1XRkFoRtBY6q8J7N2O0NcnZzSWOp
         EPXA==
X-Gm-Message-State: ABuFfoiPlm0FAZF9VatqCYH9qtDeXlek+awCENwowE404AuS79eMQPh5
        0q8yfmc9JBKuBl4fI2nRutbrUQ==
X-Google-Smtp-Source: ACcGV618M6/zm42xYnQ9oBdlR4p2/qFGbCz9mVgi3n95fFKaEL7iyp+VIUw5cqXMu6cXmU+VAhXXsg==
X-Received: by 2002:a17:902:6848:: with SMTP id f8-v6mr26295281pln.27.1539040729595;
        Mon, 08 Oct 2018 16:18:49 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:fed3:9637:a13a:6c15])
        by smtp.gmail.com with ESMTPSA id e64-v6sm25653743pfe.55.2018.10.08.16.18.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Oct 2018 16:18:49 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Andy Gross <andy.gross@linaro.org>,
        Douglas Anderson <dianders@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20181008201711.152038-1-dianders@chromium.org>
Cc:     Ryan Case <ryandcase@chromium.org>, linux-arm-msm@vger.kernel.org,
        Girish Mahadevan <girishm@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-soc@vger.kernel.org
References: <20181008201711.152038-1-dianders@chromium.org>
Message-ID: <153904072826.119890.13295983146179211257@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v2] arm64: dts: qcom: sdm845: Add qspi (quad SPI) node
Date:   Mon, 08 Oct 2018 16:18:48 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2018-10-08 13:17:11)
> This adds the Quad SPI controller to the main sdm845 device tree file.
> Boards will be expected to assign the proper pinctrl depending on how
> many chip selects they have hooked up and how many data lines.
> =

> This depends on commit 48735597f7bd ("clk: qcom: Add qspi (Quad SPI)
> clock defines for sdm845 to header") to add the needed defines.  It
> also shouldn't land until the patch ("dt-bindings: spi: Qualcomm Quad
> SPI(QSPI) documentation") [1] lands.
> =

> [1] https://lkml.kernel.org/r/20181002214709.162330-1-ryandcase@chromium.=
org
> =

> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

