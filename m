Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A57AECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 12:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32FBD20C0A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 12:19:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32FBD20C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731455AbeGQMvg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 08:51:36 -0400
Received: from mga14.intel.com ([192.55.52.115]:8190 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731250AbeGQMvg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 08:51:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jul 2018 05:19:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,365,1526367600"; 
   d="scan'208";a="216679187"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga004.jf.intel.com with ESMTP; 17 Jul 2018 05:19:09 -0700
Message-ID: <d64fc362be63bb8540447f7df2c232eedd696edb.camel@linux.intel.com>
Subject: Re: [PATCH 3/5] i2c: designware: add MSCC Ocelot support
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        James Hogan <jhogan@kernel.org>
Cc:     Paul Burton <paul.burton@mips.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microsemi.com>,
        Rob Herring <robh+dt@kernel.org>
Date:   Tue, 17 Jul 2018 15:19:08 +0300
In-Reply-To: <20180717114837.21839-4-alexandre.belloni@bootlin.com>
References: <20180717114837.21839-1-alexandre.belloni@bootlin.com>
         <20180717114837.21839-4-alexandre.belloni@bootlin.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-07-17 at 13:48 +0200, Alexandre Belloni wrote:
> The Microsemi Ocelot I2C controller is a designware IP. It also has a
> second set of registers to allow tweaking SDA hold time and spike
> filtering.

Can you elaborate a bit?

Are they platform specific? Are they shadow registers? Are they
something else? Datasheet link / excerpt would be also good to read.
 
>  Optional properties :
> + - reg : for "mscc,ocelot-i2c", a second register set to configure
> the SDA hold
> +   time, named ICPU_CFG:TWI_DELAY in the datasheet.
> +

Hmm... Is this registers unique to the SoC in question? Is address of
them fixed or may be configured on RTL level?

If former is right, why do we need a separate property?

>  
> +#define MSCC_ICPU_CFG_TWI_DELAY		0x0
> +#define MSCC_ICPU_CFG_TWI_DELAY_ENABLE	BIT(0)
> +#define MSCC_ICPU_CFG_TWI_SPIKE_FILTER	0x4
> +
> +static int mscc_twi_set_sda_hold_time(struct dw_i2c_dev *dev)
> +{
> +	writel((dev->sda_hold_time << 1) |
> MSCC_ICPU_CFG_TWI_DELAY_ENABLE,
> +	       dev->base_ext + MSCC_ICPU_CFG_TWI_DELAY);
> +
> +	return 0;
> +}

Hmm... And does how this make native DesignWare IP's registers obsolete?


> +	if (of_device_is_compatible(pdev->dev.of_node, "mscc,ocelot-
> i2c"))

Can't you just ask for this unconditionally? Why not?
(It seems I might have known why not, but can we use named resource
instead in case this is not so SoC specific)


-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
