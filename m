Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD17DC07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 927F220661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:22:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 927F220661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbeLIWWd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:22:33 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35184 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726513AbeLIVzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:55:21 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72h-0002ir-Qo; Sun, 09 Dec 2018 21:55:16 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72e-0003SK-TN; Sun, 09 Dec 2018 21:55:12 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Corey Minyard" <cminyard@mvista.com>,
        "Andrew Banman" <abanman@hpe.com>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.20353647@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 175/328] ipmi: Move BT capabilities detection to the
 detect call
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Corey Minyard <cminyard@mvista.com>

commit c86ba91be75702c013bbf7379542920b6920e98f upstream.

The capabilities detection was being done as part of the normal
state machine, but it was possible for it to be running while
the upper layers of the IPMI driver were initializing the
device, resulting in error and failure to initialize.

Move the capabilities detection to the the detect function,
so it's done before anything else runs on the device.  This also
simplifies the state machine and removes some code, as a bonus.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
Reported-by: Andrew Banman <abanman@hpe.com>
Tested-by: Andrew Banman <abanman@hpe.com>
[bwh: Backported to 3.16:
 - struct si_sm_data doesn't include a dev pointer, so use pr_* functions
   for logging
 - Include <linux/sched.h> for schedule_timeout_uninterruptible()]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/drivers/char/ipmi/ipmi_bt_sm.c
+++ b/drivers/char/ipmi/ipmi_bt_sm.c
@@ -31,6 +31,7 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/ipmi_msgdefs.h>		/* for completion codes */
+#include <linux/sched.h>
 #include "ipmi_si_sm.h"
 
 #define BT_DEBUG_OFF	0	/* Used in production */
@@ -77,8 +78,6 @@ enum bt_states {
 	BT_STATE_RESET3,
 	BT_STATE_RESTART,
 	BT_STATE_PRINTME,
-	BT_STATE_CAPABILITIES_BEGIN,
-	BT_STATE_CAPABILITIES_END,
 	BT_STATE_LONG_BUSY	/* BT doesn't get hosed :-) */
 };
 
@@ -104,7 +103,6 @@ struct si_sm_data {
 	int		error_retries;	/* end of "common" fields */
 	int		nonzero_status;	/* hung BMCs stay all 0 */
 	enum bt_states	complete;	/* to divert the state machine */
-	int		BT_CAP_outreqs;
 	long		BT_CAP_req2rsp;
 	int		BT_CAP_retries;	/* Recommended retries */
 };
@@ -155,8 +153,6 @@ static char *state2txt(unsigned char sta
 	case BT_STATE_RESET3:		return("RESET3");
 	case BT_STATE_RESTART:		return("RESTART");
 	case BT_STATE_LONG_BUSY:	return("LONG_BUSY");
-	case BT_STATE_CAPABILITIES_BEGIN: return("CAP_BEGIN");
-	case BT_STATE_CAPABILITIES_END:	return("CAP_END");
 	}
 	return("BAD STATE");
 }
@@ -203,7 +199,6 @@ static unsigned int bt_init_data(struct
 	bt->complete = BT_STATE_IDLE;	/* end here */
 	bt->BT_CAP_req2rsp = BT_NORMAL_TIMEOUT * USEC_PER_SEC;
 	bt->BT_CAP_retries = BT_NORMAL_RETRY_LIMIT;
-	/* BT_CAP_outreqs == zero is a flag to read BT Capabilities */
 	return 3; /* We claim 3 bytes of space; ought to check SPMI table */
 }
 
@@ -469,7 +464,7 @@ static enum si_sm_result error_recovery(
 
 static enum si_sm_result bt_event(struct si_sm_data *bt, long time)
 {
-	unsigned char status, BT_CAP[8];
+	unsigned char status;
 	static enum bt_states last_printed = BT_STATE_PRINTME;
 	int i;
 
@@ -522,12 +517,6 @@ static enum si_sm_result bt_event(struct
 		if (status & BT_H_BUSY)		/* clear a leftover H_BUSY */
 			BT_CONTROL(BT_H_BUSY);
 
-		bt->timeout = bt->BT_CAP_req2rsp;
-
-		/* Read BT capabilities if it hasn't been done yet */
-		if (!bt->BT_CAP_outreqs)
-			BT_STATE_CHANGE(BT_STATE_CAPABILITIES_BEGIN,
-					SI_SM_CALL_WITHOUT_DELAY);
 		BT_SI_SM_RETURN(SI_SM_IDLE);
 
 	case BT_STATE_XACTION_START:
@@ -632,37 +621,6 @@ static enum si_sm_result bt_event(struct
 		BT_STATE_CHANGE(BT_STATE_XACTION_START,
 				SI_SM_CALL_WITH_DELAY);
 
-	/*
-	 * Get BT Capabilities, using timing of upper level state machine.
-	 * Set outreqs to prevent infinite loop on timeout.
-	 */
-	case BT_STATE_CAPABILITIES_BEGIN:
-		bt->BT_CAP_outreqs = 1;
-		{
-			unsigned char GetBT_CAP[] = { 0x18, 0x36 };
-			bt->state = BT_STATE_IDLE;
-			bt_start_transaction(bt, GetBT_CAP, sizeof(GetBT_CAP));
-		}
-		bt->complete = BT_STATE_CAPABILITIES_END;
-		BT_STATE_CHANGE(BT_STATE_XACTION_START,
-				SI_SM_CALL_WITH_DELAY);
-
-	case BT_STATE_CAPABILITIES_END:
-		i = bt_get_result(bt, BT_CAP, sizeof(BT_CAP));
-		bt_init_data(bt, bt->io);
-		if ((i == 8) && !BT_CAP[2]) {
-			bt->BT_CAP_outreqs = BT_CAP[3];
-			bt->BT_CAP_req2rsp = BT_CAP[6] * USEC_PER_SEC;
-			bt->BT_CAP_retries = BT_CAP[7];
-		} else
-			printk(KERN_WARNING "IPMI BT: using default values\n");
-		if (!bt->BT_CAP_outreqs)
-			bt->BT_CAP_outreqs = 1;
-		printk(KERN_WARNING "IPMI BT: req2rsp=%ld secs retries=%d\n",
-			bt->BT_CAP_req2rsp / USEC_PER_SEC, bt->BT_CAP_retries);
-		bt->timeout = bt->BT_CAP_req2rsp;
-		return SI_SM_CALL_WITHOUT_DELAY;
-
 	default:	/* should never occur */
 		return error_recovery(bt,
 				      status,
@@ -673,6 +631,11 @@ static enum si_sm_result bt_event(struct
 
 static int bt_detect(struct si_sm_data *bt)
 {
+	unsigned char GetBT_CAP[] = { 0x18, 0x36 };
+	unsigned char BT_CAP[8];
+	enum si_sm_result smi_result;
+	int rv;
+
 	/*
 	 * It's impossible for the BT status and interrupt registers to be
 	 * all 1's, (assuming a properly functioning, self-initialized BMC)
@@ -683,6 +646,47 @@ static int bt_detect(struct si_sm_data *
 	if ((BT_STATUS == 0xFF) && (BT_INTMASK_R == 0xFF))
 		return 1;
 	reset_flags(bt);
+
+	/*
+	 * Try getting the BT capabilities here.
+	 */
+	rv = bt_start_transaction(bt, GetBT_CAP, sizeof(GetBT_CAP));
+	if (rv) {
+		pr_warn("BT: Can't start capabilities transaction: %d\n", rv);
+		goto out_no_bt_cap;
+	}
+
+	smi_result = SI_SM_CALL_WITHOUT_DELAY;
+	for (;;) {
+		if (smi_result == SI_SM_CALL_WITH_DELAY ||
+		    smi_result == SI_SM_CALL_WITH_TICK_DELAY) {
+			schedule_timeout_uninterruptible(1);
+			smi_result = bt_event(bt, jiffies_to_usecs(1));
+		} else if (smi_result == SI_SM_CALL_WITHOUT_DELAY) {
+			smi_result = bt_event(bt, 0);
+		} else
+			break;
+	}
+
+	rv = bt_get_result(bt, BT_CAP, sizeof(BT_CAP));
+	bt_init_data(bt, bt->io);
+	if (rv < 8) {
+		pr_warn("BT: bt cap response too short: %d\n", rv);
+		goto out_no_bt_cap;
+	}
+
+	if (BT_CAP[2]) {
+		pr_warn("BT: Error fetching bt cap: %x\n", BT_CAP[2]);
+out_no_bt_cap:
+		pr_warn("BT: using default values\n");
+	} else {
+		bt->BT_CAP_req2rsp = BT_CAP[6] * USEC_PER_SEC;
+		bt->BT_CAP_retries = BT_CAP[7];
+	}
+
+	pr_info("BT: req2rsp=%ld secs retries=%d\n",
+		 bt->BT_CAP_req2rsp / USEC_PER_SEC, bt->BT_CAP_retries);
+
 	return 0;
 }
 

