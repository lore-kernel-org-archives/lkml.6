Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA77BC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 15:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CC31273CE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 15:36:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CC31273CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967245AbeF1Pgc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 11:36:32 -0400
Received: from mga05.intel.com ([192.55.52.43]:63832 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933985AbeF1Pga (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 11:36:30 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jun 2018 08:36:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,284,1526367600"; 
   d="scan'208";a="62934174"
Received: from bee.sh.intel.com (HELO bee) ([10.239.97.14])
  by orsmga003.jf.intel.com with ESMTP; 28 Jun 2018 08:36:22 -0700
Received: from kbuild by bee with local (Exim 4.84_2)
        (envelope-from <lkp@intel.com>)
        id 1fYYy5-000Hkl-Uc; Thu, 28 Jun 2018 23:36:21 +0800
Date:   Thu, 28 Jun 2018 23:35:49 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Parthiban Nallathambi <pn@denx.de>
Cc:     kbuild-all@01.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, robh+dt@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        matthias.bgg@gmail.com, wd@denx.de, sbabic@denx.de, hs@denx.de,
        Parthiban Nallathambi <pn@denx.de>
Subject: Re: [PATCH 1/2] iio: light: Add support for vishay vcnl4035
Message-ID: <201806282346.z3EjCFvh%fengguang.wu@intel.com>
References: <20180628123021.1628338-1-pn@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180628123021.1628338-1-pn@denx.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lkp@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Parthiban,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on iio/togreg]
[also build test WARNING on v4.18-rc2 next-20180628]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Parthiban-Nallathambi/iio-light-Add-support-for-vishay-vcnl4035/20180628-213034
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/iio/light/vcnl4035.c:136:28: sparse: cast to restricted __le16

vim +136 drivers/iio/light/vcnl4035.c

   115	
   116	static irqreturn_t vcnl4035_trigger_consumer_handler(int irq, void *p)
   117	{
   118		struct iio_poll_func *pf = p;
   119		struct iio_dev *indio_dev = pf->indio_dev;
   120		struct vcnl4035_data *data = iio_priv(indio_dev);
   121		int als_data;
   122		int ret;
   123	
   124		if (iio_trigger_using_own(indio_dev) && data->irq_timestamp) {
   125			pf->timestamp = data->irq_timestamp;
   126			data->irq_timestamp = 0;
   127		}
   128	
   129		if (!pf->timestamp)
   130			pf->timestamp = iio_get_time_ns(indio_dev);
   131	
   132		mutex_lock(&data->lock);
   133		ret = regmap_read(data->regmap, VCNL4035_ALS_DATA, &als_data);
   134		mutex_unlock(&data->lock);
   135		if (!ret) {
 > 136			als_data = le16_to_cpu(als_data);
   137			iio_push_to_buffers_with_timestamp(indio_dev,
   138							   &als_data,
   139							   pf->timestamp);
   140		} else
   141			dev_err(&data->client->dev,
   142				"Trigger consumer can't read from sensor.\n");
   143		pf->timestamp = 0;
   144	
   145		iio_trigger_notify_done(indio_dev->trig);
   146	
   147		return IRQ_HANDLED;
   148	}
   149	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
