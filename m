Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF611C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 05:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B900220657
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 05:57:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bss3R4qH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729731AbfAQF5e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 00:57:34 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:47043 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727251AbfAQF5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 00:57:34 -0500
Received: by mail-pf1-f193.google.com with SMTP id c73so4256965pfe.13
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 21:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4TKZNjcxuP4sO2JiRTeBwn324kLziSG+kppWjp5xzaA=;
        b=Bss3R4qHvdznle1Mc0OQ2GOypH6c9UHi0A7XematgpUs3SsnqMhtwssmKzh37fEN7E
         TAgfD35w6SEjQQdHksbYmT1PwFo92zK6oP6GRBFROgzkm8434bwkFxJQP86Eu+De/rak
         z534Kr4qyBcCyIRJnIX01nH1eVUNZUTGseQ9g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4TKZNjcxuP4sO2JiRTeBwn324kLziSG+kppWjp5xzaA=;
        b=Q00m91AdHjIKa9zrIi1u6bziPdkKudnhh+PGiJzMB/o88450CiEqRoP503fU4sDDUL
         as0vBF6OGLDaQDAAvsa3sRMF6H4wWhxYyIZwOeIylBzR6lCpOuz1PHEDNgoEIPVpHEzB
         Y0VS3NTR9FHwILh9Lg4G1UxSpjrDlisOYTzl4CcpA0bkc9KQk0FMiVC8bYw0U9hMblpU
         lEIHcfR6NccEGfJPnTQt75vPaUddYgBn7bCuUgz/mo5GuOUIM0wQsyFTi2reCAN+xSQb
         0trev6qzPWAOUBNqxeSt5DfnYDeTsLaFXHhSSsCYKszOSXRZU1llteNPxtz4TT5YBjb5
         yKIw==
X-Gm-Message-State: AJcUukeyKsrY9iCtCMuCD6akjQ0spL5wfKeHUQBniBLaxuZMgn8JVKi6
        TWlEAHYQCwOnfmKypEJoraOMng==
X-Google-Smtp-Source: ALg8bN59gWCJCoUZ9gkqFrE8eXoeTQ9R1iVDaHgnPBRelpNH1QjMNtS9rr9imRpKhw/yS83x6VCnrg==
X-Received: by 2002:a62:cd44:: with SMTP id o65mr13579373pfg.222.1547704653293;
        Wed, 16 Jan 2019 21:57:33 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id o66sm1342009pgo.75.2019.01.16.21.57.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 21:57:32 -0800 (PST)
Date:   Thu, 17 Jan 2019 11:27:30 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, tdas@codeaurora.org, swboyd@chromium.org,
        dianders@chromium.org, mka@chromium.org,
        Javi Merino <javi.merino@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "open list:THERMAL/CPU_COOLING" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v2 9/9] thermal: cpu_cooling: Clarify error message
Message-ID: <20190117055730.7hxe37ngcubo6htw@vireshk-i7>
References: <cover.1547458732.git.amit.kucheria@linaro.org>
 <2de2d178380525191d99d6c3619ad8c45efdbab4.1547458732.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2de2d178380525191d99d6c3619ad8c45efdbab4.1547458732.git.amit.kucheria@linaro.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-01-19, 15:51, Amit Kucheria wrote:
> Make it clear that it is a failure if the cpufreq driver was unable to
> register as a cooling device. Makes it easier to find in logs and
> grepping for words like fail, err, warn.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  drivers/thermal/cpu_cooling.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
> index dfd23245f778..6fff16113628 100644
> --- a/drivers/thermal/cpu_cooling.c
> +++ b/drivers/thermal/cpu_cooling.c
> @@ -774,7 +774,7 @@ of_cpufreq_cooling_register(struct cpufreq_policy *policy)
>  
>  		cdev = __cpufreq_cooling_register(np, policy, capacitance);
>  		if (IS_ERR(cdev)) {
> -			pr_err("cpu_cooling: cpu%d is not running as cooling device: %ld\n",
> +			pr_err("cpu_cooling: cpu%d failed to register as cooling device: %ld\n",
>  			       policy->cpu, PTR_ERR(cdev));
>  			cdev = NULL;
>  		}

Always keep such cleanup patches at the top, so the maintainers can
pick them up easily even if the entire series doesn't get in.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
