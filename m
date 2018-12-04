Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF222C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 08:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A134F2087F
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 08:22:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LsLnOp1u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A134F2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbeLDIWD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 03:22:03 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35485 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbeLDIWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 03:22:03 -0500
Received: by mail-pl1-f196.google.com with SMTP id p8so7927367plo.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 00:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OpYTHvNyAWqgy7nsKPr+g6ey5sLKAIj6db+wtP/ieJ4=;
        b=LsLnOp1ucxff8wAVDb9EtqHTkoXGmp0WzHM2kMqaSq4KOFwj/mlXAX+PbDtlPnmEs+
         fYp1bichE0VrF9NMiuzQQ5SFDOqZmECkGW3SVDVITLgu/TlCCk9NdxglY736HeELlZkZ
         hoNt/lspVniUxWZqNMKZkenZf8wIQHNYto0vw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OpYTHvNyAWqgy7nsKPr+g6ey5sLKAIj6db+wtP/ieJ4=;
        b=HmcDDg+Wi/p0PY5NPN4LCqXdXpgOIiq/tScKDl6n18EoYnlfFCbU2OTHoE70lV3EYN
         EnhchnzGNnxI+A0i8pEQMxySTD7nyE0FZof+Yv3SohGHuMw50S3MF9kLlgGhYexHd4h9
         iqPUlQg4A04xs7G1CRpOMLyiT1AnY/tXXHjYpV9lPGp30uXWhFKSMuouSfGAGWKL6BNY
         vCwirdbUZQCkPdqpGwfj+IKXMpyCmFRUJF0vfoRsgqtcxJVwwqlcuEzHqHzRhoLkgbzp
         nq5ywK5KsP1fMFMuZbYQ2QWLJyh3/LzjorqyR43NU5xaoMv4mSmbPnfJyhd8LhxI86U7
         oABw==
X-Gm-Message-State: AA+aEWabNcUL5Wa03mgffS16ZHoHtyrvCAS8Uv1ZSSQsXThaI4CSacJi
        bs2J0HygNQdqiRKdQ1+qpVWO4g==
X-Google-Smtp-Source: AFSGD/UXAiosgP5OpebGlX7nvRpwhLvm8bzeVjEH3mzav/exyJh1lHrdZUE1KZawLazKp4e+Os/ZIQ==
X-Received: by 2002:a17:902:708b:: with SMTP id z11mr19041715plk.203.1543911722133;
        Tue, 04 Dec 2018 00:22:02 -0800 (PST)
Received: from localhost ([122.172.23.29])
        by smtp.gmail.com with ESMTPSA id i123sm32555829pfg.164.2018.12.04.00.22.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 00:22:01 -0800 (PST)
Date:   Tue, 4 Dec 2018 13:51:58 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Nick Fan <Nick.Fan@mediatek.com>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        tfiga@chromium.org, Chiawen.Lee@mediatek.com, erin.lo@mediatek.com
Subject: Re: [PATCH] opp: Add API for getting voltage from supplies
Message-ID: <20181204082158.rb7uzdiwmcotwoxh@vireshk-i7>
References: <1543906760-15631-1-git-send-email-Nick.Fan@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543906760-15631-1-git-send-email-Nick.Fan@mediatek.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-12-18, 14:59, Nick Fan wrote:
> Add API to get voltage for multiple supplies from opp table

And who needs to use this new API ? It would be better to add the user in the
same series to make sure this really gets used.

> Signed-off-by: Nick Fan <Nick.Fan@mediatek.com>
> ---
>  drivers/opp/core.c     | 28 ++++++++++++++++++++++++++++
>  include/linux/pm_opp.h |  3 +++
>  2 files changed, 31 insertions(+)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 2c2df4e..ee73546 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -113,6 +113,34 @@ unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp)
>  EXPORT_SYMBOL_GPL(dev_pm_opp_get_voltage);
>  
>  /**
> + * dev_pm_opp_get_voltage_supply() - Gets the voltage corresponding to an opp
> + * with index
> + * @opp:        opp for which voltage has to be returned for
> + * @index:      index to specify the returned supplies
> + *
> + * Return: voltage in micro volt corresponding to the opp with index, else
> + * return 0
> + *
> + * This is useful for devices with multiple power supplies.
> + */
> +unsigned long dev_pm_opp_get_voltage_supply(struct dev_pm_opp *opp,
> +					    unsigned int index)

How will the users of this API get the index ?

> +{
> +	if (IS_ERR_OR_NULL(opp)) {
> +		pr_err("%s: Invalid parameters\n", __func__);
> +		return 0;
> +	}
> +
> +	if (index >= opp->opp_table->regulator_count) {
> +		pr_err("%s: Invalid supply index: %u\n", __func__, index);
> +		return 0;
> +	}
> +
> +	return opp->supplies[index].u_volt;

-- 
viresh
