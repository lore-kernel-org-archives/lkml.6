Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8AE1C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 21:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C7A4214FE
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 21:58:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C7A4214FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbeI0ENq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 00:13:46 -0400
Received: from mga06.intel.com ([134.134.136.31]:4547 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726098AbeI0ENq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 00:13:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Sep 2018 14:58:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,307,1534834800"; 
   d="scan'208";a="73957790"
Received: from maru.jf.intel.com ([10.54.51.77])
  by fmsmga008.fm.intel.com with ESMTP; 26 Sep 2018 14:58:43 -0700
From:   Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Joel Stanley <joel@jms.id.au>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Jeffery <andrew@aj.id.au>, linux-i2c@vger.kernel.org,
        openbmc@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        James Feist <james.feist@linux.intel.com>,
        Vernon Mauery <vernon.mauery@linux.intel.com>,
        Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Subject: [PATCH i2c-next v3 0/3] i2c: aspeed: Add bus idle waiting logic for multi-master use cases
Date:   Wed, 26 Sep 2018 14:58:39 -0700
Message-Id: <20180926215842.23125-1-jae.hyun.yoo@linux.intel.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In multi-master environment, this driver's master cannot know
exactly when peer master sends data to this driver's slave so a
case can be happened that this master tries to send data through
the master_xfer function but slave data from peer master is still
being processed by this driver.

To prevent state corruption in the case, this patch adds checking
code if any slave operation is ongoing and it waits up to the
timeout duration before starting a master_xfer operation.

Please review this patch set.

Thanks,

-Jae

Changes since v2:
- Changed the property name to 'aspeed,timeout' and made it to
  update the adapter's timeout configuration.

Changes since v1:
- Changed define names of timeout related.

Jae Hyun Yoo (3):
  dt-bindings: i2c: aspeed: Add 'timeout' property as an optional
    property
  i2c: aspeed: Add 'aspeed,timeout' DT property reading code
  i2c: aspeed: Add bus idle waiting logic for multi-master use cases

 .../devicetree/bindings/i2c/i2c-aspeed.txt    |  3 +
 drivers/i2c/busses/i2c-aspeed.c               | 71 ++++++++++++++-----
 2 files changed, 58 insertions(+), 16 deletions(-)

-- 
2.19.0

