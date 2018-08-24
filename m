Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95226C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 09:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48CDE21710
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 09:20:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dvOS+B8z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48CDE21710
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbeHXMyi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 08:54:38 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33655 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727621AbeHXMyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 08:54:36 -0400
Received: by mail-wr1-f65.google.com with SMTP id v90-v6so6914746wrc.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 02:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=N3K+acll4KCrlQjecV1IEoyA4IuCOl9wWm1WveBlyus=;
        b=dvOS+B8zo17cqD9BLAqxRZ9A2kMk/iirjLl9MIZSHYpt1y0thNFDziumqz+YPvhFIR
         mWJUhXnzCQRY32THrgma8erT1adI/KmLaCvWFk9OH/BJI1KaKW2SyxxC51EU3hBnmehi
         QbPrBToRZGZOfzIlai6NxQuc2HaSNsli/Eh5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=N3K+acll4KCrlQjecV1IEoyA4IuCOl9wWm1WveBlyus=;
        b=ayzcOlzQJzaG0TSdgGQkpd/ehVmOR3nKG0I2mngxDK08PqMJ7pd8cJgwheL762VrCw
         vmLW4fC6dlhjrANCe5kCVcMF0kTu8kCGZr9A3IrclEK0Pt9MHKY+zizlKR2J+Z2tfy4J
         HNG2T7Rj6YrdvBhmzFTRk6QK4TBf/qbK4qe082E1BqztobxI/4fH1yU983HgLOliNT+P
         tQZ1OkA6abKoCh7ioUIVf3QIvxfj/kmRpAxnjlTNU/afsfix7kRiaagjyRKvVxqf+PsA
         bag1tB+eaut6LxwWAdR7bc97AIXG14Q3RXjvE/SiAeoZYjl+QuXJNZ2nNqkjYE08f7VH
         JekQ==
X-Gm-Message-State: APzg51BKF/UOLG8Lu8jjTyy41/KIZWTeci6Js+KX6iDkPd1AErGs1f8U
        c177s81Ct8GYB83+2ufrpwRyzg==
X-Google-Smtp-Source: ANB0Vda32QzhYUxGGCTmiNM0rPOQZAM5JE+sX/VGS8Z0TbQ3WySGtdSvnfXm/Bxm35yfEqcLl6IphA==
X-Received: by 2002:adf:e084:: with SMTP id c4-v6mr608037wri.199.1535102450029;
        Fri, 24 Aug 2018 02:20:50 -0700 (PDT)
Received: from dell ([2.27.167.102])
        by smtp.gmail.com with ESMTPSA id s205-v6sm862354wmf.42.2018.08.24.02.20.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 Aug 2018 02:20:49 -0700 (PDT)
Date:   Fri, 24 Aug 2018 10:20:47 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sangbeom Kim <sbkim73@samsung.com>,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH 4/4] mfd: sec-core: Allow building as module
Message-ID: <20180824092047.GF28860@dell>
References: <20180807161125.18155-1-krzk@kernel.org>
 <20180807161125.18155-4-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180807161125.18155-4-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Aug 2018, Krzysztof Kozlowski wrote:

> The main MFD driver for Samsung PMICs (S2MPSXX, S5M876X) used with
> Exynos SoCs can be compiled and used as a module.  The dependent clock,
> regulator and RTC drivers already can be built as a module.
> 
> Building entire set of drivers as modules might require using initial
> ramdisk and can make booting process longer (due to probe deferrals).
> However adding such option is useful for testing and for multi-platform
> configurations.
> 
> This also add required module authors to sec-irq.c file based on recent
> main contributors.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/mfd/Kconfig   | 11 +++++++++--
>  drivers/mfd/sec-irq.c |  8 ++++++++
>  2 files changed, 17 insertions(+), 2 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
