Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id fF4vOfdZGlvdYAAAmS7hNA
	; Fri, 08 Jun 2018 10:27:59 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 42FBB606FA; Fri,  8 Jun 2018 10:27:59 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id BFA6560590;
	Fri,  8 Jun 2018 10:27:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BFA6560590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752478AbeFHK14 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 06:27:56 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8704 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751152AbeFHK1y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 06:27:54 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 976E049E2C96E;
        Fri,  8 Jun 2018 18:27:40 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.382.0; Fri, 8 Jun 2018 18:27:35 +0800
From: John Garry <john.garry@huawei.com>
To: <tj@kernel.org>
CC: <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dan.carpenter@oracle.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH] libahci: Fix possible Spectre-v1 pmp indexing in ahci_led_store()
Date: Fri, 8 Jun 2018 18:26:33 +0800
Message-ID: <1528453593-225313-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently smatch warns of possible Spectre-V1 issue in ahci_led_store():
drivers/ata/libahci.c:1150 ahci_led_store() warn: potential spectre issue 'pp->em_priv' (local cap)

Userspace controls @pmp from following callchain:
em_message->store()
->ata_scsi_em_message_store()
-->ap->ops->em_store()
--->ahci_led_store()

After the mask+shift @pmp is effectively an 8b value, which is used to
index into an array of length 8, so sanitize the array index.

Signed-off-by: John Garry <john.garry@huawei.com>

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 7adcf3c..4ce5bb4 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -35,6 +35,7 @@
 #include <linux/kernel.h>
 #include <linux/gfp.h>
 #include <linux/module.h>
+#include <linux/nospec.h>
 #include <linux/blkdev.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
@@ -1142,10 +1143,12 @@ static ssize_t ahci_led_store(struct ata_port *ap, const char *buf,
 
 	/* get the slot number from the message */
 	pmp = (state & EM_MSG_LED_PMP_SLOT) >> 8;
-	if (pmp < EM_MAX_SLOTS)
+	if (pmp < EM_MAX_SLOTS) {
+		pmp = array_index_nospec(pmp, EM_MAX_SLOTS);
 		emp = &pp->em_priv[pmp];
-	else
+	} else {
 		return -EINVAL;
+	}
 
 	/* mask off the activity bits if we are in sw_activity
 	 * mode, user should turn off sw_activity before setting
-- 
1.9.1
