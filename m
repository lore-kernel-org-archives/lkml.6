Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDDEBC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 10:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87C6521717
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 10:10:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87C6521717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732584AbeHCMG1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 08:06:27 -0400
Received: from mga06.intel.com ([134.134.136.31]:57381 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729818AbeHCMG0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 08:06:26 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Aug 2018 03:10:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,438,1526367600"; 
   d="scan'208";a="72272390"
Received: from bee.sh.intel.com (HELO lkp-server01) ([10.239.97.14])
  by orsmga003.jf.intel.com with ESMTP; 03 Aug 2018 03:10:45 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1flX2i-0009zi-L5; Fri, 03 Aug 2018 18:10:44 +0800
Date:   Fri, 3 Aug 2018 18:10:21 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     kbuild-all@01.org, lee.jones@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, eballetbo@gmail.com,
        linus.walleij@linaro.org, mazziesaccount@gmail.com,
        dmitry.torokhov@gmail.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        sboyd@kernel.org, broonie@kernel.org, linux-input@vger.kernel.org,
        mikko.mutanen@fi.rohmeurope.com, heikki.haikola@fi.rohmeurope.com
Subject: Re: [PATCH v11 1/2] mfd: bd71837: mfd driver for ROHM BD71837 PMIC
Message-ID: <201808031831.TJYSQ80i%fengguang.wu@intel.com>
References: <77184f651e5cefb112f1061bc682b759f88144c6.1532946848.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77184f651e5cefb112f1061bc682b759f88144c6.1532946848.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matti,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on ljones-mfd/for-mfd-next]
[also build test WARNING on v4.18-rc7 next-20180802]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Matti-Vaittinen/mfd-bd71837-mfd-driver-for-ROHM-BD71837-PMIC/20180730-204810
base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git for-mfd-next

smatch warnings:
drivers/mfd/rohm-bd718x7.c:163 bd71837_i2c_probe() warn: unsigned 'button.irq' is never less than zero.

vim +163 drivers/mfd/rohm-bd718x7.c

    88	
    89	static int bd71837_i2c_probe(struct i2c_client *i2c,
    90				    const struct i2c_device_id *id)
    91	{
    92		struct bd71837 *bd71837;
    93		int ret, i;
    94		unsigned int val;
    95	
    96		bd71837 = devm_kzalloc(&i2c->dev, sizeof(struct bd71837), GFP_KERNEL);
    97	
    98		if (!bd71837)
    99			return -ENOMEM;
   100	
   101		bd71837->chip_irq = i2c->irq;
   102	
   103		if (!bd71837->chip_irq) {
   104			dev_err(&i2c->dev, "No IRQ configured\n");
   105			return -EINVAL;
   106		}
   107	
   108		bd71837->dev = &i2c->dev;
   109		dev_set_drvdata(&i2c->dev, bd71837);
   110	
   111		bd71837->regmap = devm_regmap_init_i2c(i2c, &bd71837_regmap_config);
   112		if (IS_ERR(bd71837->regmap)) {
   113			dev_err(&i2c->dev, "regmap initialization failed\n");
   114			return PTR_ERR(bd71837->regmap);
   115		}
   116	
   117		ret = regmap_read(bd71837->regmap, BD71837_REG_REV, &val);
   118		if (ret) {
   119			dev_err(&i2c->dev, "Read BD71837_REG_DEVICE failed\n");
   120			return ret;
   121		}
   122		for (i = 0; i < ARRAY_SIZE(supported_revisions); i++)
   123			if (supported_revisions[i] == val)
   124				break;
   125	
   126		if (i == ARRAY_SIZE(supported_revisions)) {
   127			dev_err(&i2c->dev, "Unsupported chip revision\n");
   128			return -ENODEV;
   129		}
   130	
   131		ret = devm_regmap_add_irq_chip(&i2c->dev, bd71837->regmap,
   132					       bd71837->chip_irq, IRQF_ONESHOT, 0,
   133					       &bd71837_irq_chip, &bd71837->irq_data);
   134		if (ret) {
   135			dev_err(&i2c->dev, "Failed to add irq_chip\n");
   136			return ret;
   137		}
   138	
   139		/* Configure short press to 10 milliseconds */
   140		ret = regmap_update_bits(bd71837->regmap,
   141					 BD71837_REG_PWRONCONFIG0,
   142					 BD718XX_PWRBTN_PRESS_DURATION_MASK,
   143					 BD718XX_PWRBTN_SHORT_PRESS_10MS);
   144		if (ret) {
   145			dev_err(&i2c->dev, "Failed to configure button short press timeout\n");
   146			return ret;
   147		}
   148	
   149		/* Configure long press to 10 seconds */
   150		ret = regmap_update_bits(bd71837->regmap,
   151					 BD71837_REG_PWRONCONFIG1,
   152					 BD718XX_PWRBTN_PRESS_DURATION_MASK,
   153					 BD718XX_PWRBTN_LONG_PRESS_10S);
   154	
   155		if (ret) {
   156			dev_err(&i2c->dev, "Failed to configure button long press timeout\n");
   157			return ret;
   158		}
   159	
   160		button.irq = regmap_irq_get_virq(bd71837->irq_data,
   161						  BD71837_INT_PWRBTN_S);
   162	
 > 163		if (button.irq < 0) {
   164			dev_err(&i2c->dev, "Failed to get the IRQ\n");
   165			return button.irq;
   166		}
   167	
   168		ret = devm_mfd_add_devices(bd71837->dev, PLATFORM_DEVID_AUTO,
   169					   bd71837_mfd_cells,
   170					   ARRAY_SIZE(bd71837_mfd_cells), NULL, 0,
   171					   regmap_irq_get_domain(bd71837->irq_data));
   172		if (ret)
   173			dev_err(&i2c->dev, "Failed to create subdevices\n");
   174	
   175		return ret;
   176	}
   177	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
