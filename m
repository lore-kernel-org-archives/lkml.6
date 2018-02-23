Return-Path: <andriy.shevchenko@linux.intel.com>
X-Google-Smtp-Source: AH8x227qu/QZSeIEi0KRkznuWP7P1bhiLoOoyL7bVlDCh/A0MpajQk1vFVMzH0pHAHkny8quJ3np
ARC-Seal: i=1; a=rsa-sha256; t=1519381539; cv=none;
        d=google.com; s=arc-20160816;
        b=uXgr6Q0Fh1ueIqCNRXBRtc+MMPi5K1GvC2wKO13xj/X+I0oQmspSNCqaSw9VrC05eY
         f3vc6ECA+AivvayEJ61n478cVKkoguuDaTYnSngU5ETkwsWeRsnjWd9K35VP9GKywIvo
         twlI3/WuJ8P7l6sO/HhBGS+Pc6ODkOTfp5RRGRV2LnzfXcSTuEXCltnkyJgQHPpjTlmw
         Agm4ZtabnB8wMkhi2VxsysJ17A5emPrHHzwqIfA0V5XNAS/Xo4Kgz5zE3rm84DULOpCo
         Lpw9w7WD8nTPW30Koqvam9nBKzGQIgHmXayQDYCUHJdu+2xsHcQux0+i5lwO0x9+i7JX
         rrCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:date:to:from:subject:message-id
         :arc-authentication-results;
        bh=q/CITCxFlgqvPU9qAPcWAJD+MjCohAXL7WwQQys8EEA=;
        b=VY4oGRN7hLjw9np76OmyYjex6GQN2MVFxN86XLBATmyeMj66LqhakknoYnV4gtJ3Li
         2RRZ3nZRZ7S6ottJJt/wqhH2yAO1/5uFpqmwHLYtjKpRJ+53yCo6TLWGEqRo/qhZm1aN
         t9NiwH2rD0nk53WHgOkc19LueY+k/Pi+Mg6AI3AR1zkMs+exkUZX1PYz99WV5IA/pRV5
         +fLGMAx8o8+kDybaYXN64pM0QVgLyXYh13WoJtILcq/h2jCEkatbT9M3kE8Avh44WqFz
         ZAZlWnXErtLv6KpdK+wxdAuEY1Ui2pjJplu2S3Nc2tQ/hAWTh4aWBGKzVJznv4pj6HFo
         Ne9w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of andriy.shevchenko@linux.intel.com designates 134.134.136.65 as permitted sender) smtp.mailfrom=andriy.shevchenko@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of andriy.shevchenko@linux.intel.com designates 134.134.136.65 as permitted sender) smtp.mailfrom=andriy.shevchenko@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,382,1515484800";
   d="scan'208";a="206378503"
Message-ID: <1519381535.10722.99.camel@linux.intel.com>
Subject: Re: [PATCH arm/aspeed/ast2500 v2] eSPI: add ASPEED AST2500 eSPI
 driver to boot a host with PCH runs on eSPI
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Haiyue Wang <haiyue.wang@linux.intel.com>, joel@jms.id.au,
 andrew@aj.id.au,  arnd@arndb.de, gregkh@linuxfoundation.org,
 openbmc@lists.ozlabs.org,  linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Date: Fri, 23 Feb 2018 12:25:35 +0200
In-Reply-To: <1519369459-12468-1-git-send-email-haiyue.wang@linux.intel.com>
References: <1519369459-12468-1-git-send-email-haiyue.wang@linux.intel.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593174288086500423?=
X-GMAIL-MSGID: =?utf-8?q?1593187017366224021?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 2018-02-23 at 15:04 +0800, Haiyue Wang wrote:
> When PCH works under eSPI mode, the PMC (Power Management Controller)
> in
> PCH is waiting for SUS_ACK from BMC after it alerts SUS_WARN. It is in
> dead loop if no SUS_ACK assert. This is the basic requirement for the
> BMC
> works as eSPI slave.

So, do we have an agreement that the driver should go in this shape w/o
interacting with SPI subsystem?

Also few comments below.

> +config ASPEED_ESPI_SLAVE

> +	depends on (ARCH_ASPEED || COMPILE_TEST) && REGMAP_MMIO

I would rather split this to two
	depends on REGMAP_MMIO
	depends on ARCH_ASPEED || COMPILE_TEST

> +	tristate "Aspeed ast2500 eSPI slave device driver"
> +	---help---
> +	  Control Aspeed ast2500 eSPI slave controller to handle
> event
> +	  which needs the firmware's processing.

> +#include <linux/of.h>

What exactly requires this header?

> +static int aspeed_espi_slave_probe(struct platform_device *pdev)
> +{
> +	struct aspeed_espi_slave_data *priv;
> +	struct device *dev = &pdev->dev;
> +	struct resource *res;
> +	void __iomem *regs;
> +	int rc;
> +

> +	dev_set_name(dev, DEVICE_NAME);

Do this after checks and memory allocations.

> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	regs = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(regs))
> +		return PTR_ERR(regs);
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->map = devm_regmap_init_mmio(dev, regs,
> &espi_slave_regmap_cfg);
> +	if (IS_ERR(priv->map))
> +		return PTR_ERR(priv->map);
> +

> +static const struct of_device_id of_espi_slave_match_table[] = {
> +	{ .compatible = "aspeed,ast2500-espi-slave" },
> +	{ }
> +};

> +MODULE_DEVICE_TABLE(of, of_espi_slave_match_table);

This one should be closer to the struct of_device_id.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
