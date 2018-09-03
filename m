Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E80C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 06:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6099020862
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 06:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CecH0gDe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6099020862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbeICKxh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 06:53:37 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34735 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbeICKxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 06:53:37 -0400
Received: by mail-pg1-f196.google.com with SMTP id d19-v6so8141880pgv.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Sep 2018 23:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3VMVK5SW3T+Wj1rpqaD9HC8NGtMPM7CRA5mmKV2xeDk=;
        b=CecH0gDeh4MKfuFAYqaU/NQfI+nxrdRjS9p5ZPSHK7j6/dUR1sxktnpWxLiU0zdZHN
         7BaFO09CVVlYYWyIi0YOcVzKb+fvJhSJRSil3c4Efo2zY5O/cjitcriPXM9VJB7IQEL2
         CqdDBP3LrKzmUakV+DaztydKgjqVxol9lW/zE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3VMVK5SW3T+Wj1rpqaD9HC8NGtMPM7CRA5mmKV2xeDk=;
        b=l4nOGtbVly0CBffL9WhkFtUlYjnUCVzW8+YAzw1yjTkER0t3T/jDyWbi/V4FJiME8L
         mfatRlsLPAi9oUvK4kpi0LkRALoU96t2Ix1KcQBZXiwMY+7bwburGj7kIYeHOCDC8BpU
         G4zwxJVyynqQUQXFUAhcYipmTPwJIsl3IhENrRB9eNNaAtsM1i/4TG+iZdomVUTElObS
         /o7UF8e4/JbkTPp0TdrqbBm9XjSu4cO/hf5Ey0/xYvWgkD0Ryggr+gcPOY/FjaypThyx
         RDCxWHFrDhPlu1HEpJX/0pfekTS+adZ2xOaQSkc8LMgJnZPM0gcOEkGwCglT3ZzWkPVU
         Cpdg==
X-Gm-Message-State: APzg51CCIGaRSg4fO8wLqPXwESiNAJ2+C91yrk9MHvp5qqduiDvuM9b4
        T4VaaPRTqQV8hQKymR4sbVhrYQ==
X-Google-Smtp-Source: ANB0VdYt0+3SgAQ77WYH7QkrOPsSuz5Rzju6EyFVj0pnMyUuVwLHisRmMIN4hUXcLqCBfRPGLnSwpw==
X-Received: by 2002:a62:3c7:: with SMTP id 190-v6mr27605867pfd.145.1535956495043;
        Sun, 02 Sep 2018 23:34:55 -0700 (PDT)
Received: from localhost ([122.171.76.41])
        by smtp.gmail.com with ESMTPSA id f11-v6sm22713515pfa.131.2018.09.02.23.34.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Sep 2018 23:34:54 -0700 (PDT)
Date:   Mon, 3 Sep 2018 12:04:52 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] cpufreq: Convert to using %pOFn instead of
 device_node.name
Message-ID: <20180903063452.mmybo2f7izvqjhci@vireshk-i7>
References: <20180828015252.28511-1-robh@kernel.org>
 <20180828015252.28511-14-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180828015252.28511-14-robh@kernel.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27-08-18, 20:52, Rob Herring wrote:
> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.
> 
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-samsung-soc@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/cpufreq/s5pv210-cpufreq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/s5pv210-cpufreq.c b/drivers/cpufreq/s5pv210-cpufreq.c
> index 5d31c2db12a3..dbecd7667db2 100644
> --- a/drivers/cpufreq/s5pv210-cpufreq.c
> +++ b/drivers/cpufreq/s5pv210-cpufreq.c
> @@ -611,8 +611,8 @@ static int s5pv210_cpufreq_probe(struct platform_device *pdev)
>  	for_each_compatible_node(np, NULL, "samsung,s5pv210-dmc") {
>  		id = of_alias_get_id(np, "dmc");
>  		if (id < 0 || id >= ARRAY_SIZE(dmc_base)) {
> -			pr_err("%s: failed to get alias of dmc node '%s'\n",
> -				__func__, np->name);
> +			pr_err("%s: failed to get alias of dmc node '%pOFn'\n",
> +				__func__, np);
>  			of_node_put(np);
>  			return id;
>  		}

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
