Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F24DC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 05:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D206D2146F
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 05:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LeYHtHlz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D206D2146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbeKUQ0U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 11:26:20 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40186 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbeKUQ0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 11:26:20 -0500
Received: by mail-pl1-f196.google.com with SMTP id b22-v6so3830485pls.7
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 21:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QBcR7uWeipWFmLLLEnJjFPKwGMJb48AaryWeunUlWao=;
        b=LeYHtHlzEMqt5rFVQ6Z6gji/7JSTutUIbxeV0Ugi98zxX7tmiYemwvgOs3qpBK6dCn
         zl/WVy1gw4uH3GLAo+6o7XM+KoGpo9UDCz14FZ8QvbKDDuBuPQNb4oTblf1baivpe+Bq
         oXbpRXPuFcrGhF4EwQYyTMCQZiTWYyiS9XeFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QBcR7uWeipWFmLLLEnJjFPKwGMJb48AaryWeunUlWao=;
        b=QTJaCJkLVZSRz7CZz3XsEbVQPiT72RdSw56GRpwqjRF7aMUBOiKl5WNXYGz2q+nCuq
         CbwzuULvt2XBFbJbVEW76Dq5NUDLSlXgXo/jNSpW78kGuwfSUnYiQ0TmN0YOBQIMZ6Ul
         mAuWqIv5106y5ttl1WXyE2d1eHqZTN3D8gbeFwhHQJn8xUv4DXRqFuyJyYDcnC3WRpEd
         rYrhkUrj5nJaUWPuQTpXU9VXTr700ZX5AfUDI+NAEfinOnFCiQza8gfAN/3Vj9HySTRm
         KrgUuHt8t4JHH6Pz5IIUx/PjGkcFVYbMQuyKg0Wv7g8UzXxgXcOOSJyEBDsyd1VQx5q3
         0y2w==
X-Gm-Message-State: AGRZ1gKZSCRDqla4hqrc13XTd79dBcOoztIMxFHkoZ2we4oFgk1oOqYj
        Z/h837Tbql8+x1sKvyEIGYZmrg==
X-Google-Smtp-Source: AJdET5e7ui5Ud+n+oUCdP/d7v70SoaPE5cpolYmLorSJQ1EqtgvJpKnJreQlr7i2I9fOd8X5QWF0XQ==
X-Received: by 2002:a62:15c3:: with SMTP id 186mr5562156pfv.240.1542779598055;
        Tue, 20 Nov 2018 21:53:18 -0800 (PST)
Received: from localhost ([122.172.88.116])
        by smtp.gmail.com with ESMTPSA id q187sm58629674pfq.128.2018.11.20.21.53.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 21:53:17 -0800 (PST)
Date:   Wed, 21 Nov 2018 11:23:15 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V5 1/2] thermal: imx: fix for dependency on cpu-freq
Message-ID: <20181121055315.cq5svzmddaavw3su@vireshk-i7>
References: <1542779052-29536-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542779052-29536-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-11-18, 05:49, Anson Huang wrote:
> The thermal driver is a standalone driver for monitoring SoC temperature
> by enabling thermal sensor, so it can be enabled even when CONFIG_CPU_FREQ
> is NOT set. So remove the dependency with CPU_THERMAL.
> 
> Introduce dummy function of legacy cooling register/unregister to make
> thermal driver probe successfully when CONFIG_CPU_FREQ is NOT set.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/thermal/Kconfig       |  2 +-
>  drivers/thermal/imx_thermal.c | 47 ++++++++++++++++++++++++++++++++-----------
>  2 files changed, 36 insertions(+), 13 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
