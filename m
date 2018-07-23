Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1767ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 22:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A057F20854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 22:32:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cXbixV5M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A057F20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388229AbeGWXgA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 19:36:00 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34355 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388109AbeGWXgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 19:36:00 -0400
Received: by mail-pg1-f194.google.com with SMTP id y5-v6so1378040pgv.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 15:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EpGraUFP5rVrbaxzYKr5ssr6P5HgDOA35NUg7aAZ0VU=;
        b=cXbixV5MygB0uPugawWI79fVTWO6nO/49pTk5vGHlugbn2XQ7kj8roZL32MEAXX9y4
         Ip4dxl2+sqFySud/gz/ou92rAcgFPeydX/m9mQkgPq7khpv8vvnjPneAewxnd8MpOzwc
         6QwoHd2tCpk7zQc8+kZu1uGBCS/WNuLIv92NA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EpGraUFP5rVrbaxzYKr5ssr6P5HgDOA35NUg7aAZ0VU=;
        b=W+0bTGYQaHthhuLoEO3VuVSINSLLjiZHbiO13lQy1tnzpcbklPBCQSUCJljFFZDZW3
         KlR0iewzalZaEfUj8z8+8SD/lNfJBFJqset7CFuOTzhgvVY9dmGr5gVIxdhJeYQwKNTO
         hs+mE1lmmD6zXoV/mFR8MOKRszsuCvBjco33gwumzlJ/DlaVGSlVZ91mIn2QAPoPLa2s
         /CurSvi9T04UvLowCpOKjuq3QAhe8GkIrzXZG9vhAaMguePj2uIogRSlA8IL34n8Lcdi
         348sgTnlKz+7p/8M3vuUKLXLsBSPEogh/Wehb4Um38vL4pqReTfsy8cEtJHkQmrJ4XO6
         CA4w==
X-Gm-Message-State: AOUpUlHRidbQ/8Y2QyVlUOZnfRBjlpBJXJJa2mr4+zS88KpSERNYDBUW
        M8OY03fzXABAda5IReN9pjk4kw==
X-Google-Smtp-Source: AAOMgpfkKfMYjwn1+UBp283LbIBzu2PXKxhPGxzd5Lbq0Y3raGQcWoFEfAlEpAJIJ2kW59kuoAoWjQ==
X-Received: by 2002:a63:2a0b:: with SMTP id q11-v6mr13805477pgq.36.1532385157694;
        Mon, 23 Jul 2018 15:32:37 -0700 (PDT)
Received: from localhost ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id y123-v6sm13235340pgy.21.2018.07.23.15.32.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Jul 2018 15:32:37 -0700 (PDT)
Date:   Mon, 23 Jul 2018 15:32:36 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, thierry.escande@linaro.org,
        rtatiya@codeaurora.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v10 1/7] dt-bindings: net: bluetooth: Add device tree
 bindings for QTI chip wcn3990
Message-ID: <20180723223236.GN129942@google.com>
References: <20180720133243.6851-1-bgodavar@codeaurora.org>
 <20180720133243.6851-2-bgodavar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180720133243.6851-2-bgodavar@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 20, 2018 at 07:02:37PM +0530, Balakrishna Godavarthi wrote:
> This patch enables regulators for the Qualcomm Bluetooth wcn3990
> controller.
> 
> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> Changes in v10:
>     * added entry for regulator currents
> 
> Changes in v9:
>     * updated with latest reg handle and names.
>     * updated max-speed definition. 
> 
> Changes in v8:
>     * Separated the optional entries between two chips
> 
> Changes in v7:
>     * no change.
> 
> Changes in v6:
> 
>     * Changed the oper-speed to max-speed.
> 
> Changes in v5:
> 
>     * Added entry for oper-speed and init-speed.
> 
> ---
>  .../bindings/net/qualcomm-bluetooth.txt       | 42 ++++++++++++++++++-
>  1 file changed, 40 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
> index 0ea18a53cc29..ca04c4981048 100644
> --- a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
> +++ b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
> @@ -10,12 +10,34 @@ device the slave device is attached to.
>  Required properties:
>   - compatible: should contain one of the following:
>     * "qcom,qca6174-bt"
> +   * "qcom,wcn3990-bt"
> +
> +Optional properties for compatible string qcom,qca6174-bt:
>  
> -Optional properties:
>   - enable-gpios: gpio specifier used to enable chip
>   - clocks: clock provided to the controller (SUSCLK_32KHZ)
>  
> -Example:
> +Optional properties for compatible string qcom,wcn3990-bt:
> +
> + - vddio-supply: Bluetooth wcn3990 VDD_IO supply regulator handle.
> + - vddxo-supply: Bluetooth wcn3990 VDD_XO supply regulator handle.
> + - vddrf-supply: Bluetooth wcn3990 VDD_RF supply regulator handle.
> + - vddch0-supply: Bluetooth wcn3990 VDD_CH0 supply regulator handle.
> +
> + - If WCN3990 is connected to platform where RPMH PMIC processor is used
> +   then the load values will be 1uA. if it is connected to platform where RPM
> +   PMIC processor is used then load value will be 10000 uA.
> +   if it is connected to different platform, where current values are fixed
> +   as in data sheet then below property are not required.

Please provide details why these magic values are needed for RPMh and
RPM PMICs.

For RPMh it looks like a value of 1uA would cause the regulator to
enter idle mode:

static int rpmh_regulator_vrm_set_load(struct regulator_dev *rdev, int load_uA)
{
	struct rpmh_vreg *vreg = rdev_get_drvdata(rdev);
	unsigned int mode;

	if (load_uA >= vreg->hw_data->hpm_min_load_uA)
		mode = REGULATOR_MODE_NORMAL;
	else
		mode = REGULATOR_MODE_IDLE;

	return rpmh_regulator_vrm_set_mode(rdev, mode);
}

https://patchwork.kernel.org/patch/10524299/

Is that really intended and if so why? It might make sense to save
power when really in idle mode, but I assume you somehow have to tell
the regulator to switch to normal mode when BT is used.

I also commented about this on patch "[7/7] Bluetooth: hci_qca: Add
support for Qualcomm Bluetooth chip wcn3990". I suggest to center the
discussion here and reply with a link to the other patch.
