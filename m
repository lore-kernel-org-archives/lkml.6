Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8549FC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 12:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41094208DC
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 12:46:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41094208DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753346AbeGDMqP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 08:46:15 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43201 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753231AbeGDMqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 08:46:13 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fahAh-0001Hu-Fp; Wed, 04 Jul 2018 12:46:11 +0000
From:   Colin King <colin.king@canonical.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] usb: typec: unlock dp->lock on error exit path, and also zero ret if successful
Date:   Wed,  4 Jul 2018 13:46:11 +0100
Message-Id: <20180704124611.9852-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

One of the error handling paths forgets to unlock dp->lock on the error
exit path leading to a potential lock-up.  Also the return path for a
successful call to the function configuration_store can return an
uninitialized error return code if dp->alt->active is false, so ensure
ret is zeroed on the successful exit path to avoid garbage being returned.

Detected by CoverityScan, CID#1471597 ("Unitialized scalar variable")

Fixes: 0e3bb7d6894d ("usb: typec: Add driver for DisplayPort alternate mode")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/usb/typec/altmodes/displayport.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/altmodes/displayport.c b/drivers/usb/typec/altmodes/displayport.c
index ef12b15bd484..9a637c2b4460 100644
--- a/drivers/usb/typec/altmodes/displayport.c
+++ b/drivers/usb/typec/altmodes/displayport.c
@@ -349,8 +349,10 @@ configuration_store(struct device *dev, struct device_attribute *attr,
 	cap = DP_CAP_CAPABILITY(dp->alt->vdo);
 
 	if ((con == DP_CONF_DFP_D && !(cap & DP_CAP_DFP_D)) ||
-	    (con == DP_CONF_UFP_D && !(cap & DP_CAP_UFP_D)))
-		return -EINVAL;
+	    (con == DP_CONF_UFP_D && !(cap & DP_CAP_UFP_D))) {
+		ret = -EINVAL;
+		goto err_unlock;
+	}
 
 	conf = dp->data.conf & ~DP_CONF_DUAL_D;
 	conf |= con;
@@ -362,6 +364,7 @@ configuration_store(struct device *dev, struct device_attribute *attr,
 	}
 
 	dp->data.conf = conf;
+	ret = 0;
 
 err_unlock:
 	mutex_unlock(&dp->lock);
-- 
2.17.1

