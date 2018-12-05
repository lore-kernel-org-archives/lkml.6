Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE74C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D75AE20850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:06:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D75AE20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbeLEIGR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 03:06:17 -0500
Received: from mga04.intel.com ([192.55.52.120]:28499 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726102AbeLEIGR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 03:06:17 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Dec 2018 00:06:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,317,1539673200"; 
   d="scan'208";a="127233262"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 05 Dec 2018 00:06:15 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1gUSCF-000D6Z-6G; Wed, 05 Dec 2018 16:06:15 +0800
Date:   Wed, 5 Dec 2018 16:06:00 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Subject: drivers/mfd/madera-core.c:158:2-3: Unneeded semicolon
Message-ID: <201812051658.GR1ik3XL%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0072a0c14d5b7cb72c611d396f143f5dcd73ebe2
commit: b04e68d16605dcde1c21b5df5f86a5372e53ae97 mfd: madera: Don't use regmap_read_poll_timeout to poll for BOOT_DONE
date:   6 weeks ago


coccinelle warnings: (new ones prefixed by >>)

>> drivers/mfd/madera-core.c:158:2-3: Unneeded semicolon

vim +158 drivers/mfd/madera-core.c

   137	
   138	static int madera_wait_for_boot(struct madera *madera)
   139	{
   140		ktime_t timeout;
   141		unsigned int val;
   142		int ret = 0;
   143	
   144		/*
   145		 * We can't use an interrupt as we need to runtime resume to do so,
   146		 * so we poll the status bit. This won't race with the interrupt
   147		 * handler because it will be blocked on runtime resume.
   148		 * The chip could NAK a read request while it is booting so ignore
   149		 * errors from regmap_read.
   150		 */
   151		timeout = ktime_add_us(ktime_get(), MADERA_BOOT_POLL_TIMEOUT_USEC);
   152		regmap_read(madera->regmap, MADERA_IRQ1_RAW_STATUS_1, &val);
   153		while (!(val & MADERA_BOOT_DONE_STS1) &&
   154		       !ktime_after(ktime_get(), timeout)) {
   155			usleep_range(MADERA_BOOT_POLL_INTERVAL_USEC / 2,
   156				     MADERA_BOOT_POLL_INTERVAL_USEC);
   157			regmap_read(madera->regmap, MADERA_IRQ1_RAW_STATUS_1, &val);
 > 158		};
   159	
   160		if (!(val & MADERA_BOOT_DONE_STS1)) {
   161			dev_err(madera->dev, "Polling BOOT_DONE_STS timed out\n");
   162			ret = -ETIMEDOUT;
   163		}
   164	
   165		/*
   166		 * BOOT_DONE defaults to unmasked on boot so we must ack it.
   167		 * Do this even after a timeout to avoid interrupt storms.
   168		 */
   169		regmap_write(madera->regmap, MADERA_IRQ1_STATUS_1,
   170			     MADERA_BOOT_DONE_EINT1);
   171	
   172		pm_runtime_mark_last_busy(madera->dev);
   173	
   174		return ret;
   175	}
   176	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
