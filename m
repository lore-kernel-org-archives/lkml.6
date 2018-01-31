Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751937AbeAaWty (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 17:49:54 -0500
Received: from mga06.intel.com ([134.134.136.31]:58670 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751746AbeAaWtv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 17:49:51 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,441,1511856000";
   d="scan'208";a="15997596"
Date: Thu, 1 Feb 2018 06:49:29 +0800
From: kbuild test robot <lkp@intel.com>
To: Philipp Rossak <embed3d@gmail.com>
Cc: kbuild-all@01.org, lee.jones@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, maxime.ripard@free-electrons.com, wens@csie.org,
        linux@armlinux.org.uk, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, davem@davemloft.net,
        hans.verkuil@cisco.com, mchehab@kernel.org, rask@formelder.dk,
        clabbe.montjoie@gmail.com, sean@mess.org, krzk@kernel.org,
        quentin.schulz@free-electrons.com, icenowy@aosc.io,
        edu.molinas@gmail.com, singhalsimran0@gmail.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v2 07/16] iio: adc: sun4i-gpadc-iio: rework: support
 nvmem calibration data
Message-ID: <201802010647.sYlui5vv%fengguang.wu@intel.com>
References: <20180128232919.12639-8-embed3d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180128232919.12639-8-embed3d@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philipp,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on robh/for-next]
[also build test WARNING on v4.15 next-20180126]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Philipp-Rossak/IIO-based-thermal-sensor-driver-for-Allwinner-H3-and-A83T-SoC/20180201-043415
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/iio/adc/sun4i-gpadc-iio.c:608:53: sparse: cast to restricted __be32
>> drivers/iio/adc/sun4i-gpadc-iio.c:608:53: sparse: cast to restricted __be32
>> drivers/iio/adc/sun4i-gpadc-iio.c:608:53: sparse: cast to restricted __be32
>> drivers/iio/adc/sun4i-gpadc-iio.c:608:53: sparse: cast to restricted __be32
>> drivers/iio/adc/sun4i-gpadc-iio.c:608:53: sparse: cast to restricted __be32
>> drivers/iio/adc/sun4i-gpadc-iio.c:608:53: sparse: cast to restricted __be32
   drivers/iio/adc/sun4i-gpadc-iio.c:613:53: sparse: cast to restricted __be32
   drivers/iio/adc/sun4i-gpadc-iio.c:613:53: sparse: cast to restricted __be32
   drivers/iio/adc/sun4i-gpadc-iio.c:613:53: sparse: cast to restricted __be32
   drivers/iio/adc/sun4i-gpadc-iio.c:613:53: sparse: cast to restricted __be32
   drivers/iio/adc/sun4i-gpadc-iio.c:613:53: sparse: cast to restricted __be32
   drivers/iio/adc/sun4i-gpadc-iio.c:613:53: sparse: cast to restricted __be32

vim +608 drivers/iio/adc/sun4i-gpadc-iio.c

   564	
   565	static int sun4i_gpadc_probe_dt(struct platform_device *pdev,
   566					struct iio_dev *indio_dev)
   567	{
   568		struct sun4i_gpadc_iio *info = iio_priv(indio_dev);
   569		struct resource *mem;
   570		void __iomem *base;
   571		int ret;
   572		struct nvmem_cell *cell;
   573		ssize_t cell_size;
   574		u64 *cell_data;
   575	
   576		info->data = of_device_get_match_data(&pdev->dev);
   577		if (!info->data)
   578			return -ENODEV;
   579	
   580		info->no_irq = true;
   581		indio_dev->num_channels = ARRAY_SIZE(sun8i_a33_gpadc_channels);
   582		indio_dev->channels = sun8i_a33_gpadc_channels;
   583	
   584		mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
   585		base = devm_ioremap_resource(&pdev->dev, mem);
   586		if (IS_ERR(base))
   587			return PTR_ERR(base);
   588	
   589		info->has_calibration_data[0] = false;
   590		info->has_calibration_data[1] = false;
   591	
   592		if (!info->data->supports_nvmem)
   593			goto no_nvmem;
   594	
   595		cell = nvmem_cell_get(&pdev->dev, "calibration");
   596		if (IS_ERR(cell)) {
   597			if (PTR_ERR(cell) == -EPROBE_DEFER)
   598				return PTR_ERR(cell);
   599			goto no_nvmem;
   600		}
   601	
   602		cell_data = (u64 *)nvmem_cell_read(cell, &cell_size);
   603		nvmem_cell_put(cell);
   604		switch (cell_size) {
   605			case 8:
   606			case 6:
   607				info->has_calibration_data[1] = true;
 > 608				info->calibration_data[1] = be32_to_cpu(
   609						upper_32_bits(cell_data[0]));
   610			case 4:
   611			case 2:
   612				info->has_calibration_data[0] = true;
   613				info->calibration_data[0] = be32_to_cpu(
   614						lower_32_bits(cell_data[0]));
   615				break;
   616			default:
   617				break;
   618		}
   619	
   620	no_nvmem:
   621	
   622		info->regmap = devm_regmap_init_mmio(&pdev->dev, base,
   623						     &sun4i_gpadc_regmap_config);
   624		if (IS_ERR(info->regmap)) {
   625			ret = PTR_ERR(info->regmap);
   626			dev_err(&pdev->dev, "failed to init regmap: %d\n", ret);
   627			return ret;
   628		}
   629	
   630		if (info->data->has_bus_rst) {
   631			info->reset = devm_reset_control_get(&pdev->dev, NULL);
   632			if (IS_ERR(info->reset)) {
   633				ret = PTR_ERR(info->reset);
   634				return ret;
   635			}
   636	
   637			ret = reset_control_deassert(info->reset);
   638			if (ret)
   639				return ret;
   640		}
   641	
   642		if (info->data->has_bus_clk) {
   643			info->bus_clk = devm_clk_get(&pdev->dev, "bus");
   644			if (IS_ERR(info->bus_clk)) {
   645				ret = PTR_ERR(info->bus_clk);
   646				goto assert_reset;
   647			}
   648	
   649			ret = clk_prepare_enable(info->bus_clk);
   650			if (ret)
   651				goto assert_reset;
   652		}
   653	
   654		if (info->data->has_mod_clk) {
   655			info->mod_clk = devm_clk_get(&pdev->dev, "mod");
   656			if (IS_ERR(info->mod_clk)) {
   657				ret = PTR_ERR(info->mod_clk);
   658				goto disable_bus_clk;
   659			}
   660	
   661			/* Running at 6MHz */
   662			ret = clk_set_rate(info->mod_clk, 4000000);
   663			if (ret)
   664				goto disable_bus_clk;
   665	
   666			ret = clk_prepare_enable(info->mod_clk);
   667			if (ret)
   668				goto disable_bus_clk;
   669		}
   670	
   671		if (IS_ENABLED(CONFIG_THERMAL_OF))
   672			info->sensor_device = &pdev->dev;
   673	
   674		return 0;
   675	
   676	disable_bus_clk:
   677		clk_disable_unprepare(info->bus_clk);
   678	
   679	assert_reset:
   680		reset_control_assert(info->reset);
   681	
   682		return ret;
   683	}
   684	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
