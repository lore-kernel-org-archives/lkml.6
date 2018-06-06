Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BD1FC60555
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752377AbeFFOE3 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 10:04:29 -0400
Received: from mga05.intel.com ([192.55.52.43]:43704 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752337AbeFFOE1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 10:04:27 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,483,1520924400";
   d="gz'50?scan'50,208,50";a="60881554"
Date: Wed, 6 Jun 2018 22:04:03 +0800
From: kbuild test robot <lkp@intel.com>
To: Marek Vasut <marek.vasut@gmail.com>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v4 06/12] mfd: da9063: Replace model with type
Message-ID: <201806062149.dJcM8IXr%fengguang.wu@intel.com>
References: <20180605231013.1803-6-marek.vasut+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="jRHKVT23PllUwdXP"
Content-Disposition: inline
In-Reply-To: <20180605231013.1803-6-marek.vasut+renesas@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lkp@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Marek,

I love your patch! Yet something to improve:

[auto build test ERROR on ljones-mfd/for-mfd-next]
[also build test ERROR on v4.17 next-20180605]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Marek-Vasut/mfd-da9063-Fix-failpath-in-core/20180606-212247
base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git for-mfd-next
config: i386-randconfig-x079-201822 (attached as .config)
compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   drivers/regulator/da9063-regulator.c: In function 'da9063_regulator_probe':
>> drivers/regulator/da9063-regulator.c:749:10: error: 'struct da9063' has no member named 'model'
       da9063->model);
             ^~

vim +749 drivers/regulator/da9063-regulator.c

69ca3e58 Krystian Garbaciak 2013-07-29  715  
69ca3e58 Krystian Garbaciak 2013-07-29  716  static int da9063_regulator_probe(struct platform_device *pdev)
69ca3e58 Krystian Garbaciak 2013-07-29  717  {
69ca3e58 Krystian Garbaciak 2013-07-29  718  	struct da9063 *da9063 = dev_get_drvdata(pdev->dev.parent);
69ca3e58 Krystian Garbaciak 2013-07-29  719  	struct da9063_pdata *da9063_pdata = dev_get_platdata(da9063->dev);
0fdfd40a Geert Uytterhoeven 2013-09-09  720  	struct of_regulator_match *da9063_reg_matches = NULL;
69ca3e58 Krystian Garbaciak 2013-07-29  721  	struct da9063_regulators_pdata *regl_pdata;
69ca3e58 Krystian Garbaciak 2013-07-29  722  	const struct da9063_dev_model *model;
69ca3e58 Krystian Garbaciak 2013-07-29  723  	struct da9063_regulators *regulators;
69ca3e58 Krystian Garbaciak 2013-07-29  724  	struct da9063_regulator *regl;
69ca3e58 Krystian Garbaciak 2013-07-29  725  	struct regulator_config config;
69ca3e58 Krystian Garbaciak 2013-07-29  726  	bool bcores_merged, bmem_bio_merged;
69ca3e58 Krystian Garbaciak 2013-07-29  727  	int id, irq, n, n_regulators, ret, val;
69ca3e58 Krystian Garbaciak 2013-07-29  728  	size_t size;
69ca3e58 Krystian Garbaciak 2013-07-29  729  
69ca3e58 Krystian Garbaciak 2013-07-29  730  	regl_pdata = da9063_pdata ? da9063_pdata->regulators_pdata : NULL;
69ca3e58 Krystian Garbaciak 2013-07-29  731  
69ca3e58 Krystian Garbaciak 2013-07-29  732  	if (!regl_pdata)
69ca3e58 Krystian Garbaciak 2013-07-29  733  		regl_pdata = da9063_parse_regulators_dt(pdev,
69ca3e58 Krystian Garbaciak 2013-07-29  734  							&da9063_reg_matches);
69ca3e58 Krystian Garbaciak 2013-07-29  735  
69ca3e58 Krystian Garbaciak 2013-07-29  736  	if (IS_ERR(regl_pdata) || regl_pdata->n_regulators == 0) {
69ca3e58 Krystian Garbaciak 2013-07-29  737  		dev_err(&pdev->dev,
69ca3e58 Krystian Garbaciak 2013-07-29  738  			"No regulators defined for the platform\n");
b6615659 Dan Carpenter      2017-08-30  739  		return -ENODEV;
69ca3e58 Krystian Garbaciak 2013-07-29  740  	}
69ca3e58 Krystian Garbaciak 2013-07-29  741  
69ca3e58 Krystian Garbaciak 2013-07-29  742  	/* Find regulators set for particular device model */
69ca3e58 Krystian Garbaciak 2013-07-29  743  	for (model = regulators_models; model->regulator_info; model++) {
9a58dfc5 Marek Vasut        2018-06-06  744  		if (model->type == da9063->type)
69ca3e58 Krystian Garbaciak 2013-07-29  745  			break;
69ca3e58 Krystian Garbaciak 2013-07-29  746  	}
69ca3e58 Krystian Garbaciak 2013-07-29  747  	if (!model->regulator_info) {
69ca3e58 Krystian Garbaciak 2013-07-29  748  		dev_err(&pdev->dev, "Chip model not recognised (%u)\n",
69ca3e58 Krystian Garbaciak 2013-07-29 @749  			da9063->model);
69ca3e58 Krystian Garbaciak 2013-07-29  750  		return -ENODEV;
69ca3e58 Krystian Garbaciak 2013-07-29  751  	}
69ca3e58 Krystian Garbaciak 2013-07-29  752  
69ca3e58 Krystian Garbaciak 2013-07-29  753  	ret = regmap_read(da9063->regmap, DA9063_REG_CONFIG_H, &val);
69ca3e58 Krystian Garbaciak 2013-07-29  754  	if (ret < 0) {
69ca3e58 Krystian Garbaciak 2013-07-29  755  		dev_err(&pdev->dev,
69ca3e58 Krystian Garbaciak 2013-07-29  756  			"Error while reading BUCKs configuration\n");
8a7963d5 Sachin Kamat       2014-02-18  757  		return ret;
69ca3e58 Krystian Garbaciak 2013-07-29  758  	}
69ca3e58 Krystian Garbaciak 2013-07-29  759  	bcores_merged = val & DA9063_BCORE_MERGE;
69ca3e58 Krystian Garbaciak 2013-07-29  760  	bmem_bio_merged = val & DA9063_BUCK_MERGE;
69ca3e58 Krystian Garbaciak 2013-07-29  761  
69ca3e58 Krystian Garbaciak 2013-07-29  762  	n_regulators = model->n_regulators;
69ca3e58 Krystian Garbaciak 2013-07-29  763  	if (bcores_merged)
69ca3e58 Krystian Garbaciak 2013-07-29  764  		n_regulators -= 2; /* remove BCORE1, BCORE2 */
69ca3e58 Krystian Garbaciak 2013-07-29  765  	else
69ca3e58 Krystian Garbaciak 2013-07-29  766  		n_regulators--;    /* remove BCORES_MERGED */
69ca3e58 Krystian Garbaciak 2013-07-29  767  	if (bmem_bio_merged)
69ca3e58 Krystian Garbaciak 2013-07-29  768  		n_regulators -= 2; /* remove BMEM, BIO */
69ca3e58 Krystian Garbaciak 2013-07-29  769  	else
69ca3e58 Krystian Garbaciak 2013-07-29  770  		n_regulators--;    /* remove BMEM_BIO_MERGED */
69ca3e58 Krystian Garbaciak 2013-07-29  771  
69ca3e58 Krystian Garbaciak 2013-07-29  772  	/* Allocate memory required by usable regulators */
69ca3e58 Krystian Garbaciak 2013-07-29  773  	size = sizeof(struct da9063_regulators) +
69ca3e58 Krystian Garbaciak 2013-07-29  774  		n_regulators * sizeof(struct da9063_regulator);
69ca3e58 Krystian Garbaciak 2013-07-29  775  	regulators = devm_kzalloc(&pdev->dev, size, GFP_KERNEL);
8b5baa56 Sachin Kamat       2014-02-20  776  	if (!regulators)
69ca3e58 Krystian Garbaciak 2013-07-29  777  		return -ENOMEM;
69ca3e58 Krystian Garbaciak 2013-07-29  778  
69ca3e58 Krystian Garbaciak 2013-07-29  779  	regulators->n_regulators = n_regulators;
69ca3e58 Krystian Garbaciak 2013-07-29  780  	platform_set_drvdata(pdev, regulators);
69ca3e58 Krystian Garbaciak 2013-07-29  781  
69ca3e58 Krystian Garbaciak 2013-07-29  782  	/* Register all regulators declared in platform information */
69ca3e58 Krystian Garbaciak 2013-07-29  783  	n = 0;
69ca3e58 Krystian Garbaciak 2013-07-29  784  	id = 0;
69ca3e58 Krystian Garbaciak 2013-07-29  785  	while (n < regulators->n_regulators) {
69ca3e58 Krystian Garbaciak 2013-07-29  786  		/* Skip regulator IDs depending on merge mode configuration */
69ca3e58 Krystian Garbaciak 2013-07-29  787  		switch (id) {
69ca3e58 Krystian Garbaciak 2013-07-29  788  		case DA9063_ID_BCORE1:
69ca3e58 Krystian Garbaciak 2013-07-29  789  		case DA9063_ID_BCORE2:
69ca3e58 Krystian Garbaciak 2013-07-29  790  			if (bcores_merged) {
69ca3e58 Krystian Garbaciak 2013-07-29  791  				id++;
69ca3e58 Krystian Garbaciak 2013-07-29  792  				continue;
69ca3e58 Krystian Garbaciak 2013-07-29  793  			}
69ca3e58 Krystian Garbaciak 2013-07-29  794  			break;
69ca3e58 Krystian Garbaciak 2013-07-29  795  		case DA9063_ID_BMEM:
69ca3e58 Krystian Garbaciak 2013-07-29  796  		case DA9063_ID_BIO:
69ca3e58 Krystian Garbaciak 2013-07-29  797  			if (bmem_bio_merged) {
69ca3e58 Krystian Garbaciak 2013-07-29  798  				id++;
69ca3e58 Krystian Garbaciak 2013-07-29  799  				continue;
69ca3e58 Krystian Garbaciak 2013-07-29  800  			}
69ca3e58 Krystian Garbaciak 2013-07-29  801  			break;
69ca3e58 Krystian Garbaciak 2013-07-29  802  		case DA9063_ID_BCORES_MERGED:
69ca3e58 Krystian Garbaciak 2013-07-29  803  			if (!bcores_merged) {
69ca3e58 Krystian Garbaciak 2013-07-29  804  				id++;
69ca3e58 Krystian Garbaciak 2013-07-29  805  				continue;
69ca3e58 Krystian Garbaciak 2013-07-29  806  			}
69ca3e58 Krystian Garbaciak 2013-07-29  807  			break;
69ca3e58 Krystian Garbaciak 2013-07-29  808  		case DA9063_ID_BMEM_BIO_MERGED:
69ca3e58 Krystian Garbaciak 2013-07-29  809  			if (!bmem_bio_merged) {
69ca3e58 Krystian Garbaciak 2013-07-29  810  				id++;
69ca3e58 Krystian Garbaciak 2013-07-29  811  				continue;
69ca3e58 Krystian Garbaciak 2013-07-29  812  			}
69ca3e58 Krystian Garbaciak 2013-07-29  813  			break;
69ca3e58 Krystian Garbaciak 2013-07-29  814  		}
69ca3e58 Krystian Garbaciak 2013-07-29  815  
69ca3e58 Krystian Garbaciak 2013-07-29  816  		/* Initialise regulator structure */
69ca3e58 Krystian Garbaciak 2013-07-29  817  		regl = &regulators->regulator[n];
69ca3e58 Krystian Garbaciak 2013-07-29  818  		regl->hw = da9063;
69ca3e58 Krystian Garbaciak 2013-07-29  819  		regl->info = &model->regulator_info[id];
69ca3e58 Krystian Garbaciak 2013-07-29  820  		regl->desc = regl->info->desc;
69ca3e58 Krystian Garbaciak 2013-07-29  821  		regl->desc.type = REGULATOR_VOLTAGE;
69ca3e58 Krystian Garbaciak 2013-07-29  822  		regl->desc.owner = THIS_MODULE;
69ca3e58 Krystian Garbaciak 2013-07-29  823  
69ca3e58 Krystian Garbaciak 2013-07-29  824  		if (regl->info->mode.reg)
69ca3e58 Krystian Garbaciak 2013-07-29  825  			regl->mode = devm_regmap_field_alloc(&pdev->dev,
69ca3e58 Krystian Garbaciak 2013-07-29  826  					da9063->regmap, regl->info->mode);
69ca3e58 Krystian Garbaciak 2013-07-29  827  		if (regl->info->suspend.reg)
69ca3e58 Krystian Garbaciak 2013-07-29  828  			regl->suspend = devm_regmap_field_alloc(&pdev->dev,
69ca3e58 Krystian Garbaciak 2013-07-29  829  					da9063->regmap, regl->info->suspend);
69ca3e58 Krystian Garbaciak 2013-07-29  830  		if (regl->info->sleep.reg)
69ca3e58 Krystian Garbaciak 2013-07-29  831  			regl->sleep = devm_regmap_field_alloc(&pdev->dev,
69ca3e58 Krystian Garbaciak 2013-07-29  832  					da9063->regmap, regl->info->sleep);
69ca3e58 Krystian Garbaciak 2013-07-29  833  		if (regl->info->suspend_sleep.reg)
69ca3e58 Krystian Garbaciak 2013-07-29  834  			regl->suspend_sleep = devm_regmap_field_alloc(&pdev->dev,
69ca3e58 Krystian Garbaciak 2013-07-29  835  					da9063->regmap, regl->info->suspend_sleep);
69ca3e58 Krystian Garbaciak 2013-07-29  836  		if (regl->info->ilimit.reg)
69ca3e58 Krystian Garbaciak 2013-07-29  837  			regl->ilimit = devm_regmap_field_alloc(&pdev->dev,
69ca3e58 Krystian Garbaciak 2013-07-29  838  					da9063->regmap, regl->info->ilimit);
69ca3e58 Krystian Garbaciak 2013-07-29  839  
69ca3e58 Krystian Garbaciak 2013-07-29  840  		/* Register regulator */
69ca3e58 Krystian Garbaciak 2013-07-29  841  		memset(&config, 0, sizeof(config));
69ca3e58 Krystian Garbaciak 2013-07-29  842  		config.dev = &pdev->dev;
69ca3e58 Krystian Garbaciak 2013-07-29  843  		config.init_data = da9063_get_regulator_initdata(regl_pdata, id);
69ca3e58 Krystian Garbaciak 2013-07-29  844  		config.driver_data = regl;
69ca3e58 Krystian Garbaciak 2013-07-29  845  		if (da9063_reg_matches)
69ca3e58 Krystian Garbaciak 2013-07-29  846  			config.of_node = da9063_reg_matches[id].of_node;
69ca3e58 Krystian Garbaciak 2013-07-29  847  		config.regmap = da9063->regmap;
e97bba91 Jingoo Han         2013-09-30  848  		regl->rdev = devm_regulator_register(&pdev->dev, &regl->desc,
e97bba91 Jingoo Han         2013-09-30  849  						     &config);
e515800b Axel Lin           2013-08-30  850  		if (IS_ERR(regl->rdev)) {
69ca3e58 Krystian Garbaciak 2013-07-29  851  			dev_err(&pdev->dev,
69ca3e58 Krystian Garbaciak 2013-07-29  852  				"Failed to register %s regulator\n",
69ca3e58 Krystian Garbaciak 2013-07-29  853  				regl->desc.name);
e97bba91 Jingoo Han         2013-09-30  854  			return PTR_ERR(regl->rdev);
69ca3e58 Krystian Garbaciak 2013-07-29  855  		}
69ca3e58 Krystian Garbaciak 2013-07-29  856  		id++;
69ca3e58 Krystian Garbaciak 2013-07-29  857  		n++;
69ca3e58 Krystian Garbaciak 2013-07-29  858  	}
69ca3e58 Krystian Garbaciak 2013-07-29  859  
69ca3e58 Krystian Garbaciak 2013-07-29  860  	/* LDOs overcurrent event support */
69ca3e58 Krystian Garbaciak 2013-07-29  861  	irq = platform_get_irq_byname(pdev, "LDO_LIM");
69ca3e58 Krystian Garbaciak 2013-07-29  862  	if (irq < 0) {
69ca3e58 Krystian Garbaciak 2013-07-29  863  		dev_err(&pdev->dev, "Failed to get IRQ.\n");
e97bba91 Jingoo Han         2013-09-30  864  		return irq;
69ca3e58 Krystian Garbaciak 2013-07-29  865  	}
69ca3e58 Krystian Garbaciak 2013-07-29  866  
d87aef91 Axel Lin           2015-05-31  867  	ret = devm_request_threaded_irq(&pdev->dev, irq,
69ca3e58 Krystian Garbaciak 2013-07-29  868  				NULL, da9063_ldo_lim_event,
69ca3e58 Krystian Garbaciak 2013-07-29  869  				IRQF_TRIGGER_LOW | IRQF_ONESHOT,
69ca3e58 Krystian Garbaciak 2013-07-29  870  				"LDO_LIM", regulators);
69ca3e58 Krystian Garbaciak 2013-07-29  871  	if (ret) {
d87aef91 Axel Lin           2015-05-31  872  		dev_err(&pdev->dev, "Failed to request LDO_LIM IRQ.\n");
d87aef91 Axel Lin           2015-05-31  873  		return ret;
69ca3e58 Krystian Garbaciak 2013-07-29  874  	}
69ca3e58 Krystian Garbaciak 2013-07-29  875  
69ca3e58 Krystian Garbaciak 2013-07-29  876  	return 0;
69ca3e58 Krystian Garbaciak 2013-07-29  877  }
69ca3e58 Krystian Garbaciak 2013-07-29  878  

:::::: The code at line 749 was first introduced by commit
:::::: 69ca3e58d17854f8fa72d85aea6bf4614ad25a56 regulator: da9063: Add Dialog DA9063 voltage regulators support.

:::::: TO: Krystian Garbaciak <krystian.garbaciak@diasemi.com>
:::::: CC: Mark Brown <broonie@linaro.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--jRHKVT23PllUwdXP
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
1rzlhjHcNVJs938EVsfzUsABAA==

--jRHKVT23PllUwdXP--
