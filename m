Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE694C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 11:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D97C2084E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 11:32:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D97C2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727512AbeLJLcy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 06:32:54 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51878 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726146AbeLJLcx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 06:32:53 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7279F15AB;
        Mon, 10 Dec 2018 03:32:53 -0800 (PST)
Received: from queper01-lin.cambridge.arm.com (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3D9923F6A8;
        Mon, 10 Dec 2018 03:32:52 -0800 (PST)
From:   Quentin Perret <quentin.perret@arm.com>
To:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH] PM / OPP: Always expose one supply in debugfs
Date:   Mon, 10 Dec 2018 11:32:47 +0000
Message-Id: <20181210113247.11412-1-quentin.perret@arm.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some platforms, the opp_table->regulator_count field is kept at zero
even though opp->supplies is always allocated. However, the loop used to
display the supplies in the debugfs doesn't deal correctly with this,
which results in the supplies not being displayed in debugfs on those
platforms.

Fix this by making sure to always display at least once supply in
debugfs.

Signed-off-by: Quentin Perret <quentin.perret@arm.com>

---

This has been observed on Juno r2 which uses SCPI and Hikey960 which
uses DT. I am not particularly familiar with that part of the code, so
I'm not sure if this is even remotely correct (hence the RFC tag).

I first thought setting opp_table->regulator_count to 1 would be the
right fix but that causes other issues. This fix seems to work OK on
Juno and Hikey960, at least.

Feedback is welcome :-)

Thanks,
Quentin
---
 drivers/opp/debugfs.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/opp/debugfs.c b/drivers/opp/debugfs.c
index e6828e5f81b0..2c14564575cb 100644
--- a/drivers/opp/debugfs.c
+++ b/drivers/opp/debugfs.c
@@ -40,9 +40,9 @@ static bool opp_debug_create_supplies(struct dev_pm_opp *opp,
 				      struct dentry *pdentry)
 {
 	struct dentry *d;
-	int i;
+	int i = 0;
 
-	for (i = 0; i < opp_table->regulator_count; i++) {
+	do {
 		char name[15];
 
 		snprintf(name, sizeof(name), "supply-%d", i);
@@ -68,7 +68,9 @@ static bool opp_debug_create_supplies(struct dev_pm_opp *opp,
 		if (!debugfs_create_ulong("u_amp", S_IRUGO, d,
 					  &opp->supplies[i].u_amp))
 			return false;
-	}
+
+		i++;
+	} while (i < opp_table->regulator_count);
 
 	return true;
 }
-- 
2.19.2

