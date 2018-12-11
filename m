Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 138E1C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDAAA20849
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:18:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dmI0lirt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDAAA20849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbeLKKSs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 05:18:48 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38064 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbeLKKSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 05:18:45 -0500
Received: by mail-wm1-f66.google.com with SMTP id m22so1617762wml.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 02:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=XQSqzYkDQfNpIAdcLVG6QmnQAH3ftItVxMqi2Hwvd04=;
        b=dmI0lirtFn80KA30Z8PuEGzUp8tA59Eg/FenbhyMoCh26AuPlL7riAn0lW+rQvpRXx
         ThxqOZ7XGrha1JBdJumCd6Ls7dt3p+QjtyncDOQVPlr4EzVBazEWsJY5RdYCGnA6vPS3
         t+hY5zOf/L7rUHHU2YE2bvB7uINIe9ZYwkXsc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=XQSqzYkDQfNpIAdcLVG6QmnQAH3ftItVxMqi2Hwvd04=;
        b=XEIkmK85hmOsgIf6nTcTQYywdY4Jr+PWGpG+FEmcKNXerddIHUuRfLi+eHshfI5wXX
         z2/9mvtjZKVrq4d2mi6O2u0TN2uP2R9Cmpof8DNTqbnXNlJvquwQhE4YmhniwijEyokI
         dtZidDpuyzBoRfgCxMrtNVIIp9f64jI6nB1Hr2WOIWTxvsI5qtyeqWz1DRqCshnCrp2Q
         Cl/5AEivb55u47q0fGwM0FTu1/RgcNS1/BJ5ftOvvU6woidWnYT2aFe2gwO0ezVV67Y/
         P87Np3s8Rtu9xVu3gtsQyHvzfbAL1Wuyv/ywrWxHxYrqXviV/bHPXWYQBIyzpazgeGYF
         BRhQ==
X-Gm-Message-State: AA+aEWbRg54Y2ug/FWOF3Kk616Q5x1OdpZOyWc1YFNtfa4SGiQxlFrbv
        46hcJYR821+EGYoWwIA7OnYAIJ3n0Nk=
X-Google-Smtp-Source: AFSGD/XNO7bKEhWXNh5Mmmbx3RgscQKBPCFefpqDhgPc+O97FY22IjwNFRmd4I83qWP17d1FlRq1Yg==
X-Received: by 2002:a1c:8c05:: with SMTP id o5mr1606175wmd.29.1544523523704;
        Tue, 11 Dec 2018 02:18:43 -0800 (PST)
Received: from dell (host109-155-202-221.range109-155.btcentralplus.com. [109.155.202.221])
        by smtp.gmail.com with ESMTPSA id w18sm10418502wru.54.2018.12.11.02.18.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 02:18:43 -0800 (PST)
Date:   Tue, 11 Dec 2018 10:18:41 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     groeck@chromium.org, gwendal@chromium.org, kernel@collabora.com,
        bleung@chromium.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] mfd: cros_ec_dev: Add missing mfd_remove_devices() call
 in remove
Message-ID: <20181211101841.GH4497@dell>
References: <20181210180002.4440-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181210180002.4440-1-enric.balletbo@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Dec 2018, Enric Balletbo i Serra wrote:

> The driver adds different MFD child devices via mfd_add_devices() and
> hence it is required to call mfd_remove_devices() to remove MFD child
> devices.
> 
> Fixes: 5e0115581bbc ("cros_ec: Move cros_ec_dev module to drivers/mfd")
> Cc: stable@vger.kernel.org
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> Hi Lee,
> 
> I saw that you send a mfd-fixes pull request this morning, so sorry in
> advance for sending this too late. This was broken since the driver
> moved from platform/chrome to mfd (and probably before that), so
> it's an old problem. Note that I plan to send a patch series that depends
> on this to apply cleanly. If the patch is fine with you and there is any
> possibility to go in this version that will be good, if not, let me know
> if you prefer queue this in your for-next branch or if you prefer I
> include the patch on the series I plan to send on top of it to not mess
> things.
> 
> Thanks,
>  Enric
> 
>  drivers/mfd/cros_ec_dev.c | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
