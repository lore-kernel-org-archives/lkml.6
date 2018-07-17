Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DEFBECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D80E720850
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:16:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D80E720850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729720AbeGQPtV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 11:49:21 -0400
Received: from mga01.intel.com ([192.55.52.88]:29166 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729640AbeGQPtV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 11:49:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jul 2018 08:16:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,366,1526367600"; 
   d="scan'208";a="57563054"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga008.jf.intel.com with ESMTP; 17 Jul 2018 08:16:11 -0700
Message-ID: <1886510d2a828d3a246ef1f490c6819f073fbdcb.camel@linux.intel.com>
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
Date:   Tue, 17 Jul 2018 18:16:10 +0300
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

Thanks for information you provided. See my comments below.

>  struct dw_i2c_dev {
>  	struct device		*dev;
>  	void __iomem		*base;
> +	void __iomem		*base_ext;

Maybe simple "ext"? Up to you.
 
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

(1)

>  
> +	if (of_device_is_compatible(pdev->dev.of_node, "mscc,ocelot-
> i2c")) {
> +		mem = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +		dev->base_ext = devm_ioremap_resource(&pdev->dev,
> mem);
> +		if (!IS_ERR(dev->base_ext))
> +			dev->set_sda_hold_time =
> mscc_twi_set_sda_hold_time;
> +	}

(2)

>  static const struct of_device_id dw_i2c_of_match[] = {
>  	{ .compatible = "snps,designware-i2c", },
> +	{ .compatible = "mscc,ocelot-i2c", },
>  	{},
>  };

(3)


I would rather place them in analogue how we do for ACPI, i.e.

--- 8< --- 8< ---

...
#define MODEL_MSCC_OCELOT  0x00000200
#define MODEL_MASK         0x00000f00
...

#ifdef CONFIG_OF
-->(1)
int dw_i2c_of_configure(pdev)
{
...
-->(2) (perhaps we don't care if it goes without condition, or move it
below in the corresponding case?
...

 switch(dev->flags & MODEL_MASK) {
  case MODEL_MSCC_OCELOT:
   ...
   break;
  default:
   break;
 }

 return 0;
}

-->(3)
...
{ .compatible = "mscc,ocelot-i2c", .data = (void *)MODEL_MSCC_OCELOT },
...

#else
static inline int dw_i2c_of_configure(pdev) { return -ENODEV; }
#endif

...

->probe():

...

/* REPLACE THIS in dw_i2c_acpi_configure() by below in ->probe():
 * id = acpi_match_device(pdev->dev.driver->acpi_match_table, &pdev-
>dev);
 * if (id && id->driver_data)
 *   dev->flags |= (u32)id->driver_data;
 */

  dev->flags |= (u32)device_get_match_data(&pdev->dev);

  if (&pdev->dev.of_node)
    dw_i2c_of_configure(pdev);

...

--- 8< --- 8< ---

What do you think?

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
