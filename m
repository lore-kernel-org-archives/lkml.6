Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB51C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1C80208E7
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:47:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fijZMbvl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1C80208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729753AbeLNMrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:47:05 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53400 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729540AbeLNMrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:47:05 -0500
Received: by mail-wm1-f66.google.com with SMTP id y1so5544838wmi.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 04:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=6C68f6LOTbY5zW50+uHsCmt4aeQjq/CrxPZXxwAN8NQ=;
        b=fijZMbvljYi19+b1CHm6J87wwbtph0WtwQ+qMMSQ+EsAAfEMBJ2bdORKVQNJFZ8XQS
         pyFs4niN/7PecQ3dPqI+BGzZSNptCjalN8ppW/v74DYGXM4B47nfHhmAVz1YfFN4OIx9
         kx31RjBsqCII4Btkk45eqdQ5NxBG+nLy8kME0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=6C68f6LOTbY5zW50+uHsCmt4aeQjq/CrxPZXxwAN8NQ=;
        b=XbmmxRuVnA7VGYpzowThjmSB+VNkRJcqC1IG/EhY9MCopiuiVdvRVbd3Omt8Dr4oJc
         P2s/8PAEOWCJSsks9PdMC2/EKgssF2+7RnhRY8XO6OaW9H49aCV9emIKl8dZLfqHhnfV
         Kw2Y9tPcGjA6ux6PlMfSRKSfh9SwQzYzr+GH3jqrnUG3XwYpOh6erEvFu5aZ1nvbuqPC
         aniWMT50GJ/f/NtJB9T/k4Wpyv0zYUmlH6igc6YF1iLXMq33KPkHHVnThiMGQQ98K7ke
         eJM5fiS+jvh3XcFgg+QLbWMvwJMrkkqmYqany62tTF2ySsKgHVCqQG2bdPKvHIL3zZZR
         GxBg==
X-Gm-Message-State: AA+aEWbsuQUvS8Zkv0BcArKf3oEf0IkTrDcXrtPP0wiw34+dtK91+7on
        i5ddg/sVoiTjwE/V3ZMyhgf1Jg==
X-Google-Smtp-Source: AFSGD/VIR3Jw7mU2J/QyBHR1wltqb8+YgszkQAvG29WWyALm4mT5DSGFJsavuFtaTPLr48BFPzyHKA==
X-Received: by 2002:a1c:1f11:: with SMTP id f17mr3068849wmf.56.1544791623506;
        Fri, 14 Dec 2018 04:47:03 -0800 (PST)
Received: from dell (host109-155-202-221.range109-155.btcentralplus.com. [109.155.202.221])
        by smtp.gmail.com with ESMTPSA id c9sm6316796wmh.27.2018.12.14.04.47.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Dec 2018 04:47:02 -0800 (PST)
Date:   Fri, 14 Dec 2018 12:47:01 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Pascal PAILLET-LME <p.paillet@st.com>
Cc:     "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>,
        "eballetbo@gmail.com" <eballetbo@gmail.com>,
        "axel.lin@ingics.com" <axel.lin@ingics.com>
Subject: Re: [PATCH v7 0/7] Introduce STPMIC1 PMIC Driver
Message-ID: <20181214124701.GZ4497@dell>
References: <1543571742-17995-1-git-send-email-p.paillet@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1543571742-17995-1-git-send-email-p.paillet@st.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Nov 2018, Pascal PAILLET-LME wrote:

> The goal of this patch-set is to propose a driver for the STPMIC1 PMIC from 
> STMicroelectronics. 
> The STPMIC1 regulators supply power to an application processor as well as 
> to external system peripherals such as DDR, Flash memories and system
> devices. It also features onkey button input and an hardware watchdog.
> The STPMIC1 is controlled via I2C. 
> 
> Main driver is drivers/mfd/stpmic1 that handle I2C regmap configuration and
> irqchip. stpmic1_regulator, stpmic1_onkey and stpmic1_wdt need stpmic1 mfd
> as parent.
> 
> STPMIC1 MFD and regulator drivers maybe mandatory at boot time.
> 
> Pascal Paillet (7):
> changes in v7:
> * rebase on regul/for-next
> 
>   dt-bindings: mfd: document stpmic1
>   mfd: stpmic1: add stpmic1 driver
>   dt-bindings: input: document stpmic1 pmic onkey
>   input: stpmic1: add stpmic1 onkey driver
>   dt-bindings: watchdog: document stpmic1 pmic watchdog
>   watchdog: stpmic1: add stpmic1 watchdog driver
>   regulator: stpmic1: fix regulator_lock usage

Could you please remove any patches which have been applied and
[RESEND]?

Also, is Dmitry planning on Acking:

  dt-bindings: input: document stpmic1 pmic onkey

... or is Rob's Ack enough?

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
