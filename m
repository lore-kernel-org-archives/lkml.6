Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB74C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 09:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FD6421710
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 09:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fMLUAm8b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FD6421710
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbeHXMxk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 08:53:40 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39504 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbeHXMxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 08:53:40 -0400
Received: by mail-wm0-f68.google.com with SMTP id q8-v6so961043wmq.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 02:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=jgprI199YxehCbiJZ5iZqhBGnsXvjAfM7CJGAqyyOiw=;
        b=fMLUAm8bVINbo+hxfgXC8QRIwSn1I9s+T+I2LXUkuvOmtZuVuiJ9rkuwaDuXkR1DBC
         9tGdw2SOLERiurgmUb2JDcMNdmrlpykvfECrLd5yEh+FfrR/+ZunjLimR4/LLqM1Fnay
         X7BlsScdHCQH9kVe9JVrmIylC+0DvnG8fY+RU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=jgprI199YxehCbiJZ5iZqhBGnsXvjAfM7CJGAqyyOiw=;
        b=BWvY8x0X6Q6x++Prd5xzKWgrXrVfQpR5j+q9h60I9wvs/Quk8ljA7ojrN4CFTTf5Wh
         Qjg9sMAFwP3/YhcBU/V8YPrF8lzx9PesoVEgX/zQ76lpAwvA3UAV/TIvv2nGDBxvt2Jg
         R5c580KHV5QDP2CiF4Qi4pmL57dnkVXh2tNKG9eGe91UNIdZcEFoqjSer8FSkoa/eK5K
         NjbUvsGtskGPJNfjAQM123+FY7bg1m+nl8TRXwDlqzdmLo/sWtsB5Qu2javWpG0ySwhf
         Vjks8OR0FiIeN5WheogwWdxq5GHKLSNb1/0K45CJYNxD1iCBx7OyRTcABf079WZE794t
         t4DQ==
X-Gm-Message-State: APzg51DPrw9WAVAKEgvb0YfJbTscg12ikmeymDZI0jw/vJnp6Xv7tFea
        wDMWBfMEcCz50dPNlsqWQu8/0Q==
X-Google-Smtp-Source: ANB0VdaT7zF4sJ1wczLr/TRjNh+s4ors8blbwHRTtxmVGFPRi0bNYL6VGVqmZHvIHOKl6j45yR3FFw==
X-Received: by 2002:a1c:8a10:: with SMTP id m16-v6mr877312wmd.42.1535102394424;
        Fri, 24 Aug 2018 02:19:54 -0700 (PDT)
Received: from dell ([2.27.167.102])
        by smtp.gmail.com with ESMTPSA id n14-v6sm726342wmc.14.2018.08.24.02.19.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 Aug 2018 02:19:53 -0700 (PDT)
Date:   Fri, 24 Aug 2018 10:19:51 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sangbeom Kim <sbkim73@samsung.com>,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH 1/4] mfd: sec-core: Add SPDX license identifiers
Message-ID: <20180824091951.GC28860@dell>
References: <20180807161125.18155-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180807161125.18155-1-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Aug 2018, Krzysztof Kozlowski wrote:

> Replace GPL v2.0+ license statements with SPDX license identifiers.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/mfd/sec-core.c              | 16 ++++------------
>  drivers/mfd/sec-irq.c               | 16 ++++------------
>  include/linux/mfd/samsung/core.h    | 11 ++---------
>  include/linux/mfd/samsung/irq.h     | 10 ++--------
>  include/linux/mfd/samsung/rtc.h     | 15 ++-------------
>  include/linux/mfd/samsung/s2mpa01.h |  7 +------
>  include/linux/mfd/samsung/s2mps11.h |  9 +--------
>  include/linux/mfd/samsung/s2mps13.h | 14 +-------------
>  include/linux/mfd/samsung/s2mps14.h | 14 +-------------
>  include/linux/mfd/samsung/s2mps15.h | 11 +----------
>  include/linux/mfd/samsung/s2mpu02.h | 14 +-------------
>  include/linux/mfd/samsung/s5m8763.h | 10 ++--------
>  include/linux/mfd/samsung/s5m8767.h | 10 ++--------
>  13 files changed, 24 insertions(+), 133 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
