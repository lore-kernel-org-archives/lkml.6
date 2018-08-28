Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 402CEC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 03:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAB0920867
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 03:02:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="H2ekDtQU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAB0920867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbeH1Gw0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 02:52:26 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34894 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbeH1Gw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 02:52:26 -0400
Received: by mail-pf1-f196.google.com with SMTP id p12-v6so88143pfh.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 20:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=54XzWo5CsG3TMc/d9h9RHD+xzKjOzhfGuENqfijJelQ=;
        b=H2ekDtQUM4RRSvsXkHeFjFLqcSaHgxh9iUdCWUk9MHgdX4OXhYswBKtvYVmlOL4P53
         aQZKzdze5XTtGH1oMJO1m8S0FS5Xb+WqJF1/NMlorP2hRxBlrqgfjTt/5vvOPyX0b9tE
         L9BoHuTSZxSTiW415gxl6dTzUqE/3xImgwEa8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=54XzWo5CsG3TMc/d9h9RHD+xzKjOzhfGuENqfijJelQ=;
        b=NaeLigLKsRXI4ZNmOPoRC723NWhILu1kLIYX8lHb+bqr9qbbfTo585RJjGUNsPrQTK
         wGV/35ZDLxWnQrxpKZW4mE2UxVkQVs6DBOp08A+Wd0cSov7gONhon35oxstPxzBCKlVv
         hnMLJcN4ydbxN1ioGeznyE6eN7oL4PKtVjFpBsbeTXM8LiA1FMFTZsC/Yrk5SDAAM5+h
         rUb0OwSLAcji8SMavvr1nxoDjErZQmmulVjO+EAV7E04OqERLZKc0ZJGHZCrSVNaXw2F
         kdT51iBk/SzWZlEhxUPcVgmH9264DqruRUgdjeRFTXRXeV1NkNumTxsFcA69uVdKD/Zm
         R64w==
X-Gm-Message-State: APzg51DVvJNwXJZRxpk2Mn9NbDHRK09jseGqTvp+mcNvEnWRKgC9b+ln
        +6++9hTrWq4r02Zztkl946jTdQ==
X-Google-Smtp-Source: ANB0VdZQo7MKGNP7kS/N6fkegmzXUlzHBmtVNJYeEWrKlp1TGwjVHBIgn2axDrpeJMWxVNWHXcmsxw==
X-Received: by 2002:a63:c14a:: with SMTP id p10-v6mr14641996pgi.305.1535425376850;
        Mon, 27 Aug 2018 20:02:56 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id t19-v6sm805249pfk.182.2018.08.27.20.02.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 Aug 2018 20:02:56 -0700 (PDT)
Date:   Mon, 27 Aug 2018 20:02:53 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Sibi Sankar <sibis@codeaurora.org>, p.zabel@pengutronix.de,
        robh+dt@kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        ohad@wizery.com, mark.rutland@arm.com, sricharan@codeaurora.org,
        akdwived@codeaurora.org, linux-arm-msm@vger.kernel.org,
        tsoni@codeaurora.org
Subject: Re: [PATCH v2 2/6] reset: qcom: PDC Global (Power Domain Controller)
 reset controller
Message-ID: <20180828030253.GF2523@minitux>
References: <20180824131900.5353-1-sibis@codeaurora.org>
 <20180824131900.5353-3-sibis@codeaurora.org>
 <20180828002236.GX160295@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180828002236.GX160295@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 27 Aug 17:22 PDT 2018, Matthias Kaehlcke wrote:
> On Fri, Aug 24, 2018 at 06:48:56PM +0530, Sibi Sankar wrote:
> > diff --git a/drivers/reset/reset-qcom-pdc.c b/drivers/reset/reset-qcom-pdc.c
[..]
> > +struct qcom_pdc_desc {
> > +	const struct regmap_config *config;
> > +	const struct qcom_pdc_reset_map *resets;
> > +	size_t num_resets;
> > +};
> 
> Not sure if this structure adds much value or just a layer of
> indirection:
> 
> - .config is only accessed in _probe(), sdm845_pdc_regmap_config could
>   be used directly
> - .resets is used in _(de)assert(), sdm845_pdc_resets could be used
>   directly
> - .num_resets is only accessed in _probe(),
>   ARRAY_SIZE(sdm845_pdc_resets) could be used instead
> 
> It probably makes sense if it is planned to support reset controllers
> of other SoCs with this driver.
> 

I like this suggestion, once we need the configurability we can add the
type for it. It also shows that only .resets would need to be referenced
by qcom_pdc_reset_data.

> > +struct qcom_pdc_reset_data {
> > +	struct reset_controller_dev rcdev;
> > +	struct regmap *regmap;
> > +	const struct qcom_pdc_desc *desc;
> > +};
[..]
> > +static int qcom_pdc_reset_probe(struct platform_device *pdev)
> > +{
[..]
> > +	data->regmap = devm_regmap_init_mmio(dev, base, desc->config);
> > +	if (IS_ERR(data->regmap)) {
> > +		dev_err(dev, "Unable to get pdc-global regmap");
> 
> Add missing '\n'
> 
> Say 'pdc-reset' instead of 'pdc-global'? (see also my other comment
> below).
> 

This regmap is created out of the single anonymous "reg", so I think the
error should be reduced to "Unable to initialize regmap\n".

[..]
> > +static const struct of_device_id qcom_pdc_reset_of_match[] = {
> > +	{ .compatible = "qcom,sdm845-pdc-global", .data = &sdm845_pdc_desc },
> 
> Should this be 'qcom,sdm845-pdc-reset' which is more specific than
> 'global' and in line with the name and purpose of the driver?
> Obviously this would require to adjust the bindings doc too.
> 

No, the binding describes the hardware block named "PDC Global",
currently implemented as a reset controller. The reason for doing this
is so that we one day can expose additional interfaces in a backwards
compatible fashion.

Regards,
Bjorn
