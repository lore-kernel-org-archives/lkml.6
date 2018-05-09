Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965196AbeEITOq (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 15:14:46 -0400
Received: from mga12.intel.com ([192.55.52.136]:5145 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965013AbeEITOo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 15:14:44 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,382,1520924400";
   d="scan'208";a="227159469"
Date: Thu, 10 May 2018 03:13:42 +0800
From: kbuild test robot <lkp@intel.com>
To: Dan Murphy <dmurphy@ti.com>
Cc: kbuild-all@01.org, robh+dt@kernel.org, mark.rutland@arm.com,
        jacek.anaszewski@gmail.com, pavel@ucw.cz, afd@ti.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCH v3 2/2] leds: lm3601x: Introduce the lm3601x LED driver
Message-ID: <201805100310.5poORgcq%fengguang.wu@intel.com>
References: <20180509115727.12070-2-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180509115727.12070-2-dmurphy@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on robh/for-next]
[also build test WARNING on v4.17-rc4 next-20180509]
[cannot apply to j.anaszewski-leds/for-next]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Dan-Murphy/dt-bindings-lm3601x-Introduce-the-lm3601x-driver/20180509-232022
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next


coccinelle warnings: (new ones prefixed by >>)

>> drivers/leds/leds-lm3601x.c:241:35-36: WARNING: Use ARRAY_SIZE

vim +241 drivers/leds/leds-lm3601x.c

   224	
   225	static int lm3601x_strobe_set(struct led_classdev_flash *fled_cdev,
   226					bool state)
   227	{
   228		struct lm3601x_led *led = fled_cdev_to_led(fled_cdev);
   229		int ret;
   230		int current_timeout;
   231		int reg_count;
   232		int i;
   233		int timeout_reg_val = 0;
   234	
   235		mutex_lock(&led->lock);
   236	
   237		ret = regmap_read(led->regmap, LM3601X_CFG_REG, &current_timeout);
   238		if (ret < 0)
   239			goto out;
   240	
 > 241		reg_count = sizeof(strobe_timeouts) / sizeof(strobe_timeouts[0]);
   242		for (i = 0; i < reg_count; i++) {
   243			if (led->strobe_timeout > strobe_timeouts[i].timeout)
   244				continue;
   245	
   246			if (led->strobe_timeout <= strobe_timeouts[i].timeout) {
   247				timeout_reg_val = (strobe_timeouts[i].reg_val << 1);
   248				break;
   249			}
   250	
   251			ret = -EINVAL;
   252			goto out;
   253		}
   254	
   255		if (led->strobe_timeout != current_timeout)
   256			ret = regmap_update_bits(led->regmap, LM3601X_CFG_REG,
   257						0x1e, timeout_reg_val);
   258	
   259		if (state)
   260			ret = regmap_update_bits(led->regmap, LM3601X_ENABLE_REG,
   261						LM3601X_MODE_STROBE,
   262						LM3601X_MODE_STROBE);
   263		else
   264			ret = regmap_update_bits(led->regmap, LM3601X_ENABLE_REG,
   265						LM3601X_MODE_STROBE, LED_OFF);
   266	
   267		ret = lm3601x_read_faults(led);
   268	out:
   269		mutex_unlock(&led->lock);
   270		return ret;
   271	}
   272	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
