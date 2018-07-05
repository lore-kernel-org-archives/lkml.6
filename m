Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B6F1C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF09224010
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:36:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF09224010
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932205AbeGENgw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 09:36:52 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:33166 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753935AbeGENgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 09:36:50 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fb4RD-0000in-I2; Thu, 05 Jul 2018 13:36:47 +0000
From:   Colin King <colin.king@canonical.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][V2] usb: typec: unlock dp->lock on error exit path, and also zero ret if successful
Date:   Thu,  5 Jul 2018 14:36:47 +0100
Message-Id: <20180705133647.13016-1-colin.king@canonical.com>
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

V2: move the ret = 0 assignment to the declaration

---
 drivers/usb/typec/altmodes/displayport.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/typec/altmodes/displayport.c b/drivers/usb/typec/altmodes/displayport.c
index ef12b15bd484..3f06e94771a7 100644
--- a/drivers/usb/typec/altmodes/displayport.c
+++ b/drivers/usb/typec/altmodes/displayport.c
@@ -333,7 +333,7 @@ configuration_store(struct device *dev, struct device_attribute *attr,
 	u32 conf;
 	u32 cap;
 	int con;
-	int ret;
+	int ret = 0;
 
 	con = sysfs_match_string(configurations, buf);
 	if (con < 0)
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
-- 
2.17.1

