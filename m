Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE318C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7CD120823
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:50:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728565AbfBUPub (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 10:50:31 -0500
Received: from mga02.intel.com ([134.134.136.20]:50434 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728527AbfBUPu1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 10:50:27 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP; 21 Feb 2019 07:50:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,395,1544515200"; 
   d="scan'208";a="136108140"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 21 Feb 2019 07:50:25 -0800
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [GIT PULL v1 4/7] intel_th: pti: Use sysfs_match_string() helper
Date:   Thu, 21 Feb 2019 17:50:03 +0200
Message-Id: <20190221155006.76832-5-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221155006.76832-1-alexander.shishkin@linux.intel.com>
References: <20190221155006.76832-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Use sysfs_match_string() helper instead of open coded variant.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 drivers/hwtracing/intel_th/pti.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/hwtracing/intel_th/pti.c b/drivers/hwtracing/intel_th/pti.c
index 56694339cb06..0da6b787f553 100644
--- a/drivers/hwtracing/intel_th/pti.c
+++ b/drivers/hwtracing/intel_th/pti.c
@@ -272,19 +272,17 @@ static ssize_t lpp_dest_store(struct device *dev, struct device_attribute *attr,
 			      const char *buf, size_t size)
 {
 	struct pti_device *pti = dev_get_drvdata(dev);
-	ssize_t ret = -EINVAL;
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(lpp_dest_str); i++)
-		if (sysfs_streq(buf, lpp_dest_str[i]))
-			break;
+	i = sysfs_match_string(lpp_dest_str, buf);
+	if (i < 0)
+		return i;
 
-	if (i < ARRAY_SIZE(lpp_dest_str) && pti->lpp_dest_mask & BIT(i)) {
-		pti->lpp_dest = i;
-		ret = size;
-	}
+	if (!(pti->lpp_dest_mask & BIT(i)))
+		return -EINVAL;
 
-	return ret;
+	pti->lpp_dest = i;
+	return size;
 }
 
 static DEVICE_ATTR_RW(lpp_dest);
-- 
2.20.1

