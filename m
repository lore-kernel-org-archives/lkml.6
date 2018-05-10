Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935029AbeEJLkn (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 07:40:43 -0400
Received: from mga07.intel.com ([134.134.136.100]:56707 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756891AbeEJLkl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 07:40:41 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,385,1520924400";
   d="scan'208";a="39878832"
Date: Thu, 10 May 2018 19:40:09 +0800
From: kbuild test robot <lkp@intel.com>
To: Amelie Delaunay <amelie.delaunay@st.com>
Cc: kbuild-all@01.org, Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Amelie Delaunay <amelie.delaunay@st.com>
Subject: Re: [PATCH v2 3/3] rtc: stm32: add stm32mp1 rtc support
Message-ID: <201805101823.CrM3ZuJP%fengguang.wu@intel.com>
References: <1525880770-22263-4-git-send-email-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525880770-22263-4-git-send-email-amelie.delaunay@st.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Amelie,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on abelloni/rtc-next]
[also build test WARNING on next-20180510]
[cannot apply to v4.17-rc4]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Amelie-Delaunay/Introduce-STM32MP1-RTC/20180510-054013
base:   https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git rtc-next

smatch warnings:
drivers/rtc/rtc-stm32.c:827 stm32_rtc_probe() warn: always true condition '(regs.verr != ~0) => (0-u16max != (-1))'

vim +827 drivers/rtc/rtc-stm32.c

   694	
   695	static int stm32_rtc_probe(struct platform_device *pdev)
   696	{
   697		struct stm32_rtc *rtc;
   698		struct stm32_rtc_registers regs;
   699		struct resource *res;
   700		int ret;
   701	
   702		rtc = devm_kzalloc(&pdev->dev, sizeof(*rtc), GFP_KERNEL);
   703		if (!rtc)
   704			return -ENOMEM;
   705	
   706		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
   707		rtc->base = devm_ioremap_resource(&pdev->dev, res);
   708		if (IS_ERR(rtc->base))
   709			return PTR_ERR(rtc->base);
   710	
   711		rtc->data = (struct stm32_rtc_data *)
   712			    of_device_get_match_data(&pdev->dev);
   713		regs = rtc->data->regs;
   714	
   715		if (rtc->data->need_dbp) {
   716			rtc->dbp = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
   717								   "st,syscfg");
   718			if (IS_ERR(rtc->dbp)) {
   719				dev_err(&pdev->dev, "no st,syscfg\n");
   720				return PTR_ERR(rtc->dbp);
   721			}
   722	
   723			ret = of_property_read_u32_index(pdev->dev.of_node, "st,syscfg",
   724							 1, &rtc->dbp_reg);
   725			if (ret) {
   726				dev_err(&pdev->dev, "can't read DBP register offset\n");
   727				return ret;
   728			}
   729	
   730			ret = of_property_read_u32_index(pdev->dev.of_node, "st,syscfg",
   731							 2, &rtc->dbp_mask);
   732			if (ret) {
   733				dev_err(&pdev->dev, "can't read DBP register mask\n");
   734				return ret;
   735			}
   736		}
   737	
   738		if (!rtc->data->has_pclk) {
   739			rtc->pclk = NULL;
   740			rtc->rtc_ck = devm_clk_get(&pdev->dev, NULL);
   741		} else {
   742			rtc->pclk = devm_clk_get(&pdev->dev, "pclk");
   743			if (IS_ERR(rtc->pclk)) {
   744				dev_err(&pdev->dev, "no pclk clock");
   745				return PTR_ERR(rtc->pclk);
   746			}
   747			rtc->rtc_ck = devm_clk_get(&pdev->dev, "rtc_ck");
   748		}
   749		if (IS_ERR(rtc->rtc_ck)) {
   750			dev_err(&pdev->dev, "no rtc_ck clock");
   751			return PTR_ERR(rtc->rtc_ck);
   752		}
   753	
   754		if (rtc->data->has_pclk) {
   755			ret = clk_prepare_enable(rtc->pclk);
   756			if (ret)
   757				return ret;
   758		}
   759	
   760		ret = clk_prepare_enable(rtc->rtc_ck);
   761		if (ret)
   762			goto err;
   763	
   764		if (rtc->data->need_dbp)
   765			regmap_update_bits(rtc->dbp, rtc->dbp_reg,
   766					   rtc->dbp_mask, rtc->dbp_mask);
   767	
   768		/*
   769		 * After a system reset, RTC_ISR.INITS flag can be read to check if
   770		 * the calendar has been initialized or not. INITS flag is reset by a
   771		 * power-on reset (no vbat, no power-supply). It is not reset if
   772		 * rtc_ck parent clock has changed (so RTC prescalers need to be
   773		 * changed). That's why we cannot rely on this flag to know if RTC
   774		 * init has to be done.
   775		 */
   776		ret = stm32_rtc_init(pdev, rtc);
   777		if (ret)
   778			goto err;
   779	
   780		rtc->irq_alarm = platform_get_irq(pdev, 0);
   781		if (rtc->irq_alarm <= 0) {
   782			dev_err(&pdev->dev, "no alarm irq\n");
   783			ret = rtc->irq_alarm;
   784			goto err;
   785		}
   786	
   787		ret = device_init_wakeup(&pdev->dev, true);
   788		if (rtc->data->has_wakeirq) {
   789			rtc->wakeirq_alarm = platform_get_irq(pdev, 1);
   790			if (rtc->wakeirq_alarm <= 0)
   791				ret = rtc->wakeirq_alarm;
   792			else
   793				ret = dev_pm_set_dedicated_wake_irq(&pdev->dev,
   794								    rtc->wakeirq_alarm);
   795		}
   796		if (ret)
   797			dev_warn(&pdev->dev, "alarm can't wake up the system: %d", ret);
   798	
   799		platform_set_drvdata(pdev, rtc);
   800	
   801		rtc->rtc_dev = devm_rtc_device_register(&pdev->dev, pdev->name,
   802							&stm32_rtc_ops, THIS_MODULE);
   803		if (IS_ERR(rtc->rtc_dev)) {
   804			ret = PTR_ERR(rtc->rtc_dev);
   805			dev_err(&pdev->dev, "rtc device registration failed, err=%d\n",
   806				ret);
   807			goto err;
   808		}
   809	
   810		/* Handle RTC alarm interrupts */
   811		ret = devm_request_threaded_irq(&pdev->dev, rtc->irq_alarm, NULL,
   812						stm32_rtc_alarm_irq, IRQF_ONESHOT,
   813						pdev->name, rtc);
   814		if (ret) {
   815			dev_err(&pdev->dev, "IRQ%d (alarm interrupt) already claimed\n",
   816				rtc->irq_alarm);
   817			goto err;
   818		}
   819	
   820		/*
   821		 * If INITS flag is reset (calendar year field set to 0x00), calendar
   822		 * must be initialized
   823		 */
   824		if (!(readl_relaxed(rtc->base + regs.isr) & STM32_RTC_ISR_INITS))
   825			dev_warn(&pdev->dev, "Date/Time must be initialized\n");
   826	
 > 827		if (regs.verr != UNDEF_REG) {
   828			u32 ver = readl_relaxed(rtc->base + regs.verr);
   829	
   830			dev_info(&pdev->dev, "registered rev:%d.%d\n",
   831				 (ver >> STM32_RTC_VERR_MAJREV_SHIFT) & 0xF,
   832				 (ver >> STM32_RTC_VERR_MINREV_SHIFT) & 0xF);
   833		}
   834	
   835		return 0;
   836	err:
   837		if (rtc->data->has_pclk)
   838			clk_disable_unprepare(rtc->pclk);
   839		clk_disable_unprepare(rtc->rtc_ck);
   840	
   841		if (rtc->data->need_dbp)
   842			regmap_update_bits(rtc->dbp, rtc->dbp_reg, rtc->dbp_mask, 0);
   843	
   844		dev_pm_clear_wake_irq(&pdev->dev);
   845		device_init_wakeup(&pdev->dev, false);
   846	
   847		return ret;
   848	}
   849	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
