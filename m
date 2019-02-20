Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3394BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 18:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16CBF20838
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 18:19:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfBTSTy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 13:19:54 -0500
Received: from anholt.net ([50.246.234.109]:51112 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726120AbfBTSTy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 13:19:54 -0500
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 9C9DD10A2D1E;
        Wed, 20 Feb 2019 10:19:53 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id PO7RdZZsgT9d; Wed, 20 Feb 2019 10:19:51 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id DAB2610A2D1A;
        Wed, 20 Feb 2019 10:19:51 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 610AD2FE464C; Wed, 20 Feb 2019 10:19:51 -0800 (PST)
From:   Eric Anholt <eric@anholt.net>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Eric Anholt <eric@anholt.net>
Subject: [PATCH v2 1/2] soc: bcm: bcm2835-pm: Fix PM_IMAGE_PERI power domain support.
Date:   Wed, 20 Feb 2019 10:19:50 -0800
Message-Id: <20190220181951.12670-1-eric@anholt.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't have ASB master/slave regs for this domain, so just skip that
step.

Signed-off-by: Eric Anholt <eric@anholt.net>
Fixes: 670c672608a1 ("soc: bcm: bcm2835-pm: Add support for power domains under a new binding.")
---
 drivers/soc/bcm/bcm2835-power.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/bcm/bcm2835-power.c b/drivers/soc/bcm/bcm2835-power.c
index 48412957ec7a..4a1b99b773c0 100644
--- a/drivers/soc/bcm/bcm2835-power.c
+++ b/drivers/soc/bcm/bcm2835-power.c
@@ -150,7 +150,12 @@ struct bcm2835_power {
 
 static int bcm2835_asb_enable(struct bcm2835_power *power, u32 reg)
 {
-	u64 start = ktime_get_ns();
+	u64 start;
+
+	if (!reg)
+		return 0;
+
+	start = ktime_get_ns();
 
 	/* Enable the module's async AXI bridges. */
 	ASB_WRITE(reg, ASB_READ(reg) & ~ASB_REQ_STOP);
@@ -165,7 +170,12 @@ static int bcm2835_asb_enable(struct bcm2835_power *power, u32 reg)
 
 static int bcm2835_asb_disable(struct bcm2835_power *power, u32 reg)
 {
-	u64 start = ktime_get_ns();
+	u64 start;
+
+	if (!reg)
+		return 0;
+
+	start = ktime_get_ns();
 
 	/* Enable the module's async AXI bridges. */
 	ASB_WRITE(reg, ASB_READ(reg) | ASB_REQ_STOP);
-- 
2.20.1

