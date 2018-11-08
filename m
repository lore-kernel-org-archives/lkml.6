Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E49ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 18:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C22E2086C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 18:11:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ah95KjQr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C22E2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbeKIDsa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 22:48:30 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33415 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbeKIDsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 22:48:30 -0500
Received: by mail-pf1-f195.google.com with SMTP id v68-v6so6064062pfk.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 10:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=rVy0OTx5IrIViU9Vn0njQFr88/uyagT3wSXQ6O2KGqM=;
        b=ah95KjQrgS/gtdYB+GktDKxmZ8mJcxAQG+hE7BHmxJrJgx5VnWuWPho4KpMnd5NTdK
         8hVf4xyWKYkGJcKKD6Jr+YRvMw1+ItUaFeM+CppbnKmM68Mv1gRtLEgCLFJwvFbzJ9pb
         FFbUs7us2ya2tEHTKwu4UJCRuLE1G5lRwTPrs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=rVy0OTx5IrIViU9Vn0njQFr88/uyagT3wSXQ6O2KGqM=;
        b=iTtqb8KeMdj9Cmzy/gg7yd1RD05IWScpECIcgZUBd7QtDYUtoBYOFxOIg3Zg8K18BN
         AE5jeUlfztVW0Cz842E/C97zMgxKfroMQM1I2SqQt5EiNmTXid/zpPZso5v51VJZMayz
         Q5Xpdyp5NwZzHdfaRsNPm9pOK4EBelR7X6AUeqYcDdX3bqU8ZZfrCvVwjEvfH+qvndJw
         MLXbl5KV9JRZrrjgg91zDsYRf8xQYmRpe9//rCOwnNYx34cG1nXsFvP4bnu43JLC5ekr
         6Lh2VW7AKHkEfXaZXrBhtwQVSXYIrGWAb9zul47obB2AQgwi3gxoVBTfxY88zn0kr2jt
         9APw==
X-Gm-Message-State: AGRZ1gKWkUKS6R3nlX14xsxo2jTU6DZ60eQShCL6ZKHMCLp+dbn/dU0z
        v5oy+GFU9Ibvo5rZs79R/lr9cQ==
X-Google-Smtp-Source: AJdET5db8RJ2TsW/M9zL5eH03Qp5BBx/ijH3qTu5qNLAk7LEBh85OJfMZBvc77v2M9kcSAerZpkQ+Q==
X-Received: by 2002:a62:e707:: with SMTP id s7-v6mr5626481pfh.124.1541700707966;
        Thu, 08 Nov 2018 10:11:47 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fed3:9637:a13a:6c15])
        by smtp.gmail.com with ESMTPSA id i189-v6sm4797077pfg.156.2018.11.08.10.11.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Nov 2018 10:11:47 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20181108054452.GD2337@tuxbook-pro>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Taniya Das <tdas@codeaurora.org>
References: <20181105194011.43770-1-swboyd@chromium.org>
 <20181105194011.43770-2-swboyd@chromium.org>
 <20181106010426.GX2523@minitux> <20181108054452.GD2337@tuxbook-pro>
Message-ID: <154170070630.88331.10123917683941164429@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 1/2] dt-bindings: clk: Introduce 'protected-clocks' property
Date:   Thu, 08 Nov 2018 10:11:46 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2018-11-07 21:44:52)
> On Mon 05 Nov 17:04 PST 2018, Bjorn Andersson wrote:
> =

> > On Mon 05 Nov 11:40 PST 2018, Stephen Boyd wrote:
> > =

> > > Add a generic clk property for clks which are not intended to be used=
 by
> > > the OS due to security restrictions put in place by firmware. For
> > > example, on some Qualcomm firmwares reading or writing certain clk
> > > registers causes the entire system to reboot, but on other firmwares
> > > reading and writing those same registers is required to make devices
> > > like QSPI work. Rather than adding one-off properties each time a new
> > > set of clks appears to be protected, let's add a generic clk property=
 to
> > > describe any set of clks that shouldn't be touched by the OS. This way
> > > we never need to register the clks or use them in certain firmware
> > > configurations.
> > > =

> > > Cc: Rob Herring <robh+dt@kernel.org>
> > > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> > =

> > Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > =

> =

> Gave this some additional thought. The way this is blacklisting
> protected clocks makes it impossible to be backwards compatible with an
> older DT while adding new protected clocks to an existing driver.
> =

> I don't have better suggestion for handling this and the problem should
> primarily be isolated to the beginning of the upstream life of a
> platform, so perhaps we can just ignore this issue?
> =


I don't have a better suggestion either besides listing all possible
clks in the binding and header file to start and then specifying any
clks that are known to not work when merging the dts bits. In the future
I think we can move dts and drivers in lockstep if certain drivers add
new clks and those cause problems on locked down systems. The
alternative seems worse, i.e. listing clks that should be added on the
unaffected platforms, so ignoring this issue sounds good for now.

