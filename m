Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C607C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 11:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CACA720877
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 11:36:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TFphGy2w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CACA720877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732861AbeGKLkB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 07:40:01 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:50527 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732502AbeGKLkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 07:40:01 -0400
Received: by mail-wm0-f65.google.com with SMTP id v25-v6so2122814wmc.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 04:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=h3aMZ6FXJw6Kw0WxszNyGOVcLEYa+hf9k+Bh+XwaefU=;
        b=TFphGy2wTpdT8nRm5Hs2+X4LxjmZKYrT9+8uiSmf2aZl00/CdGpPmZOPSLuEEJlpkf
         sJH0GFTdV9Q+hb9sqes7vN0HyV8pPgGFkuBQtpOv0TkoxCbv7F0SE2LxxICtMUoj77PL
         1D+cUEq4dv4//RKbS/zrSsVnKLHgkUuHluQ90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=h3aMZ6FXJw6Kw0WxszNyGOVcLEYa+hf9k+Bh+XwaefU=;
        b=a0GrMxug6TzLGidQa3lWF+8OST2TmdgPUtZ85Sc2FFII6UXAvsHgJCniWJmZd97KJG
         AzJlSO2ZvPyyEwSGslI2xpD54xVzzwpA9fhqOp4Es7swVCfW21DPR1P+2IunhwBosdMp
         QlQWlv6b2Gbd+6/KxvdAeUHs6UJ+xPFDkkwlM1S56XUYhBgX0aHK4jx6OS07U9ta8NDa
         OyJjfWqaiR4YpgA1HHjs9chU2BhCCvCyePNmQNfjNUnN5p2eKkV7N9LmaW+Qa1lgE/ls
         h6biH2W5EZsI3ye+qRVlWVzZdkfjC81rVvPdy6fif7ORgMa3m5X+O8lh4E1fvX4Qseiq
         LCdA==
X-Gm-Message-State: APt69E3oITN6ydFXsZEiwW+bNCKuKz0BA7UY428AgzLr5DUeb4POMfYP
        fJQKnwtKg8iC2lhb3JJCvsa7Vw==
X-Google-Smtp-Source: AAOMgpejgCQXspu8YiibR7Om/kFyl16lr9+/vk7GIWAO8U50BqpwayIgUMM4RPeMo0n+RlGosa24vg==
X-Received: by 2002:a1c:8010:: with SMTP id b16-v6mr18578389wmd.41.1531308964174;
        Wed, 11 Jul 2018 04:36:04 -0700 (PDT)
Received: from [192.168.8.101] ([37.173.39.171])
        by smtp.googlemail.com with ESMTPSA id b198-v6sm2260164wme.11.2018.07.11.04.36.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 04:36:03 -0700 (PDT)
Subject: Re: [PATCH 1/3] clocksource: drivers: set clockevent device cpumask
 to cpu_possible_mask
To:     Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Santosh Shilimkar <ssantosh@kernel.org>
References: <1531308264-24220-1-git-send-email-sudeep.holla@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <2009eeb1-e925-fe5c-ac4a-9f3e41945127@linaro.org>
Date:   Wed, 11 Jul 2018 13:36:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1531308264-24220-1-git-send-email-sudeep.holla@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/07/2018 13:24, Sudeep Holla wrote:
> Currently, quite a few clockevent devices have cpumask set to
> cpu_all_mask which should be fine. However, cpu_possible_mask is more
> accurate and if there are any other clockevent devices in the system
> which have cpumask set to cpu_possible_mask, then having cpu_all_mask
> may result in issues (mostly boot hang with forever loops in
> clockevents_notify_released).
> 
> So, lets replace all the clockevent device cpu_all_mask to
> cpu_possible_mask in order to prevent above mentioned possible issue.
> 
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Jonathan Hunter <jonathanh@nvidia.com>
> Cc: Santosh Shilimkar <ssantosh@kernel.org>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---

Applied, thanks for the fix.


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

