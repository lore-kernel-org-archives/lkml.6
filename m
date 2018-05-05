Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751398AbeEEF1d (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 01:27:33 -0400
Received: from mga18.intel.com ([134.134.136.126]:29744 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750744AbeEEF1b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 01:27:31 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,364,1520924400";
   d="scan'208";a="51701360"
Date: Sat, 5 May 2018 13:26:42 +0800
From: kbuild test robot <lkp@intel.com>
To: Baolin Wang <baolin.wang@linaro.org>
Cc: kbuild-all@01.org, jacek.anaszewski@gmail.com, pavel@ucw.cz,
        robh+dt@kernel.org, mark.rutland@arm.com, xiaotong.lu@spreadtrum.com,
        baolin.wang@linaro.org, broonie@kernel.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] leds: Add Spreadtrum SC27xx breathing light
 controller driver
Message-ID: <201805051300.jy5SNVta%fengguang.wu@intel.com>
References: <1bf5bc3e007d237477d740f47ed63f05aa71b348.1525427961.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1bf5bc3e007d237477d740f47ed63f05aa71b348.1525427961.git.baolin.wang@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xiaotong,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on robh/for-next]
[also build test WARNING on v4.17-rc3 next-20180504]
[cannot apply to j.anaszewski-leds/for-next]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Baolin-Wang/dt-bindings-leds-Add-SC27xx-breathing-light-controller-documentation/20180504-200830
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next

smatch warnings:
drivers/leds/leds-sc27xx-bltc.c:337 sc27xx_led_probe() warn: unsigned 'reg' is never less than zero.

vim +/reg +337 drivers/leds/leds-sc27xx-bltc.c

   299	
   300	static int sc27xx_led_probe(struct platform_device *pdev)
   301	{
   302		struct device *dev = &pdev->dev;
   303		struct device_node *np = dev->of_node, *child;
   304		struct sc27xx_led_priv *priv;
   305		u32 base, count, reg;
   306		int err;
   307	
   308		count = of_get_child_count(np);
   309		if (!count || count > SC27XX_LEDS_MAX)
   310			return -EINVAL;
   311	
   312		err = of_property_read_u32(np, "reg", &base);
   313		if (err) {
   314			dev_err(dev, "fail to get reg of property\n");
   315			return err;
   316		}
   317	
   318		priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
   319		if (!priv)
   320			return -ENOMEM;
   321	
   322		priv->base = base;
   323		priv->regmap = dev_get_regmap(dev->parent, NULL);
   324		if (IS_ERR(priv->regmap)) {
   325			err = PTR_ERR(priv->regmap);
   326			dev_err(dev, "failed to get regmap: %d\n", err);
   327			return err;
   328		}
   329	
   330		for_each_child_of_node(np, child) {
   331			err = of_property_read_u32(child, "reg", &reg);
   332			if (err) {
   333				of_node_put(child);
   334				return err;
   335			}
   336	
 > 337			if (reg < 0 || reg >= SC27XX_LEDS_MAX
   338			    || priv->leds[reg].active) {
   339				of_node_put(child);
   340				return -EINVAL;
   341			}
   342	
   343			priv->leds[reg].active = true;
   344			priv->leds[reg].ldev.name =
   345				of_get_property(child, "label", NULL) ? : child->name;
   346		}
   347	
   348		return sc27xx_led_register(dev, priv);
   349	}
   350	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
