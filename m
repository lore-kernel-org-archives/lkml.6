Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C96C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 06:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 830F021773
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 06:44:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hx6Al5qU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727410AbfAJGoW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 01:44:22 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41900 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbfAJGoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 01:44:21 -0500
Received: by mail-pl1-f193.google.com with SMTP id u6so4763983plm.8
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 22:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YFBDM9UHAyp1DRu2iDrvsZu44YHmW0/JlZ/lx8yIDOs=;
        b=hx6Al5qUI75c1yCXKHwi0EqRScoYdeXvG7WLXUL7U1R5KhbPZUKL9HB6N3CFblaZIe
         CFf1Lhya+EKdZ4DT5yW2iUuItzEjz3dEKOIwrtxDio/fdVfdbcsvFyXkAYLkpmcFUsl5
         sQyrSyJieGWFNKyC7ZVTSK+HJBWddWxwBxcAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YFBDM9UHAyp1DRu2iDrvsZu44YHmW0/JlZ/lx8yIDOs=;
        b=esdRAoWeyxv9CrS5UdE55dg6LM5HOm263+eiJFNhFxD+3S5eX5A1IaDU42wS3JHSnV
         6yorcIZaBqNYOE77nQ/5MmN4oBVDba/zhKxjl1VNoVfr8miHTpBciTBOftms5k2AE+I3
         nJK5PcXaRMhBaxqCH8Yu6w5jA7Kdw618Qc/7mW7SGlhkp9ouATbFADqYJ3Nb67JmgPyI
         Gxr8B9uSeEB1LCN6emYe7xbGNC6vZ1SUvLYNmZfVP3tSTzda9P1ViaIpb5tKmnM/6Omv
         d09zbW38Z5jbRU5C/obcBXZsXy8CAmPfzU7Dq+fkVD+XFS+QLNpTRd8xegSsuspPX/iU
         gVtw==
X-Gm-Message-State: AJcUukemww4Bn8bukBv29V+QQdLMOnXRLMVNEZO+EzeuopwqU4HH+2Qy
        krcE6VEQeGqQw9QY9oB02zvSOw==
X-Google-Smtp-Source: ALg8bN7Z/Lv1L5XqrPRI2emC8o+eVIxCRstcm3r3ZswYItFZvq09iymyolz2iuUyLSas82JknTl9eg==
X-Received: by 2002:a17:902:6b49:: with SMTP id g9mr9009429plt.98.1547102660985;
        Wed, 09 Jan 2019 22:44:20 -0800 (PST)
Received: from localhost ([122.166.131.155])
        by smtp.gmail.com with ESMTPSA id b5sm173177295pfc.150.2019.01.09.22.44.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 22:44:20 -0800 (PST)
Date:   Thu, 10 Jan 2019 12:14:18 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, tdas@codeaurora.org, swboyd@chromium.org,
        dianders@chromium.org, mka@chromium.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "open list:CPU FREQUENCY DRIVERS" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v1 4/7] cpufreq: qcom-hw: Move to device_initcall
Message-ID: <20190110064418.qahzyonqoane3xhp@vireshk-i7>
References: <cover.1547078153.git.amit.kucheria@linaro.org>
 <f62562bb1f8ffc021a814707e0c74a91d5d0746f.1547078153.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f62562bb1f8ffc021a814707e0c74a91d5d0746f.1547078153.git.amit.kucheria@linaro.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-01-19, 05:30, Amit Kucheria wrote:
> subsys_initcall causes problems registering the driver as a thermal
> cooling device.
> 
> If "faster boot" is the main reason for doing subsys_initcall, this
> should be handled in the bootloader or another boot constraint
> framework.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  drivers/cpufreq/qcom-cpufreq-hw.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> index d83939a1b3d4..649dddd72749 100644
> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> @@ -296,7 +296,7 @@ static int __init qcom_cpufreq_hw_init(void)
>  {
>  	return platform_driver_register(&qcom_cpufreq_hw_driver);
>  }
> -subsys_initcall(qcom_cpufreq_hw_init);
> +device_initcall(qcom_cpufreq_hw_init);
>  
>  static void __exit qcom_cpufreq_hw_exit(void)
>  {

Applied. Thanks.

-- 
viresh
