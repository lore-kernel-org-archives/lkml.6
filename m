Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19ACDC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 10:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCE7020660
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 10:14:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jUEphVE5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCE7020660
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728181AbeK1VQF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 16:16:05 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50290 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727662AbeK1VQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 16:16:04 -0500
Received: by mail-wm1-f67.google.com with SMTP id 125so1985924wmh.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 02:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=53Ak6C3WNNiQNkvqMs4P5zMFlFRa8bndCGM0pLopCK8=;
        b=jUEphVE5D+ZxAqfNOafnYC1pZltO1nkQKS8tSaFHJzBKW3jMDDov9lAHvkbUNr761k
         SGjuLiriS+62xAdyyko9F8ww8jMmr5ObLNlFZWBZhx3Cjb1+QoZ9mUVMIiigmV+Mr5tG
         leZ4S55W2LWZaiPNYPgcdITmJsTcCluPTQgdo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=53Ak6C3WNNiQNkvqMs4P5zMFlFRa8bndCGM0pLopCK8=;
        b=r53Wrem+e3E+tEoD5VIO20ikajzGJGCjeXFG4FidJgaOLTOx2yRVMj6/3Sf5mS8cBP
         PDPa949/IVA9y/8pcYG6Epq9a8JVmwzQMmLx4FfHg42CcZj8JFNUzxpS9glDJNNKnYWM
         zc1H6qh2R0fRmk4JUgZF1DWuumISsDIxHxxeLQMaN1YtVvMsnU73PjfGDxOtWHIqippO
         tHo+mAjSFGUgsTAoaL9FUEIdDiybm6EoNwMN3yCVvT4yCaU1Rmrc6kxxZTi9YFUUhSIO
         EJt6DPxJlN5kG8hqpuU2Uz4JsRK0NHhCDigyv2LBly8pQ0ZUAwJnGxqrpdXG403y+CFv
         Slgw==
X-Gm-Message-State: AA+aEWaNIIvuUIjWlokhusuquc4yfhv8Z/98zdNKZUAj0RX1MHtrBlFo
        kj3zboxMLMF+K2zGMeqxi9/QGw==
X-Google-Smtp-Source: AFSGD/WSaxnFtAKFTLis4yNWR+TJdW2QGfWHWQ4T88rX24qNK0F7v48x9k564Bve1S817N4On/ssRQ==
X-Received: by 2002:a1c:b189:: with SMTP id a131mr2251049wmf.38.1543400094484;
        Wed, 28 Nov 2018 02:14:54 -0800 (PST)
Received: from dell ([2.31.167.233])
        by smtp.gmail.com with ESMTPSA id s139sm4271497wmd.3.2018.11.28.02.14.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Nov 2018 02:14:53 -0800 (PST)
Date:   Wed, 28 Nov 2018 10:14:52 +0000
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
Subject: Re: [PATCH v6 2/8] mfd: stpmic1: add stpmic1 driver
Message-ID: <20181128101452.GE4272@dell>
References: <1543337529-22301-1-git-send-email-p.paillet@st.com>
 <1543337529-22301-3-git-send-email-p.paillet@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1543337529-22301-3-git-send-email-p.paillet@st.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Nov 2018, Pascal PAILLET-LME wrote:

> STPMIC1 is a PMIC from STMicroelectronics. The STPMIC1 integrates 10
> regulators, 3 power switches, a watchdog and an input for a power on key.
> 
> Signed-off-by: Pascal Paillet <p.paillet@st.com>
> ---
> changes in v6:
> * replace i2c_device_id by of_device_id
> * fix commit message and Kconfig description
> 
>  drivers/mfd/Kconfig         |  16 ++++
>  drivers/mfd/Makefile        |   1 +
>  drivers/mfd/stpmic1.c       | 213 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/stpmic1.h | 212 +++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 442 insertions(+)
>  create mode 100644 drivers/mfd/stpmic1.c
>  create mode 100644 include/linux/mfd/stpmic1.h

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
