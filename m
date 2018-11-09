Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33468C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 06:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDFDA20883
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 06:52:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CME+Th4h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDFDA20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbeKIQcB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 11:32:01 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35320 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727864AbeKIQcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 11:32:01 -0500
Received: by mail-pl1-f196.google.com with SMTP id n4-v6so510898plp.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 22:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JQCz/jmkLaOixrDrZQ/LpwGIxSK+h55ashnzfsip1lM=;
        b=CME+Th4hUVLh35gYjsveFcy3Qnre/1K4EcgBIPctZAdRW3MhNr30qlWi+QTteYYOR/
         NiOhq/67KwedTEnmNWtNd0jjFB6EEtkfgpTDc/+E8KtFFTbFMQTMPqsC7wwlclxi1Y2U
         crFvDEWB1/wzIOSKbwGAUpTf3uJwGjQf6jcAQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JQCz/jmkLaOixrDrZQ/LpwGIxSK+h55ashnzfsip1lM=;
        b=T6rdoV4DJAheCD19arqb0FO2P8B03bJVkFHgQ88WkAnFvLCJJaGYqP6ZmjOdAGdpBn
         kWoqexjhAEhwOdhbOWFl8ZOSkrMSKaZ6OJgwHtYUhufRwUNUtIiYF6u3c0uBFWc+XhRr
         l0VWUIRsbVzK2rur+q7JOm+7MrptpyOMTKrr7a5W8dpMLEkle3fvPlCIGilcT+2yWTRF
         7wCUWkIZ5Ga0XUYAKCYwc1aPr39WsAKEfWJ6jNdLZ5rg1iN+b3Jfo4FUhh6xdehKrrMh
         Mj7qi/6eVaaEkeE72GHrZccdKrRfjgEU9kCwGPcOEK+xQVU3jUUQcBxyNgzPfcOh+8FM
         Ytjw==
X-Gm-Message-State: AGRZ1gLnOI8MiWQbJrsoUlL4W63vMaNw0b8aqc63zMi14GWkEdDX2T3K
        11u4kb5/jpVTmHn57AaQTCoHlg==
X-Google-Smtp-Source: AJdET5fMBek3ovADx5KiOxNaiCPfHV1Xzz2VcJbjdJjfDoIUsdJz5OYqblz1xVSv6P21d3xtGYlTQw==
X-Received: by 2002:a17:902:684e:: with SMTP id f14-v6mr7728560pln.242.1541746370215;
        Thu, 08 Nov 2018 22:52:50 -0800 (PST)
Received: from tiger (61-216-91-114.HINET-IP.hinet.net. [61.216.91.114])
        by smtp.gmail.com with ESMTPSA id i12-v6sm7357141pfe.7.2018.11.08.22.52.44
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 08 Nov 2018 22:52:48 -0800 (PST)
Date:   Fri, 9 Nov 2018 14:52:28 +0800
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sriharsha Allenki <sallenki@codeaurora.org>,
        Anu Ramanathan <anur@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] phy: qualcomm: Add Synopsys High-Speed USB PHY driver
Message-ID: <20181109065226.GB20049@tiger>
References: <20181108070449.23572-1-shawn.guo@linaro.org>
 <20181108070449.23572-3-shawn.guo@linaro.org>
 <20181109052217.GL12092@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181109052217.GL12092@vkoul-mobl>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2018 at 10:52:17AM +0530, Vinod Koul wrote:
> On 08-11-18, 15:04, Shawn Guo wrote:
> > +static int qcom_snps_hsphy_config_regulators(struct hsphy_priv *priv, int high)
> > +{
> > +	int min, ret, i;
> > +
> > +	min = high ? 1 : 0; /* low or none? */
> > +
> > +	for (i = 0; i < VREG_NUM; i++) {
> > +		ret = regulator_set_voltage(priv->vregs[i].consumer,
> > +					    priv->voltages[i][min],
> > +					    priv->voltages[i][VOL_MAX]);
> > +		if (ret)
> > +			return ret;
> 
> should we not roll back the set voltages on error?

Yes.  I will get that handled in v2.  Thanks.

> 
> > +static int qcom_snps_hsphy_por_reset(struct hsphy_priv *priv)
> > +{
> > +	int ret;
> > +
> > +	ret = reset_control_assert(priv->por_reset);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/*
> > +	 * The Femto PHY is POR reset in the following scenarios.
> 
> POR?

Hmm, I do not understand this comment.  The POR is commonly used as the
abbrev of power-on-reset.  What do you meat exactly?

> 
> > +static int qcom_snps_hsphy_init(struct phy *phy)
> > +{
> > +	struct hsphy_priv *priv = phy_get_drvdata(phy);
> > +	int state;
> > +	int ret;
> 
> perhaps they can be in a single line :)

I prefer to keep them on separate line, as that makes the addition and
removal of one of them relatively easier.

> 
> > +static int qcom_snps_hsphy_probe(struct platform_device *pdev)
> > +{
> > +	struct device *dev = &pdev->dev;
> > +	struct phy_provider *provider;
> > +	struct hsphy_priv *priv;
> > +	struct resource *res;
> > +	struct phy *phy;
> > +	int size;
> > +	int ret;
> > +	int i;
> > +
> > +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > +	if (!priv)
> > +		return -ENOMEM;
> > +
> > +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	priv->base = devm_ioremap_resource(dev, res);
> > +	if (IS_ERR(priv->base))
> > +		return PTR_ERR(priv->base);
> > +
> > +	priv->num_clks = ARRAY_SIZE(qcom_snps_hsphy_clks);
> > +	priv->clks = devm_kcalloc(dev, priv->num_clks, sizeof(*priv->clks),
> > +				  GFP_KERNEL);
> > +	if (!priv->clks)
> > +		return -ENOMEM;
> > +
> > +	for (i = 0; i < priv->num_clks; i++)
> > +		priv->clks[i].id = qcom_snps_hsphy_clks[i];
> > +
> > +	ret = devm_clk_bulk_get(dev, priv->num_clks, priv->clks);
> > +	if (ret)
> > +		return ret;
> > +
> > +	priv->phy_reset = devm_reset_control_get(dev, "phy");
> > +	if (IS_ERR(priv->phy_reset))
> > +		return PTR_ERR(priv->phy_reset);
> > +
> > +	priv->por_reset = devm_reset_control_get(dev, "por");
> > +	if (IS_ERR(priv->por_reset))
> > +		return PTR_ERR(priv->por_reset);
> > +
> > +	priv->vregs[VDD].supply = "vdd";
> > +	priv->vregs[VDDA_1P8].supply = "vdda1p8";
> > +	priv->vregs[VDDA_3P3].supply = "vdda3p3";
> > +
> > +	ret = devm_regulator_bulk_get(dev, VREG_NUM, priv->vregs);
> > +	if (ret)
> > +		return ret;
> > +
> > +	priv->voltages[VDDA_1P8][VOL_NONE] = 0;
> > +	priv->voltages[VDDA_1P8][VOL_MIN] = 1800000;
> > +	priv->voltages[VDDA_1P8][VOL_MAX] = 1800000;
> > +
> > +	priv->voltages[VDDA_3P3][VOL_NONE] = 0;
> > +	priv->voltages[VDDA_3P3][VOL_MIN] = 3050000;
> > +	priv->voltages[VDDA_3P3][VOL_MAX] = 3300000;
> > +
> > +	ret = of_property_read_u32_array(dev->of_node, "qcom,vdd-voltage-level",
> > +					 priv->voltages[VDD], VOL_NUM);
> > +	if (ret) {
> > +		dev_err(dev, "failed to read qcom,vdd-voltage-level\n");
> > +		return ret;
> > +	}
> > +
> > +	size = of_property_count_u32_elems(dev->of_node, "qcom,init-seq");
> > +	if (size < 0)
> > +		size = 0;
> > +
> > +	priv->init_seq = devm_kcalloc(dev, (size / 3) + 1,
> 
> size/3? I think it would be good to add a common explaining this

The property is a sequence of <offset value delay> tuples, and we are
figuring out how many tuples are there.  Yep, I will add a comment in
there for v2.

Shawn
