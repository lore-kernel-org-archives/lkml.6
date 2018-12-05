Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD08C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5220620659
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:14:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FGOS0AQP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5220620659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbeLEKOQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 05:14:16 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41706 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727297AbeLEJgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:36:09 -0500
Received: by mail-wr1-f66.google.com with SMTP id x10so18890886wrs.8
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 01:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=DPSKJfYQ6rC06gChBEjW81xQvhnC/YU81KmkgKXcX0A=;
        b=FGOS0AQPb15fpsdCL2QwMtrnTXAA2CHJb+gjI9fiVHL2iuqxVYnEwFBT0VOjcY/kxb
         1aD8qcf9nyLp6ggWIhhSXj9pm5Q6cvVwVGQzUGxLvs3txnvli1q1STtO420I7CPO5/3t
         NrUUXZe6D+JyIS9wkK1i0r3FLIcMYWPHvNtJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=DPSKJfYQ6rC06gChBEjW81xQvhnC/YU81KmkgKXcX0A=;
        b=bj/bDQRYq1ox7yHbAXJd/qKtsomBJcqWAMD9FURaQGQRAe7MvwdGeanRUdxaW7dLiE
         SEIWEHDaBM2IwWGOW+/yUaI7L/ah8ZCpp0RBdcJ0lyG4ORUC9DtRCwY9LIM3hGdtQ9Sx
         SA2cAyBVg6szrWdofaIEaLEzHO2+imxQ8/yfSIupZ1jlmuRS+Xt7UzmxXpkAxU/vH4az
         Oxz3MNCaPZfxKT0Cyg8E/IZ9+58p0MPfxz5t9ZRprtl9mswkKatdaVGQimAGn5c5TWaV
         SV2PaqgNx8Ld4ygcnWcAXLCbs9IVArdi7TdoKInYmL0llcWziznBmd75WswOqmnL5VzY
         Izyg==
X-Gm-Message-State: AA+aEWYAp322GxV6Y7b2exKBG2MAJLzn372NgQnCPySOIyyZsWZDyz4a
        79lkq+AchgMy3mSrtxIgwWyJ7g==
X-Google-Smtp-Source: AFSGD/WyjfMgukBb9CyDNkxCqtJDKkSSkRm5XwfB650AqgOb1p374RpxFf8X//9nxtET0MuxOAAiFg==
X-Received: by 2002:adf:c612:: with SMTP id n18mr20268552wrg.174.1544002567223;
        Wed, 05 Dec 2018 01:36:07 -0800 (PST)
Received: from dell ([2.31.167.218])
        by smtp.gmail.com with ESMTPSA id s1sm24468471wro.9.2018.12.05.01.36.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 01:36:06 -0800 (PST)
Date:   Wed, 5 Dec 2018 09:36:04 +0000
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
Message-ID: <20181205093604.GZ26661@dell>
References: <1543571742-17995-1-git-send-email-p.paillet@st.com>
 <20181203071145.GA26661@dell>
 <5C069C47.6080305@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5C069C47.6080305@st.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 04 Dec 2018, Pascal PAILLET-LME wrote:
> Le 12/03/2018 08:11 AM, Lee Jones a écrit :
> > On Fri, 30 Nov 2018, Pascal PAILLET-LME wrote:
> >
> >> The goal of this patch-set is to propose a driver for the STPMIC1 PMIC from
> >> STMicroelectronics.
> >> The STPMIC1 regulators supply power to an application processor as well as
> >> to external system peripherals such as DDR, Flash memories and system
> >> devices. It also features onkey button input and an hardware watchdog.
> >> The STPMIC1 is controlled via I2C.
> >>
> >> Main driver is drivers/mfd/stpmic1 that handle I2C regmap configuration and
> >> irqchip. stpmic1_regulator, stpmic1_onkey and stpmic1_wdt need stpmic1 mfd
> >> as parent.
> >>
> >> STPMIC1 MFD and regulator drivers maybe mandatory at boot time.
> >>
> >> Pascal Paillet (7):
> >> changes in v7:
> >> * rebase on regul/for-next
> >>
> >>    dt-bindings: mfd: document stpmic1
> >>    mfd: stpmic1: add stpmic1 driver
> >>    dt-bindings: input: document stpmic1 pmic onkey
> >>    input: stpmic1: add stpmic1 onkey driver
> >>    dt-bindings: watchdog: document stpmic1 pmic watchdog
> >>    watchdog: stpmic1: add stpmic1 watchdog driver
> >>    regulator: stpmic1: fix regulator_lock usage
> >>
> >>   .../devicetree/bindings/input/st,stpmic1-onkey.txt |  28 +++
> >>   .../devicetree/bindings/mfd/st,stpmic1.txt         |  61 ++++++
> >>   .../bindings/watchdog/st,stpmic1-wdt.txt           |  11 ++
> >>   drivers/input/misc/Kconfig                         |  11 ++
> >>   drivers/input/misc/Makefile                        |   2 +
> >>   drivers/input/misc/stpmic1_onkey.c                 | 198 +++++++++++++++++++
> >>   drivers/mfd/Kconfig                                |  16 ++
> >>   drivers/mfd/Makefile                               |   1 +
> >>   drivers/mfd/stpmic1.c                              | 213 +++++++++++++++++++++
> >>   drivers/regulator/stpmic1_regulator.c              |   2 +-
> > Is it just Mark you're waiting on now?
> It is ok now, Mark has applied the patch.
> Evrey thing has been acked now. What is the nex step ?

Mark has applied patch 7?

Why don't I see that?  Should you have removed it from this set?

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
