Return-Path: <SRS0=itv6=LI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A0BAC433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 05:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1476F2146E
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 05:22:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1476F2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbeHYJAA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Aug 2018 05:00:00 -0400
Received: from mga03.intel.com ([134.134.136.65]:53951 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726468AbeHYI77 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Aug 2018 04:59:59 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Aug 2018 22:22:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,285,1531810800"; 
   d="scan'208";a="227547482"
Received: from bee.sh.intel.com (HELO lkp-server01) ([10.239.97.14])
  by orsmga004.jf.intel.com with ESMTP; 24 Aug 2018 22:22:13 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1ftR1Y-0004Qj-0R; Sat, 25 Aug 2018 13:22:12 +0800
Date:   Sat, 25 Aug 2018 13:21:25 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Dilip Kota <dkota@codeaurora.org>
Cc:     kbuild-all@01.org, swboyd@chromium.org, broonie@kernel.org,
        mka@chromium.org, dianders@chromium.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org,
        Girish Mahadevan <girishm@codeaurora.org>,
        Dilip Kota <dkota@codeaurora.org>
Subject: Re: [PATCH V3] spi: spi-geni-qcom: Add SPI driver support for GENI
 based QUP
Message-ID: <201808251010.KRlMjZ8C%fengguang.wu@intel.com>
References: <1535107336-2214-1-git-send-email-dkota@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1535107336-2214-1-git-send-email-dkota@codeaurora.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Girish,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on spi/for-next]
[also build test ERROR on v4.18]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Dilip-Kota/spi-spi-geni-qcom-Add-SPI-driver-support-for-GENI-based-QUP/20180824-190528
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
config: i386-allmodconfig
compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
reproduce:
        make ARCH=i386  allmodconfig
        make ARCH=i386 

All errors (new ones prefixed by >>):


vim +239 drivers/spi/spi-geni-qcom.c

   212	
   213	static int spi_geni_prepare_transfer_hardware(struct spi_master *spi)
   214	{
   215		struct spi_geni_master *mas = spi_master_get_devdata(spi);
   216		struct geni_se *se = &mas->se;
   217	
   218		if (!mas->setup) {
   219			unsigned int proto = geni_se_read_proto(se);
   220			unsigned int major, minor, step, ver;
   221	
   222			if (proto != GENI_SE_SPI) {
   223				dev_err(mas->dev, "Invalid proto %d\n", proto);
   224				return -ENXIO;
   225			}
   226			mas->tx_fifo_depth = geni_se_get_tx_fifo_depth(se);
   227			mas->rx_fifo_depth = geni_se_get_rx_fifo_depth(se);
   228			mas->tx_fifo_width = geni_se_get_tx_fifo_width(se);
   229	
   230			/*
   231			 * Hardware programming guide suggests to configure
   232			 * RX FIFO RFR level to fifo_depth-2.
   233			 */
   234			geni_se_init(se, 0x0, mas->tx_fifo_depth - 2);
   235			mas->oversampling = 1;
   236			/* Transmit an entire FIFO worth of data per IRQ */
   237			mas->tx_wm = 1;
   238			ver = geni_se_get_qup_hw_version(se);
 > 239			major = GENI_SE_VERSION_MAJOR(ver);
 > 240			minor = GENI_SE_VERSION_MINOR(ver);
 > 241			step = GENI_SE_VERSION_STEP(ver);
   242	
   243			if (major == 1 && minor == 0)
   244				mas->oversampling = 2;
   245			mas->setup = 1;
   246		}
   247		return 0;
   248	}
   249	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
