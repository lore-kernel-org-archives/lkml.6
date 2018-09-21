Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC2EECE567
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 17:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D88821479
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 17:31:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VFYoQPnR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D88821479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391018AbeIUXUw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 19:20:52 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35643 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390693AbeIUXUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 19:20:52 -0400
Received: by mail-pg1-f195.google.com with SMTP id 205-v6so5413557pgd.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 10:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=md5rIgo9mqWlgXa285vg9lW1AXrcZqkAaFIy8gWCins=;
        b=VFYoQPnRSBOsR+JGpBWO7tKFn5dDtCWFxeLYRoRQf6C9ZSmO8Mg+0Sjovwrve56CLh
         f0FWA51Zhy5cj0VFX09WOdTth+4aiGY6bEydYIstcrdFTV6iT5fl2tXmkuvE4EAilxMW
         waq7HPkODowRAjvaEtm7UCzZjC3XYx//TB1JQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=md5rIgo9mqWlgXa285vg9lW1AXrcZqkAaFIy8gWCins=;
        b=r8fb7tm/fNWuY1U+k44IhWCcApwQ41KHSRynVr9W0mJmShbCG6CXwIC9GG1tL6oD+o
         qFnu1IDqI/PlPgL9rFgJiZ4tLqbb2xmpob3Eit0J/7l6RICN9G0whuGK9ndXIISAJEWH
         /xEBPClQURvD3eRUmnTRANFajksM1sAfHvvKTumvYSYgVH9JE42v/eXQLSjHS71ETv32
         eubJ9dJYBZ/psGph46UFU19WU3KgpbnX/V4h8xup82KObSefiQ+9L2Tg8+n6lE7EPBOm
         bPvbN1hDcZuZ9Jhhqcae684yv74ZFJPY/FG8HuAwz7ptcZFX3lzlAvBaQKrKEeOAMEfd
         YLGw==
X-Gm-Message-State: APzg51BPLqjhYwaJJdE2goKxqYmkNHPsDnSh7e/MX90FOa7MxBPqepxv
        3YQLIu3Hhpm3EQy6zOGr4Gn7Kw==
X-Google-Smtp-Source: ANB0VdYbcN8kzEh4m9dgCu1OvxVBH02m5v1gABK/qT9Pxyd+Miv37uXu4UJH1ijoR6FIKq6s3nrCUg==
X-Received: by 2002:a65:4043:: with SMTP id h3-v6mr42039715pgp.207.1537551059128;
        Fri, 21 Sep 2018 10:30:59 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:7e28:b9f3:6afc:5326])
        by smtp.gmail.com with ESMTPSA id 16-v6sm38589298pfp.6.2018.09.21.10.30.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Sep 2018 10:30:58 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Mark Brown <broonie@kernel.org>, Ryan Case <ryandcase@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20180920224055.164856-1-ryandcase@chromium.org>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Doug Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org,
        Girish Mahadevan <girishm@codeaurora.org>,
        Ryan Case <ryandcase@chromium.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
References: <20180920224055.164856-1-ryandcase@chromium.org>
Message-ID: <153755105782.119890.8484594239463905156@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v2 1/2] dt-bindings: spi: Qualcomm Quad SPI(QSPI) documentation
Date:   Fri, 21 Sep 2018 10:30:57 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Ryan Case (2018-09-20 15:40:54)
> diff --git a/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.txt=
 b/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.txt
> new file mode 100644
> index 000000000000..ecfb1e2bd520
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.txt
> @@ -0,0 +1,36 @@
> +Qualcomm Quad Serial Peripheral Interface (QSPI)
> +
> +The QSPI controller allows SPI protocol communication in single, dual, o=
r quad
> +wire transmission modes for read/write access to slaves such as NOR flas=
h.
> +
> +Required properties:
> +- compatible:  Should contain:
> +               "qcom,sdm845-qspi"

Does someone have a more generic compatible string that can be added
here to indicate the type of quad SPI controller this is? I really doubt
this is a one-off hardware block for the specific SDM845 SoC. =


> +- reg:         Should contain the base register location and length.
> +- interrupts:  Interrupt number used by the controller.
> +- clocks:      Should contain the core and AHB clock.
> +- clock-names: Should be "core" for core clock and "iface" for AHB clock.
> +
