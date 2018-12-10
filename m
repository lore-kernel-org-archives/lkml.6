Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F69BC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49E122084E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:33:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49E122084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729943AbeLJVdR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 16:33:17 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:56225 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728088AbeLJVdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 16:33:16 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue002 [212.227.15.129]) with ESMTPA (Nemesis) id
 0MYXbd-1h1USP0gqn-00V4z7; Mon, 10 Dec 2018 22:33:04 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Raghava Aditya Renukunta 
        <RaghavaAditya.Renukunta@microsemi.com>,
        Prasad B Munirathnam <prasad.munirathnam@microsemi.com>,
        Dave Carroll <david.carroll@microsemi.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] scsi: aacraid: change wait_sem to a completion
Date:   Mon, 10 Dec 2018 22:32:40 +0100
Message-Id: <20181210213301.1065510-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:sUhRvsNkbv6cbFas1m2MplSdrFOrDEQ6+R0mIh7jg0wiP5NCG0V
 yJT/YZz08+8fgORLZW7tuwhGvT5bUDRIuXpubzhLTG+6y1yK5fh5KG+2EwagpWPUd/UjbK+
 c7LDOPktu9PmXKMzA3tA9JfR1bbdZpit3mFpLI5p2Tgx4ACUBc5L++9YdYAErfmJhiD/R/2
 JiBkrqObkVr2N61MjgOJA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vsc4rWV+O24=:XXB5ADPvQAly2V/zBz66To
 Ml42TKPBeVZItq7v2mKxOf31qI74kwwN2EYBwJOnpUV9awp+VkRvQL47DN5Ar6Xf6PAsKnx3n
 nKULmm4ivM2ibc07SUQh2M2oBMiPTgQXqGP4wqbVFD6RCb3xcp247Ai7XtFnRLgWt+/mFo/Ow
 Jf77BdTd4N/f/2ZOBtbYrNQknyq+L5evFK5o0Er5vF5v9+klb5xjcYOe75KtUYf44mZw6UgKp
 I1hKFjbfRa1dyWorz8cq4Vyej7a0otl35FP7qDPU7cWeZwjZHcQ2usIendKJaiY+S6KBIanme
 6/FIJZULVvUd9FvktwIY7gDgh5u+JQtt77tjQ8qdUUQcLsgNpVIym3IbO/f13jBZWCfLS+bqv
 j3dIFBVwXS0UwJBQwD/7dNaUXXGuhrlKanAahOwqOiEjx72uJhZaAYCltPEf9MgHXV1+3jLxi
 ZGaFh2tjzpf85Einlphdv6VldnB9j8S1K27YM5ANM5FYgieAycwPToeCydjHRvgDBBfrWee6m
 AtKZouHDjW5Xz0Wu3PiZ/O9vptPoeztQDcPZJrG/ATXLBWKbtePtNtRodUpLIkw12wQo/Jl08
 KYX7IzusQeaG+12wX7gw9yRYrcYwvi6YAVxRr7jWfGbCCT0fRxyJ1xL0o1ISJx96+nyBlR6Z7
 07+pyQ8y7SZazIPfdkXU+gOq2C7ir8RujdfxpPp4fxbYlI+PNhFqMRJBnGXrPTw5quaOK21QO
 9szt7rv4LWbnDc52xOX8ctOLTKaKeecDPRXgvg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The wait_sem member is used like a completion, so we should
use the respective API. The behavior is unchanged.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/scsi/aacraid/aacraid.h  | 2 +-
 drivers/scsi/aacraid/commctrl.c | 4 ++--
 drivers/scsi/aacraid/commsup.c  | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/aacraid/aacraid.h b/drivers/scsi/aacraid/aacraid.h
index 39eb415987fc..531a0b9a58f8 100644
--- a/drivers/scsi/aacraid/aacraid.h
+++ b/drivers/scsi/aacraid/aacraid.h
@@ -1241,7 +1241,7 @@ struct aac_fib_context {
 	u32			unique;		// unique value representing this context
 	ulong			jiffies;	// used for cleanup - dmb changed to ulong
 	struct list_head	next;		// used to link context's into a linked list
-	struct semaphore	wait_sem;	// this is used to wait for the next fib to arrive.
+	struct completion	completion;	// this is used to wait for the next fib to arrive.
 	int			wait;		// Set to true when thread is in WaitForSingleObject
 	unsigned long		count;		// total number of FIBs on FibList
 	struct list_head	fib_list;	// this holds fibs and their attachd hw_fibs
diff --git a/drivers/scsi/aacraid/commctrl.c b/drivers/scsi/aacraid/commctrl.c
index 25f6600d6c09..6a6ad9477786 100644
--- a/drivers/scsi/aacraid/commctrl.c
+++ b/drivers/scsi/aacraid/commctrl.c
@@ -203,7 +203,7 @@ static int open_getadapter_fib(struct aac_dev * dev, void __user *arg)
 		/*
 		 *	Initialize the mutex used to wait for the next AIF.
 		 */
-		sema_init(&fibctx->wait_sem, 0);
+		init_completion(&fibctx->completion);
 		fibctx->wait = 0;
 		/*
 		 *	Initialize the fibs and set the count of fibs on
@@ -335,7 +335,7 @@ static int next_getadapter_fib(struct aac_dev * dev, void __user *arg)
 			ssleep(1);
 		}
 		if (f.wait) {
-			if(down_interruptible(&fibctx->wait_sem) < 0) {
+			if (wait_for_completion_interruptible(&fibctx->completion) < 0) {
 				status = -ERESTARTSYS;
 			} else {
 				/* Lock again and retry */
diff --git a/drivers/scsi/aacraid/commsup.c b/drivers/scsi/aacraid/commsup.c
index 1e77d96a18f2..7ed51a77e39d 100644
--- a/drivers/scsi/aacraid/commsup.c
+++ b/drivers/scsi/aacraid/commsup.c
@@ -1828,7 +1828,7 @@ int aac_check_health(struct aac_dev * aac)
 			 * Set the event to wake up the
 			 * thread that will waiting.
 			 */
-			up(&fibctx->wait_sem);
+			complete(&fibctx->completion);
 		} else {
 			printk(KERN_WARNING "aifd: didn't allocate NewFib.\n");
 			kfree(fib);
@@ -2165,7 +2165,7 @@ static void wakeup_fibctx_threads(struct aac_dev *dev,
 		 * Set the event to wake up the
 		 * thread that is waiting.
 		 */
-		up(&fibctx->wait_sem);
+		complete(&fibctx->completion);
 
 		entry = entry->next;
 	}
-- 
2.20.0

