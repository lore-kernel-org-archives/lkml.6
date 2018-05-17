Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752112AbeEQKEs (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 06:04:48 -0400
Received: from mga11.intel.com ([192.55.52.93]:60269 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751858AbeEQKEn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 06:04:43 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,409,1520924400";
   d="scan'208";a="51614285"
Date: Thu, 17 May 2018 18:03:41 +0800
From: kbuild test robot <lkp@intel.com>
To: Mark Jonas <mark.jonas@de.bosch.com>
Cc: kbuild-all@01.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, hs@denx.de, andy.shevchenko@gmail.com,
        Zhu Yi <yi.zhu5@cn.bosch.com>, Mark Jonas <mark.jonas@de.bosch.com>
Subject: Re: [PATCH v4] Input: add bu21029 touch driver
Message-ID: <201805171546.tV4UnTVC%fengguang.wu@intel.com>
References: <1526477123-18208-1-git-send-email-mark.jonas@de.bosch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526477123-18208-1-git-send-email-mark.jonas@de.bosch.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhu,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on v4.17-rc5]
[also build test WARNING on next-20180516]
[cannot apply to input/next]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Mark-Jonas/Input-add-bu21029-touch-driver/20180517-133332
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/input/touchscreen/bu21029_ts.c:289:13: sparse: cast to restricted __be16
>> drivers/input/touchscreen/bu21029_ts.c:289:13: sparse: cast to restricted __be16
>> drivers/input/touchscreen/bu21029_ts.c:289:13: sparse: cast to restricted __be16
>> drivers/input/touchscreen/bu21029_ts.c:289:13: sparse: cast to restricted __be16

vim +289 drivers/input/touchscreen/bu21029_ts.c

   258	
   259	static int bu21029_start_chip(struct input_dev *dev)
   260	{
   261		struct bu21029_ts_data *bu21029 = input_get_drvdata(dev);
   262		struct i2c_client *i2c = bu21029->client;
   263		struct {
   264			u8 reg;
   265			u8 value;
   266		} init_table[] = {
   267			{BU21029_CFR0_REG, CFR0_VALUE},
   268			{BU21029_CFR1_REG, CFR1_VALUE},
   269			{BU21029_CFR2_REG, CFR2_VALUE},
   270			{BU21029_CFR3_REG, CFR3_VALUE},
   271			{BU21029_LDO_REG,  LDO_VALUE}
   272		};
   273		int error, i;
   274		u16 hwid;
   275	
   276		/* take chip out of reset */
   277		gpiod_set_value_cansleep(bu21029->reset_gpios, 0);
   278		mdelay(START_DELAY_MS);
   279	
   280		error = i2c_smbus_read_i2c_block_data(i2c,
   281						      BU21029_HWID_REG,
   282						      2,
   283						      (u8 *)&hwid);
   284		if (error < 0) {
   285			dev_err(&i2c->dev, "failed to read HW ID\n");
   286			goto out;
   287		}
   288	
 > 289		if (be16_to_cpu(hwid) != SUPPORTED_HWID) {
   290			dev_err(&i2c->dev, "unsupported HW ID 0x%x\n", hwid);
   291			error = -ENODEV;
   292			goto out;
   293		}
   294	
   295		for (i = 0; i < ARRAY_SIZE(init_table); ++i) {
   296			error = i2c_smbus_write_byte_data(i2c,
   297							  init_table[i].reg,
   298							  init_table[i].value);
   299			if (error < 0) {
   300				dev_err(&i2c->dev,
   301					"failed to write 0x%x to register 0x%x\n",
   302					init_table[i].value,
   303					init_table[i].reg);
   304				goto out;
   305			}
   306		}
   307	
   308		error = i2c_smbus_write_byte(i2c, BU21029_AUTOSCAN);
   309		if (error < 0) {
   310			dev_err(&i2c->dev, "failed to start autoscan\n");
   311			goto out;
   312		}
   313	
   314		enable_irq(bu21029->client->irq);
   315		return 0;
   316	
   317	out:
   318		bu21029_stop_chip(dev);
   319		return error;
   320	}
   321	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
