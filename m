Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F5FC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4690720844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:34:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4690720844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729845AbeIHCQy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:16:54 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51864 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727959AbeIHCQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:16:52 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id DEA1AF4A;
        Fri,  7 Sep 2018 21:33:59 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xavier Deguillard <xdeguillard@vmware.com>,
        Nadav Amit <namit@vmware.com>
Subject: [PATCH 4.9 26/63] vmw_balloon: VMCI_DOORBELL_SET does not check status
Date:   Fri,  7 Sep 2018 23:09:57 +0200
Message-Id: <20180907211014.421168059@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907211012.965501324@linuxfoundation.org>
References: <20180907211012.965501324@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nadav Amit <namit@vmware.com>

commit ce664331b2487a5d244a51cbdd8cb54f866fbe5d upstream.

When vmballoon_vmci_init() sets a doorbell using VMCI_DOORBELL_SET, for
some reason it does not consider the status and looks at the result.
However, the hypervisor does not update the result - it updates the
status. This might cause VMCI doorbell not to be enabled, resulting in
degraded performance.

Fixes: 48e3d668b790 ("VMware balloon: Enable notification via VMCI")
Cc: stable@vger.kernel.org
Reviewed-by: Xavier Deguillard <xdeguillard@vmware.com>
Signed-off-by: Nadav Amit <namit@vmware.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/misc/vmw_balloon.c |   37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

--- a/drivers/misc/vmw_balloon.c
+++ b/drivers/misc/vmw_balloon.c
@@ -1036,29 +1036,30 @@ static void vmballoon_vmci_cleanup(struc
  */
 static int vmballoon_vmci_init(struct vmballoon *b)
 {
-	int error = 0;
+	unsigned long error, dummy;
 
-	if ((b->capabilities & VMW_BALLOON_SIGNALLED_WAKEUP_CMD) != 0) {
-		error = vmci_doorbell_create(&b->vmci_doorbell,
-				VMCI_FLAG_DELAYED_CB,
-				VMCI_PRIVILEGE_FLAG_RESTRICTED,
-				vmballoon_doorbell, b);
-
-		if (error == VMCI_SUCCESS) {
-			VMWARE_BALLOON_CMD(VMCI_DOORBELL_SET,
-					b->vmci_doorbell.context,
-					b->vmci_doorbell.resource, error);
-			STATS_INC(b->stats.doorbell_set);
-		}
-	}
+	if ((b->capabilities & VMW_BALLOON_SIGNALLED_WAKEUP_CMD) == 0)
+		return 0;
 
-	if (error != 0) {
-		vmballoon_vmci_cleanup(b);
+	error = vmci_doorbell_create(&b->vmci_doorbell, VMCI_FLAG_DELAYED_CB,
+				     VMCI_PRIVILEGE_FLAG_RESTRICTED,
+				     vmballoon_doorbell, b);
 
-		return -EIO;
-	}
+	if (error != VMCI_SUCCESS)
+		goto fail;
+
+	error = VMWARE_BALLOON_CMD(VMCI_DOORBELL_SET, b->vmci_doorbell.context,
+				   b->vmci_doorbell.resource, dummy);
+
+	STATS_INC(b->stats.doorbell_set);
+
+	if (error != VMW_BALLOON_SUCCESS)
+		goto fail;
 
 	return 0;
+fail:
+	vmballoon_vmci_cleanup(b);
+	return -EIO;
 }
 
 /*


