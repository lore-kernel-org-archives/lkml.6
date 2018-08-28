Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42504C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 16:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D921420880
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 16:56:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UB1D/x5V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D921420880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbeH1Usx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 16:48:53 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46328 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbeH1Usx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 16:48:53 -0400
Received: by mail-pl1-f196.google.com with SMTP id a4-v6so971477plm.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 09:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3/gW1fTiY+QGnPl1x9HeYANm78j55I54mYhq73CjqFk=;
        b=UB1D/x5V/90kODTTv2HuT3Vbq6Or2fhcNhG88LTNILas/jSK84YpuaMxzwh4rCAjIb
         zxO5DIkfTducPyS1lY0ow0w4jnZs7cWf8lg+1VCayIL+mjM2cBjHTZbBne6x48RZEoIp
         VrptEXlSsHnpsEi7NMMO9If13wH9Jc6WeVyls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3/gW1fTiY+QGnPl1x9HeYANm78j55I54mYhq73CjqFk=;
        b=ZbT2b8Oev6iY8LHf62YpzdjzxpiZ2e2AMgghcEVoiivhbC/PDO+GK1WLAEAebKoGxX
         YLZVjKgyPPLbVmmUAY7idMULwrZphK9fpys6iAFY3M8KZb/bCnB/Ep0YJRa7W9qlr3fC
         TxOK+NNDm3CuAasVy0k5ys5tziOsw34uoTfzu60c+MKoyUpx+AHfBzDEP80DUEifs7/G
         B2sUwikft0akbP/NjPHoPomJJLDLJz2bhWTh1TeKPBp0aWJfrEAqNdt2J+jtUEBLXgOm
         c1+xuLaXuq0yJR07refxhNyv5RSVrrfoE0bTE4Mu2fi9QEUjKr0sZ8J62MK45jU36/97
         OwKQ==
X-Gm-Message-State: APzg51BSphcnznJqb51vboxc0QMDQbwOf7220YP4m5n7AcY9p8wq6iGy
        ELe2Hqbb9onkhB2gu3Uj8F4IZLrc6Xs=
X-Google-Smtp-Source: ANB0VdYOdZi4CsECW1t7gXBAC4Nu+MGd3OPXdheqcImQvYfHfkkA610pnLaR0A7DMj1LnKblWao+Iw==
X-Received: by 2002:a17:902:8643:: with SMTP id y3-v6mr611542plt.225.1535475381201;
        Tue, 28 Aug 2018 09:56:21 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id g5-v6sm3318260pgn.73.2018.08.28.09.56.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Aug 2018 09:56:20 -0700 (PDT)
Date:   Tue, 28 Aug 2018 09:56:19 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Sibi Sankar <sibis@codeaurora.org>, p.zabel@pengutronix.de,
        robh+dt@kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        ohad@wizery.com, mark.rutland@arm.com, sricharan@codeaurora.org,
        akdwived@codeaurora.org, linux-arm-msm@vger.kernel.org,
        tsoni@codeaurora.org
Subject: Re: [PATCH v2 2/6] reset: qcom: PDC Global (Power Domain Controller)
 reset controller
Message-ID: <20180828165619.GA10879@google.com>
References: <20180824131900.5353-1-sibis@codeaurora.org>
 <20180824131900.5353-3-sibis@codeaurora.org>
 <20180828002236.GX160295@google.com>
 <20180828030253.GF2523@minitux>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180828030253.GF2523@minitux>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 08:02:53PM -0700, Bjorn Andersson wrote:
> On Mon 27 Aug 17:22 PDT 2018, Matthias Kaehlcke wrote:
> > On Fri, Aug 24, 2018 at 06:48:56PM +0530, Sibi Sankar wrote:
> > > diff --git a/drivers/reset/reset-qcom-pdc.c b/drivers/reset/reset-qcom-pdc.c
> [..]
> > > +struct qcom_pdc_desc {
> > > +	const struct regmap_config *config;
> > > +	const struct qcom_pdc_reset_map *resets;
> > > +	size_t num_resets;
> > > +};
> > 
> > Not sure if this structure adds much value or just a layer of
> > indirection:
> > 
> > - .config is only accessed in _probe(), sdm845_pdc_regmap_config could
> >   be used directly
> > - .resets is used in _(de)assert(), sdm845_pdc_resets could be used
> >   directly
> > - .num_resets is only accessed in _probe(),
> >   ARRAY_SIZE(sdm845_pdc_resets) could be used instead
> > 
> > It probably makes sense if it is planned to support reset controllers
> > of other SoCs with this driver.
> > 
> 
> I like this suggestion, once we need the configurability we can add the
> type for it. It also shows that only .resets would need to be referenced
> by qcom_pdc_reset_data.
> 
> > > +struct qcom_pdc_reset_data {
> > > +	struct reset_controller_dev rcdev;
> > > +	struct regmap *regmap;
> > > +	const struct qcom_pdc_desc *desc;
> > > +};
> [..]
> > > +static int qcom_pdc_reset_probe(struct platform_device *pdev)
> > > +{
> [..]
> > > +	data->regmap = devm_regmap_init_mmio(dev, base, desc->config);
> > > +	if (IS_ERR(data->regmap)) {
> > > +		dev_err(dev, "Unable to get pdc-global regmap");
> > 
> > Add missing '\n'
> > 
> > Say 'pdc-reset' instead of 'pdc-global'? (see also my other comment
> > below).
> > 
> 
> This regmap is created out of the single anonymous "reg", so I think the
> error should be reduced to "Unable to initialize regmap\n".
> 
> [..]
> > > +static const struct of_device_id qcom_pdc_reset_of_match[] = {
> > > +	{ .compatible = "qcom,sdm845-pdc-global", .data = &sdm845_pdc_desc },
> > 
> > Should this be 'qcom,sdm845-pdc-reset' which is more specific than
> > 'global' and in line with the name and purpose of the driver?
> > Obviously this would require to adjust the bindings doc too.
> > 
> 
> No, the binding describes the hardware block named "PDC Global",
> currently implemented as a reset controller. The reason for doing this
> is so that we one day can expose additional interfaces in a backwards
> compatible fashion.

Sounds reasonable, thanks for the clarification.
