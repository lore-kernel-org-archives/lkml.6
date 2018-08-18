Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E15C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 12:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBF0A2183D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 12:46:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="QewGjRzB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBF0A2183D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbeHRPxk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 11:53:40 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:59588 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbeHRPxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 11:53:40 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 841E35C11DF;
        Sat, 18 Aug 2018 14:46:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1534596362;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1PLZDKX4y+nai0J8kxH8SIxT32iLq6KnPUhK0/HoziE=;
        b=QewGjRzBRn2eJITBAAYwxPMpscBnz/TbJqjKpYqquhDf4X1Xe8Ct5PDhXi83tpFdNXteph
        9FPvncbNJhiSUFGO4dwevYWbHLeInDJRSI3Re4PvO3q2/KFAVt44OfvoHJ3EqAWrTrF0m5
        0uU8f/caPXIOdvVQceDeD8hVsukAPK8=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Sat, 18 Aug 2018 14:45:47 +0200
From:   Stefan Agner <stefan@agner.ch>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v2] clk: tegra: probe deferral error reporting
In-Reply-To: <20180814091805.1363-1-marcel@ziswiler.com>
References: <20180814091805.1363-1-marcel@ziswiler.com>
Message-ID: <bd9a8bb8c140fab18f88d383a0b7d5f1@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.08.2018 11:18, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> Actually report the error code from devm_regulator_get() which may as
> well just be a probe deferral.
> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Reviewed-by: Stefan Agner <stefan@agner.ch>

> 
> ---
> 
> Changes in v2:
> - Silence probe deferral as discussed between Peter, Stefan and Stephen.
> - Fix line over 80 characters as reported by checkpatch.
> 
>  drivers/clk/tegra/clk-dfll.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/tegra/clk-dfll.c b/drivers/clk/tegra/clk-dfll.c
> index 48ee43734e05..ebb0e1b6bf01 100644
> --- a/drivers/clk/tegra/clk-dfll.c
> +++ b/drivers/clk/tegra/clk-dfll.c
> @@ -1609,8 +1609,12 @@ int tegra_dfll_register(struct platform_device *pdev,
>  
>  	td->vdd_reg = devm_regulator_get(td->dev, "vdd-cpu");
>  	if (IS_ERR(td->vdd_reg)) {
> -		dev_err(td->dev, "couldn't get vdd_cpu regulator\n");
> -		return PTR_ERR(td->vdd_reg);
> +		ret = PTR_ERR(td->vdd_reg);
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(td->dev, "couldn't get vdd_cpu regulator: %d\n",
> +				ret);
> +
> +		return ret;
>  	}
>  
>  	td->dvco_rst = devm_reset_control_get(td->dev, "dvco");
