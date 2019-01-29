Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01AB7C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 05:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C10632148E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 05:31:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ECy16EZ/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbfA2Fbi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 00:31:38 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43971 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbfA2Fbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 00:31:36 -0500
Received: by mail-pl1-f194.google.com with SMTP id gn14so8844160plb.10
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 21:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vlg5RKRyPLWXTBq2LOJACwgaidg3unYs3d3ZnrY1INg=;
        b=ECy16EZ/Y6jE+aah4EZBoP9nZOEXtsKfUWIryo38B6bgh6TVGV9dDCHanABhvtGZVX
         ffJib29zhxcAq5wViyxusDnC/DTkY9Oc73fErmpRFl9txBMHeXO26ChZ+7JrlpUM0x1S
         2u5Dv23rssSMZt4BK3bQ9Zu6sqFaWt9XJxvDc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vlg5RKRyPLWXTBq2LOJACwgaidg3unYs3d3ZnrY1INg=;
        b=AkBI++91hL6BYvRSH3ld+seCihoDAGcptnZH59420ou7DLQWMPoZZi5sQaZgEjKErk
         qTDLvC9NBtMUzmbdJuJEiO8AtV3T+Pgml9N32xBirDhqHM/GNLt61tIvX9YWglzi/DFk
         onz4/btXczZglMauwRMnCbwE0bM6WHEBSPFTtbirPW1cYxzrVtZo+AMrO8Nh5XhoKkn2
         +mb4t9sIiYTQ3eQ3BbyQ7l54SD1KkF4XFThDoAzhzv5Ez8lBG/v30e4xP2CTc4oRC6Jt
         A5N1H5jNg9oJvdH+X28QLxo49DrZ6aCqf+IPINxbchrAnrNEHF8QlzHFjei/woNA6Zwq
         FPZw==
X-Gm-Message-State: AJcUukfvHXo8Sr/7FaywPMOqFx4I4LTWcIxARzQgupQC70FAGWIAORnR
        G+0yfWWCa6VBAhHo7TcAlUvpFw==
X-Google-Smtp-Source: ALg8bN75XfWs0sEQP9p9INBUSDRQFrbDis5v2xtNgT6H/5XHiIo7Z6C8xD+kW/R+/RqQiO3gpW/7Ng==
X-Received: by 2002:a17:902:29ab:: with SMTP id h40mr24527616plb.238.1548739896184;
        Mon, 28 Jan 2019 21:31:36 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id 15sm59474176pfr.55.2019.01.28.21.31.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 21:31:35 -0800 (PST)
Date:   Tue, 29 Jan 2019 11:01:33 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     rjw@rjwysocki.net, sudeep.holla@arm.com, liviu.dudau@arm.com,
        lorenzo.pieralisi@arm.com, robh+dt@kernel.org,
        mark.rutland@arm.com, nm@ti.com, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        dietmar.eggemann@arm.com, mka@chromium.org
Subject: Re: [PATCH 3/7] cpufreq: scpi: Register an Energy Model
Message-ID: <20190129053133.l5wix4qgvty7bzig@vireshk-i7>
References: <20190128165522.31749-1-quentin.perret@arm.com>
 <20190128165522.31749-4-quentin.perret@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190128165522.31749-4-quentin.perret@arm.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-01-19, 16:55, Quentin Perret wrote:
> Now that PM_OPP provides a helper function to estimate the power
> consumed by CPUs, make sure to try and register an Energy Model (EM)
> from scpi-cpufreq, hence ensuring interested subsystems (the task
> scheduler, for example) can make use of that information when available.
> 
> Signed-off-by: Quentin Perret <quentin.perret@arm.com>
> ---
>  drivers/cpufreq/scpi-cpufreq.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/scpi-cpufreq.c b/drivers/cpufreq/scpi-cpufreq.c
> index 87a98ec77773..05fc7448f5cb 100644
> --- a/drivers/cpufreq/scpi-cpufreq.c
> +++ b/drivers/cpufreq/scpi-cpufreq.c
> @@ -23,6 +23,7 @@
>  #include <linux/cpufreq.h>
>  #include <linux/cpumask.h>
>  #include <linux/cpu_cooling.h>
> +#include <linux/energy_model.h>
>  #include <linux/export.h>
>  #include <linux/module.h>
>  #include <linux/of_platform.h>
> @@ -98,11 +99,12 @@ scpi_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask)
>  
>  static int scpi_cpufreq_init(struct cpufreq_policy *policy)
>  {
> -	int ret;
> +	int ret, nr_opp;
>  	unsigned int latency;
>  	struct device *cpu_dev;
>  	struct scpi_data *priv;
>  	struct cpufreq_frequency_table *freq_table;
> +	struct em_data_callback em_cb = EM_DATA_CB(of_dev_pm_opp_get_cpu_power);
>  
>  	cpu_dev = get_cpu_device(policy->cpu);
>  	if (!cpu_dev) {
> @@ -135,6 +137,7 @@ static int scpi_cpufreq_init(struct cpufreq_policy *policy)
>  		ret = -EPROBE_DEFER;
>  		goto out_free_opp;
>  	}
> +	nr_opp = ret;

Same comment here.

-- 
viresh
