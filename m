Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F5BFC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 21:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D76782087A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 21:14:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D76782087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbeJ3GFF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 02:05:05 -0400
Received: from mga06.intel.com ([134.134.136.31]:36149 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726501AbeJ3GFF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 02:05:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Oct 2018 14:14:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,441,1534834800"; 
   d="scan'208";a="275455989"
Received: from maru.jf.intel.com ([10.54.51.77])
  by fmsmga005.fm.intel.com with ESMTP; 29 Oct 2018 14:14:38 -0700
From:   Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
To:     Wolfram Sang <wsa@the-dreams.de>,
        Brendan Higgins <brendanhiggins@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Jeffery <andrew@aj.id.au>, linux-i2c@vger.kernel.org,
        openbmc@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        James Feist <james.feist@linux.intel.com>,
        Vernon Mauery <vernon.mauery@linux.intel.com>,
        Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Subject: [PATCH i2c-next v8 0/5] i2c: aspeed: Add bus idle waiting logic for multi-master use cases
Date:   Mon, 29 Oct 2018 14:14:09 -0700
Message-Id: <20181029211414.20771-1-jae.hyun.yoo@linux.intel.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In multi-master environment, this driver's master cannot know
exactly when a peer master sends data to this driver's slave so a
case can be happened that this master tries to send data through
the master_xfer function but slave data from peer master is still
being processed by this driver. To prevent state corruption in the
case, this patch adds checking code if any slave operation is
ongoing and it waits up to the bus timeout duration before starting
a master_xfer operation.

To support this change, it introduces changes on i2c-core-base to
make that able to read the bus timeout and master transfer retries
count values from device tree properties.

Please review this patch set.

Thanks,

-Jae

Changes since v7:
- Simplified the bus idle waiting logic using jiffy based timer APIs.

Changes since v6:
- Changed the 'timeout-ms' property name to 'bus-timeout-ms'.

Changes since v5:
- Changed using of property reading API to device_property_read_u32.

Changes since v4:
- Moved the property reading code into i2c-base-core and changed the
  property name to 'timeout-ms'. Also, added '#retries' property reading
  code.
- Changed bus busy checking logic to make that check slave_state instead
  of 'Transfer Mode State Machine' reg value.

Changes since v3:
- Changed the property name to 'timeout' and made it use the
  default setting in i2c-core when not specified.

Changes since v2:
- Changed the property name to 'aspeed,timeout' and made it to
  update the adapter's timeout configuration.

Changes since v1:
- Changed define names of timeout related.

Jae Hyun Yoo (5):
  dt-bindings: i2c: Add 'bus-timeout-ms' and '#retries' properties as
    common optional
  i2c: core: Add support reading of 'bus-timeout-ms' and '#retries'
    properties
  dt-bindings: i2c: aspeed: Add 'bus-timeout-ms' property as an optional
    property
  i2c: aspeed: Remove hard-coded bus timeout value setting
  i2c: aspeed: Add bus idle waiting logic for multi-master use cases

 .../devicetree/bindings/i2c/i2c-aspeed.txt    |  3 ++
 Documentation/devicetree/bindings/i2c/i2c.txt |  6 +++
 drivers/i2c/busses/i2c-aspeed.c               | 53 +++++++++++++------
 drivers/i2c/i2c-core-base.c                   | 12 ++++-
 4 files changed, 56 insertions(+), 18 deletions(-)

-- 
2.19.1

