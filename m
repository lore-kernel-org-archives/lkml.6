Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18EAEC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 22:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1381217C7
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 22:17:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="epCEA50E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1381217C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbeHVBjo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 21:39:44 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33584 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727636AbeHVBjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 21:39:44 -0400
Received: by mail-pg1-f195.google.com with SMTP id t14-v6so2370331pgf.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 15:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=O9L/3BVYTDaG4nR4vhr3SRJntD05ZCWEg5S1vHWlqk4=;
        b=epCEA50EZ2OATfCMeYMQR2xmd7xPNQ8BsRkn19WirBKa2m1U5yCHcQ8hovmux3JLqV
         ggscB31d3GXPTz+2Z2DUY5tgoKJwJZyVqNsJrKQwsRYRWBL888RsYqiUYaPYoj5I4bdR
         kRoVnWO4Yb6Nrm4kMMtHn1Mw2R9du5hASP2ps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=O9L/3BVYTDaG4nR4vhr3SRJntD05ZCWEg5S1vHWlqk4=;
        b=F+EKWNzYAmrzG9NVzeG94HmJNXKI2kfZR4nDYQndc2wFGq1WkLxn2Gi03FjIcLjLv+
         P5IzG5x/GWyFFWuiB8z0ETwz9Uunet5LrYlNA4w/8ucJCNqbpdAcjhk0uaXEwZ3uNl6F
         hWVmj/NE/UnxjDVs0Y6bpLROSJUccsNyfKnd4sQt3f8sFeNgI5DMnyfBCke9rQRFwpWO
         t9Hb9GcRUNSUjqsNPz+hDGaPmnj5pAngjeN4ovk7iZp4UTULBagB9DpNARSg7bGf4iDD
         PxA5MdOWBe6vEq6A2LgIG4OBcATKeRPvigmPMX0EsmH85ppDyCk+O0wpdGFZ9pcheNoK
         IH4A==
X-Gm-Message-State: AOUpUlG4E6yTLUyCMmLZbaQ8VNr/JRllKPUfMsDkieydDwySG9otQBV/
        pkUznQwx5LOp7+Q+SH0mifiNUumgWB0=
X-Google-Smtp-Source: AA+uWPziwjbfCmDybh+dKxv+WQTyIqVp+3wn81nqQZiwJbXYYy/4IkYiHmE8/YUx4aeZ3hEoIZxD3w==
X-Received: by 2002:a63:2c0e:: with SMTP id s14-v6mr14323040pgs.199.1534889863474;
        Tue, 21 Aug 2018 15:17:43 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id o10-v6sm32659724pfk.76.2018.08.21.15.17.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Aug 2018 15:17:42 -0700 (PDT)
Date:   Tue, 21 Aug 2018 15:17:40 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     p.zabel@pengutronix.de, robh+dt@kernel.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, ohad@wizery.com, mark.rutland@arm.com,
        sricharan@codeaurora.org, akdwived@codeaurora.org,
        linux-arm-msm@vger.kernel.org, tsoni@codeaurora.org
Subject: Re: [PATCH 2/4] reset: qcom: PDC (Power Domain Controller) reset
 controller
Message-ID: <20180821221740.GB2353@minitux>
References: <20180727152811.15258-1-sibis@codeaurora.org>
 <20180727152811.15258-2-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180727152811.15258-2-sibis@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 27 Jul 08:28 PDT 2018, Sibi Sankar wrote:

> Add reset controller for SDM845 SoC to control reset signals
> provided by PDC for Modem, Compute, Display, GPU, Debug, AOP,
> Sensors, Audio, SP and APPS
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>  drivers/reset/Kconfig          |   9 +++
>  drivers/reset/Makefile         |   1 +
>  drivers/reset/reset-qcom-pdc.c | 139 +++++++++++++++++++++++++++++++++
>  3 files changed, 149 insertions(+)
>  create mode 100644 drivers/reset/reset-qcom-pdc.c
> 
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> index 13d28fdbdbb5..5344e202a630 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -98,6 +98,15 @@ config RESET_QCOM_AOSS
>  	  reset signals provided by AOSS for Modem, Venus, ADSP,
>  	  GPU, Camera, Wireless, Display subsystem. Otherwise, say N.
>  
> +config RESET_QCOM_PDC
> +	bool "Qcom PDC Reset Driver"

"Qualcomm"

And I do not see a strong reason for this not being tristate, the
consumers we've talked about so far can all be modules.

> +	depends on ARCH_QCOM || COMPILE_TEST
> +	help
> +	  This enables the PDC (Power Domain Controller) reset driver
> +	  for Qualcomm Technologies Inc SDM845 SoCs. Say Y if you want
> +	  to control reset signals provided by PDC for Modem, Compute,
> +	  Display, GPU, Debug, AOP, Sensors, Audio, SP and APPS.
> +

Implementation looks fine.

Regards,
Bjorn
