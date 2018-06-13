Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 84B36C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 21:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45D43208D5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 21:09:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45D43208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964788AbeFMVJV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 17:09:21 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:49469 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935842AbeFMVJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 17:09:16 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Wed, 13 Jun 2018 14:08:50 -0700
Received: from sc2-haas01-esx0118.eng.vmware.com (sc2-haas01-esx0118.eng.vmware.com [10.172.44.118])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id EA889409B8;
        Wed, 13 Jun 2018 14:09:15 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Xavier Deguillard <xdeguillard@vmware.com>,
        <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Nadav Amit <namit@vmware.com>, <stable@vger.kernel.org>
Subject: [PATCH v2 3/7] vmw_balloon: VMCI_DOORBELL_SET does not check status
Date:   Wed, 13 Jun 2018 06:54:08 -0700
Message-ID: <20180613135412.81660-4-namit@vmware.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180613135412.81660-1-namit@vmware.com>
References: <20180613135412.81660-1-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (EX13-EDG-OU-001.vmware.com: namit@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When vmballoon_vmci_init() sets a doorbell using VMCI_DOORBELL_SET, for
some reason it does not consider the status and looks at the result.
However, the hypervisor does not update the result - it updates the
status. This might cause VMCI doorbell not to be enabled, resulting in
degraded performance.

Fixes: 48e3d668b790 ("VMware balloon: Enable notification via VMCI")

Cc: stable@vger.kernel.org
Reviewed-by: Xavier Deguillard <xdeguillard@vmware.com>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 drivers/misc/vmw_balloon.c | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
index 60ab83d3d0ef..a7df4c24a28d 100644
--- a/drivers/misc/vmw_balloon.c
+++ b/drivers/misc/vmw_balloon.c
@@ -1036,29 +1036,30 @@ static void vmballoon_vmci_cleanup(struct vmballoon *b)
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
-- 
2.17.0

