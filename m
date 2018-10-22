Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 896C9C67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 05:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35BDE2083A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 05:36:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="j11NOVAA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35BDE2083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbeJVNxk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 09:53:40 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46404 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727388AbeJVNxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 09:53:40 -0400
Received: by mail-pg1-f194.google.com with SMTP id r190-v6so6853765pgr.13
        for <linux-kernel@vger.kernel.org>; Sun, 21 Oct 2018 22:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7Qi2tehAH9db0RX2ZFZ7EVrRNPifGdb6V7nyOEmMy9o=;
        b=j11NOVAABIGpEUhIX8U1o1QeDg50cKBJdsvrnGKuaeJ9Cnphyg0yJ4kZI/t//XPGk0
         2MGhO0oDcpC0FuypifgWbPQyfmNYfFj+RiTdHupR6Tgxc2licpVkiEfMrX+tVhcD6fzw
         jT69vuM7xwN1eT2+awSOaaO7Z0GcVexKVoSso=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7Qi2tehAH9db0RX2ZFZ7EVrRNPifGdb6V7nyOEmMy9o=;
        b=X+AFzpvHcBXcLBzVO6t1ZTCmiuM8Ppi0uSlcKZJl5X1t68KEgBU1rlMDYOZ2s9X5km
         ut0lUVkcmo/xNgwAINLSXcQITSNQCXGfTB3NVoLDSVambUjEB/Nc8rYWUxvQ/bgXnoKE
         MdIBYDPWzCJSbzv7JL2mg5ISUeBriKtsrW6NukNCNpeesft8GTwgoMqM0uA7Bfhdma/S
         O3mtXt21p9WCTarOQKSmGpsSWstL4XHxuDlCxKsycIIzgthMWp1ab4SpiVT1Rb8jxr2H
         YADl5ehLdzjWt3UGVV8P44TXWNsRJykSrxLXPlu2uT7H3KWXGnT+Np3Rd4brR1Y4WW8D
         sMXg==
X-Gm-Message-State: ABuFfoh6DJbwmHwU4IDGiNO2J8Wt77bW/d40h93v7dJwXWc6cgyL/Blo
        HUu/IjmHnUO38Q7VbBnfG1sg8Q==
X-Google-Smtp-Source: ACcGV63RGXvuE/aPew/lGdOJAIAYN/d3A0K94IXQf9f+dvoVA1mja1EAToDNwGBw5nyoNyQhQcf9ug==
X-Received: by 2002:a62:d085:: with SMTP id p127-v6mr18413773pfg.202.1540186600261;
        Sun, 21 Oct 2018 22:36:40 -0700 (PDT)
Received: from localhost ([122.172.217.9])
        by smtp.gmail.com with ESMTPSA id k132-v6sm179281pga.28.2018.10.21.22.36.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Oct 2018 22:36:39 -0700 (PDT)
Date:   Mon, 22 Oct 2018 11:06:36 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 01/17] OPP: Allow to request stub voltage
 regulators
Message-ID: <20181022053636.ag62j3rj3vovbz53@vireshk-i7>
References: <20181021205501.23943-1-digetx@gmail.com>
 <20181021205501.23943-2-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181021205501.23943-2-digetx@gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-10-18, 23:54, Dmitry Osipenko wrote:
> Voltage regulators may be not available on some variations of HW, allow to
> request stub voltage regulators by OPP core in a such case to reduce code
> churning within drivers.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/cpufreq/cpufreq-dt.c | 2 +-
>  drivers/cpufreq/ti-cpufreq.c | 3 ++-
>  drivers/opp/core.c           | 9 +++++++--
>  include/linux/pm_opp.h       | 4 ++--
>  4 files changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
> index e58bfcb1169e..6ebca472ec76 100644
> --- a/drivers/cpufreq/cpufreq-dt.c
> +++ b/drivers/cpufreq/cpufreq-dt.c
> @@ -196,7 +196,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
>  	 */
>  	name = find_supply_name(cpu_dev);
>  	if (name) {
> -		opp_table = dev_pm_opp_set_regulators(cpu_dev, &name, 1);
> +		opp_table = dev_pm_opp_set_regulators(cpu_dev, &name, 1, false);
>  		if (IS_ERR(opp_table)) {
>  			ret = PTR_ERR(opp_table);
>  			dev_err(cpu_dev, "Failed to set regulator for cpu%d: %d\n",

Have you actually tested this stuff ? The cpufreq-dt driver will
probably fail to probe if the CPU node has a "-supply" property, but
no regulator matching that.

-- 
viresh
