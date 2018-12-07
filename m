Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98156C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 23:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57A9120837
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 23:30:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nXv+iqsR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57A9120837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbeLGXaN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 18:30:13 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36557 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbeLGXaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 18:30:12 -0500
Received: by mail-pl1-f193.google.com with SMTP id g9so2495394plo.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 15:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Xe+0U7AEF8Sy7fWxtsHJuSR6GRBK1TSDzTBz0pDfccs=;
        b=nXv+iqsR3ikh3pfPJPyqvHsQOJMcG1Sdd8aUXxvREnPC1FDCS1+vtazYujGGoCxwj/
         +7/Msre3Gfucywvgn61x9xIN2xsU9yS0n3rvveajNzGzfbmesoEnyPGdKSadUSZsDw+m
         JkhQOBh5k5zgVHopm8j98iaKS4McYAu8//am0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Xe+0U7AEF8Sy7fWxtsHJuSR6GRBK1TSDzTBz0pDfccs=;
        b=Uupj/ruIKeff29V/YP5Djrjl5HhYHyqHrztpw8XFzeNGZp1W8vRqvQdvw6TD1mEdz2
         ujqo/4kf/07UNa0Cxmi8BSXwtX4V+ZmmDEga5swwGb/Xws8SO3WgsPDpcVXVLi8q8FPQ
         fvC2ThdkS1uMG5E3XgsFzwQinceHcZhgOog3bNmeEIWj3S9yvi6cMzLNNDBcCSzwBI0a
         +vt4t/fQGges5fAHL2fTw2q+sqrcwZp+bhXGBMKFnfCGiV69bRXNCjF2ZXF9MTqpBB5y
         Y//270+6LeKbibTw63Vlgkv4Sqd4uYHjLobA+Zlm92nazn+d43Jk/nIc665Xj5ak7wQb
         YcbA==
X-Gm-Message-State: AA+aEWYy4LaqPXlgNt+ZT/3s+0iuLnlFUPy2iAhaKFTIIyITAmGHGHPX
        S3+/Ipq5H47tUmHbhv5oObrNxw==
X-Google-Smtp-Source: AFSGD/VUFWwgJ7kZ4oBpIIbUlYW1RnJ8Hni5iGZ61RzOq8t4IIpAJoOqizFUnicfU/HkVH00C5lS6g==
X-Received: by 2002:a17:902:28e9:: with SMTP id f96mr3973560plb.169.1544225411658;
        Fri, 07 Dec 2018 15:30:11 -0800 (PST)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id 85sm6360865pfw.17.2018.12.07.15.30.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Dec 2018 15:30:10 -0800 (PST)
Date:   Fri, 7 Dec 2018 15:30:10 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     gregkh@linuxfoundation.org, linux-pm@vger.kernel.org,
        rjw@rjwysocki.net, robh+dt@kernel.org, mturquette@baylibre.com,
        khilman@baylibre.com, vincent.guittot@linaro.org,
        skannan@codeaurora.org, bjorn.andersson@linaro.org,
        amit.kucheria@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, evgreen@chromium.org,
        dianders@chromium.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, abailon@baylibre.com,
        maxime.ripard@bootlin.com, arnd@arndb.de, thierry.reding@gmail.com,
        ksitaraman@nvidia.com, sanjayc@nvidia.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v11 5/8] interconnect: qcom: Add sdm845 interconnect
 provider driver
Message-ID: <20181207233010.GE14307@google.com>
References: <20181207152917.4862-1-georgi.djakov@linaro.org>
 <20181207152917.4862-6-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181207152917.4862-6-georgi.djakov@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Georgi,

not a full review, only one thing I just stumbled across:

On Fri, Dec 07, 2018 at 05:29:14PM +0200, Georgi Djakov wrote:
> From: David Dai <daidavid1@codeaurora.org>
> 
> Introduce Qualcomm SDM845 specific provider driver using the
> interconnect framework.
> 
> Signed-off-by: David Dai <daidavid1@codeaurora.org>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>  .../bindings/interconnect/qcom,sdm845.txt     |  24 +
>  drivers/interconnect/Kconfig                  |   5 +
>  drivers/interconnect/Makefile                 |   1 +
>  drivers/interconnect/qcom/Kconfig             |  13 +
>  drivers/interconnect/qcom/Makefile            |   5 +
>  drivers/interconnect/qcom/sdm845.c            | 836 ++++++++++++++++++
>  .../dt-bindings/interconnect/qcom,sdm845.h    | 143 +++
>  7 files changed, 1027 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sdm845.txt
>  create mode 100644 drivers/interconnect/qcom/Kconfig
>  create mode 100644 drivers/interconnect/qcom/Makefile
>  create mode 100644 drivers/interconnect/qcom/sdm845.c
>  create mode 100644 include/dt-bindings/interconnect/qcom,sdm845.h
>
> ...
> 
> diff --git a/drivers/interconnect/qcom/sdm845.c b/drivers/interconnect/qcom/sdm845.c
> new file mode 100644
> index 000000000000..f594dd6f500f
> --- /dev/null
> +++ b/drivers/interconnect/qcom/sdm845.c
> 
> ...
> 
> +static int qcom_icc_bcm_init(struct qcom_icc_bcm *bcm, struct device *dev)
> +{
> +	struct qcom_icc_node *qn;
> +	int ret, i;
> +
> +	bcm->addr = cmd_db_read_addr(bcm->name);
> +	if (!bcm->addr) {
> +		dev_err(dev, "%s could not find RPMh address\n",
> +			bcm->name);
> +		return -EINVAL;
> +	}
> +
> +	if (cmd_db_read_aux_data_len(bcm->name) < sizeof(struct bcm_db)) {
> +		dev_err(dev, "%s command db missing or partial aux data\n",
> +			bcm->name);
> +		return -EINVAL;
> +	}

cmd_db_read_aux_data_len() is in the process of being removed, see
ed3cafa79ea7 ("soc: qcom: cmd-db: Stop memcpy()ing in
cmd_db_read_aux_data()") in arm-soc/for-next

https://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git/commit/?h=for-next&id=ed3cafa79ea756be653d22087c017af95ea78a49

Cheers

Matthias
