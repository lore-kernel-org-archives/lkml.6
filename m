Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B87C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 04:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9880220827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 04:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KqsYdDW2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9880220827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbeKHOU7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 09:20:59 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40884 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728878AbeKHOU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 09:20:59 -0500
Received: by mail-pg1-f194.google.com with SMTP id z10so6440039pgp.7
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 20:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kEbBMLrTo33kFHUposH1DWY8Gl4NRhkrpsPCHP2Ayu0=;
        b=KqsYdDW2wrtfxSR549cn1E3oXFG40jbictlVLlQIPHpK1u6K4EgTL63cgm8XdRKSIS
         BxjN+TjivEDl3AjJYjAcUUbbORc4QKYBIGyo6wSrwKbeJ1dtQRyJUaDOuJHiPwE9Axvp
         YhBM4Gke3xgMkhVPZCgi8xFj063P2o2Pao7OA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kEbBMLrTo33kFHUposH1DWY8Gl4NRhkrpsPCHP2Ayu0=;
        b=nyOmglqAKmtdWV+Z0Dmiwi91BmYRqrVlWMO3GggxmAtbfvzhaiFXMFpVU+P8mRV6SG
         85aW8q7GUOITmEgo9EUQ/UXZUjhUiznQBxFp4y9huWDL3UoMRojC8hb5Dzx1tw+/8jTx
         YaIgY0xdS6+YEpqR2es1vpm1ZTCL/3blfy2npI12hax3AYsfdbb/ryTIBi4L9XSUKsT7
         2bzgBW+u6/dtXoKWImvF1L8eir75iLzcDAaODyHqgMChn9hzYkfMa1GDgGYPqXsfIXWr
         4AydmB3oRhBPZmYctsIKUE5ZwrljBBOAzoWkEDj8nA6zMUCA0P+CvnxL1ktpike8zrYA
         8TUg==
X-Gm-Message-State: AGRZ1gJRAlZHJtSXwpRrR0zo9QbeUZiRmANn+BVbx8CRPwzeqQKlbMxH
        SQAmpxp6bTZZF0ILJCL6zKKH1Q==
X-Google-Smtp-Source: AJdET5eOoGU982acYRKOgDMTMv+O9009sLvx3sqGbwkIOLvz50oEECRmayHyBTc+GcU9BdBsm3A3vQ==
X-Received: by 2002:a63:d846:: with SMTP id k6mr2679812pgj.251.1541652441413;
        Wed, 07 Nov 2018 20:47:21 -0800 (PST)
Received: from localhost ([171.61.116.174])
        by smtp.gmail.com with ESMTPSA id f18-v6sm5505116pfh.0.2018.11.07.20.47.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 20:47:20 -0800 (PST)
Date:   Thu, 8 Nov 2018 10:17:18 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/9] arm64: defconfig: Drop ARM_BIG_LITTLE_CPUFREQ
Message-ID: <20181108044718.qkvw55srkctfkkye@vireshk-i7>
References: <8b49a92b-ca92-1fca-cd09-3bcd7a3dcbb9@free.fr>
 <596a4b64-e2ef-878d-0873-dd59d14c2d85@free.fr>
 <147b3b1d-e395-7e8c-c1e9-7995d1abddfe@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <147b3b1d-e395-7e8c-c1e9-7995d1abddfe@free.fr>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-11-18, 21:54, Marc Gonzalez wrote:
> [ Add interested parties ]
> 
> On 07/11/2018 21:14, Marc Gonzalez wrote:
> 
> > Commit a7314405d83c ("drop ARM_BIG_LITTLE_CPUFREQ support for ARM64")
> > 
> > Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
> > ---
> >  arch/arm64/configs/defconfig | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> > index f786c95504d3..8d6878c1e794 100644
> > --- a/arch/arm64/configs/defconfig
> > +++ b/arch/arm64/configs/defconfig
> > @@ -107,7 +107,6 @@ CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y
> >  CONFIG_CPUFREQ_DT=y
> >  CONFIG_ACPI_CPPC_CPUFREQ=m
> >  CONFIG_ARM_ARMADA_37XX_CPUFREQ=y
> > -CONFIG_ARM_BIG_LITTLE_CPUFREQ=y
> >  CONFIG_ARM_SCPI_CPUFREQ=y
> >  CONFIG_ARM_TEGRA186_CPUFREQ=y
> >  CONFIG_ARM_SCPI_PROTOCOL=y

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
