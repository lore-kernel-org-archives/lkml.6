Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD7F2ECE567
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 12:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90C8721529
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 12:46:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90C8721529
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387917AbeITS36 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 14:29:58 -0400
Received: from mga07.intel.com ([134.134.136.100]:56674 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387655AbeITS35 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 14:29:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Sep 2018 05:46:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,398,1531810800"; 
   d="scan'208";a="87820967"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 20 Sep 2018 05:46:35 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [QUEUED v20180920 16/16] stm class: Use memcat_p()
Date:   Thu, 20 Sep 2018 15:45:53 +0300
Message-Id: <20180920124553.56978-17-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180920124553.56978-1-alexander.shishkin@linux.intel.com>
References: <20180920124553.56978-1-alexander.shishkin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of a local copy, use the memcat_p() helper to merge policy
node attributes.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 drivers/hwtracing/stm/policy.c | 29 +----------------------------
 1 file changed, 1 insertion(+), 28 deletions(-)

diff --git a/drivers/hwtracing/stm/policy.c b/drivers/hwtracing/stm/policy.c
index 894598cfe2b7..2e3841ee7030 100644
--- a/drivers/hwtracing/stm/policy.c
+++ b/drivers/hwtracing/stm/policy.c
@@ -202,33 +202,6 @@ static struct configfs_attribute *stp_policy_node_attrs[] = {
 static const struct config_item_type stp_policy_type;
 static const struct config_item_type stp_policy_node_type;
 
-/* lifted from arch/x86/events/core.c */
-static struct configfs_attribute **merge_attr(struct configfs_attribute **a, struct configfs_attribute **b)
-{
-	struct configfs_attribute **new;
-	int j, i;
-
-	for (j = 0; a[j]; j++)
-		;
-	for (i = 0; b[i]; i++)
-		j++;
-	j++;
-
-	new = kmalloc_array(j, sizeof(struct configfs_attribute *),
-			    GFP_KERNEL);
-	if (!new)
-		return NULL;
-
-	j = 0;
-	for (i = 0; a[i]; i++)
-		new[j++] = a[i];
-	for (i = 0; b[i]; i++)
-		new[j++] = b[i];
-	new[j] = NULL;
-
-	return new;
-}
-
 const struct config_item_type *
 get_policy_node_type(struct configfs_attribute **attrs)
 {
@@ -240,7 +213,7 @@ get_policy_node_type(struct configfs_attribute **attrs)
 	if (!type)
 		return NULL;
 
-	merged = merge_attr(stp_policy_node_attrs, attrs);
+	merged = memcat_p(stp_policy_node_attrs, attrs);
 	if (!merged) {
 		kfree(type);
 		return NULL;
-- 
2.18.0

