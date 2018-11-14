Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B145C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 21:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B6C3223DD
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 21:49:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B6C3223DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbeKOHyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 02:54:36 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:52400 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbeKOHyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 02:54:35 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gN32W-0003H1-19; Wed, 14 Nov 2018 21:49:36 +0000
From:   Colin King <colin.king@canonical.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] reset: fix null pointer dereference on dev by dev_name
Date:   Wed, 14 Nov 2018 21:49:35 +0000
Message-Id: <20181114214935.16038-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The call to dev_name will dereference dev, however, dev is later
being null checked, so there is a possibility of a null pointer
dereference on dev by the call to dev_name. Fix this by null
checking dev first before the call to dev_name

Detected by CoverityScan, CID#1475475 ("Dereference before null check")

Fixes: 2a6cb2b1d83b ("reset: Add reset_control_get_count()")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/reset/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/reset/core.c b/drivers/reset/core.c
index 7f95fcb7805d..3d9a887c217e 100644
--- a/drivers/reset/core.c
+++ b/drivers/reset/core.c
@@ -799,12 +799,13 @@ EXPORT_SYMBOL_GPL(devm_reset_control_array_get);
 static int reset_control_get_count_from_lookup(struct device *dev)
 {
 	const struct reset_control_lookup *lookup;
-	const char *dev_id = dev_name(dev);
+	const char *dev_id;
 	int count = 0;
 
 	if (!dev)
 		return -EINVAL;
 
+	dev_id = dev_name(dev);
 	mutex_lock(&reset_lookup_mutex);
 
 	list_for_each_entry(lookup, &reset_lookup_list, list) {
-- 
2.19.1

