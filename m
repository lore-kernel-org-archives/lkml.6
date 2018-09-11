Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE06FC6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 13:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59A3D20882
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 13:49:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="L3UJ1JDO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59A3D20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbeIKStQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 14:49:16 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:40197 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbeIKStQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 14:49:16 -0400
Received: by mail-wm0-f68.google.com with SMTP id 207-v6so1060034wme.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 06:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=H9v88KnKNONDdluI3ZXm5Yei7TlrCS0x6SNdiWxEm7E=;
        b=L3UJ1JDOBWzX0si04Y86G7I005H1ySRx4+G/IMI8B+9VVbhSo00RLgKrSQ8KyST+Y/
         Qjmq2YIrxSRm32jYuRO4XxvMWaKBv2GEsj25/0SbIYMJZKmqmt75Qz9jVjvU9/pbRqTR
         uzhBw/WdGGvkyZ1hYLUh6j7Pcplnub4yWJMy4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=H9v88KnKNONDdluI3ZXm5Yei7TlrCS0x6SNdiWxEm7E=;
        b=I1pcx8udTHMISd7jpwbopXfFvk75vTKECmRRhSVdzjvF2JnTwOG+J+rF+TWLQ3aFYe
         adRqwz+c5PN3ZlI+fMhfRfW0P51Jcm6RN8r8d462tjRsm8vzfVmoPf7hNrdBG9EFO/kY
         R46NkEuLWZ5D7ocOa3QxtPl1PzXcXPydwuZ0zO7322cc21NYdL3cqMxUFThv2bRIWIDM
         XOM9GIU3eOkx1vAwxUmjXnVX6tS8hg+N913ti3zrCYEkysJM84HSOOKhXGRHx61SfDKQ
         Vze0V+/sg8scRUT9WRDr5tWMgBQrjpS1+Z5/2okAajoDDfsLhrkdxKZ1zda5yaZpAvhm
         rIOA==
X-Gm-Message-State: APzg51BuQUS/crOK14LHSQFcTzSAH5ZN5vSSq6sjFEUeA/PAjqlTSEqg
        gTrPdWNvrrdYNa5Dd1HfcpyEjQ==
X-Google-Smtp-Source: ANB0VdboKAMh5pMzWvf64rs+4fcwZiccIVw02R4QUrb8bP9B3F9F3SjcsTqbSQxV0nzrmrr64QdJ/w==
X-Received: by 2002:a1c:c501:: with SMTP id v1-v6mr1425308wmf.115.1536673789841;
        Tue, 11 Sep 2018 06:49:49 -0700 (PDT)
Received: from dell ([2.27.167.7])
        by smtp.gmail.com with ESMTPSA id h82-v6sm1578945wme.11.2018.09.11.06.49.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 06:49:48 -0700 (PDT)
Date:   Tue, 11 Sep 2018 14:49:47 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, lgirdwood@gmail.com,
        broonie@kernel.org, mazziesaccount@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com
Subject: Re: [PATCH 4/8] mfd: dt bindings: add BD71847 device-tree binding
 documentation
Message-ID: <20180911134947.GQ4185@dell>
References: <cover.1535545377.git.matti.vaittinen@fi.rohmeurope.com>
 <09eceb20f4f05ac48c6767d5f3359743e5b98985.1535545377.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <09eceb20f4f05ac48c6767d5f3359743e5b98985.1535545377.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Aug 2018, Matti Vaittinen wrote:

> Add ROHM BD71847 Power Management IC MFD binding information to
> device-tree binding documents.
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> ---
>  .../devicetree/bindings/mfd/rohm,bd71837-pmic.txt       | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt b/Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt
> index 3ca56fdb5ffe..d78172878faa 100644
> --- a/Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt
> +++ b/Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt
> @@ -1,16 +1,17 @@
> -* ROHM BD71837 Power Management Integrated Circuit bindings
> +* ROHM BD71837 and BD71847 Power Management Integrated Circuit bindings
>  
> -BD71837MWV is a programmable Power Management IC for powering single-core,
> -dual-core, and quad-core SoCs such as NXP-i.MX 8M. It is optimized for
> -low BOM cost and compact solution footprint. It integrates 8 Buck
> -egulators and 7 LDOs to provide all the power rails required by the SoC and
> -the commonly used peripherals.
> +BD71837MWV and BD71847MWV are programmable Power Management ICs for powering
> +single-core, dual-core, and quad-core SoCs such as NXP-i.MX 8M. They are
> +optimized for low BOM cost and compact solution footprint. BD71837MWV
> +integrates 8 Buck regulators and 7 LDOs. BD71847MWV contains 6 Buck regulators
> +and 6 LDOs.
>  
> -Datasheet for PMIC is available at:
> +Datasheet for BD71837 is available at:
>  https://www.rohm.com/datasheet/BD71837MWV/bd71837mwv-e
>  
>  Required properties:
> - - compatible		: Should be "rohm,bd71837".
> + - compatible		: Should be "rohm,bd71837" for bd71837 and
> +			  "rohm,bd71847" for bd71847.

Nit: Probably sightly clearer as:

> + - compatible		: Should be "rohm,bd71837" for bd71837
> +			                    "rohm,bd71847" for bd71847.

Apart from that:

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
