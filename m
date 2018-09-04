Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=FAKE_REPLY_C,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB12C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D56B320843
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:25:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D56B320843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbeIDTvb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 15:51:31 -0400
Received: from mga09.intel.com ([134.134.136.24]:50258 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726304AbeIDTvb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 15:51:31 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Sep 2018 08:25:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,329,1531810800"; 
   d="scan'208";a="71513523"
Received: from pl-dbox.sh.intel.com (HELO intel.com) ([10.239.13.138])
  by orsmga006.jf.intel.com with ESMTP; 04 Sep 2018 08:25:54 -0700
Date:   Tue, 4 Sep 2018 23:38:30 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     kbuild-all@01.org, "David S. Miller" <davem@davemloft.net>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH] net: qca_spi: Fix race condition in spi transfers
Message-ID: <20180904153830.GW17047@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1535719981-20812-1-git-send-email-stefan.wahren@i2se.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

I love your patch! Perhaps something to improve:

[auto build test WARNING on net-next/master]
[also build test WARNING on v4.19-rc2 next-20180831]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Stefan-Wahren/net-qca_spi-Fix-race-condition-in-spi-transfers/20180903-112513
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__
:::::: branch date: 4 hours ago
:::::: commit date: 4 hours ago

>> drivers/net/ethernet/qualcomm/qca_7k.c:78:27: sparse: cast to restricted __be16
>> drivers/net/ethernet/qualcomm/qca_7k.c:78:27: sparse: cast to restricted __be16
>> drivers/net/ethernet/qualcomm/qca_7k.c:78:27: sparse: cast to restricted __be16
>> drivers/net/ethernet/qualcomm/qca_7k.c:78:27: sparse: cast to restricted __be16

# https://github.com/0day-ci/linux/commit/5fb0b49d203c5085fd770521b6c18d0becda9086
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout 5fb0b49d203c5085fd770521b6c18d0becda9086
vim +78 drivers/net/ethernet/qualcomm/qca_7k.c

291ab06e Stefan Wahren 2014-09-26  42  
291ab06e Stefan Wahren 2014-09-26  43  int
291ab06e Stefan Wahren 2014-09-26  44  qcaspi_read_register(struct qcaspi *qca, u16 reg, u16 *result)
291ab06e Stefan Wahren 2014-09-26  45  {
291ab06e Stefan Wahren 2014-09-26  46  	__be16 tx_data;
5fb0b49d Stefan Wahren 2018-08-31  47  	struct spi_transfer transfer[2];
5fb0b49d Stefan Wahren 2018-08-31  48  	struct spi_message msg;
291ab06e Stefan Wahren 2014-09-26  49  	int ret;
291ab06e Stefan Wahren 2014-09-26  50  
5fb0b49d Stefan Wahren 2018-08-31  51  	memset(transfer, 0, sizeof(transfer));
5fb0b49d Stefan Wahren 2018-08-31  52  
5fb0b49d Stefan Wahren 2018-08-31  53  	spi_message_init(&msg);
5fb0b49d Stefan Wahren 2018-08-31  54  
291ab06e Stefan Wahren 2014-09-26  55  	tx_data = cpu_to_be16(QCA7K_SPI_READ | QCA7K_SPI_INTERNAL | reg);
5fb0b49d Stefan Wahren 2018-08-31  56  	*result = 0;
5fb0b49d Stefan Wahren 2018-08-31  57  
5fb0b49d Stefan Wahren 2018-08-31  58  	transfer[0].tx_buf = &tx_data;
5fb0b49d Stefan Wahren 2018-08-31  59  	transfer[0].len = QCASPI_CMD_LEN;
5fb0b49d Stefan Wahren 2018-08-31  60  	transfer[1].rx_buf = result;
5fb0b49d Stefan Wahren 2018-08-31  61  	transfer[1].len = QCASPI_CMD_LEN;
5fb0b49d Stefan Wahren 2018-08-31  62  
5fb0b49d Stefan Wahren 2018-08-31  63  	spi_message_add_tail(&transfer[0], &msg);
291ab06e Stefan Wahren 2014-09-26  64  
291ab06e Stefan Wahren 2014-09-26  65  	if (qca->legacy_mode) {
5fb0b49d Stefan Wahren 2018-08-31  66  		spi_sync(qca->spi_dev, &msg);
5fb0b49d Stefan Wahren 2018-08-31  67  		spi_message_init(&msg);
291ab06e Stefan Wahren 2014-09-26  68  	}
5fb0b49d Stefan Wahren 2018-08-31  69  	spi_message_add_tail(&transfer[1], &msg);
5fb0b49d Stefan Wahren 2018-08-31  70  	ret = spi_sync(qca->spi_dev, &msg);
291ab06e Stefan Wahren 2014-09-26  71  
291ab06e Stefan Wahren 2014-09-26  72  	if (!ret)
5fb0b49d Stefan Wahren 2018-08-31  73  		ret = msg.status;
291ab06e Stefan Wahren 2014-09-26  74  
5fb0b49d Stefan Wahren 2018-08-31  75  	if (ret) {
291ab06e Stefan Wahren 2014-09-26  76  		qcaspi_spi_error(qca);
5fb0b49d Stefan Wahren 2018-08-31  77  	} else {
5fb0b49d Stefan Wahren 2018-08-31 @78  		*result = be16_to_cpu(*result);
5fb0b49d Stefan Wahren 2018-08-31  79  	}
291ab06e Stefan Wahren 2014-09-26  80  
291ab06e Stefan Wahren 2014-09-26  81  	return ret;
291ab06e Stefan Wahren 2014-09-26  82  }
291ab06e Stefan Wahren 2014-09-26  83  

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
