Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37AFFC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 04:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3A492087F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 04:54:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TPOcQdl+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbfAHEyH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 23:54:07 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44894 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727433AbfAHEyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 23:54:07 -0500
Received: by mail-pl1-f193.google.com with SMTP id e11so1246800plt.11
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 20:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZqFcJbbU+g5aGVRCVwtttpV/U3OiPS6INfJTfWQDbTs=;
        b=TPOcQdl+soDnb75kvbLPvV5z9Nm6CdrVHANgs9iF2bGysoMpDwvirr0RuEpdc7d9fo
         8E3egGy9crwBQzzIt1RTczHen9wSLGsZ/TQ2iq8w2LyXJisLj/dq7Hv0eR18bz6FFGFa
         twigyizRLLgNg7ctgvSoO1qumJRrB3K6Pur5U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZqFcJbbU+g5aGVRCVwtttpV/U3OiPS6INfJTfWQDbTs=;
        b=BWLue+ffUbKYywHZiO/i8svCxW/5sml+H0Bnt+pQ0Ps00ndPboDzuDs33HSHoqdr50
         hP03WR7clDXAKWJ835ACf8JR0yNHxDDZ/8Hp4Q/ovFZkUzPwSG0mcZWtJZUI5NwNNezh
         ISNX8LxoBJCs6MGgk/xOTnrO/ZRYhYrSnMWHDdK3XLwRHddBwEx0tDd22M1cJcNdJlrE
         oCWnLxnttbNsDwGHvKmPi/srEn2oCrP8/dC/cvd6QbGF3vCFczQ9TCfSpEHIwMy7FmJ5
         XnR4XxZeB3oahoGtbls42X2oT1TwZ/fOL0Ga1dpN8563Ad/oZSqGom2ya5WCFTxfPlw4
         Xy3A==
X-Gm-Message-State: AJcUukfIdmxLL7CNv++eHrqf1GwISF+Cx3iaOSy/mKSGW7bJ8JisxKMB
        mgyiEqEuTb5LSjtlpjcnPQDhgQ==
X-Google-Smtp-Source: ALg8bN6YYX7UZSFbChXL/vM62LV4q4vrH7rKW9NGEvdzKIVexcEE4pfFZHlptmK0HdrpWvGFmp8nfw==
X-Received: by 2002:a17:902:bc81:: with SMTP id bb1mr279373plb.223.1546923246715;
        Mon, 07 Jan 2019 20:54:06 -0800 (PST)
Received: from localhost ([122.166.131.155])
        by smtp.gmail.com with ESMTPSA id n7sm117569756pff.36.2019.01.07.20.54.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 20:54:06 -0800 (PST)
Date:   Tue, 8 Jan 2019 10:24:02 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     andy.gross@linaro.org, robh@kernel.org, sboyd@kernel.org,
        ulf.hansson@linaro.org, collinsd@codeaurora.org, mka@chromium.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, henryc.chen@mediatek.com
Subject: Re: [PATCH v9 08/10] OPP: Add a dev_pm_opp_of_get_level() helper
Message-ID: <20190108045402.2jglb5y3bk76dems@vireshk-i7>
References: <20190107100959.14528-1-rnayak@codeaurora.org>
 <20190107100959.14528-9-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190107100959.14528-9-rnayak@codeaurora.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-01-19, 15:39, Rajendra Nayak wrote:
> Now that we have atleast 2 genpd providers, both using a simple

This kind of reasoning for this patch isn't required anymore. Make
this patch the second one in the series, i.e. just after the bindings.

> routine to read a performance state (opp-level) value from device
> tree, in order to implement the .opp_to_performance_state
> callback, add a dev_pm_opp_of_get_level() helper to do
> it, so it can be resued across all such genpd providers which
> just need to read the value from DT.
> 
> Suggested-by: Stephen Boyd <sboyd@kernel.org>
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---
>  drivers/opp/of.c       | 23 +++++++++++++++++++++++
>  include/linux/pm_opp.h |  5 +++++
>  2 files changed, 28 insertions(+)
> 
> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> index 06f0f632ec47..6fb383fee601 100644
> --- a/drivers/opp/of.c
> +++ b/drivers/opp/of.c
> @@ -1029,6 +1029,29 @@ int of_get_required_opp_performance_state(struct device_node *np, int index)
>  }
>  EXPORT_SYMBOL_GPL(of_get_required_opp_performance_state);
>  
> +/**
> + * dev_pm_opp_of_get_level() - Reads the opp-level value from Device Tree
> + * @opp: opp for which 'opp-level' should be read and returned
> + *
> + * Returns the opp-level value read from Device Tree, if present, else 0
> + *
> + * Return: Zero or positive opp-level value read from Device tree
> + */
> +unsigned int dev_pm_opp_of_get_level(struct dev_pm_opp *opp)
> +{
> +	struct device_node *np;
> +	unsigned int perf_state = 0;
> +
> +	np = dev_pm_opp_get_of_node(opp);
> +	if (of_property_read_u32(np, "opp-level", &perf_state))
> +		pr_err("%s: missing 'opp-level' property\n", __func__);

Instead of this, add a field "level" in the opp structure in
drivers/opp/opp.h and fill it while parsing the OPPs. And here you can
just read the values then.

-- 
viresh
