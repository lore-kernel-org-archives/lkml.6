Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27188C28CF6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 20:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB7BF20852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 20:39:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB7BF20852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388801AbeGXVrK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 17:47:10 -0400
Received: from mga17.intel.com ([192.55.52.151]:42383 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388765AbeGXVrK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 17:47:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jul 2018 13:38:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,399,1526367600"; 
   d="scan'208";a="67229028"
Received: from maru.jf.intel.com ([10.54.51.80])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Jul 2018 13:37:31 -0700
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
Subject: [PATCH i2c-next v2] i2c: aspeed: Add an explicit type casting for *get_clk_reg_val
Date:   Tue, 24 Jul 2018 13:36:15 -0700
Message-Id: <20180724203615.5770-1-jae.hyun.yoo@linux.intel.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit fixes this sparse warning:
drivers/i2c/busses/i2c-aspeed.c:875:38: warning: incorrect type in assignment (different modifiers)
drivers/i2c/busses/i2c-aspeed.c:875:38:    expected unsigned int ( *get_clk_reg_val )( ... )
drivers/i2c/busses/i2c-aspeed.c:875:38:    got void const *const data

Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
---
Changes since v1:
- Fixed title and added Reported-by tag.

 drivers/i2c/busses/i2c-aspeed.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
index efb89422d496..a4f956c6d567 100644
--- a/drivers/i2c/busses/i2c-aspeed.c
+++ b/drivers/i2c/busses/i2c-aspeed.c
@@ -872,7 +872,7 @@ static int aspeed_i2c_probe_bus(struct platform_device *pdev)
 	if (!match)
 		bus->get_clk_reg_val = aspeed_i2c_24xx_get_clk_reg_val;
 	else
-		bus->get_clk_reg_val = match->data;
+		bus->get_clk_reg_val = (u32 (*)(u32))match->data;
 
 	/* Initialize the I2C adapter */
 	spin_lock_init(&bus->lock);
-- 
2.18.0

