Return-Path: <haiyue.wang@linux.intel.com>
X-Google-Smtp-Source: AH8x226W7ki9R+ZLoeQQ/jLZmk+fyGizlFyKm75IISMgFzek0ms0x2ZLbyQq+woUVw3MKGJpL7Hv
ARC-Seal: i=1; a=rsa-sha256; t=1519391959; cv=none;
        d=google.com; s=arc-20160816;
        b=zH2X+J1qGjLyl2Zi4cAynNdRMp8q+vnpd2xo7V3YfgRcfwg1ManYB+3NIaBNmybz8A
         V2waPqKGQ4VYIpUOktotBEZUiFmQAdd+NnEgXieRIpO1NMF1PGgP/HD+wWlUugms+ebI
         SbKcHzxyZKqGsmqubNGDvAqI1vuIcnuzvGFNdu0uhN9vBMvVbExnMkHWpsx8hO+2K4K+
         VndsV2uwYAVfU4H4REtIU0XoOAZT4Q3GubRVogOF+EKVjl5WRm8qrBsK9d/rz9xx0Y5s
         PNHq1ieGSLPI/OuaodfNun8H/ajXGPCpr6tGMHkzjFSbJokof1SeCmSkT7xcLe/4APyU
         O9zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject
         :arc-authentication-results;
        bh=vKnIXHwup0fLcMw5RBlUcLzmPLFY4YykCavV7nIKEME=;
        b=tqghD2yYIBIR650vVIVWpqdiJso61rlT65Pp1bgo+6qS5mXGA8sCkTU9BliQ4Ea5op
         bYPBKIOPG9Bz7ywrU2nZw86izIQyi0OQgjZLwx31YOZAVyICi2+bjynL3Rom8KSIOLD1
         kFQ5qXOdeayiYPPesv7dMGVSNZYoJKzSYbPQSXIRdwIHvNDfFFDHwYkNxCjo57H9kU7K
         WIdhwRL1xEIePuwNOiKxvjVMwmTUUGWcmMlBRkwt46gNvedR9DESZIlag1TfUxQZdEZU
         YrSIFamMWU2mM/AOaTbFL8jZntu6OL9VS2NojuMCM1MgVgpyWCWOLb1t4LZsg8hgis3+
         5taA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of haiyue.wang@linux.intel.com designates 134.134.136.100 as permitted sender) smtp.mailfrom=haiyue.wang@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of haiyue.wang@linux.intel.com designates 134.134.136.100 as permitted sender) smtp.mailfrom=haiyue.wang@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,383,1515484800";
   d="scan'208";a="30125968"
Subject: Re: [PATCH arm/aspeed/ast2500 v2] eSPI: add ASPEED AST2500 eSPI
 driver to boot a host with PCH runs on eSPI
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, joel@jms.id.au,
 andrew@aj.id.au, arnd@arndb.de, gregkh@linuxfoundation.org,
 openbmc@lists.ozlabs.org, linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <1519369459-12468-1-git-send-email-haiyue.wang@linux.intel.com>
 <1519381535.10722.99.camel@linux.intel.com>
From: "Wang, Haiyue" <haiyue.wang@linux.intel.com>
Message-ID: <ae72a9ca-e506-5279-c1b3-114e4eec2be3@linux.intel.com>
Date: Fri, 23 Feb 2018 21:19:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519381535.10722.99.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593174288086500423?=
X-GMAIL-MSGID: =?utf-8?q?1593197942972997282?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018-02-23 18:25, Andy Shevchenko wrote:
> On Fri, 2018-02-23 at 15:04 +0800, Haiyue Wang wrote:
>> When PCH works under eSPI mode, the PMC (Power Management Controller)
>> in
>> PCH is waiting for SUS_ACK from BMC after it alerts SUS_WARN. It is in
>> dead loop if no SUS_ACK assert. This is the basic requirement for the
>> BMC
>> works as eSPI slave.
> So, do we have an agreement that the driver should go in this shape w/o
> interacting with SPI subsystem?
Not sure, I've added the specification of eSPI, hope people don't feel 
confused with SPI. :-)
> Also few comments below.
>
>> +config ASPEED_ESPI_SLAVE
>> +	depends on (ARCH_ASPEED || COMPILE_TEST) && REGMAP_MMIO
> I would rather split this to two
> 	depends on REGMAP_MMIO
> 	depends on ARCH_ASPEED || COMPILE_TEST
OK, it looks clean. I referred to:
config ASPEED_LPC_CTRL
         depends on (ARCH_ASPEED || COMPILE_TEST) && REGMAP && MFD_SYSCON

>> +	tristate "Aspeed ast2500 eSPI slave device driver"
>> +	---help---
>> +	  Control Aspeed ast2500 eSPI slave controller to handle
>> event
>> +	  which needs the firmware's processing.
>> +#include <linux/of.h>
> What exactly requires this header?
Oh, I ctrl+c / ctrl+v from other device tree usage module. :-(
Remove it now. Thanks for making the code more clean.
>> +static int aspeed_espi_slave_probe(struct platform_device *pdev)
>> +{
>> +	struct aspeed_espi_slave_data *priv;
>> +	struct device *dev = &pdev->dev;
>> +	struct resource *res;
>> +	void __iomem *regs;
>> +	int rc;
>> +
>> +	dev_set_name(dev, DEVICE_NAME);
> Do this after checks and memory allocations.
Fixed!
>> +
>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	regs = devm_ioremap_resource(dev, res);
>> +	if (IS_ERR(regs))
>> +		return PTR_ERR(regs);
>> +
>> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>> +	if (!priv)
>> +		return -ENOMEM;
>> +
>> +	priv->map = devm_regmap_init_mmio(dev, regs,
>> &espi_slave_regmap_cfg);
>> +	if (IS_ERR(priv->map))
>> +		return PTR_ERR(priv->map);
>> +
>> +static const struct of_device_id of_espi_slave_match_table[] = {
>> +	{ .compatible = "aspeed,ast2500-espi-slave" },
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(of, of_espi_slave_match_table);
> This one should be closer to the struct of_device_id.
Fixed.
