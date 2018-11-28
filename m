Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0065EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 22:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6CA62081C
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 22:23:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PUaYlVLj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6CA62081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbeK2J0r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 04:26:47 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39939 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727368AbeK2J0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 04:26:46 -0500
Received: by mail-pg1-f194.google.com with SMTP id z10so10123589pgp.7
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 14:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WT+OyciSn6tm60G+djLo1QOuzRI00eAck3T2zc1OecU=;
        b=PUaYlVLjG9y87eq/KazmTUgNZepc6InldOAcRlp3/N+0D5akM51lsNGmPCpB5vbkvx
         gpzTQwOJcko0mMjcFOEmTOBgoRR5wpbX9+Ze+SBp9tMOe8dYYvOIXTJ8p6VIeaRxqonN
         ArIo7YWd68dtDwX3k+6+ufaRjB4kxhsCLnnjo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WT+OyciSn6tm60G+djLo1QOuzRI00eAck3T2zc1OecU=;
        b=ap253sgZgJUCrJAJ9NJEhVIrGfhKdlN60aQBiSkO9+wmUvTmxrqVIuMO7u1lc60YVC
         JMDgSPxdqvtjqiTu7QUTpULUQZe9NFYMRvul7wQbOSK9pzkYs1dDXTy+9B5cw09pHH/C
         Zzh85JspQ5TfIBgi8OhLdloKZUOatNB1XGaw4XMw8GW9DTRLNqFOeoCFBJRw0d12jSUr
         uMaCFjcraMpRNbhtz4HOPjpjs+xFDSLXFoR2Iys3uNS/3KGvOalhYFV4rdPrf4LuXxw1
         crvdwtW/rry567vVki0ZYrMExkdT93JvqBk1QdbtPlpkROgd4KSDFT8ZYsfJR/ZKP+oY
         j88g==
X-Gm-Message-State: AGRZ1gJTrtOhxn+7p4VQ0qSSbSN6R3+oJ4Ev1UVdlzX6LWTO1li6FAgT
        ZHtBC+dfKU+GnuB3OYV8YgLZxA==
X-Google-Smtp-Source: AJdET5f/ZEZ37lqgH8F18wz0P6gcyHd2Rpn1nhYGfWAhgzCi4leSTnzey6gW/Ej7uXslxb4YgDjNKg==
X-Received: by 2002:a62:8145:: with SMTP id t66mr39647480pfd.55.1543443817498;
        Wed, 28 Nov 2018 14:23:37 -0800 (PST)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id k137sm15023364pfd.56.2018.11.28.14.23.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Nov 2018 14:23:36 -0800 (PST)
Date:   Wed, 28 Nov 2018 14:23:34 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     linux-pm@vger.kernel.org, gregkh@linuxfoundation.org,
        rjw@rjwysocki.net, robh+dt@kernel.org, mturquette@baylibre.com,
        khilman@baylibre.com, vincent.guittot@linaro.org,
        skannan@codeaurora.org, amit.kucheria@linaro.org,
        seansw@qti.qualcomm.com, daidavid1@codeaurora.org,
        evgreen@chromium.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, abailon@baylibre.com,
        maxime.ripard@bootlin.com, arnd@arndb.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, ulf.hansson@linaro.org,
        adrian.hunter@intel.com, linux-mmc@vger.kernel.org
Subject: Re: [RFC] mmc: host: sdhci-msm: Use the interconnect API
Message-ID: <20181128222333.GA24969@minitux>
References: <20181011120336.9129-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181011120336.9129-1-georgi.djakov@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 11 Oct 05:03 PDT 2018, Georgi Djakov wrote:

> The interconnect API provides an interface for consumer drivers to express
> their bandwidth needs in the SoC. This data is aggregated and the on-chip
> interconnect hardware is configured to the appropriate power/performance
> profile.
> 
> Use the interconnect API to get() the path between the endpoints used for
> data transfers by the SD host controller and report the needed bandwidth
> based on the clock rate, bus width and mode.
> 

Although the Qualcomm SDHCI driver is our primary target, wouldn't it be
possible to add this in the mmc core or sdhci helper functions instead,
so that other platforms doesn't need to duplicate this code?

[..]
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
[..]
> @@ -1917,6 +1957,7 @@ static int sdhci_msm_runtime_suspend(struct device *dev)
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>  	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
>  
> +	icc_set(msm_host->path, 0, 0);

The use sdhci_msm_icc_update() to enable a bus vote and icc_set() to
disable the vote lacks symmetry. Please see if this can be improved,
e.g. by passing a boolean to the update function to "enable"/"disable"
the vote.

>  	clk_bulk_disable_unprepare(ARRAY_SIZE(msm_host->bulk_clks),
>  				   msm_host->bulk_clks);
>  
> @@ -1929,6 +1970,7 @@ static int sdhci_msm_runtime_resume(struct device *dev)
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>  	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
>  
> +	sdhci_msm_icc_update(msm_host);
>  	return clk_bulk_prepare_enable(ARRAY_SIZE(msm_host->bulk_clks),
>  				       msm_host->bulk_clks);
>  }

Regards,
Bjorn
