Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965027AbeEIPQN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 11:16:13 -0400
Received: from smtprelay0046.hostedemail.com ([216.40.44.46]:55443 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S964963AbeEIPQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 11:16:06 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::,RULES_HIT:1:41:69:355:379:541:800:960:968:973:988:989:1260:1345:1359:1437:1605:1730:1747:1777:1792:2198:2199:2393:2559:2562:2638:2902:3138:3139:3140:3141:3142:3865:3867:3870:3871:3872:4321:4398:4605:5007:6117:6119:6261:7875:7903:8603:8957:9038:10004:10848:11026:11473:11658:11914:12043:12296:12438:12555:12679:12683:12895:12986:13972:14110:14394:21080:21433:21451:21627:30012:30045:30046:30054:30070,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:20,LUA_SUMMARY:none
X-HE-Tag: brain53_8c5ed9318f325
X-Filterd-Recvd-Size: 13374
From: Joe Perches <joe@perches.com>
To: Corey Minyard <minyard@acm.org>
Cc: x86@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        openipmi-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] ipmi: Convert printk(KERN_<level> to pr_<level>(
Date: Wed,  9 May 2018 08:15:49 -0700
Message-Id: <6ded88aac897dfb05803f81acdb31146315fd372.1525878372.git.joe@perches.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <cover.1525878372.git.joe@perches.com>
References: <cover.1525878372.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the more common logging style.

Miscellanea:

o Convert old style continuation printks without KERN_CONT to pr_cont
o Coalesce formats
o Realign arguments
o Remove unnecessary casts

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/char/ipmi/ipmi_bt_sm.c   | 64 +++++++++++++++++++---------------------
 drivers/char/ipmi/ipmi_devintf.c | 11 ++++---
 drivers/char/ipmi/ipmi_kcs_sm.c  |  4 +--
 drivers/char/ipmi/ipmi_smic_sm.c | 26 +++++++---------
 4 files changed, 48 insertions(+), 57 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_bt_sm.c b/drivers/char/ipmi/ipmi_bt_sm.c
index fd4ea8d87d4b..95cfa20456e6 100644
--- a/drivers/char/ipmi/ipmi_bt_sm.c
+++ b/drivers/char/ipmi/ipmi_bt_sm.c
@@ -221,11 +221,11 @@ static int bt_start_transaction(struct si_sm_data *bt,
 		return IPMI_NOT_IN_MY_STATE_ERR;
 
 	if (bt_debug & BT_DEBUG_MSG) {
-		printk(KERN_WARNING "BT: +++++++++++++++++ New command\n");
-		printk(KERN_WARNING "BT: NetFn/LUN CMD [%d data]:", size - 2);
+		pr_warn("BT: +++++++++++++++++ New command\n");
+		pr_warn("BT: NetFn/LUN CMD [%d data]:", size - 2);
 		for (i = 0; i < size; i ++)
-			printk(" %02x", data[i]);
-		printk("\n");
+			pr_cont(" %02x", data[i]);
+		pr_cont("\n");
 	}
 	bt->write_data[0] = size + 1;	/* all data plus seq byte */
 	bt->write_data[1] = *data;	/* NetFn/LUN */
@@ -266,10 +266,10 @@ static int bt_get_result(struct si_sm_data *bt,
 		memcpy(data + 2, bt->read_data + 4, msg_len - 2);
 
 	if (bt_debug & BT_DEBUG_MSG) {
-		printk(KERN_WARNING "BT: result %d bytes:", msg_len);
+		pr_warn("BT: result %d bytes:", msg_len);
 		for (i = 0; i < msg_len; i++)
-			printk(" %02x", data[i]);
-		printk("\n");
+			pr_cont(" %02x", data[i]);
+		pr_cont("\n");
 	}
 	return msg_len;
 }
@@ -280,8 +280,7 @@ static int bt_get_result(struct si_sm_data *bt,
 static void reset_flags(struct si_sm_data *bt)
 {
 	if (bt_debug)
-		printk(KERN_WARNING "IPMI BT: flag reset %s\n",
-					status2txt(BT_STATUS));
+		pr_warn("IPMI BT: flag reset %s\n", status2txt(BT_STATUS));
 	if (BT_STATUS & BT_H_BUSY)
 		BT_CONTROL(BT_H_BUSY);	/* force clear */
 	BT_CONTROL(BT_CLR_WR_PTR);	/* always reset */
@@ -307,14 +306,13 @@ static void drain_BMC2HOST(struct si_sm_data *bt)
 	BT_CONTROL(BT_B2H_ATN);		/* some BMCs are stubborn */
 	BT_CONTROL(BT_CLR_RD_PTR);	/* always reset */
 	if (bt_debug)
-		printk(KERN_WARNING "IPMI BT: stale response %s; ",
-			status2txt(BT_STATUS));
+		pr_warn("IPMI BT: stale response %s; ", status2txt(BT_STATUS));
 	size = BMC2HOST;
 	for (i = 0; i < size ; i++)
 		BMC2HOST;
 	BT_CONTROL(BT_H_BUSY);		/* now clear */
 	if (bt_debug)
-		printk("drained %d bytes\n", size + 1);
+		pr_cont("drained %d bytes\n", size + 1);
 }
 
 static inline void write_all_bytes(struct si_sm_data *bt)
@@ -322,11 +320,11 @@ static inline void write_all_bytes(struct si_sm_data *bt)
 	int i;
 
 	if (bt_debug & BT_DEBUG_MSG) {
-		printk(KERN_WARNING "BT: write %d bytes seq=0x%02X",
+		pr_warn("BT: write %d bytes seq=0x%02X",
 			bt->write_count, bt->seq);
 		for (i = 0; i < bt->write_count; i++)
-			printk(" %02x", bt->write_data[i]);
-		printk("\n");
+			pr_cont(" %02x", bt->write_data[i]);
+		pr_cont("\n");
 	}
 	for (i = 0; i < bt->write_count; i++)
 		HOST2BMC(bt->write_data[i]);
@@ -346,8 +344,7 @@ static inline int read_all_bytes(struct si_sm_data *bt)
 
 	if (bt->read_count < 4 || bt->read_count >= IPMI_MAX_MSG_LENGTH) {
 		if (bt_debug & BT_DEBUG_MSG)
-			printk(KERN_WARNING "BT: bad raw rsp len=%d\n",
-				bt->read_count);
+			pr_warn("BT: bad raw rsp len=%d\n", bt->read_count);
 		bt->truncated = 1;
 		return 1;	/* let next XACTION START clean it up */
 	}
@@ -358,13 +355,12 @@ static inline int read_all_bytes(struct si_sm_data *bt)
 	if (bt_debug & BT_DEBUG_MSG) {
 		int max = bt->read_count;
 
-		printk(KERN_WARNING "BT: got %d bytes seq=0x%02X",
-			max, bt->read_data[2]);
+		pr_warn("BT: got %d bytes seq=0x%02X", max, bt->read_data[2]);
 		if (max > 16)
 			max = 16;
 		for (i = 0; i < max; i++)
-			printk(KERN_CONT " %02x", bt->read_data[i]);
-		printk(KERN_CONT "%s\n", bt->read_count == max ? "" : " ...");
+			pr_cont(" %02x", bt->read_data[i]);
+		pr_cont("%s\n", bt->read_count == max ? "" : " ...");
 	}
 
 	/* per the spec, the (NetFn[1], Seq[2], Cmd[3]) tuples must match */
@@ -374,10 +370,10 @@ static inline int read_all_bytes(struct si_sm_data *bt)
 			return 1;
 
 	if (bt_debug & BT_DEBUG_MSG)
-		printk(KERN_WARNING "IPMI BT: bad packet: "
-		"want 0x(%02X, %02X, %02X) got (%02X, %02X, %02X)\n",
-		bt->write_data[1] | 0x04, bt->write_data[2], bt->write_data[3],
-		bt->read_data[1],  bt->read_data[2],  bt->read_data[3]);
+		pr_warn("IPMI BT: bad packet: want 0x(%02X, %02X, %02X) got (%02X, %02X, %02X)\n",
+			bt->write_data[1] | 0x04, bt->write_data[2],
+			bt->write_data[3],
+			bt->read_data[1],  bt->read_data[2],  bt->read_data[3]);
 	return 0;
 }
 
@@ -400,7 +396,7 @@ static enum si_sm_result error_recovery(struct si_sm_data *bt,
 		break;
 	}
 
-	printk(KERN_WARNING "IPMI BT: %s in %s %s ", 	/* open-ended line */
+	pr_warn("IPMI BT: %s in %s %s ", 	/* open-ended line */
 		reason, STATE2TXT, STATUS2TXT);
 
 	/*
@@ -409,20 +405,20 @@ static enum si_sm_result error_recovery(struct si_sm_data *bt,
 	 */
 	(bt->error_retries)++;
 	if (bt->error_retries < bt->BT_CAP_retries) {
-		printk("%d retries left\n",
+		pr_cont("%d retries left\n",
 			bt->BT_CAP_retries - bt->error_retries);
 		bt->state = BT_STATE_RESTART;
 		return SI_SM_CALL_WITHOUT_DELAY;
 	}
 
-	printk(KERN_WARNING "failed %d retries, sending error response\n",
-	       bt->BT_CAP_retries);
+	pr_warn("failed %d retries, sending error response\n",
+		bt->BT_CAP_retries);
 	if (!bt->nonzero_status)
-		printk(KERN_ERR "IPMI BT: stuck, try power cycle\n");
+		pr_err("IPMI BT: stuck, try power cycle\n");
 
 	/* this is most likely during insmod */
 	else if (bt->seq <= (unsigned char)(bt->BT_CAP_retries & 0xFF)) {
-		printk(KERN_WARNING "IPMI: BT reset (takes 5 secs)\n");
+		pr_warn("IPMI: BT reset (takes 5 secs)\n");
 		bt->state = BT_STATE_RESET1;
 		return SI_SM_CALL_WITHOUT_DELAY;
 	}
@@ -458,7 +454,7 @@ static enum si_sm_result bt_event(struct si_sm_data *bt, long time)
 	status = BT_STATUS;
 	bt->nonzero_status |= status;
 	if ((bt_debug & BT_DEBUG_STATES) && (bt->state != last_printed)) {
-		printk(KERN_WARNING "BT: %s %s TO=%ld - %ld \n",
+		pr_warn("BT: %s %s TO=%ld - %ld\n",
 			STATE2TXT,
 			STATUS2TXT,
 			bt->timeout,
@@ -636,10 +632,10 @@ static enum si_sm_result bt_event(struct si_sm_data *bt, long time)
 			bt->BT_CAP_req2rsp = BT_CAP[6] * USEC_PER_SEC;
 			bt->BT_CAP_retries = BT_CAP[7];
 		} else
-			printk(KERN_WARNING "IPMI BT: using default values\n");
+			pr_warn("IPMI BT: using default values\n");
 		if (!bt->BT_CAP_outreqs)
 			bt->BT_CAP_outreqs = 1;
-		printk(KERN_WARNING "IPMI BT: req2rsp=%ld secs retries=%d\n",
+		pr_warn("IPMI BT: req2rsp=%ld secs retries=%d\n",
 			bt->BT_CAP_req2rsp / USEC_PER_SEC, bt->BT_CAP_retries);
 		bt->timeout = bt->BT_CAP_req2rsp;
 		return SI_SM_CALL_WITHOUT_DELAY;
diff --git a/drivers/char/ipmi/ipmi_devintf.c b/drivers/char/ipmi/ipmi_devintf.c
index 1a486aec99b6..effab11887ca 100644
--- a/drivers/char/ipmi/ipmi_devintf.c
+++ b/drivers/char/ipmi/ipmi_devintf.c
@@ -818,8 +818,7 @@ static void ipmi_new_smi(int if_num, struct device *device)
 
 	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
 	if (!entry) {
-		printk(KERN_ERR "ipmi_devintf: Unable to create the"
-		       " ipmi class device link\n");
+		pr_err("ipmi_devintf: Unable to create the ipmi class device link\n");
 		return;
 	}
 	entry->dev = dev;
@@ -861,18 +860,18 @@ static int __init init_ipmi_devintf(void)
 	if (ipmi_major < 0)
 		return -EINVAL;
 
-	printk(KERN_INFO "ipmi device interface\n");
+	pr_info("ipmi device interface\n");
 
 	ipmi_class = class_create(THIS_MODULE, "ipmi");
 	if (IS_ERR(ipmi_class)) {
-		printk(KERN_ERR "ipmi: can't register device class\n");
+		pr_err("ipmi: can't register device class\n");
 		return PTR_ERR(ipmi_class);
 	}
 
 	rv = register_chrdev(ipmi_major, DEVICE_NAME, &ipmi_fops);
 	if (rv < 0) {
 		class_destroy(ipmi_class);
-		printk(KERN_ERR "ipmi: can't get major %d\n", ipmi_major);
+		pr_err("ipmi: can't get major %d\n", ipmi_major);
 		return rv;
 	}
 
@@ -884,7 +883,7 @@ static int __init init_ipmi_devintf(void)
 	if (rv) {
 		unregister_chrdev(ipmi_major, DEVICE_NAME);
 		class_destroy(ipmi_class);
-		printk(KERN_WARNING "ipmi: can't register smi watcher\n");
+		pr_warn("ipmi: can't register smi watcher\n");
 		return rv;
 	}
 
diff --git a/drivers/char/ipmi/ipmi_kcs_sm.c b/drivers/char/ipmi/ipmi_kcs_sm.c
index f4ea9f47230a..2e7cda08b079 100644
--- a/drivers/char/ipmi/ipmi_kcs_sm.c
+++ b/drivers/char/ipmi/ipmi_kcs_sm.c
@@ -274,8 +274,8 @@ static int start_kcs_transaction(struct si_sm_data *kcs, unsigned char *data,
 	if (kcs_debug & KCS_DEBUG_MSG) {
 		printk(KERN_DEBUG "start_kcs_transaction -");
 		for (i = 0; i < size; i++)
-			printk(" %02x", (unsigned char) (data [i]));
-		printk("\n");
+			pr_cont(" %02x", data[i]);
+		pr_cont("\n");
 	}
 	kcs->error_retries = 0;
 	memcpy(kcs->write_data, data, size);
diff --git a/drivers/char/ipmi/ipmi_smic_sm.c b/drivers/char/ipmi/ipmi_smic_sm.c
index 466a5aac5298..b6225bba2532 100644
--- a/drivers/char/ipmi/ipmi_smic_sm.c
+++ b/drivers/char/ipmi/ipmi_smic_sm.c
@@ -132,8 +132,8 @@ static int start_smic_transaction(struct si_sm_data *smic,
 	if (smic_debug & SMIC_DEBUG_MSG) {
 		printk(KERN_DEBUG "start_smic_transaction -");
 		for (i = 0; i < size; i++)
-			printk(" %02x", (unsigned char) data[i]);
-		printk("\n");
+			pr_cont(" %02x", data[i]);
+		pr_cont("\n");
 	}
 	smic->error_retries = 0;
 	memcpy(smic->write_data, data, size);
@@ -154,8 +154,8 @@ static int smic_get_result(struct si_sm_data *smic,
 	if (smic_debug & SMIC_DEBUG_MSG) {
 		printk(KERN_DEBUG "smic_get result -");
 		for (i = 0; i < smic->read_pos; i++)
-			printk(" %02x", smic->read_data[i]);
-		printk("\n");
+			pr_cont(" %02x", smic->read_data[i]);
+		pr_cont("\n");
 	}
 	if (length < smic->read_pos) {
 		smic->read_pos = length;
@@ -212,8 +212,7 @@ static inline void start_error_recovery(struct si_sm_data *smic, char *reason)
 	(smic->error_retries)++;
 	if (smic->error_retries > SMIC_MAX_ERROR_RETRIES) {
 		if (smic_debug & SMIC_DEBUG_ENABLE)
-			printk(KERN_WARNING
-			       "ipmi_smic_drv: smic hosed: %s\n", reason);
+			pr_warn("ipmi_smic_drv: smic hosed: %s\n", reason);
 		smic->state = SMIC_HOSED;
 	} else {
 		smic->write_count = smic->orig_write_count;
@@ -326,8 +325,7 @@ static enum si_sm_result smic_event(struct si_sm_data *smic, long time)
 	if (smic->state != SMIC_IDLE) {
 		if (smic_debug & SMIC_DEBUG_STATES)
 			printk(KERN_DEBUG
-			       "smic_event - smic->smic_timeout = %ld,"
-			       " time = %ld\n",
+			       "smic_event - smic->smic_timeout = %ld, time = %ld\n",
 			       smic->smic_timeout, time);
 		/*
 		 * FIXME: smic_event is sometimes called with time >
@@ -347,9 +345,7 @@ static enum si_sm_result smic_event(struct si_sm_data *smic, long time)
 
 	status = read_smic_status(smic);
 	if (smic_debug & SMIC_DEBUG_STATES)
-		printk(KERN_DEBUG
-		       "smic_event - state = %d, flags = 0x%02x,"
-		       " status = 0x%02x\n",
+		printk(KERN_DEBUG "smic_event - state = %d, flags = 0x%02x, status = 0x%02x\n",
 		       smic->state, flags, status);
 
 	switch (smic->state) {
@@ -440,8 +436,8 @@ static enum si_sm_result smic_event(struct si_sm_data *smic, long time)
 		data = read_smic_data(smic);
 		if (data != 0) {
 			if (smic_debug & SMIC_DEBUG_ENABLE)
-				printk(KERN_DEBUG
-				       "SMIC_WRITE_END: data = %02x\n", data);
+				printk(KERN_DEBUG "SMIC_WRITE_END: data = %02x\n",
+				       data);
 			start_error_recovery(smic,
 					     "state = SMIC_WRITE_END, "
 					     "data != SUCCESS");
@@ -520,8 +516,8 @@ static enum si_sm_result smic_event(struct si_sm_data *smic, long time)
 		/* data register holds an error code */
 		if (data != 0) {
 			if (smic_debug & SMIC_DEBUG_ENABLE)
-				printk(KERN_DEBUG
-				       "SMIC_READ_END: data = %02x\n", data);
+				printk(KERN_DEBUG "SMIC_READ_END: data = %02x\n",
+				       data);
 			start_error_recovery(smic,
 					     "state = SMIC_READ_END, "
 					     "data != SUCCESS");
-- 
2.15.0
