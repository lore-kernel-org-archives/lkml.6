Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966071AbeE2Sfv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 14:35:51 -0400
Received: from mga07.intel.com ([134.134.136.100]:27189 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965885AbeE2Sft (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 14:35:49 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,457,1520924400";
   d="scan'208";a="58652261"
Date: Wed, 30 May 2018 02:35:03 +0800
From: kbuild test robot <lkp@intel.com>
To: Srinath Mannam <srinath.mannam@broadcom.com>
Cc: kbuild-all@01.org, Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Pramod Kumar <pramod.kumar@broadcom.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: Re: [PATCH 3/3] thermal: broadcom: Add Stingray thermal driver
Message-ID: <201805292313.y0wwGpTj%fengguang.wu@intel.com>
References: <1527486084-4636-4-git-send-email-srinath.mannam@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527486084-4636-4-git-send-email-srinath.mannam@broadcom.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pramod,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on soc-thermal/next]
[also build test WARNING on v4.17-rc7 next-20180529]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Srinath-Mannam/Stingray-thermal-driver-support/20180529-145243
base:   https://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal.git next
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/thermal/broadcom/sr-thermal.c:101:26: sparse: incorrect type in assignment (different address spaces) @@    expected void [noderef] <asn:2>*regs @@    got sn:2>*regs @@
   drivers/thermal/broadcom/sr-thermal.c:101:26:    expected void [noderef] <asn:2>*regs
   drivers/thermal/broadcom/sr-thermal.c:101:26:    got void *

vim +101 drivers/thermal/broadcom/sr-thermal.c

    88	
    89	static int sr_thermal_probe(struct platform_device *pdev)
    90	{
    91		struct device *dev = &pdev->dev;
    92		struct sr_thermal *sr_thermal;
    93		struct resource *res;
    94	
    95		sr_thermal = devm_kzalloc(dev, sizeof(*sr_thermal), GFP_KERNEL);
    96		if (!sr_thermal)
    97			return -ENOMEM;
    98		sr_thermal->dev = dev;
    99	
   100		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 > 101		sr_thermal->regs = devm_memremap(&pdev->dev, res->start,
   102						 resource_size(res), MEMREMAP_WB);
   103		if (IS_ERR(sr_thermal->regs)) {
   104			dev_err(dev, "failed to get io address\n");
   105			return PTR_ERR(sr_thermal->regs);
   106		}
   107	
   108		/* initialize tmon value to 0 */
   109		writel(0, sr_thermal->regs);
   110		sr_thermal->crit_temp = TMON_CRIT_TEMP;
   111	
   112		sr_thermal->tz = thermal_zone_device_register(dev_name(dev), 1, 1,
   113								 sr_thermal,
   114								 &sr_thermal_ops,
   115								 NULL, 1000, 1000);
   116		if (IS_ERR(sr_thermal->tz))
   117			return PTR_ERR(sr_thermal->tz);
   118	
   119		platform_set_drvdata(pdev, sr_thermal);
   120	
   121		return 0;
   122	}
   123	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
