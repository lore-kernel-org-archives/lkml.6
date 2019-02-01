Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98BCBC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 06:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62A8920869
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 06:19:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="X3v0Q65p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbfBAGT6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 01:19:58 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42973 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbfBAGT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 01:19:57 -0500
Received: by mail-pl1-f195.google.com with SMTP id y1so2662984plp.9
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 22:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=k6egFMNb7fOzEGOS2UMwhAqzuL31g0z8LHt6VmEc6LE=;
        b=X3v0Q65p6qWQaTE4u2xVlf65ns6vW9LFrEmqPUSn9VPfY2qYd+sqQB9procRQIAFAa
         DVumimwEXgs83a2i4hXMfdNnFoct+obDc2CkDVtzapjsfVgRnxLjK7cDrNAFcQ0i2+Q3
         /Re901vOMwBdRwdvxu8faL3Kxha9P8RA4erQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=k6egFMNb7fOzEGOS2UMwhAqzuL31g0z8LHt6VmEc6LE=;
        b=J6poTwzAEcVgTCdJXHSLCVbIxGmc/WVDPSGuSv4tnCQrpMkzoCOBlpImLMNW2nJUAO
         UKoWauzFvpZixeX26ONkCYUHREdDO6O/dSyY1XkZuGq1R6Yi9CJTy3v0ou84cwGWnULK
         gJNWuj9njgMceYhNuEuex9Ae9bcLNLHfjxSBOm7KgV13OrECk6A+J+TwlHA12imAj39h
         AFPM6UfYHZvNrSjZotC4pZ5RjzEBnyCCO8Ple2g/oLfeVNApVrjoA7EPsaIDOVvuMsu0
         onF/5OduMCxJWOSgDPiQShrVlsV4K3RrN5U0CyqEC246UVYk6fpweh9T3AQOAlTyDciO
         CI4w==
X-Gm-Message-State: AJcUuke185Daxwv9/Pe1D2XQpCqwKRhbgPMQIdTWfKMi1vbBoSp0cbhn
        jAICgkUDP3k2Mqb2fQqYCNzueg==
X-Google-Smtp-Source: ALg8bN581Ywp4hX8i6Du+Le9kqZnJvrxghv5ZIdLcSGiPpPHT7BqzlwGoTJDFHNFvoGywVSd49MArA==
X-Received: by 2002:a17:902:48:: with SMTP id 66mr36992432pla.68.1549001996982;
        Thu, 31 Jan 2019 22:19:56 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id d16sm7047740pgj.21.2019.01.31.22.19.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 22:19:56 -0800 (PST)
Date:   Fri, 1 Feb 2019 11:49:54 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Taniya Das <tdas@codeaurora.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, amit.kucheria@linaro.org,
        Matthias Kaehlcke <mka@chromium.org>, evgreen@google.com
Subject: Re: [PATCH v6] cpufreq: qcom: Read voltage LUT and populate OPP
Message-ID: <20190201061954.ly2aisvwz3bftd5o@vireshk-i7>
References: <1548955970-2897-1-git-send-email-tdas@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548955970-2897-1-git-send-email-tdas@codeaurora.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31-01-19, 23:02, Taniya Das wrote:
> Add support to read the voltage look up table and populate OPP for all
> corresponding CPUS for consumers like the energy model could use the
> frequency and voltage from the OPP tables. Also update the logic to not add
> duplicate OPPs.
> 
> Tested-by: Matthias Kaehlcke <mka@chromium.org>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---
>  drivers/cpufreq/qcom-cpufreq-hw.c | 46 +++++++++++++++++++++++++++++++--------
>  1 file changed, 37 insertions(+), 9 deletions(-)

Applied. Thanks.

-- 
viresh
