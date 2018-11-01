Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13824C6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 17:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E00E920657
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 17:46:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E00E920657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbeKBCuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 22:50:23 -0400
Received: from mga01.intel.com ([192.55.52.88]:61502 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727465AbeKBCuX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 22:50:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Nov 2018 10:46:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,453,1534834800"; 
   d="scan'208";a="82693278"
Received: from maru.jf.intel.com ([10.54.51.77])
  by fmsmga007.fm.intel.com with ESMTP; 01 Nov 2018 10:46:25 -0700
From:   Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, linux-i2c@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        James Feist <james.feist@linux.intel.com>,
        Vernon Mauery <vernon.mauery@linux.intel.com>,
        Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Subject: [PATCH] i2c: aspeed: Fix an incorrect error log printing
Date:   Thu,  1 Nov 2018 10:46:21 -0700
Message-Id: <20181101174621.8266-1-jae.hyun.yoo@linux.intel.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Usually a SLAVE_MATCH and an RX_DONE intterupts come together at
the same time in most cases but rarely these come separately like
SLAVE_MATCH first and then RX_DONE right after that.

Current slave irq handler prints out an error message if the
latter case happens but this is not an actual error, so this commit
fixes the incorrect error log printing and makes the handler
initialize slave state if an incorrect state actually happens.

Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
---
 drivers/i2c/busses/i2c-aspeed.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
index 8dc9161ced38..e9312d90ff7d 100644
--- a/drivers/i2c/busses/i2c-aspeed.c
+++ b/drivers/i2c/busses/i2c-aspeed.c
@@ -311,9 +311,13 @@ static u32 aspeed_i2c_slave_irq(struct aspeed_i2c_bus *bus, u32 irq_status)
 	case ASPEED_I2C_SLAVE_STOP:
 		i2c_slave_event(slave, I2C_SLAVE_STOP, &value);
 		break;
+	case ASPEED_I2C_SLAVE_START:
+		/* Slave was just started. Waiting for the next irq. */;
+		break;
 	default:
-		dev_err(bus->dev, "unhandled slave_state: %d\n",
+		dev_err(bus->dev, "unknown slave_state: %d\n",
 			bus->slave_state);
+		bus->slave_state = ASPEED_I2C_SLAVE_STOP;
 		break;
 	}
 
-- 
2.19.1

