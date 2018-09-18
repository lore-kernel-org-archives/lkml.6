Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A4EECE563
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 06:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A78F206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 06:41:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A78F206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729356AbeIRMLh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 08:11:37 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:36971 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729295AbeIRMLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 08:11:36 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Mon, 17 Sep 2018 23:39:56 -0700
Received: from sc2-haas01-esx0118.eng.vmware.com (sc2-haas01-esx0118.eng.vmware.com [10.172.44.118])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id D4AEA40957;
        Mon, 17 Sep 2018 23:40:19 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, Nadav Amit <namit@vmware.com>
Subject: [PATCH 09/19] vmw_balloon: simplify vmballoon_send_get_target()
Date:   Mon, 17 Sep 2018 23:38:43 -0700
Message-ID: <20180918063853.198332-10-namit@vmware.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180918063853.198332-1-namit@vmware.com>
References: <20180918063853.198332-1-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (EX13-EDG-OU-002.vmware.com: namit@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As we want to leave as little as possible on the global balloon
structure, to avoid possible future races, we want to get rid sysinfo.
We can actually get the total_ram directly, and simplify the logic of
vmballoon_send_get_target() a little.

While we are doing that, let's return int and avoid mistakes due to
bool/int conversions.

Reviewed-by: Xavier Deguillard <xdeguillard@vmware.com>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 drivers/misc/vmw_balloon.c | 35 ++++++++++++++---------------------
 1 file changed, 14 insertions(+), 21 deletions(-)

diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
index aafd087809e9..17ac066a20fe 100644
--- a/drivers/misc/vmw_balloon.c
+++ b/drivers/misc/vmw_balloon.c
@@ -223,8 +223,6 @@ struct vmballoon {
 	struct dentry *dbg_entry;
 #endif
 
-	struct sysinfo sysinfo;
-
 	struct delayed_work dwork;
 
 	struct vmci_handle vmci_doorbell;
@@ -353,34 +351,29 @@ static u16 vmballoon_page_size(bool is_2m_page)
 	return 1;
 }
 
-/*
- * Retrieve desired balloon size from the host.
+/**
+ * vmballoon_send_get_target() - Retrieve desired balloon size from the host.
+ *
+ * @b: pointer to the balloon.
+ *
+ * Return: zero on success, EINVAL if limit does not fit in 32-bit, as required
+ * by the host-guest protocol and EIO if an error occurred in communicating with
+ * the host.
  */
-static bool vmballoon_send_get_target(struct vmballoon *b)
+static int vmballoon_send_get_target(struct vmballoon *b)
 {
 	unsigned long status;
 	unsigned long limit;
-	u32 limit32;
 
-	/*
-	 * si_meminfo() is cheap. Moreover, we want to provide dynamic
-	 * max balloon size later. So let us call si_meminfo() every
-	 * iteration.
-	 */
-	si_meminfo(&b->sysinfo);
-	limit = b->sysinfo.totalram;
+	limit = totalram_pages;
 
 	/* Ensure limit fits in 32-bits */
-	limit32 = (u32)limit;
-	if (limit != limit32)
-		return false;
+	if (limit != (u32)limit)
+		return -EINVAL;
 
 	status = vmballoon_cmd(b, VMW_BALLOON_CMD_GET_TARGET, limit, 0);
 
-	if (status == VMW_BALLOON_SUCCESS)
-		return true;
-
-	return false;
+	return status == VMW_BALLOON_SUCCESS ? 0 : -EIO;
 }
 
 static struct page *vmballoon_alloc_page(bool is_2m_page)
@@ -960,7 +953,7 @@ static void vmballoon_work(struct work_struct *work)
 	if (b->reset_required)
 		vmballoon_reset(b);
 
-	if (vmballoon_send_get_target(b))
+	if (!vmballoon_send_get_target(b))
 		change = vmballoon_change(b);
 
 	if (change != 0) {
-- 
2.17.1

