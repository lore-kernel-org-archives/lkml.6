Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72581C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 16:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4125220861
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 16:26:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4125220861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633006AbeKXDLC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 22:11:02 -0500
Received: from muru.com ([72.249.23.125]:54798 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387726AbeKXDLB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 22:11:01 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id CAD1C80D4;
        Fri, 23 Nov 2018 16:26:08 +0000 (UTC)
Date:   Fri, 23 Nov 2018 08:26:04 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Roger Quadros <rogerq@ti.com>
Cc:     robh+dt@kernel.org, bcousson@baylibre.com, ssantosh@kernel.org,
        ohad@wizery.com, bjorn.andersson@linaro.org, s-anna@ti.com,
        nsekhar@ti.com, t-kristo@ti.com, nsaulnier@ti.com, jreeder@ti.com,
        m-karicheri2@ti.com, woods.technical@gmail.com,
        linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 05/17] soc: ti: pruss: Configure SYSCFG properly during
 probe/remove
Message-ID: <20181123162604.GA53235@atomide.com>
References: <1542886753-17625-1-git-send-email-rogerq@ti.com>
 <1542886753-17625-6-git-send-email-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542886753-17625-6-git-send-email-rogerq@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Roger Quadros <rogerq@ti.com> [181122 11:39]:
> +/* firmware must be idle when calling this function */
> +static void pruss_disable_module(struct device *dev)
> +{
> +	struct pruss_soc_bus *psoc_bus = dev_get_drvdata(dev);
> +
> +	/* configure Smart Standby */
> +	pruss_soc_bus_rmw(psoc_bus->syscfg, SYSCFG_STANDBY_MODE_MASK,
> +			  SYSCFG_STANDBY_MODE_SMART);
> +
> +	/* initiate MStandby */
> +	pruss_soc_bus_rmw(psoc_bus->syscfg, SYSCFG_STANDBY_INIT,
> +			  SYSCFG_STANDBY_INIT);
> +
> +	/* tell PRCM to initiate IDLE request */
> +	pm_runtime_put_sync(dev);
> +}
> +
> +static int pruss_enable_module(struct device *dev)
> +{
> +	struct pruss_soc_bus *psoc_bus = dev_get_drvdata(dev);
> +	int ret;
> +
> +	/* tell PRCM to de-assert IDLE request */
> +	ret = pm_runtime_get_sync(dev);
> +	if (ret < 0) {
> +		pm_runtime_put_noidle(dev);
> +		return ret;
> +	}
> +
> +	/* configure for Smart Idle & Smart Standby */
> +	pruss_soc_bus_rmw(psoc_bus->syscfg, SYSCFG_IDLE_MODE_MASK,
> +			  SYSCFG_IDLE_MODE_SMART);
> +	pruss_soc_bus_rmw(psoc_bus->syscfg, SYSCFG_STANDBY_MODE_MASK,
> +			  SYSCFG_STANDBY_MODE_SMART);
> +
> +	return ret;
> +}

Yeah so nothing PRU specific here, this you should be able to
handle in a generic way with drivers/bus/ti-sysc.c.

Regards,

Tony
