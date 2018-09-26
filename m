Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D408C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 19:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F369B2064D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 19:16:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F369B2064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbeI0B3p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 21:29:45 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:2656 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727112AbeI0B3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 21:29:44 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Wed, 26 Sep 2018 12:15:01 -0700
Received: from sc2-haas01-esx0118.eng.vmware.com (sc2-haas01-esx0118.eng.vmware.com [10.172.44.118])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id D0523B0E88;
        Wed, 26 Sep 2018 15:15:09 -0400 (EDT)
From:   Nadav Amit <namit@vmware.com>
To:     Arnd Bergmann <arnd@arndb.de>, <gregkh@linuxfoundation.org>
CC:     Xavier Deguillard <xdeguillard@vmware.com>,
        <linux-kernel@vger.kernel.org>, Nadav Amit <namit@vmware.com>
Subject: [PATCH v3 13/20] vmw_balloon: general style cleanup
Date:   Wed, 26 Sep 2018 12:13:29 -0700
Message-ID: <20180926191336.101885-14-namit@vmware.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180926191336.101885-1-namit@vmware.com>
References: <20180926191336.101885-1-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (EX13-EDG-OU-001.vmware.com: namit@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change all the remaining return values to int to avoid mistakes. Reduce
indentation when possible.

Reviewed-by: Xavier Deguillard <xdeguillard@vmware.com>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 drivers/misc/vmw_balloon.c | 39 ++++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
index cb363db34b4a..99a831ea82c0 100644
--- a/drivers/misc/vmw_balloon.c
+++ b/drivers/misc/vmw_balloon.c
@@ -477,10 +477,9 @@ vmballoon_cmd(struct vmballoon *b, unsigned long cmd, unsigned long arg1,
  * Send "start" command to the host, communicating supported version
  * of the protocol.
  */
-static bool vmballoon_send_start(struct vmballoon *b, unsigned long req_caps)
+static int vmballoon_send_start(struct vmballoon *b, unsigned long req_caps)
 {
 	unsigned long status, capabilities;
-	bool success;
 
 	status = __vmballoon_cmd(b, VMW_BALLOON_CMD_START, req_caps, 0,
 				 &capabilities);
@@ -488,14 +487,12 @@ static bool vmballoon_send_start(struct vmballoon *b, unsigned long req_caps)
 	switch (status) {
 	case VMW_BALLOON_SUCCESS_WITH_CAPABILITIES:
 		b->capabilities = capabilities;
-		success = true;
 		break;
 	case VMW_BALLOON_SUCCESS:
 		b->capabilities = VMW_BALLOON_BASIC_CMDS;
-		success = true;
 		break;
 	default:
-		success = false;
+		return -EIO;
 	}
 
 	/*
@@ -509,26 +506,29 @@ static bool vmballoon_send_start(struct vmballoon *b, unsigned long req_caps)
 		b->max_page_size = VMW_BALLOON_2M_PAGE;
 
 
-	return success;
+	return 0;
 }
 
-/*
+/**
+ * vmballoon_send_guest_id - communicate guest type to the host.
+ *
+ * @b: pointer to the balloon.
+ *
  * Communicate guest type to the host so that it can adjust ballooning
  * algorithm to the one most appropriate for the guest. This command
  * is normally issued after sending "start" command and is part of
  * standard reset sequence.
+ *
+ * Return: zero on success or appropriate error code.
  */
-static bool vmballoon_send_guest_id(struct vmballoon *b)
+static int vmballoon_send_guest_id(struct vmballoon *b)
 {
 	unsigned long status;
 
 	status = vmballoon_cmd(b, VMW_BALLOON_CMD_GUEST_ID,
 			       VMW_BALLOON_GUEST_ID, 0);
 
-	if (status == VMW_BALLOON_SUCCESS)
-		return true;
-
-	return false;
+	return status == VMW_BALLOON_SUCCESS ? 0 : -EIO;
 }
 
 /**
@@ -1215,8 +1215,15 @@ static void vmballoon_vmci_cleanup(struct vmballoon *b)
 	}
 }
 
-/*
- * Initialize vmci doorbell, to get notified as soon as balloon changes
+/**
+ * vmballoon_vmci_init - Initialize vmci doorbell.
+ *
+ * @b: pointer to the balloon.
+ *
+ * Return: zero on success or when wakeup command not supported. Error-code
+ * otherwise.
+ *
+ * Initialize vmci doorbell, to get notified as soon as balloon changes.
  */
 static int vmballoon_vmci_init(struct vmballoon *b)
 {
@@ -1278,7 +1285,7 @@ static void vmballoon_reset(struct vmballoon *b)
 	/* free all pages, skipping monitor unlock */
 	vmballoon_pop(b);
 
-	if (!vmballoon_send_start(b, VMW_BALLOON_CAPABILITIES))
+	if (vmballoon_send_start(b, VMW_BALLOON_CAPABILITIES))
 		return;
 
 	if ((b->capabilities & VMW_BALLOON_BATCHED_CMDS) != 0) {
@@ -1302,7 +1309,7 @@ static void vmballoon_reset(struct vmballoon *b)
 	if (error)
 		pr_err("failed to initialize vmci doorbell\n");
 
-	if (!vmballoon_send_guest_id(b))
+	if (vmballoon_send_guest_id(b))
 		pr_err("failed to send guest ID to the host\n");
 
 	up_write(&b->conf_sem);
-- 
2.17.1

