Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E605C433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 19:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEB52208B6
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 19:19:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEB52208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933466AbeFQTTe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 15:19:34 -0400
Received: from mga12.intel.com ([192.55.52.136]:65062 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754217AbeFQTTc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 15:19:32 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jun 2018 12:19:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,236,1526367600"; 
   d="scan'208";a="64893780"
Received: from bee.sh.intel.com (HELO bee) ([10.239.97.14])
  by fmsmga001.fm.intel.com with ESMTP; 17 Jun 2018 12:19:30 -0700
Received: from kbuild by bee with local (Exim 4.84_2)
        (envelope-from <lkp@intel.com>)
        id 1fUdCz-000JF2-AJ; Mon, 18 Jun 2018 03:19:29 +0800
Date:   Mon, 18 Jun 2018 03:19:26 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Mark Jonas <mark.jonas@de.bosch.com>
Cc:     kbuild-all@01.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, hs@denx.de,
        Zhu Yi <yi.zhu5@cn.bosch.com>,
        Mark Jonas <mark.jonas@de.bosch.com>
Subject: Re: [PATCH v3] Input: add bu21029 touch driver
Message-ID: <201806180153.010oE5tw%fengguang.wu@intel.com>
References: <1526048528-3613-1-git-send-email-mark.jonas@de.bosch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526048528-3613-1-git-send-email-mark.jonas@de.bosch.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lkp@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhu,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on v4.17-rc4]
[also build test WARNING on next-20180615]
[cannot apply to input/next]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Mark-Jonas/Input-add-bu21029-touch-driver/20180512-091305
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/input/touchscreen/bu21029_ts.c:293:13: sparse: restricted __be16 degrades to integer

vim +293 drivers/input/touchscreen/bu21029_ts.c

   262	
   263	static int bu21029_start_chip(struct input_dev *dev)
   264	{
   265		struct bu21029_ts_data *bu21029 = input_get_drvdata(dev);
   266		struct i2c_client *i2c = bu21029->client;
   267		struct {
   268			u8 reg;
   269			u8 value;
   270		} init_table[] = {
   271			{BU21029_CFR0_REG, CFR0_VALUE},
   272			{BU21029_CFR1_REG, CFR1_VALUE},
   273			{BU21029_CFR2_REG, CFR2_VALUE},
   274			{BU21029_CFR3_REG, CFR3_VALUE},
   275			{BU21029_LDO_REG,  LDO_VALUE}
   276		};
   277		int error, i;
   278		u16 hwid;
   279	
   280		/* take chip out of reset */
   281		gpiod_set_value_cansleep(bu21029->reset_gpios, 0);
   282		mdelay(START_DELAY_MS);
   283	
   284		error = i2c_smbus_read_i2c_block_data(i2c,
   285						      BU21029_HWID_REG,
   286						      2,
   287						      (u8 *)&hwid);
   288		if (error < 0) {
   289			dev_err(&i2c->dev, "failed to read HW ID\n");
   290			goto out;
   291		}
   292	
 > 293		if (cpu_to_be16(hwid) != SUPPORTED_HWID) {
   294			dev_err(&i2c->dev, "unsupported HW ID 0x%x\n", hwid);
   295			error = -ENODEV;
   296			goto out;
   297		}
   298	
   299		for (i = 0; i < ARRAY_SIZE(init_table); ++i) {
   300			error = i2c_smbus_write_byte_data(i2c,
   301							  init_table[i].reg,
   302							  init_table[i].value);
   303			if (error < 0) {
   304				dev_err(&i2c->dev,
   305					"failed to write 0x%x to register 0x%x\n",
   306					init_table[i].value,
   307					init_table[i].reg);
   308				goto out;
   309			}
   310		}
   311	
   312		error = i2c_smbus_write_byte(i2c, BU21029_AUTOSCAN);
   313		if (error < 0) {
   314			dev_err(&i2c->dev, "failed to start autoscan\n");
   315			goto out;
   316		}
   317	
   318		enable_irq(bu21029->client->irq);
   319		return 0;
   320	
   321	out:
   322		bu21029_stop_chip(dev);
   323		return error;
   324	}
   325	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
