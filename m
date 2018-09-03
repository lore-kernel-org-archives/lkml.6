Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F21AC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 06:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BA2020843
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 06:39:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="emRamXuU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BA2020843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbeICK6P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 06:58:15 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34198 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbeICK6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 06:58:15 -0400
Received: by mail-pf1-f194.google.com with SMTP id k19-v6so8255634pfi.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Sep 2018 23:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Z4ve4EgeoinRXXJsFU9DAlQrZrrJ0q9VszNQQ4iZTeA=;
        b=emRamXuUnrhV0xkq3RIO4sX4h+mBdZVxedP4t6CR4dEZc301ATiLZ/MAwMrXkYc3m0
         zecYN2X6QD9hhxafA0HDwO3P/9XrvaFoBzvkIJLBFWZkvUvDg++aW9z/Cmdbf8+MLkNH
         jzEP7jW1YA8rX9P0djSGVXG5ODaTDD2WDvZGg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z4ve4EgeoinRXXJsFU9DAlQrZrrJ0q9VszNQQ4iZTeA=;
        b=QEDrpD8dYJ+XrkByv5ygi/lv969C7dNqbb2mfOZ8rrXVPqcW/hYmPtQGNsbR4l6kaD
         MSHKsGXJ0KMRw/M32GNfx7eix4YNOtDR116CXRjC9kLXK5n+xWuw1vrfYNxhx/wDSap0
         UwdmigJ+huqU3Bg3z6qWT5xRV2XjwoDk6k+wUg1TF0ShcPerFLiicX9B9mUuBDki98b2
         BIgK4lPV1qjFrFZJ3o/S8aCGvZdmFaAO41i4ZV0npFpDffChl5E10KEoCTB02U52bdbA
         ET/qovkP9IRpSyAQnNSPIHb9fIBOKPOov/vDqyyBmRA6sCtw46fd4e2LFPpJhIjSE6sC
         fdBg==
X-Gm-Message-State: APzg51DnfBbIMBoQH3lXpihUHitYAQj7CMXOXRoOKmFIkEQ05mWWDVnl
        6srxCujTatcfL6IEL6FiLtsuvQ==
X-Google-Smtp-Source: ANB0VdYs77y2SFRk/7P752tWOB2gXOpk9XWg70uKLMw+9jupgd3hfLzhmY6Wi6Y2+9UexNtHrgUCjw==
X-Received: by 2002:a65:4043:: with SMTP id h3-v6mr20674138pgp.207.1535956771904;
        Sun, 02 Sep 2018 23:39:31 -0700 (PDT)
Received: from localhost ([122.171.76.41])
        by smtp.gmail.com with ESMTPSA id 16-v6sm28966638pfo.164.2018.09.02.23.39.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Sep 2018 23:39:31 -0700 (PDT)
Date:   Mon, 3 Sep 2018 12:09:29 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, punit.agrawal@arm.com,
        edubezval@gmail.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2] dt-binding: arm/cpus.txt: fix
 dynamic-power-coefficient unit
Message-ID: <20180903063929.oic5rgynzos2a4s2@vireshk-i7>
References: <1535526518-29022-1-git-send-email-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1535526518-29022-1-git-send-email-vincent.guittot@linaro.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-08-18, 09:08, Vincent Guittot wrote:
> The unit of dynamic-power-coefficient is described as mW/MHz/uV^2 whereas
> its usage in the code assumes that unit is uW/MHz/V^2
> 
> In drivers/thermal/cpu_cooling.c, the code is :
> 
> power = (u64)capacitance * freq_mhz * voltage_mv * voltage_mv;
> do_div(power, 1000000000);
> 
> which can be summarized as :
> power (mW) = capacitance * freq_mhz/1000 * (voltage_mv/1000)^2
> or
> power (mW) = (capacitance * freq_mhz * (voltage_mv/1000)^2) / 1000
> then
> power (mW) = power (uW) / 1000
> so
> power (uW) = capacitance * freq_mhz * (voltage_mv/1000)^2
> 
> Furthermore, if we test basic values like :
> voltage_mv = 1000mV = 1V
> freq_mhz = 1000Mhz
> 
> The minimum possible power, when dynamic-power-coefficient equals 1, will
> be with current unit:
> min power = 1 * 1000  * (1000000)^2 = 10^15 mW
> which is not realistic
> 
> With the unit used by the code, the min power is
> min power =  1 * 1000 * 1^2 = 1000uW = 1mW which is far more realistic
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/cpus.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
