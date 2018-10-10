Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 760CAC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 23:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF82B2150C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 23:13:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PxfH8Y44"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF82B2150C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbeJKGhz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 02:37:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:36068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727500AbeJKGhy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 02:37:54 -0400
Received: from lerouge.suse.de (LFbn-NCY-1-241-207.w83-194.abo.wanadoo.fr [83.194.85.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94AB020870;
        Wed, 10 Oct 2018 23:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539213210;
        bh=hUBxrIGaP7u8TLZxVMCaERuxDOMFk/fR9f2XHLUKEP0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PxfH8Y44RdDFF4I6W41cwK6ysP/cyvDTs4R9BtwFOXqz3ny8Wf7fM1/tmnigiHOS0
         HvBRbnXzzUkERZw3QrC/KPs/DiFF4fZn7lOFhqRaVasKeXAJj7IF7EMqPlBkB9+N9N
         CmNpIZu43OW6kubSdkMb/OlAsUjiDaskT9zeQf64=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [RFC PATCH 19/30] diva: Prepare diva_os_enter_spin_lock() for handling softirq mask
Date:   Thu, 11 Oct 2018 01:12:06 +0200
Message-Id: <1539213137-13953-20-git-send-email-frederic@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539213137-13953-1-git-send-email-frederic@kernel.org>
References: <1539213137-13953-1-git-send-email-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This pair of function is implemented on top of spin_lock_bh() that
is going to handle a softirq mask in order to apply finegrained vector
disablement. The lock function is going to return the previous vectors
enabled mask prior to the last call to local_bh_disable(), following a
similar model to that of local_irq_save/restore. Subsequent calls to
local_bh_disable() and friends can then stack up:

	bh = local_bh_disable(vec_mask);
		bh2 = diva_os_enter_spin_lock() {
			return spin_lock_bh(...)
		}
		...
		diva_os_leave_spin_lock(bh2) {
			spin_unlock_bh(bh2, ...);
		}
	local_bh_enable(bh);

To prepare for that, make diva_os_enter_spin_lock() able to return a
saved vector enabled mask and pass it back to diva_os_leave_spin_lock().
We'll plug it to spin_lock_bh() in a subsequent patch.

Thanks to coccinelle that helped a lot with scripts such as the
following:

	@spin exists@
	identifier func;
	expression e, e1, e2;
	@@
	func(...) {
	+ unsigned int bh;
	...
	- diva_os_enter_spin_lock(e, e1, e2);
	+ bh = diva_os_enter_spin_lock(e, e1, e2);
	...
	- diva_os_leave_spin_lock(e, e1, e2);
	+ diva_os_leave_spin_lock(e, e1, e2, bh);
	...
	}

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David S. Miller <davem@davemloft.net>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 drivers/isdn/hardware/eicon/capifunc.c |  53 ++++++++------
 drivers/isdn/hardware/eicon/dadapter.c |  39 ++++++----
 drivers/isdn/hardware/eicon/debug.c    | 129 +++++++++++++++++++--------------
 drivers/isdn/hardware/eicon/debug_if.h |   6 +-
 drivers/isdn/hardware/eicon/diva.c     |  45 +++++++-----
 drivers/isdn/hardware/eicon/idifunc.c  |  22 +++---
 drivers/isdn/hardware/eicon/io.c       |  88 ++++++++++++----------
 drivers/isdn/hardware/eicon/mntfunc.c  |  13 ++--
 drivers/isdn/hardware/eicon/platform.h |   9 ++-
 drivers/isdn/hardware/eicon/um_idi.c   | 104 ++++++++++++++++----------
 10 files changed, 304 insertions(+), 204 deletions(-)

diff --git a/drivers/isdn/hardware/eicon/capifunc.c b/drivers/isdn/hardware/eicon/capifunc.c
index 7a0bdbd..c345286 100644
--- a/drivers/isdn/hardware/eicon/capifunc.c
+++ b/drivers/isdn/hardware/eicon/capifunc.c
@@ -390,6 +390,7 @@ static void clean_adapter(int id, struct list_head *free_mem_q)
  */
 static void divacapi_remove_card(DESCRIPTOR *d)
 {
+	unsigned int bh;
 	diva_card *card = NULL;
 	diva_os_spin_lock_magic_t old_irql;
 	LIST_HEAD(free_mem_q);
@@ -401,7 +402,7 @@ static void divacapi_remove_card(DESCRIPTOR *d)
 	 * Ensures that there is no call from sendf to CAPI in
 	 * the time CAPI controller is about to be removed.
 	 */
-	diva_os_enter_spin_lock(&api_lock, &old_irql, "remove card");
+	bh = diva_os_enter_spin_lock(&api_lock, &old_irql, "remove card");
 	list_for_each(tmp, &cards) {
 		card = list_entry(tmp, diva_card, list);
 		if (card->d.request == d->request) {
@@ -410,7 +411,7 @@ static void divacapi_remove_card(DESCRIPTOR *d)
 			break;
 		}
 	}
-	diva_os_leave_spin_lock(&api_lock, &old_irql, "remove card");
+	diva_os_leave_spin_lock(&api_lock, &old_irql, "remove card", bh);
 
 	if (card) {
 		/*
@@ -423,7 +424,7 @@ static void divacapi_remove_card(DESCRIPTOR *d)
 		 * Now get API lock (to ensure stable state of LI tables)
 		 * and update the adapter map/LI table.
 		 */
-		diva_os_enter_spin_lock(&api_lock, &old_irql, "remove card");
+		bh = diva_os_enter_spin_lock(&api_lock, &old_irql, "remove card");
 
 		clean_adapter(card->Id - 1, &free_mem_q);
 		DBG_TRC(("DelAdapterMap (%d) -> (%d)",
@@ -431,7 +432,7 @@ static void divacapi_remove_card(DESCRIPTOR *d)
 			ControllerMap[card->Id] = 0;
 		DBG_TRC(("adapter remove, max_adapter=%d",
 			 max_adapter));
-		diva_os_leave_spin_lock(&api_lock, &old_irql, "remove card");
+		diva_os_leave_spin_lock(&api_lock, &old_irql, "remove card", bh);
 
 		/* After releasing the lock, we can free the memory */
 		diva_os_free(0, card);
@@ -449,13 +450,14 @@ static void divacapi_remove_card(DESCRIPTOR *d)
  */
 static void divacapi_remove_cards(void)
 {
+	unsigned int bh;
 	DESCRIPTOR d;
 	struct list_head *tmp;
 	diva_card *card;
 	diva_os_spin_lock_magic_t old_irql;
 
 rescan:
-	diva_os_enter_spin_lock(&api_lock, &old_irql, "remove cards");
+	bh = diva_os_enter_spin_lock(&api_lock, &old_irql, "remove cards");
 	list_for_each(tmp, &cards) {
 		card = list_entry(tmp, diva_card, list);
 		diva_os_leave_spin_lock(&api_lock, &old_irql, "remove cards");
@@ -463,7 +465,7 @@ static void divacapi_remove_cards(void)
 		divacapi_remove_card(&d);
 		goto rescan;
 	}
-	diva_os_leave_spin_lock(&api_lock, &old_irql, "remove cards");
+	diva_os_leave_spin_lock(&api_lock, &old_irql, "remove cards", bh);
 }
 
 /*
@@ -471,13 +473,15 @@ static void divacapi_remove_cards(void)
  */
 static void sync_callback(ENTITY *e)
 {
+	unsigned int bh;
 	diva_os_spin_lock_magic_t old_irql;
 
 	DBG_TRC(("cb:Id=%x,Rc=%x,Ind=%x", e->Id, e->Rc, e->Ind))
 
-		diva_os_enter_spin_lock(&api_lock, &old_irql, "sync_callback");
+		bh = diva_os_enter_spin_lock(&api_lock, &old_irql,
+					     "sync_callback");
 	callback(e);
-	diva_os_leave_spin_lock(&api_lock, &old_irql, "sync_callback");
+	diva_os_leave_spin_lock(&api_lock, &old_irql, "sync_callback", bh);
 }
 
 /*
@@ -485,6 +489,7 @@ static void sync_callback(ENTITY *e)
  */
 static int diva_add_card(DESCRIPTOR *d)
 {
+	unsigned int bh;
 	int k = 0, i = 0;
 	diva_os_spin_lock_magic_t old_irql;
 	diva_card *card = NULL;
@@ -521,9 +526,9 @@ static int diva_add_card(DESCRIPTOR *d)
 		return (0);
 	}
 
-	diva_os_enter_spin_lock(&api_lock, &old_irql, "find id");
+	bh = diva_os_enter_spin_lock(&api_lock, &old_irql, "find id");
 	card->Id = find_free_id();
-	diva_os_leave_spin_lock(&api_lock, &old_irql, "find id");
+	diva_os_leave_spin_lock(&api_lock, &old_irql, "find id", bh);
 
 	strlcpy(ctrl->manu, M_COMPANY, sizeof(ctrl->manu));
 	ctrl->version.majorversion = 2;
@@ -630,7 +635,7 @@ static int diva_add_card(DESCRIPTOR *d)
 	}
 
 	/* Prevent access to line interconnect table in process update */
-	diva_os_enter_spin_lock(&api_lock, &old_irql, "add card");
+	bh = diva_os_enter_spin_lock(&api_lock, &old_irql, "add card");
 
 	j = 0;
 	for (i = 0; i < k; i++) {
@@ -686,7 +691,7 @@ static int diva_add_card(DESCRIPTOR *d)
 	list_add(&(card->list), &cards);
 	AutomaticLaw(a);
 
-	diva_os_leave_spin_lock(&api_lock, &old_irql, "add card");
+	diva_os_leave_spin_lock(&api_lock, &old_irql, "add card", bh);
 
 	if (mem_to_free) {
 		diva_os_free(0, mem_to_free);
@@ -733,6 +738,7 @@ static void diva_register_appl(struct capi_ctr *ctrl, __u16 appl,
 	diva_os_spin_lock_magic_t old_irql;
 	unsigned int mem_len;
 	int nconn = rp->level3cnt;
+	unsigned int bh;
 
 
 	if (diva_os_in_irq()) {
@@ -809,7 +815,7 @@ static void diva_register_appl(struct capi_ctr *ctrl, __u16 appl,
 	}
 
 	/* initialize application data */
-	diva_os_enter_spin_lock(&api_lock, &old_irql, "register_appl");
+	bh = diva_os_enter_spin_lock(&api_lock, &old_irql, "register_appl");
 
 	this = &application[appl - 1];
 	memset(this, 0, sizeof(APPL));
@@ -838,7 +844,7 @@ static void diva_register_appl(struct capi_ctr *ctrl, __u16 appl,
 	}
 
 	CapiRegister(this->Id);
-	diva_os_leave_spin_lock(&api_lock, &old_irql, "register_appl");
+	diva_os_leave_spin_lock(&api_lock, &old_irql, "register_appl", bh);
 
 }
 
@@ -847,6 +853,7 @@ static void diva_register_appl(struct capi_ctr *ctrl, __u16 appl,
  */
 static void diva_release_appl(struct capi_ctr *ctrl, __u16 appl)
 {
+	unsigned int bh;
 	diva_os_spin_lock_magic_t old_irql;
 	APPL *this = &application[appl - 1];
 	void *mem_to_free = NULL;
@@ -858,14 +865,14 @@ static void diva_release_appl(struct capi_ctr *ctrl, __u16 appl)
 				return;
 		}
 
-	diva_os_enter_spin_lock(&api_lock, &old_irql, "release_appl");
+	bh = diva_os_enter_spin_lock(&api_lock, &old_irql, "release_appl");
 	if (this->Id) {
 		CapiRelease(this->Id);
 		mem_to_free = this->DataNCCI;
 		this->DataNCCI = NULL;
 		this->Id = 0;
 	}
-	diva_os_leave_spin_lock(&api_lock, &old_irql, "release_appl");
+	diva_os_leave_spin_lock(&api_lock, &old_irql, "release_appl", bh);
 
 	if (mem_to_free)
 		diva_os_free(0, mem_to_free);
@@ -888,6 +895,7 @@ static u16 diva_send_message(struct capi_ctr *ctrl,
 	word clength = GET_WORD(&msg->header.length);
 	word command = GET_WORD(&msg->header.command);
 	u16 retval = CAPI_NOERROR;
+	unsigned int bh;
 
 	if (diva_os_in_irq()) {
 		DBG_ERR(("CAPI_SEND_MSG - in irq context !"))
@@ -900,10 +908,10 @@ static u16 diva_send_message(struct capi_ctr *ctrl,
 				return CAPI_REGOSRESOURCEERR;
 		}
 
-	diva_os_enter_spin_lock(&api_lock, &old_irql, "send message");
+	bh = diva_os_enter_spin_lock(&api_lock, &old_irql, "send message");
 
 	if (!this->Id) {
-		diva_os_leave_spin_lock(&api_lock, &old_irql, "send message");
+		diva_os_leave_spin_lock(&api_lock, &old_irql, "send message", bh);
 		return CAPI_ILLAPPNR;
 	}
 
@@ -997,7 +1005,7 @@ static u16 diva_send_message(struct capi_ctr *ctrl,
 	}
 
 write_end:
-	diva_os_leave_spin_lock(&api_lock, &old_irql, "send message");
+	diva_os_leave_spin_lock(&api_lock, &old_irql, "send message", bh);
 	if (retval == CAPI_NOERROR)
 		diva_os_free_message_buffer(dmb);
 	return retval;
@@ -1163,13 +1171,16 @@ static void remove_main_structs(void)
  */
 static void do_api_remove_start(void)
 {
+	unsigned int bh;
 	diva_os_spin_lock_magic_t old_irql;
 	int ret = 1, count = 100;
 
 	do {
-		diva_os_enter_spin_lock(&api_lock, &old_irql, "api remove start");
+		bh = diva_os_enter_spin_lock(&api_lock, &old_irql,
+					     "api remove start");
 		ret = api_remove_start();
-		diva_os_leave_spin_lock(&api_lock, &old_irql, "api remove start");
+		diva_os_leave_spin_lock(&api_lock, &old_irql,
+					"api remove start", bh);
 
 		diva_os_sleep(10);
 	} while (ret && count--);
diff --git a/drivers/isdn/hardware/eicon/dadapter.c b/drivers/isdn/hardware/eicon/dadapter.c
index 5142099..842c1f1 100644
--- a/drivers/isdn/hardware/eicon/dadapter.c
+++ b/drivers/isdn/hardware/eicon/dadapter.c
@@ -106,6 +106,7 @@ void diva_didd_load_time_finit(void) {
    return -1 adapter array overflow
    -------------------------------------------------------------------------- */
 static int diva_didd_add_descriptor(DESCRIPTOR *d) {
+	unsigned int bh;
 	diva_os_spin_lock_magic_t      irql;
 	int i;
 	if (d->type == IDI_DIMAINT) {
@@ -123,16 +124,17 @@ static int diva_didd_add_descriptor(DESCRIPTOR *d) {
 		return (NEW_MAX_DESCRIPTORS);
 	}
 	for (i = 0; i < NEW_MAX_DESCRIPTORS; i++) {
-		diva_os_enter_spin_lock(&didd_spin, &irql, "didd_add");
+		bh = diva_os_enter_spin_lock(&didd_spin, &irql, "didd_add");
 		if (HandleTable[i].type == 0) {
 			memcpy(&HandleTable[i], d, sizeof(*d));
 			Adapters++;
-			diva_os_leave_spin_lock(&didd_spin, &irql, "didd_add");
+			diva_os_leave_spin_lock(&didd_spin, &irql, "didd_add",
+						bh);
 			diva_notify_adapter_change(d, 0); /* we have new adapter */
 			DBG_TRC(("Add adapter[%d], request=%08x", (i + 1), d->request))
 				return (i + 1);
 		}
-		diva_os_leave_spin_lock(&didd_spin, &irql, "didd_add");
+		diva_os_leave_spin_lock(&didd_spin, &irql, "didd_add", bh);
 	}
 	DBG_ERR(("Can't add adapter, out of resources"))
 		return (-1);
@@ -143,6 +145,7 @@ static int diva_didd_add_descriptor(DESCRIPTOR *d) {
    return 0 on success
    -------------------------------------------------------------------------- */
 static int diva_didd_remove_descriptor(IDI_CALL request) {
+	unsigned int bh;
 	diva_os_spin_lock_magic_t      irql;
 	int i;
 	if (request == MAdapter.request) {
@@ -155,10 +158,12 @@ static int diva_didd_remove_descriptor(IDI_CALL request) {
 	for (i = 0; (Adapters && (i < NEW_MAX_DESCRIPTORS)); i++) {
 		if (HandleTable[i].request == request) {
 			diva_notify_adapter_change(&HandleTable[i], 1); /* About to remove */
-			diva_os_enter_spin_lock(&didd_spin, &irql, "didd_rm");
+			bh = diva_os_enter_spin_lock(&didd_spin, &irql,
+						     "didd_rm");
 			memset(&HandleTable[i], 0x00, sizeof(HandleTable[0]));
 			Adapters--;
-			diva_os_leave_spin_lock(&didd_spin, &irql, "didd_rm");
+			diva_os_leave_spin_lock(&didd_spin, &irql, "didd_rm",
+						bh);
 			DBG_TRC(("Remove adapter[%d], request=%08x", (i + 1), request))
 				return (0);
 		}
@@ -171,13 +176,14 @@ static int diva_didd_remove_descriptor(IDI_CALL request) {
    return 1 if not enough space to save all available adapters
    -------------------------------------------------------------------------- */
 static int diva_didd_read_adapter_array(DESCRIPTOR *buffer, int length) {
+	unsigned int bh;
 	diva_os_spin_lock_magic_t      irql;
 	int src, dst;
 	memset(buffer, 0x00, length);
 	length /= sizeof(DESCRIPTOR);
 	DBG_TRC(("DIDD_Read, space = %d, Adapters = %d", length, Adapters + 2))
 
-		diva_os_enter_spin_lock(&didd_spin, &irql, "didd_read");
+		bh = diva_os_enter_spin_lock(&didd_spin, &irql, "didd_read");
 	for (src = 0, dst = 0;
 	     (Adapters && (src < NEW_MAX_DESCRIPTORS) && (dst < length));
 	     src++) {
@@ -186,7 +192,7 @@ static int diva_didd_read_adapter_array(DESCRIPTOR *buffer, int length) {
 			dst++;
 		}
 	}
-	diva_os_leave_spin_lock(&didd_spin, &irql, "didd_read");
+	diva_os_leave_spin_lock(&didd_spin, &irql, "didd_read", bh);
 	if (dst < length) {
 		memcpy(&buffer[dst], &MAdapter, sizeof(DESCRIPTOR));
 		dst++;
@@ -268,19 +274,22 @@ static void IDI_CALL_LINK_T diva_dadapter_request(	\
 static dword diva_register_adapter_callback(		\
 	didd_adapter_change_callback_t callback,
 	void IDI_CALL_ENTITY_T *context) {
+	unsigned int bh;
 	diva_os_spin_lock_magic_t irql;
 	dword i;
 
 	for (i = 0; i < DIVA_DIDD_MAX_NOTIFICATIONS; i++) {
-		diva_os_enter_spin_lock(&didd_spin, &irql, "didd_nfy_add");
+		bh = diva_os_enter_spin_lock(&didd_spin, &irql,
+				             "didd_nfy_add");
 		if (!NotificationTable[i].callback) {
 			NotificationTable[i].callback = callback;
 			NotificationTable[i].context = context;
-			diva_os_leave_spin_lock(&didd_spin, &irql, "didd_nfy_add");
+			diva_os_leave_spin_lock(&didd_spin, &irql,
+						"didd_nfy_add", bh);
 			DBG_TRC(("Register adapter notification[%d]=%08x", i + 1, callback))
 				return (i + 1);
 		}
-		diva_os_leave_spin_lock(&didd_spin, &irql, "didd_nfy_add");
+		diva_os_leave_spin_lock(&didd_spin, &irql, "didd_nfy_add", bh);
 	}
 	DBG_ERR(("Can't register adapter notification, overflow"))
 		return (0);
@@ -289,12 +298,13 @@ static dword diva_register_adapter_callback(		\
    IDI client does register his notification function
    -------------------------------------------------------------------------- */
 static void diva_remove_adapter_callback(dword handle) {
+	unsigned int bh;
 	diva_os_spin_lock_magic_t irql;
 	if (handle && ((--handle) < DIVA_DIDD_MAX_NOTIFICATIONS)) {
-		diva_os_enter_spin_lock(&didd_spin, &irql, "didd_nfy_rm");
+		bh = diva_os_enter_spin_lock(&didd_spin, &irql, "didd_nfy_rm");
 		NotificationTable[handle].callback = NULL;
 		NotificationTable[handle].context  = NULL;
-		diva_os_leave_spin_lock(&didd_spin, &irql, "didd_nfy_rm");
+		diva_os_leave_spin_lock(&didd_spin, &irql, "didd_nfy_rm", bh);
 		DBG_TRC(("Remove adapter notification[%d]", (int)(handle + 1)))
 			return;
 	}
@@ -307,17 +317,18 @@ static void diva_remove_adapter_callback(dword handle) {
    Step 2: Read Adapter Array
    -------------------------------------------------------------------------- */
 static void diva_notify_adapter_change(DESCRIPTOR *d, int removal) {
+	unsigned int bh;
 	int i, do_notify;
 	didd_adapter_change_notification_t nfy;
 	diva_os_spin_lock_magic_t irql;
 	for (i = 0; i < DIVA_DIDD_MAX_NOTIFICATIONS; i++) {
 		do_notify = 0;
-		diva_os_enter_spin_lock(&didd_spin, &irql, "didd_nfy");
+		bh = diva_os_enter_spin_lock(&didd_spin, &irql, "didd_nfy");
 		if (NotificationTable[i].callback) {
 			memcpy(&nfy, &NotificationTable[i], sizeof(nfy));
 			do_notify = 1;
 		}
-		diva_os_leave_spin_lock(&didd_spin, &irql, "didd_nfy");
+		diva_os_leave_spin_lock(&didd_spin, &irql, "didd_nfy", bh);
 		if (do_notify) {
 			(*(nfy.callback))(nfy.context, d, removal);
 		}
diff --git a/drivers/isdn/hardware/eicon/debug.c b/drivers/isdn/hardware/eicon/debug.c
index 3017881..cbfcd5c 100644
--- a/drivers/isdn/hardware/eicon/debug.c
+++ b/drivers/isdn/hardware/eicon/debug.c
@@ -307,19 +307,20 @@ dword diva_dbg_q_length(void) {
   entry.
 */
 diva_dbg_entry_head_t *diva_maint_get_message(word *size,
-					      diva_os_spin_lock_magic_t *old_irql) {
+					      diva_os_spin_lock_magic_t *old_irql,
+					      unsigned int *bh) {
 	diva_dbg_entry_head_t *pmsg = NULL;
 
-	diva_os_enter_spin_lock(&dbg_q_lock, old_irql, "read");
+	*bh = diva_os_enter_spin_lock(&dbg_q_lock, old_irql, "read");
 	if (dbg_q_busy) {
-		diva_os_leave_spin_lock(&dbg_q_lock, old_irql, "read_busy");
+		diva_os_leave_spin_lock(&dbg_q_lock, old_irql, "read_busy", *bh);
 		return NULL;
 	}
 	dbg_q_busy = 1;
 
 	if (!(pmsg = (diva_dbg_entry_head_t *)queuePeekMsg(dbg_queue, size))) {
 		dbg_q_busy = 0;
-		diva_os_leave_spin_lock(&dbg_q_lock, old_irql, "read_empty");
+		diva_os_leave_spin_lock(&dbg_q_lock, old_irql, "read_empty", *bh);
 	}
 
 	return (pmsg);
@@ -330,7 +331,8 @@ diva_dbg_entry_head_t *diva_maint_get_message(word *size,
   acknowledge last message and unlock queue
 */
 void diva_maint_ack_message(int do_release,
-			    diva_os_spin_lock_magic_t *old_irql) {
+			    diva_os_spin_lock_magic_t *old_irql,
+			    unsigned int bh) {
 	if (!dbg_q_busy) {
 		return;
 	}
@@ -338,7 +340,7 @@ void diva_maint_ack_message(int do_release,
 		queueFreeMsg(dbg_queue);
 	}
 	dbg_q_busy = 0;
-	diva_os_leave_spin_lock(&dbg_q_lock, old_irql, "read_ack");
+	diva_os_leave_spin_lock(&dbg_q_lock, old_irql, "read_ack", bh);
 }
 
 
@@ -369,6 +371,7 @@ void diva_maint_prtComp(char *format, ...) {
 }
 
 static void DI_register(void *arg) {
+	unsigned int bh;
 	diva_os_spin_lock_magic_t old_irql;
 	dword sec, usec;
 	pDbgHandle	hDbg;
@@ -386,14 +389,15 @@ static void DI_register(void *arg) {
 		return;
 	}
 
-	diva_os_enter_spin_lock(&dbg_q_lock, &old_irql, "register");
+	bh = diva_os_enter_spin_lock(&dbg_q_lock, &old_irql, "register");
 
 	for (id = 1; id < ARRAY_SIZE(clients); id++) {
 		if (clients[id].hDbg == hDbg) {
 			/*
 			  driver already registered
 			*/
-			diva_os_leave_spin_lock(&dbg_q_lock, &old_irql, "register");
+			diva_os_leave_spin_lock(&dbg_q_lock, &old_irql,
+						"register", bh);
 			return;
 		}
 		if (clients[id].hDbg) { /* slot is busy */
@@ -476,7 +480,7 @@ static void DI_register(void *arg) {
 		}
 	}
 
-	diva_os_leave_spin_lock(&dbg_q_lock, &old_irql, "register");
+	diva_os_leave_spin_lock(&dbg_q_lock, &old_irql, "register", bh);
 }
 
 static void DI_deregister(pDbgHandle hDbg) {
@@ -485,11 +489,12 @@ static void DI_deregister(pDbgHandle hDbg) {
 	int i;
 	word size;
 	byte *pmem = NULL;
+	unsigned int bh, bh2;
 
 	diva_os_get_time(&sec, &usec);
 
-	diva_os_enter_spin_lock(&dbg_adapter_lock, &old_irql1, "read");
-	diva_os_enter_spin_lock(&dbg_q_lock, &old_irql, "read");
+	bh = diva_os_enter_spin_lock(&dbg_adapter_lock, &old_irql1, "read");
+	bh2 = diva_os_enter_spin_lock(&dbg_q_lock, &old_irql, "read");
 
 	for (i = 1; i < ARRAY_SIZE(clients); i++) {
 		if (clients[i].hDbg == hDbg) {
@@ -551,8 +556,8 @@ static void DI_deregister(pDbgHandle hDbg) {
 		}
 	}
 
-	diva_os_leave_spin_lock(&dbg_q_lock, &old_irql, "read_ack");
-	diva_os_leave_spin_lock(&dbg_adapter_lock, &old_irql1, "read_ack");
+	diva_os_leave_spin_lock(&dbg_q_lock, &old_irql, "read_ack", bh2);
+	diva_os_leave_spin_lock(&dbg_adapter_lock, &old_irql1, "read_ack", bh);
 
 	if (pmem) {
 		diva_os_free(0, pmem);
@@ -571,6 +576,7 @@ static void DI_format(int do_lock,
 		      int type,
 		      char *format,
 		      va_list ap) {
+	unsigned int bh;
 	diva_os_spin_lock_magic_t old_irql;
 	dword sec, usec;
 	diva_dbg_entry_head_t *pmsg = NULL;
@@ -595,7 +601,7 @@ static void DI_format(int do_lock,
 	diva_os_get_time(&sec, &usec);
 
 	if (do_lock) {
-		diva_os_enter_spin_lock(&dbg_q_lock, &old_irql, "format");
+		bh = diva_os_enter_spin_lock(&dbg_q_lock, &old_irql, "format");
 	}
 
 	switch (type) {
@@ -720,7 +726,7 @@ static void DI_format(int do_lock,
 	}
 
 	if (do_lock) {
-		diva_os_leave_spin_lock(&dbg_q_lock, &old_irql, "format");
+		diva_os_leave_spin_lock(&dbg_q_lock, &old_irql, "format", bh);
 	}
 }
 
@@ -728,6 +734,7 @@ static void DI_format(int do_lock,
   Write driver ID and driver revision to callers buffer
 */
 int diva_get_driver_info(dword id, byte *data, int data_length) {
+	unsigned int bh;
 	diva_os_spin_lock_magic_t old_irql;
 	byte *p = data;
 	int to_copy;
@@ -737,7 +744,7 @@ int diva_get_driver_info(dword id, byte *data, int data_length) {
 		return (-1);
 	}
 
-	diva_os_enter_spin_lock(&dbg_q_lock, &old_irql, "driver info");
+	bh = diva_os_enter_spin_lock(&dbg_q_lock, &old_irql, "driver info");
 
 	if (clients[id].hDbg) {
 		*p++ = 1;
@@ -774,19 +781,20 @@ int diva_get_driver_info(dword id, byte *data, int data_length) {
 	}
 	*p++ = 0;
 
-	diva_os_leave_spin_lock(&dbg_q_lock, &old_irql, "driver info");
+	diva_os_leave_spin_lock(&dbg_q_lock, &old_irql, "driver info", bh);
 
 	return (p - data);
 }
 
 int diva_get_driver_dbg_mask(dword id, byte *data) {
+	unsigned int bh;
 	diva_os_spin_lock_magic_t old_irql;
 	int ret = -1;
 
 	if (!data || !id || (id >= ARRAY_SIZE(clients))) {
 		return (-1);
 	}
-	diva_os_enter_spin_lock(&dbg_q_lock, &old_irql, "driver info");
+	bh = diva_os_enter_spin_lock(&dbg_q_lock, &old_irql, "driver info");
 
 	if (clients[id].hDbg) {
 		ret = 4;
@@ -796,12 +804,13 @@ int diva_get_driver_dbg_mask(dword id, byte *data) {
 		*data++ = (byte)(clients[id].hDbg->dbgMask >> 24);
 	}
 
-	diva_os_leave_spin_lock(&dbg_q_lock, &old_irql, "driver info");
+	diva_os_leave_spin_lock(&dbg_q_lock, &old_irql, "driver info", bh);
 
 	return (ret);
 }
 
 int diva_set_driver_dbg_mask(dword id, dword mask) {
+	unsigned int bh, bh2;
 	diva_os_spin_lock_magic_t old_irql, old_irql1;
 	int ret = -1;
 
@@ -810,8 +819,9 @@ int diva_set_driver_dbg_mask(dword id, dword mask) {
 		return (-1);
 	}
 
-	diva_os_enter_spin_lock(&dbg_adapter_lock, &old_irql1, "dbg mask");
-	diva_os_enter_spin_lock(&dbg_q_lock, &old_irql, "dbg mask");
+	bh = diva_os_enter_spin_lock(&dbg_adapter_lock, &old_irql1,
+				     "dbg mask");
+	bh2 = diva_os_enter_spin_lock(&dbg_q_lock, &old_irql, "dbg mask");
 
 	if (clients[id].hDbg) {
 		dword old_mask = clients[id].hDbg->dbgMask;
@@ -823,14 +833,14 @@ int diva_set_driver_dbg_mask(dword id, dword mask) {
 	}
 
 
-	diva_os_leave_spin_lock(&dbg_q_lock, &old_irql, "dbg mask");
+	diva_os_leave_spin_lock(&dbg_q_lock, &old_irql, "dbg mask", bh2);
 
 	if (clients[id].request_pending) {
 		clients[id].request_pending = 0;
 		(*(clients[id].request))((ENTITY *)(*(clients[id].pIdiLib->DivaSTraceGetHandle))(clients[id].pIdiLib->hLib));
 	}
 
-	diva_os_leave_spin_lock(&dbg_adapter_lock, &old_irql1, "dbg mask");
+	diva_os_leave_spin_lock(&dbg_adapter_lock, &old_irql1, "dbg mask", bh);
 
 	return (ret);
 }
@@ -856,6 +866,7 @@ static int diva_get_idi_adapter_info(IDI_CALL request, dword *serial, dword *log
   Register XDI adapter as MAINT compatible driver
 */
 void diva_mnt_add_xdi_adapter(const DESCRIPTOR *d) {
+	unsigned int bh, bh2;
 	diva_os_spin_lock_magic_t old_irql, old_irql1;
 	dword sec, usec, logical, serial, org_mask;
 	int id, free_id = -1;
@@ -881,13 +892,15 @@ void diva_mnt_add_xdi_adapter(const DESCRIPTOR *d) {
 	}
 	memset(pmem, 0x00, DivaSTraceGetMemotyRequirement(d->channels));
 
-	diva_os_enter_spin_lock(&dbg_adapter_lock, &old_irql1, "register");
-	diva_os_enter_spin_lock(&dbg_q_lock, &old_irql, "register");
+	bh = diva_os_enter_spin_lock(&dbg_adapter_lock, &old_irql1,
+				     "register");
+	bh2 = diva_os_enter_spin_lock(&dbg_q_lock, &old_irql, "register");
 
 	for (id = 1; id < ARRAY_SIZE(clients); id++) {
 		if (clients[id].hDbg && (clients[id].request == d->request)) {
-			diva_os_leave_spin_lock(&dbg_q_lock, &old_irql, "register");
-			diva_os_leave_spin_lock(&dbg_adapter_lock, &old_irql1, "register");
+			diva_os_leave_spin_lock(&dbg_q_lock, &old_irql, "register", bh2);
+			diva_os_leave_spin_lock(&dbg_adapter_lock, &old_irql1,
+						"register", bh);
 			diva_os_free(0, pmem);
 			return;
 		}
@@ -908,8 +921,9 @@ void diva_mnt_add_xdi_adapter(const DESCRIPTOR *d) {
 	}
 
 	if (free_id < 0) {
-		diva_os_leave_spin_lock(&dbg_q_lock, &old_irql, "register");
-		diva_os_leave_spin_lock(&dbg_adapter_lock, &old_irql1, "register");
+		diva_os_leave_spin_lock(&dbg_q_lock, &old_irql, "register", bh2);
+		diva_os_leave_spin_lock(&dbg_adapter_lock, &old_irql1,
+					"register", bh);
 		diva_os_free(0, pmem);
 		return;
 	}
@@ -967,8 +981,9 @@ void diva_mnt_add_xdi_adapter(const DESCRIPTOR *d) {
 		clients[id].request = NULL;
 		clients[id].request_pending = 0;
 		clients[id].hDbg    = NULL;
-		diva_os_leave_spin_lock(&dbg_q_lock, &old_irql, "register");
-		diva_os_leave_spin_lock(&dbg_adapter_lock, &old_irql1, "register");
+		diva_os_leave_spin_lock(&dbg_q_lock, &old_irql, "register", bh2);
+		diva_os_leave_spin_lock(&dbg_adapter_lock, &old_irql1,
+					"register", bh);
 		diva_os_free(0, pmem);
 		return;
 	}
@@ -1006,14 +1021,14 @@ void diva_mnt_add_xdi_adapter(const DESCRIPTOR *d) {
 	org_mask = clients[id].Dbg.dbgMask;
 	clients[id].Dbg.dbgMask = 0;
 
-	diva_os_leave_spin_lock(&dbg_q_lock, &old_irql, "register");
+	diva_os_leave_spin_lock(&dbg_q_lock, &old_irql, "register", bh2);
 
 	if (clients[id].request_pending) {
 		clients[id].request_pending = 0;
 		(*(clients[id].request))((ENTITY *)(*(clients[id].pIdiLib->DivaSTraceGetHandle))(clients[id].pIdiLib->hLib));
 	}
 
-	diva_os_leave_spin_lock(&dbg_adapter_lock, &old_irql1, "register");
+	diva_os_leave_spin_lock(&dbg_adapter_lock, &old_irql1, "register", bh);
 
 	diva_set_driver_dbg_mask(id, org_mask);
 }
@@ -1027,11 +1042,12 @@ void diva_mnt_remove_xdi_adapter(const DESCRIPTOR *d) {
 	int i;
 	word size;
 	byte *pmem = NULL;
+	unsigned int bh, bh2;
 
 	diva_os_get_time(&sec, &usec);
 
-	diva_os_enter_spin_lock(&dbg_adapter_lock, &old_irql1, "read");
-	diva_os_enter_spin_lock(&dbg_q_lock, &old_irql, "read");
+	bh = diva_os_enter_spin_lock(&dbg_adapter_lock, &old_irql1, "read");
+	bh2 = diva_os_enter_spin_lock(&dbg_q_lock, &old_irql, "read");
 
 	for (i = 1; i < ARRAY_SIZE(clients); i++) {
 		if (clients[i].hDbg && (clients[i].request == d->request)) {
@@ -1094,8 +1110,8 @@ void diva_mnt_remove_xdi_adapter(const DESCRIPTOR *d) {
 		}
 	}
 
-	diva_os_leave_spin_lock(&dbg_q_lock, &old_irql, "read_ack");
-	diva_os_leave_spin_lock(&dbg_adapter_lock, &old_irql1, "read_ack");
+	diva_os_leave_spin_lock(&dbg_q_lock, &old_irql, "read_ack", bh2);
+	diva_os_leave_spin_lock(&dbg_adapter_lock, &old_irql1, "read_ack", bh);
 
 	if (pmem) {
 		diva_os_free(0, pmem);
@@ -1355,13 +1371,14 @@ static void single_p(byte *P, word *PLength, byte Id) {
 }
 
 static void diva_maint_xdi_cb(ENTITY *e) {
+	unsigned int bh, bh2;
 	diva_strace_context_t *pLib = DIVAS_CONTAINING_RECORD(e, diva_strace_context_t, e);
 	diva_maint_client_t *pC;
 	diva_os_spin_lock_magic_t old_irql, old_irql1;
 
 
-	diva_os_enter_spin_lock(&dbg_adapter_lock, &old_irql1, "xdi_cb");
-	diva_os_enter_spin_lock(&dbg_q_lock, &old_irql, "xdi_cb");
+	bh = diva_os_enter_spin_lock(&dbg_adapter_lock, &old_irql1, "xdi_cb");
+	bh2 = diva_os_enter_spin_lock(&dbg_q_lock, &old_irql, "xdi_cb");
 
 	pC = (diva_maint_client_t *)pLib->hAdapter;
 
@@ -1378,7 +1395,7 @@ static void diva_maint_xdi_cb(ENTITY *e) {
 		}
 	}
 
-	diva_os_leave_spin_lock(&dbg_q_lock, &old_irql, "xdi_cb");
+	diva_os_leave_spin_lock(&dbg_q_lock, &old_irql, "xdi_cb", bh2);
 
 
 	if (pC->request_pending) {
@@ -1386,7 +1403,7 @@ static void diva_maint_xdi_cb(ENTITY *e) {
 		(*(pC->request))(e);
 	}
 
-	diva_os_leave_spin_lock(&dbg_adapter_lock, &old_irql1, "xdi_cb");
+	diva_os_leave_spin_lock(&dbg_adapter_lock, &old_irql1, "xdi_cb", bh);
 }
 
 
@@ -1916,6 +1933,7 @@ void diva_mnt_internal_dprintf(dword drv_id, dword type, char *fmt, ...) {
   Shutdown all adapters before driver removal
 */
 int diva_mnt_shutdown_xdi_adapters(void) {
+	unsigned int bh, bh2;
 	diva_os_spin_lock_magic_t old_irql, old_irql1;
 	int i, fret = 0;
 	byte *pmem;
@@ -1924,8 +1942,9 @@ int diva_mnt_shutdown_xdi_adapters(void) {
 	for (i = 1; i < ARRAY_SIZE(clients); i++) {
 		pmem = NULL;
 
-		diva_os_enter_spin_lock(&dbg_adapter_lock, &old_irql1, "unload");
-		diva_os_enter_spin_lock(&dbg_q_lock, &old_irql, "unload");
+		bh = diva_os_enter_spin_lock(&dbg_adapter_lock, &old_irql1,
+					     "unload");
+		bh2 = diva_os_enter_spin_lock(&dbg_q_lock, &old_irql, "unload");
 
 		if (clients[i].hDbg && clients[i].pIdiLib && clients[i].request) {
 			if ((*(clients[i].pIdiLib->DivaSTraceLibraryStop))(clients[i].pIdiLib) == 1) {
@@ -1955,7 +1974,7 @@ int diva_mnt_shutdown_xdi_adapters(void) {
 			}
 		}
 
-		diva_os_leave_spin_lock(&dbg_q_lock, &old_irql, "unload");
+		diva_os_leave_spin_lock(&dbg_q_lock, &old_irql, "unload", bh2);
 		if (clients[i].hDbg && clients[i].pIdiLib && clients[i].request && clients[i].request_pending) {
 			clients[i].request_pending = 0;
 			(*(clients[i].request))((ENTITY *)(*(clients[i].pIdiLib->DivaSTraceGetHandle))(clients[i].pIdiLib->hLib));
@@ -1964,7 +1983,8 @@ int diva_mnt_shutdown_xdi_adapters(void) {
 				clients[i].dma_handle = -1;
 			}
 		}
-		diva_os_leave_spin_lock(&dbg_adapter_lock, &old_irql1, "unload");
+		diva_os_leave_spin_lock(&dbg_adapter_lock, &old_irql1,
+					"unload", bh);
 
 		if (pmem) {
 			diva_os_free(0, pmem);
@@ -1979,11 +1999,13 @@ int diva_mnt_shutdown_xdi_adapters(void) {
   Affects B- and Audio Tap trace mask at run time
 */
 int diva_set_trace_filter(int filter_length, const char *filter) {
+	unsigned int bh, bh2;
 	diva_os_spin_lock_magic_t old_irql, old_irql1;
 	int i, ch, on, client_b_on, client_atap_on;
 
-	diva_os_enter_spin_lock(&dbg_adapter_lock, &old_irql1, "dbg mask");
-	diva_os_enter_spin_lock(&dbg_q_lock, &old_irql, "write_filter");
+	bh = diva_os_enter_spin_lock(&dbg_adapter_lock, &old_irql1,
+				     "dbg mask");
+	bh2 = diva_os_enter_spin_lock(&dbg_q_lock, &old_irql, "write_filter");
 
 	if (filter_length <= DIVA_MAX_SELECTIVE_FILTER_LENGTH) {
 		memcpy(&TraceFilter[0], filter, filter_length);
@@ -2015,29 +2037,30 @@ int diva_set_trace_filter(int filter_length, const char *filter) {
 
 	for (i = 1; i < ARRAY_SIZE(clients); i++) {
 		if (clients[i].hDbg && clients[i].pIdiLib && clients[i].request && clients[i].request_pending) {
-			diva_os_leave_spin_lock(&dbg_q_lock, &old_irql, "write_filter");
+			diva_os_leave_spin_lock(&dbg_q_lock, &old_irql, "write_filter", bh2);
 			clients[i].request_pending = 0;
 			(*(clients[i].request))((ENTITY *)(*(clients[i].pIdiLib->DivaSTraceGetHandle))(clients[i].pIdiLib->hLib));
-			diva_os_enter_spin_lock(&dbg_q_lock, &old_irql, "write_filter");
+			bh2 = diva_os_enter_spin_lock(&dbg_q_lock, &old_irql, "write_filter");
 		}
 	}
 
-	diva_os_leave_spin_lock(&dbg_q_lock, &old_irql, "write_filter");
-	diva_os_leave_spin_lock(&dbg_adapter_lock, &old_irql1, "dbg mask");
+	diva_os_leave_spin_lock(&dbg_q_lock, &old_irql, "write_filter", bh2);
+	diva_os_leave_spin_lock(&dbg_adapter_lock, &old_irql1, "dbg mask", bh);
 
 	return (filter_length);
 }
 
 int diva_get_trace_filter(int max_length, char *filter) {
+	unsigned int bh;
 	diva_os_spin_lock_magic_t old_irql;
 	int len;
 
-	diva_os_enter_spin_lock(&dbg_q_lock, &old_irql, "read_filter");
+	bh = diva_os_enter_spin_lock(&dbg_q_lock, &old_irql, "read_filter");
 	len = strlen(&TraceFilter[0]) + 1;
 	if (max_length >= len) {
 		memcpy(filter, &TraceFilter[0], len);
 	}
-	diva_os_leave_spin_lock(&dbg_q_lock, &old_irql, "read_filter");
+	diva_os_leave_spin_lock(&dbg_q_lock, &old_irql, "read_filter", bh);
 
 	return (len);
 }
diff --git a/drivers/isdn/hardware/eicon/debug_if.h b/drivers/isdn/hardware/eicon/debug_if.h
index fc5953a..baead0f 100644
--- a/drivers/isdn/hardware/eicon/debug_if.h
+++ b/drivers/isdn/hardware/eicon/debug_if.h
@@ -45,9 +45,11 @@ int diva_maint_init(byte *base, unsigned long length, int do_init);
 void *diva_maint_finit(void);
 dword diva_dbg_q_length(void);
 diva_dbg_entry_head_t *diva_maint_get_message(word *size,
-					      diva_os_spin_lock_magic_t *old_irql);
+					      diva_os_spin_lock_magic_t *old_irql,
+					      unsigned int *bh);
 void diva_maint_ack_message(int do_release,
-			    diva_os_spin_lock_magic_t *old_irql);
+			    diva_os_spin_lock_magic_t *old_irql,
+			    unsigned int bh);
 void diva_maint_prtComp(char *format, ...);
 void diva_maint_wakeup_read(void);
 int diva_get_driver_info(dword id, byte *data, int data_length);
diff --git a/drivers/isdn/hardware/eicon/diva.c b/drivers/isdn/hardware/eicon/diva.c
index 1b25d8b..92e11ea 100644
--- a/drivers/isdn/hardware/eicon/diva.c
+++ b/drivers/isdn/hardware/eicon/diva.c
@@ -166,6 +166,7 @@ static diva_os_xdi_adapter_t *diva_q_get_next(struct list_head *what)
    -------------------------------------------------------------------------- */
 void *diva_driver_add_card(void *pdev, unsigned long CardOrdinal)
 {
+	unsigned int bh;
 	diva_os_spin_lock_magic_t old_irql;
 	diva_os_xdi_adapter_t *pdiva, *pa;
 	int i, j, max, nr;
@@ -189,14 +190,14 @@ void *diva_driver_add_card(void *pdev, unsigned long CardOrdinal)
 				nr = 1;
 			}
 
-			diva_os_enter_spin_lock(&adapter_lock, &old_irql, "add card");
+			bh = diva_os_enter_spin_lock(&adapter_lock, &old_irql, "add card");
 
 			for (i = 0; i < max; i++) {
 				if (!diva_find_free_adapters(i, nr)) {
 					pdiva->controller = i + 1;
 					pdiva->xdi_adapter.ANum = pdiva->controller;
 					IoAdapters[i] = &pdiva->xdi_adapter;
-					diva_os_leave_spin_lock(&adapter_lock, &old_irql, "add card");
+					diva_os_leave_spin_lock(&adapter_lock, &old_irql, "add card", bh);
 					create_adapter_proc(pdiva);	/* add adapter to proc file system */
 
 					DBG_LOG(("add %s:%d",
@@ -204,7 +205,7 @@ void *diva_driver_add_card(void *pdev, unsigned long CardOrdinal)
 						 [CardOrdinal].Name,
 						 pdiva->controller))
 
-						diva_os_enter_spin_lock(&adapter_lock, &old_irql, "add card");
+						bh = diva_os_enter_spin_lock(&adapter_lock, &old_irql, "add card");
 					pa = pdiva;
 					for (j = 1; j < nr; j++) {	/* slave adapters, if any */
 						pa = diva_q_get_next(&pa->link);
@@ -212,23 +213,23 @@ void *diva_driver_add_card(void *pdev, unsigned long CardOrdinal)
 							pa->controller = i + 1 + j;
 							pa->xdi_adapter.ANum = pa->controller;
 							IoAdapters[i + j] = &pa->xdi_adapter;
-							diva_os_leave_spin_lock(&adapter_lock, &old_irql, "add card");
+							diva_os_leave_spin_lock(&adapter_lock, &old_irql, "add card", bh);
 							DBG_LOG(("add slave adapter (%d)",
 								 pa->controller))
 								create_adapter_proc(pa);	/* add adapter to proc file system */
-							diva_os_enter_spin_lock(&adapter_lock, &old_irql, "add card");
+							bh = diva_os_enter_spin_lock(&adapter_lock, &old_irql, "add card");
 						} else {
 							DBG_ERR(("slave adapter problem"))
 								break;
 						}
 					}
 
-					diva_os_leave_spin_lock(&adapter_lock, &old_irql, "add card");
+					diva_os_leave_spin_lock(&adapter_lock, &old_irql, "add card", bh);
 					return (pdiva);
 				}
 			}
 
-			diva_os_leave_spin_lock(&adapter_lock, &old_irql, "add card");
+			diva_os_leave_spin_lock(&adapter_lock, &old_irql, "add card", bh);
 
 			/*
 			  Not able to add adapter - remove it and return error
@@ -260,17 +261,19 @@ int divasa_xdi_driver_entry(void)
    -------------------------------------------------------------------------- */
 static diva_os_xdi_adapter_t *get_and_remove_from_queue(void)
 {
+	unsigned int bh;
 	diva_os_spin_lock_magic_t old_irql;
 	diva_os_xdi_adapter_t *a = NULL;
 
-	diva_os_enter_spin_lock(&adapter_lock, &old_irql, "driver_unload");
+	bh = diva_os_enter_spin_lock(&adapter_lock, &old_irql,
+				     "driver_unload");
 
 	if (!list_empty(&adapter_queue)) {
 		a = list_entry(adapter_queue.next, diva_os_xdi_adapter_t, link);
 		list_del(adapter_queue.next);
 	}
 
-	diva_os_leave_spin_lock(&adapter_lock, &old_irql, "driver_unload");
+	diva_os_leave_spin_lock(&adapter_lock, &old_irql, "driver_unload", bh);
 	return (a);
 }
 
@@ -282,12 +285,13 @@ void diva_driver_remove_card(void *pdiva)
 	diva_os_spin_lock_magic_t old_irql;
 	diva_os_xdi_adapter_t *a[4];
 	diva_os_xdi_adapter_t *pa;
+	unsigned int bh;
 	int i;
 
 	pa = a[0] = (diva_os_xdi_adapter_t *) pdiva;
 	a[1] = a[2] = a[3] = NULL;
 
-	diva_os_enter_spin_lock(&adapter_lock, &old_irql, "remode adapter");
+	bh = diva_os_enter_spin_lock(&adapter_lock, &old_irql, "remode adapter");
 
 	for (i = 1; i < 4; i++) {
 		if ((pa = diva_q_get_next(&pa->link))
@@ -302,7 +306,7 @@ void diva_driver_remove_card(void *pdiva)
 		list_del(&a[i]->link);
 	}
 
-	diva_os_leave_spin_lock(&adapter_lock, &old_irql, "driver_unload");
+	diva_os_leave_spin_lock(&adapter_lock, &old_irql, "driver_unload", bh);
 
 	(*(a[0]->interface.cleanup_adapter_proc)) (a[0]);
 
@@ -326,6 +330,7 @@ static void *divas_create_pci_card(int handle, void *pci_dev_handle)
 	diva_supported_cards_info_t *pI = &divas_supported_cards[handle];
 	diva_os_spin_lock_magic_t old_irql;
 	diva_os_xdi_adapter_t *a;
+	unsigned int bh;
 
 	DBG_LOG(("found %d-%s", pI->CardOrdinal, CardProperties[pI->CardOrdinal].Name))
 
@@ -348,14 +353,14 @@ static void *divas_create_pci_card(int handle, void *pci_dev_handle)
 	  Add master adapter first, so slave adapters will receive higher
 	  numbers as master adapter
 	*/
-	diva_os_enter_spin_lock(&adapter_lock, &old_irql, "found_pci_card");
+	bh = diva_os_enter_spin_lock(&adapter_lock, &old_irql, "found_pci_card");
 	list_add_tail(&a->link, &adapter_queue);
-	diva_os_leave_spin_lock(&adapter_lock, &old_irql, "found_pci_card");
+	diva_os_leave_spin_lock(&adapter_lock, &old_irql, "found_pci_card", bh);
 
 	if ((*(pI->init_card)) (a)) {
-		diva_os_enter_spin_lock(&adapter_lock, &old_irql, "found_pci_card");
+		bh = diva_os_enter_spin_lock(&adapter_lock, &old_irql, "found_pci_card");
 		list_del(&a->link);
-		diva_os_leave_spin_lock(&adapter_lock, &old_irql, "found_pci_card");
+		diva_os_leave_spin_lock(&adapter_lock, &old_irql, "found_pci_card", bh);
 		diva_os_free(0, a);
 		DBG_ERR(("A: can't get adapter resources"));
 		return NULL;
@@ -391,6 +396,7 @@ void *diva_xdi_open_adapter(void *os_handle, const void __user *src,
 			    int length, void *mptr,
 			    divas_xdi_copy_from_user_fn_t cp_fn)
 {
+	unsigned int bh;
 	diva_xdi_um_cfg_cmd_t *msg = (diva_xdi_um_cfg_cmd_t *)mptr;
 	diva_os_xdi_adapter_t *a = NULL;
 	diva_os_spin_lock_magic_t old_irql;
@@ -405,14 +411,14 @@ void *diva_xdi_open_adapter(void *os_handle, const void __user *src,
 		DBG_ERR(("A: A(?) open, write error"))
 			return NULL;
 	}
-	diva_os_enter_spin_lock(&adapter_lock, &old_irql, "open_adapter");
+	bh = diva_os_enter_spin_lock(&adapter_lock, &old_irql, "open_adapter");
 	list_for_each(tmp, &adapter_queue) {
 		a = list_entry(tmp, diva_os_xdi_adapter_t, link);
 		if (a->controller == (int)msg->adapter)
 			break;
 		a = NULL;
 	}
-	diva_os_leave_spin_lock(&adapter_lock, &old_irql, "open_adapter");
+	diva_os_leave_spin_lock(&adapter_lock, &old_irql, "open_adapter", bh);
 
 	if (!a) {
 		DBG_ERR(("A: A(%d) open, adapter not found", msg->adapter))
@@ -614,11 +620,12 @@ void diva_xdi_display_adapter_features(int card)
 
 void diva_add_slave_adapter(diva_os_xdi_adapter_t *a)
 {
+	unsigned int bh;
 	diva_os_spin_lock_magic_t old_irql;
 
-	diva_os_enter_spin_lock(&adapter_lock, &old_irql, "add_slave");
+	bh = diva_os_enter_spin_lock(&adapter_lock, &old_irql, "add_slave");
 	list_add_tail(&a->link, &adapter_queue);
-	diva_os_leave_spin_lock(&adapter_lock, &old_irql, "add_slave");
+	diva_os_leave_spin_lock(&adapter_lock, &old_irql, "add_slave", bh);
 }
 
 int diva_card_read_xlog(diva_os_xdi_adapter_t *a)
diff --git a/drivers/isdn/hardware/eicon/idifunc.c b/drivers/isdn/hardware/eicon/idifunc.c
index fef6586..1c489c3 100644
--- a/drivers/isdn/hardware/eicon/idifunc.c
+++ b/drivers/isdn/hardware/eicon/idifunc.c
@@ -60,20 +60,21 @@ static diva_os_spin_lock_t ll_lock;
  */
 static udiva_card *find_card_in_list(DESCRIPTOR *d)
 {
+	unsigned int bh;
 	udiva_card *card;
 	struct list_head *tmp;
 	diva_os_spin_lock_magic_t old_irql;
 
-	diva_os_enter_spin_lock(&ll_lock, &old_irql, "find card");
+	bh = diva_os_enter_spin_lock(&ll_lock, &old_irql, "find card");
 	list_for_each(tmp, &cards) {
 		card = list_entry(tmp, udiva_card, list);
 		if (card->d.request == d->request) {
 			diva_os_leave_spin_lock(&ll_lock, &old_irql,
-						"find card");
+						"find card", bh);
 			return (card);
 		}
 	}
-	diva_os_leave_spin_lock(&ll_lock, &old_irql, "find card");
+	diva_os_leave_spin_lock(&ll_lock, &old_irql, "find card", bh);
 	return ((udiva_card *) NULL);
 }
 
@@ -82,6 +83,7 @@ static udiva_card *find_card_in_list(DESCRIPTOR *d)
  */
 static void um_new_card(DESCRIPTOR *d)
 {
+	unsigned int bh;
 	int adapter_nr = 0;
 	udiva_card *card = NULL;
 	IDI_SYNC_REQ sync_req;
@@ -100,9 +102,9 @@ static void um_new_card(DESCRIPTOR *d)
 		sync_req.xdi_logical_adapter_number.info.logical_adapter_number;
 	card->Id = adapter_nr;
 	if (!(diva_user_mode_idi_create_adapter(d, adapter_nr))) {
-		diva_os_enter_spin_lock(&ll_lock, &old_irql, "add card");
+		bh = diva_os_enter_spin_lock(&ll_lock, &old_irql, "add card");
 		list_add_tail(&card->list, &cards);
-		diva_os_leave_spin_lock(&ll_lock, &old_irql, "add card");
+		diva_os_leave_spin_lock(&ll_lock, &old_irql, "add card", bh);
 	} else {
 		DBG_ERR(("could not create user mode idi card %d",
 			 adapter_nr));
@@ -115,6 +117,7 @@ static void um_new_card(DESCRIPTOR *d)
  */
 static void um_remove_card(DESCRIPTOR *d)
 {
+	unsigned int bh;
 	diva_os_spin_lock_magic_t old_irql;
 	udiva_card *card = NULL;
 
@@ -123,9 +126,9 @@ static void um_remove_card(DESCRIPTOR *d)
 		return;
 	}
 	diva_user_mode_idi_remove_adapter(card->Id);
-	diva_os_enter_spin_lock(&ll_lock, &old_irql, "remove card");
+	bh = diva_os_enter_spin_lock(&ll_lock, &old_irql, "remove card");
 	list_del(&card->list);
-	diva_os_leave_spin_lock(&ll_lock, &old_irql, "remove card");
+	diva_os_leave_spin_lock(&ll_lock, &old_irql, "remove card", bh);
 	DBG_LOG(("idi proc entry removed for card %d", card->Id));
 	diva_os_free(0, card);
 }
@@ -135,11 +138,12 @@ static void um_remove_card(DESCRIPTOR *d)
  */
 static void __exit remove_all_idi_proc(void)
 {
+	unsigned int bh;
 	udiva_card *card;
 	diva_os_spin_lock_magic_t old_irql;
 
 rescan:
-	diva_os_enter_spin_lock(&ll_lock, &old_irql, "remove all");
+	bh = diva_os_enter_spin_lock(&ll_lock, &old_irql, "remove all");
 	if (!list_empty(&cards)) {
 		card = list_entry(cards.next, udiva_card, list);
 		list_del(&card->list);
@@ -148,7 +152,7 @@ static void __exit remove_all_idi_proc(void)
 		diva_os_free(0, card);
 		goto rescan;
 	}
-	diva_os_leave_spin_lock(&ll_lock, &old_irql, "remove all");
+	diva_os_leave_spin_lock(&ll_lock, &old_irql, "remove all", bh);
 }
 
 /*
diff --git a/drivers/isdn/hardware/eicon/io.c b/drivers/isdn/hardware/eicon/io.c
index 8851ce5..df3d1f8 100644
--- a/drivers/isdn/hardware/eicon/io.c
+++ b/drivers/isdn/hardware/eicon/io.c
@@ -202,6 +202,7 @@ dump_trap_frame(PISDN_ADAPTER IoAdapter, byte __iomem *exceptionFrame)
    -------------------------------------------------------------------------- */
 void request(PISDN_ADAPTER IoAdapter, ENTITY *e)
 {
+	unsigned int bh;
 	byte i;
 	diva_os_spin_lock_magic_t irql;
 /*
@@ -222,7 +223,7 @@ void request(PISDN_ADAPTER IoAdapter, ENTITY *e)
 				pI->descriptor_number = -1;
 				return;
 			}
-			diva_os_enter_spin_lock(&IoAdapter->data_spin_lock, &irql, "dma_op");
+			bh = diva_enter_spin_lock(&IoAdapter->data_spin_lock, &irql, "dma_op");
 			if (pI->operation == IDI_SYNC_REQ_DMA_DESCRIPTOR_ALLOC) {
 				pI->descriptor_number = diva_alloc_dma_map_entry(\
 					(struct _diva_dma_map_entry *)IoAdapter->dma_map);
@@ -249,7 +250,7 @@ void request(PISDN_ADAPTER IoAdapter, ENTITY *e)
 				pI->descriptor_number = -1;
 				pI->operation         = -1;
 			}
-			diva_os_leave_spin_lock(&IoAdapter->data_spin_lock, &irql, "dma_op");
+			diva_os_leave_spin_lock(&IoAdapter->data_spin_lock, &irql, "dma_op", bh);
 		} return;
 #endif
 		case IDI_SYNC_REQ_XDI_GET_LOGICAL_ADAPTER_NUMBER: {
@@ -373,7 +374,8 @@ void request(PISDN_ADAPTER IoAdapter, ENTITY *e)
 			DBG_FTL(("xdi: uninitialized Adapter used - ignore request"))
 				return;
 		}
-	diva_os_enter_spin_lock(&IoAdapter->data_spin_lock, &irql, "data_req");
+	bh = diva_os_enter_spin_lock(&IoAdapter->data_spin_lock, &irql,
+				     "data_req");
 /*
  * assign an entity
  */
@@ -383,7 +385,8 @@ void request(PISDN_ADAPTER IoAdapter, ENTITY *e)
 		{
 			DBG_FTL(("xdi: all Ids in use (max=%d) --> Req ignored",
 				 IoAdapter->e_max))
-				diva_os_leave_spin_lock(&IoAdapter->data_spin_lock, &irql, "data_req");
+				diva_os_leave_spin_lock(&IoAdapter->data_spin_lock,
+							&irql, "data_req", bh);
 			return;
 		}
 /*
@@ -416,7 +419,8 @@ void request(PISDN_ADAPTER IoAdapter, ENTITY *e)
 					(*(IoAdapter->os_trap_nfy_Fnc))(IoAdapter, IoAdapter->ANum);
 				}
 			}
-		diva_os_leave_spin_lock(&IoAdapter->data_spin_lock, &irql, "data_req");
+		diva_os_leave_spin_lock(&IoAdapter->data_spin_lock, &irql,
+					"data_req", bh);
 		return;
 	}
 /*
@@ -444,12 +448,14 @@ void request(PISDN_ADAPTER IoAdapter, ENTITY *e)
  * queue the DPC to process the request
  */
 	diva_os_schedule_soft_isr(&IoAdapter->req_soft_isr);
-	diva_os_leave_spin_lock(&IoAdapter->data_spin_lock, &irql, "data_req");
+	diva_os_leave_spin_lock(&IoAdapter->data_spin_lock, &irql, "data_req",
+				bh);
 }
 /* ---------------------------------------------------------------------
    Main DPC routine
    --------------------------------------------------------------------- */
 void DIDpcRoutine(struct _diva_os_soft_isr *psoft_isr, void *Context) {
+	unsigned int bh;
 	PISDN_ADAPTER IoAdapter = (PISDN_ADAPTER)Context;
 	ADAPTER *a = &IoAdapter->a;
 	diva_os_atomic_t *pin_dpc = &IoAdapter->in_dpc;
@@ -469,9 +475,8 @@ void DIDpcRoutine(struct _diva_os_soft_isr *psoft_isr, void *Context) {
 		if (IoAdapter->pcm_pending) {
 			struct pc_maint *pcm;
 			diva_os_spin_lock_magic_t OldIrql;
-			diva_os_enter_spin_lock(&IoAdapter->data_spin_lock,
-						&OldIrql,
-						"data_dpc");
+			bh = diva_os_enter_spin_lock(&IoAdapter->data_spin_lock,
+						     &OldIrql, "data_dpc");
 			pcm = (struct pc_maint *)IoAdapter->pcm_data;
 			switch (IoAdapter->pcm_pending) {
 			case 1: /* ask card for XLOG */
@@ -489,8 +494,7 @@ void DIDpcRoutine(struct _diva_os_soft_isr *psoft_isr, void *Context) {
 				break;
 			}
 			diva_os_leave_spin_lock(&IoAdapter->data_spin_lock,
-						&OldIrql,
-						"data_dpc");
+						&OldIrql, "data_dpc", bh);
 		}
 		/* ---------------------------------------------------------------- */
 	}
@@ -501,6 +505,7 @@ void DIDpcRoutine(struct _diva_os_soft_isr *psoft_isr, void *Context) {
 static void
 pcm_req(PISDN_ADAPTER IoAdapter, ENTITY *e)
 {
+	unsigned int bh;
 	diva_os_spin_lock_magic_t OldIrql;
 	int              i, rc;
 	ADAPTER         *a = &IoAdapter->a;
@@ -511,45 +516,43 @@ pcm_req(PISDN_ADAPTER IoAdapter, ENTITY *e)
  */
 	if (IoAdapter->Properties.Card == CARD_MAE)
 	{
-		diva_os_enter_spin_lock(&IoAdapter->data_spin_lock,
-					&OldIrql,
-					"data_pcm_1");
+		bh = diva_os_enter_spin_lock(&IoAdapter->data_spin_lock,
+					     &OldIrql, "data_pcm_1");
 		IoAdapter->pcm_data = (void *)pcm;
 		IoAdapter->pcm_pending = 1;
 		diva_os_schedule_soft_isr(&IoAdapter->req_soft_isr);
-		diva_os_leave_spin_lock(&IoAdapter->data_spin_lock,
-					&OldIrql,
-					"data_pcm_1");
+		diva_os_leave_spin_lock(&IoAdapter->data_spin_lock, &OldIrql,
+					"data_pcm_1", bh);
 		for (rc = 0, i = (IoAdapter->trapped ? 3000 : 250); !rc && (i > 0); --i)
 		{
 			diva_os_sleep(1);
 			if (IoAdapter->pcm_pending == 3) {
-				diva_os_enter_spin_lock(&IoAdapter->data_spin_lock,
+				bh = diva_os_enter_spin_lock(&IoAdapter->data_spin_lock,
 							&OldIrql,
 							"data_pcm_3");
 				IoAdapter->pcm_pending = 0;
 				IoAdapter->pcm_data    = NULL;
 				diva_os_leave_spin_lock(&IoAdapter->data_spin_lock,
 							&OldIrql,
-							"data_pcm_3");
+							"data_pcm_3", bh);
 				return;
 			}
-			diva_os_enter_spin_lock(&IoAdapter->data_spin_lock,
+			bh = diva_os_enter_spin_lock(&IoAdapter->data_spin_lock,
 						&OldIrql,
 						"data_pcm_2");
 			diva_os_schedule_soft_isr(&IoAdapter->req_soft_isr);
 			diva_os_leave_spin_lock(&IoAdapter->data_spin_lock,
 						&OldIrql,
-						"data_pcm_2");
+						"data_pcm_2", bh);
 		}
-		diva_os_enter_spin_lock(&IoAdapter->data_spin_lock,
+		bh = diva_os_enter_spin_lock(&IoAdapter->data_spin_lock,
 					&OldIrql,
 					"data_pcm_4");
 		IoAdapter->pcm_pending = 0;
 		IoAdapter->pcm_data    = NULL;
 		diva_os_leave_spin_lock(&IoAdapter->data_spin_lock,
 					&OldIrql,
-					"data_pcm_4");
+					"data_pcm_4", bh);
 		goto Trapped;
 	}
 /*
@@ -755,48 +758,55 @@ void io_inc(ADAPTER *a, void *adr)
 /*------------------------------------------------------------------*/
 void free_entity(ADAPTER *a, byte e_no)
 {
+	unsigned int bh;
 	PISDN_ADAPTER IoAdapter;
 	diva_os_spin_lock_magic_t irql;
 	IoAdapter = (PISDN_ADAPTER) a->io;
-	diva_os_enter_spin_lock(&IoAdapter->data_spin_lock, &irql, "data_free");
+	bh = diva_os_enter_spin_lock(&IoAdapter->data_spin_lock, &irql,
+				     "data_free");
 	IoAdapter->e_tbl[e_no].e = NULL;
 	IoAdapter->e_count--;
-	diva_os_leave_spin_lock(&IoAdapter->data_spin_lock, &irql, "data_free");
+	diva_os_leave_spin_lock(&IoAdapter->data_spin_lock, &irql,
+				"data_free", bh);
 }
 void assign_queue(ADAPTER *a, byte e_no, word ref)
 {
+	unsigned int bh;
 	PISDN_ADAPTER IoAdapter;
 	diva_os_spin_lock_magic_t irql;
 	IoAdapter = (PISDN_ADAPTER) a->io;
-	diva_os_enter_spin_lock(&IoAdapter->data_spin_lock, &irql, "data_assign");
+	bh = diva_os_enter_spin_lock(&IoAdapter->data_spin_lock, &irql,
+				     "data_assign");
 	IoAdapter->e_tbl[e_no].assign_ref = ref;
 	IoAdapter->e_tbl[e_no].next = (byte)IoAdapter->assign;
 	IoAdapter->assign = e_no;
-	diva_os_leave_spin_lock(&IoAdapter->data_spin_lock, &irql, "data_assign");
+	diva_os_leave_spin_lock(&IoAdapter->data_spin_lock, &irql,
+				"data_assign", bh);
 }
 byte get_assign(ADAPTER *a, word ref)
 {
+	unsigned int bh;
 	PISDN_ADAPTER IoAdapter;
 	diva_os_spin_lock_magic_t irql;
 	byte e_no;
 	IoAdapter = (PISDN_ADAPTER) a->io;
-	diva_os_enter_spin_lock(&IoAdapter->data_spin_lock,
-				&irql,
-				"data_assign_get");
+	bh = diva_os_enter_spin_lock(&IoAdapter->data_spin_lock, &irql,
+				     "data_assign_get");
 	for (e_no = (byte)IoAdapter->assign;
 	    e_no && IoAdapter->e_tbl[e_no].assign_ref != ref;
 	    e_no = IoAdapter->e_tbl[e_no].next);
-	diva_os_leave_spin_lock(&IoAdapter->data_spin_lock,
-				&irql,
-				"data_assign_get");
+	diva_os_leave_spin_lock(&IoAdapter->data_spin_lock, &irql,
+				"data_assign_get", bh);
 	return e_no;
 }
 void req_queue(ADAPTER *a, byte e_no)
 {
+	unsigned int bh;
 	PISDN_ADAPTER IoAdapter;
 	diva_os_spin_lock_magic_t irql;
 	IoAdapter = (PISDN_ADAPTER) a->io;
-	diva_os_enter_spin_lock(&IoAdapter->data_spin_lock, &irql, "data_req_q");
+	bh = diva_os_enter_spin_lock(&IoAdapter->data_spin_lock, &irql,
+				     "data_req_q");
 	IoAdapter->e_tbl[e_no].next = 0;
 	if (IoAdapter->head) {
 		IoAdapter->e_tbl[IoAdapter->tail].next = e_no;
@@ -806,7 +816,8 @@ void req_queue(ADAPTER *a, byte e_no)
 		IoAdapter->head = e_no;
 		IoAdapter->tail = e_no;
 	}
-	diva_os_leave_spin_lock(&IoAdapter->data_spin_lock, &irql, "data_req_q");
+	diva_os_leave_spin_lock(&IoAdapter->data_spin_lock, &irql,
+				"data_req_q", bh);
 }
 byte look_req(ADAPTER *a)
 {
@@ -816,13 +827,16 @@ byte look_req(ADAPTER *a)
 }
 void next_req(ADAPTER *a)
 {
+	unsigned int bh;
 	PISDN_ADAPTER IoAdapter;
 	diva_os_spin_lock_magic_t irql;
 	IoAdapter = (PISDN_ADAPTER) a->io;
-	diva_os_enter_spin_lock(&IoAdapter->data_spin_lock, &irql, "data_req_next");
+	bh = diva_os_enter_spin_lock(&IoAdapter->data_spin_lock, &irql,
+				     "data_req_next");
 	IoAdapter->head = IoAdapter->e_tbl[IoAdapter->head].next;
 	if (!IoAdapter->head) IoAdapter->tail = 0;
-	diva_os_leave_spin_lock(&IoAdapter->data_spin_lock, &irql, "data_req_next");
+	diva_os_leave_spin_lock(&IoAdapter->data_spin_lock, &irql,
+				"data_req_next", bh);
 }
 /*------------------------------------------------------------------*/
 /* memory map functions                                             */
diff --git a/drivers/isdn/hardware/eicon/mntfunc.c b/drivers/isdn/hardware/eicon/mntfunc.c
index 1cd9aff..b7a87ec 100644
--- a/drivers/isdn/hardware/eicon/mntfunc.c
+++ b/drivers/isdn/hardware/eicon/mntfunc.c
@@ -137,6 +137,7 @@ int maint_read_write(void __user *buf, int count)
 {
 	byte data[128];
 	dword cmd, id, mask;
+	unsigned int bh;
 	int ret = 0;
 
 	if (count < (3 * sizeof(dword)))
@@ -218,17 +219,17 @@ int maint_read_write(void __user *buf, int count)
 
 		for (;;) {
 			if (!(pmsg =
-			      diva_maint_get_message(&size, &old_irql))) {
+			      diva_maint_get_message(&size, &old_irql, &bh))) {
 				break;
 			}
 			if (size > mask) {
-				diva_maint_ack_message(0, &old_irql);
+				diva_maint_ack_message(0, &old_irql, bh);
 				ret = -EINVAL;
 				break;
 			}
 			ret = size;
 			memcpy(pbuf, pmsg, size);
-			diva_maint_ack_message(1, &old_irql);
+			diva_maint_ack_message(1, &old_irql, bh);
 			if ((count < size) ||
 			    diva_os_copy_to_user(NULL, buf, (void *) pbuf, size))
 				ret = -EFAULT;
@@ -255,11 +256,11 @@ int maint_read_write(void __user *buf, int count)
 
 		for (;;) {
 			if (!(pmsg =
-			      diva_maint_get_message(&size, &old_irql))) {
+			      diva_maint_get_message(&size, &old_irql, &bh))) {
 				break;
 			}
 			if ((size + 8) > mask) {
-				diva_maint_ack_message(0, &old_irql);
+				diva_maint_ack_message(0, &old_irql, bh);
 				break;
 			}
 			/*
@@ -273,7 +274,7 @@ int maint_read_write(void __user *buf, int count)
 			  Write message
 			*/
 			memcpy(&pbuf[written], pmsg, size);
-			diva_maint_ack_message(1, &old_irql);
+			diva_maint_ack_message(1, &old_irql, bh);
 			written += size;
 			mask -= (size + 4);
 		}
diff --git a/drivers/isdn/hardware/eicon/platform.h b/drivers/isdn/hardware/eicon/platform.h
index 62e2073..345c901 100644
--- a/drivers/isdn/hardware/eicon/platform.h
+++ b/drivers/isdn/hardware/eicon/platform.h
@@ -235,12 +235,13 @@ typedef long diva_os_spin_lock_magic_t;
 typedef spinlock_t diva_os_spin_lock_t;
 static __inline__ int diva_os_initialize_spin_lock(spinlock_t *lock, void *unused) { \
 	spin_lock_init(lock); return (0); }
-static __inline__ void diva_os_enter_spin_lock(diva_os_spin_lock_t *a, \
-					       diva_os_spin_lock_magic_t *old_irql, \
-					       void *dbg) { spin_lock_bh(a); }
+static __inline__ unsigned int diva_os_enter_spin_lock(diva_os_spin_lock_t *a, \
+						       diva_os_spin_lock_magic_t *old_irql, \
+						       void *dbg) { spin_lock_bh(a); }
 static __inline__ void diva_os_leave_spin_lock(diva_os_spin_lock_t *a, \
 					       diva_os_spin_lock_magic_t *old_irql, \
-					       void *dbg) { spin_unlock_bh(a); }
+					       void *dbg,
+					       unsigned int bh) { spin_unlock_bh(a); }
 
 #define diva_os_destroy_spin_lock(a, b) do { } while (0)
 
diff --git a/drivers/isdn/hardware/eicon/um_idi.c b/drivers/isdn/hardware/eicon/um_idi.c
index db4dd4f..138be33 100644
--- a/drivers/isdn/hardware/eicon/um_idi.c
+++ b/drivers/isdn/hardware/eicon/um_idi.c
@@ -121,6 +121,7 @@ void diva_user_mode_idi_finit(void)
    ------------------------------------------------------------------------- */
 int diva_user_mode_idi_create_adapter(const DESCRIPTOR *d, int adapter_nr)
 {
+	unsigned int bh;
 	diva_os_spin_lock_magic_t old_irql;
 	diva_um_idi_adapter_t *a =
 		(diva_um_idi_adapter_t *) diva_os_malloc(0,
@@ -139,9 +140,11 @@ int diva_user_mode_idi_create_adapter(const DESCRIPTOR *d, int adapter_nr)
 	DBG_LOG(("DIDD_ADD A(%d), type:%02x, features:%04x, channels:%d",
 		 adapter_nr, a->d.type, a->d.features, a->d.channels));
 
-	diva_os_enter_spin_lock(&adapter_lock, &old_irql, "create_adapter");
+	bh = diva_os_enter_spin_lock(&adapter_lock, &old_irql,
+				     "create_adapter");
 	list_add_tail(&a->link, &adapter_q);
-	diva_os_leave_spin_lock(&adapter_lock, &old_irql, "create_adapter");
+	diva_os_leave_spin_lock(&adapter_lock, &old_irql, "create_adapter",
+				bh);
 	return (0);
 }
 
@@ -208,6 +211,7 @@ static void cleanup_entity(divas_um_idi_entity_t *e)
    ------------------------------------------------------------------------ */
 void *divas_um_idi_create_entity(dword adapter_nr, void *file)
 {
+	unsigned int bh;
 	divas_um_idi_entity_t *e;
 	diva_um_idi_adapter_t *a;
 	diva_os_spin_lock_magic_t old_irql;
@@ -235,7 +239,8 @@ void *divas_um_idi_create_entity(dword adapter_nr, void *file)
 			return NULL;
 		}
 
-		diva_os_enter_spin_lock(&adapter_lock, &old_irql, "create_entity");
+		bh = diva_os_enter_spin_lock(&adapter_lock, &old_irql,
+					     "create_entity");
 		/*
 		  Look for Adapter requested
 		*/
@@ -243,7 +248,8 @@ void *divas_um_idi_create_entity(dword adapter_nr, void *file)
 			/*
 			  No adapter was found, or this adapter was removed
 			*/
-			diva_os_leave_spin_lock(&adapter_lock, &old_irql, "create_entity");
+			diva_os_leave_spin_lock(&adapter_lock, &old_irql,
+						"create_entity", bh);
 
 			DBG_LOG(("A: no adapter(%ld)", adapter_nr));
 
@@ -259,7 +265,8 @@ void *divas_um_idi_create_entity(dword adapter_nr, void *file)
 
 		list_add_tail(&e->link, &a->entity_q);	/* link from adapter */
 
-		diva_os_leave_spin_lock(&adapter_lock, &old_irql, "create_entity");
+		diva_os_leave_spin_lock(&adapter_lock, &old_irql,
+					"create_entity", bh);
 
 		DBG_LOG(("A(%ld), create E(%08x)", adapter_nr, e));
 	}
@@ -272,6 +279,7 @@ void *divas_um_idi_create_entity(dword adapter_nr, void *file)
    ------------------------------------------------------------------------ */
 int divas_um_idi_delete_entity(int adapter_nr, void *entity)
 {
+	unsigned int bh;
 	divas_um_idi_entity_t *e;
 	diva_um_idi_adapter_t *a;
 	diva_os_spin_lock_magic_t old_irql;
@@ -279,11 +287,12 @@ int divas_um_idi_delete_entity(int adapter_nr, void *entity)
 	if (!(e = (divas_um_idi_entity_t *) entity))
 		return (-1);
 
-	diva_os_enter_spin_lock(&adapter_lock, &old_irql, "delete_entity");
+	bh = diva_os_enter_spin_lock(&adapter_lock, &old_irql,
+				     "delete_entity");
 	if ((a = e->adapter)) {
 		list_del(&e->link);
 	}
-	diva_os_leave_spin_lock(&adapter_lock, &old_irql, "delete_entity");
+	diva_os_leave_spin_lock(&adapter_lock, &old_irql, "delete_entity", bh);
 
 	diva_um_idi_stop_wdog(entity);
 	cleanup_entity(e);
@@ -304,6 +313,7 @@ int diva_um_idi_read(void *entity,
 		     void *dst,
 		     int max_length, divas_um_idi_copy_to_user_fn_t cp_fn)
 {
+	unsigned int bh;
 	divas_um_idi_entity_t *e;
 	diva_um_idi_adapter_t *a;
 	const void *data;
@@ -311,14 +321,14 @@ int diva_um_idi_read(void *entity,
 	diva_um_idi_data_queue_t *q;
 	diva_os_spin_lock_magic_t old_irql;
 
-	diva_os_enter_spin_lock(&adapter_lock, &old_irql, "read");
+	bh = diva_os_enter_spin_lock(&adapter_lock, &old_irql, "read");
 
 	e = (divas_um_idi_entity_t *) entity;
 	if (!e || (!(a = e->adapter)) ||
 	    (e->status & DIVA_UM_IDI_REMOVE_PENDING) ||
 	    (e->status & DIVA_UM_IDI_REMOVED) ||
 	    (a->status & DIVA_UM_IDI_ADAPTER_REMOVED)) {
-		diva_os_leave_spin_lock(&adapter_lock, &old_irql, "read");
+		diva_os_leave_spin_lock(&adapter_lock, &old_irql, "read", bh);
 		DBG_ERR(("E(%08x) read failed - adapter removed", e))
 			return (-1);
 	}
@@ -354,7 +364,7 @@ int diva_um_idi_read(void *entity,
 			DBG_ERR(("A: A(%d) E(%08x) read small buffer",
 				 a->adapter_nr, e, ret));
 			diva_os_leave_spin_lock(&adapter_lock, &old_irql,
-						"read");
+						"read", bh);
 			return (-2);
 		}
 		/*
@@ -373,7 +383,7 @@ int diva_um_idi_read(void *entity,
 
 	DBG_TRC(("A(%d) E(%08x) read=%d", a->adapter_nr, e, ret));
 
-	diva_os_leave_spin_lock(&adapter_lock, &old_irql, "read");
+	diva_os_leave_spin_lock(&adapter_lock, &old_irql, "read", bh);
 
 	return (ret);
 }
@@ -384,6 +394,7 @@ int diva_um_idi_write(void *entity,
 		      const void *src,
 		      int length, divas_um_idi_copy_from_user_fn_t cp_fn)
 {
+	unsigned int bh;
 	divas_um_idi_entity_t *e;
 	diva_um_idi_adapter_t *a;
 	diva_um_idi_req_hdr_t *req;
@@ -391,14 +402,14 @@ int diva_um_idi_write(void *entity,
 	int ret = 0;
 	diva_os_spin_lock_magic_t old_irql;
 
-	diva_os_enter_spin_lock(&adapter_lock, &old_irql, "write");
+	bh = diva_os_enter_spin_lock(&adapter_lock, &old_irql, "write");
 
 	e = (divas_um_idi_entity_t *) entity;
 	if (!e || (!(a = e->adapter)) ||
 	    (e->status & DIVA_UM_IDI_REMOVE_PENDING) ||
 	    (e->status & DIVA_UM_IDI_REMOVED) ||
 	    (a->status & DIVA_UM_IDI_ADAPTER_REMOVED)) {
-		diva_os_leave_spin_lock(&adapter_lock, &old_irql, "write");
+		diva_os_leave_spin_lock(&adapter_lock, &old_irql, "write", bh);
 		DBG_ERR(("E(%08x) write failed - adapter removed", e))
 			return (-1);
 	}
@@ -406,13 +417,13 @@ int diva_um_idi_write(void *entity,
 	DBG_TRC(("A(%d) E(%08x) write(%d)", a->adapter_nr, e, length));
 
 	if ((length < sizeof(*req)) || (length > sizeof(e->buffer))) {
-		diva_os_leave_spin_lock(&adapter_lock, &old_irql, "write");
+		diva_os_leave_spin_lock(&adapter_lock, &old_irql, "write", bh);
 		return (-2);
 	}
 
 	if (e->status & DIVA_UM_IDI_RC_PENDING) {
 		DBG_ERR(("A: A(%d) E(%08x) rc pending", a->adapter_nr, e));
-		diva_os_leave_spin_lock(&adapter_lock, &old_irql, "write");
+		diva_os_leave_spin_lock(&adapter_lock, &old_irql, "write", bh);
 		return (-1);	/* should wait for RC code first */
 	}
 
@@ -423,7 +434,7 @@ int diva_um_idi_write(void *entity,
 	if ((ret = (*cp_fn) (os_handle, e->buffer, src, length)) < 0) {
 		DBG_TRC(("A: A(%d) E(%08x) write error=%d", a->adapter_nr,
 			 e, ret));
-		diva_os_leave_spin_lock(&adapter_lock, &old_irql, "write");
+		diva_os_leave_spin_lock(&adapter_lock, &old_irql, "write", bh);
 		return (ret);
 	}
 
@@ -436,9 +447,8 @@ int diva_um_idi_write(void *entity,
 		      diva_data_q_get_segment4write(&e->data))) {
 			DBG_ERR(("A(%d) get_features, no free buffer",
 				 a->adapter_nr));
-			diva_os_leave_spin_lock(&adapter_lock,
-						&old_irql,
-						"write");
+			diva_os_leave_spin_lock(&adapter_lock, &old_irql,
+						"write", bh);
 			return (0);
 		}
 		diva_user_mode_idi_adapter_features(a, &(((diva_um_idi_ind_hdr_t
@@ -449,7 +459,7 @@ int diva_um_idi_write(void *entity,
 		diva_data_q_ack_segment4write(&e->data,
 					      sizeof(diva_um_idi_ind_hdr_t));
 
-		diva_os_leave_spin_lock(&adapter_lock, &old_irql, "write");
+		diva_os_leave_spin_lock(&adapter_lock, &old_irql, "write", bh);
 
 		diva_os_wakeup_read(e->os_context);
 	}
@@ -464,20 +474,23 @@ int diva_um_idi_write(void *entity,
 			 req->type & DIVA_UM_IDI_REQ_TYPE_MASK));
 		switch (process_idi_request(e, req)) {
 		case -1:
-			diva_os_leave_spin_lock(&adapter_lock, &old_irql, "write");
+			diva_os_leave_spin_lock(&adapter_lock, &old_irql,
+						"write", bh);
 			return (-1);
 		case -2:
-			diva_os_leave_spin_lock(&adapter_lock, &old_irql, "write");
+			diva_os_leave_spin_lock(&adapter_lock, &old_irql,
+						"write", bh);
 			diva_os_wakeup_read(e->os_context);
 			break;
 		default:
-			diva_os_leave_spin_lock(&adapter_lock, &old_irql, "write");
+			diva_os_leave_spin_lock(&adapter_lock, &old_irql,
+						"write", bh);
 			break;
 		}
 		break;
 
 	default:
-		diva_os_leave_spin_lock(&adapter_lock, &old_irql, "write");
+		diva_os_leave_spin_lock(&adapter_lock, &old_irql, "write", bh);
 		return (-1);
 	}
 
@@ -491,13 +504,14 @@ int diva_um_idi_write(void *entity,
    -------------------------------------------------------------------------- */
 static void diva_um_idi_xdi_callback(ENTITY *entity)
 {
+	unsigned int bh;
 	divas_um_idi_entity_t *e = DIVAS_CONTAINING_RECORD(entity,
 							   divas_um_idi_entity_t,
 							   e);
 	diva_os_spin_lock_magic_t old_irql;
 	int call_wakeup = 0;
 
-	diva_os_enter_spin_lock(&adapter_lock, &old_irql, "xdi_callback");
+	bh = diva_os_enter_spin_lock(&adapter_lock, &old_irql, "xdi_callback");
 
 	if (e->e.complete == 255) {
 		if (!(e->status & DIVA_UM_IDI_REMOVE_PENDING)) {
@@ -509,7 +523,8 @@ static void diva_um_idi_xdi_callback(ENTITY *entity)
 			}
 		}
 		e->e.Rc = 0;
-		diva_os_leave_spin_lock(&adapter_lock, &old_irql, "xdi_callback");
+		diva_os_leave_spin_lock(&adapter_lock, &old_irql,
+					"xdi_callback", bh);
 
 		if (call_wakeup) {
 			diva_os_wakeup_read(e->os_context);
@@ -523,7 +538,8 @@ static void diva_um_idi_xdi_callback(ENTITY *entity)
 			call_wakeup = process_idi_ind(e, e->e.Ind);
 		}
 		e->e.Ind = 0;
-		diva_os_leave_spin_lock(&adapter_lock, &old_irql, "xdi_callback");
+		diva_os_leave_spin_lock(&adapter_lock, &old_irql,
+					"xdi_callback", bh);
 		if (call_wakeup) {
 			diva_os_wakeup_read(e->os_context);
 		}
@@ -759,6 +775,7 @@ static int write_return_code(divas_um_idi_entity_t *e, byte rc)
    -------------------------------------------------------------------------- */
 int diva_user_mode_idi_ind_ready(void *entity, void *os_handle)
 {
+	unsigned int bh;
 	divas_um_idi_entity_t *e;
 	diva_um_idi_adapter_t *a;
 	diva_os_spin_lock_magic_t old_irql;
@@ -766,7 +783,7 @@ int diva_user_mode_idi_ind_ready(void *entity, void *os_handle)
 
 	if (!entity)
 		return (-1);
-	diva_os_enter_spin_lock(&adapter_lock, &old_irql, "ind_ready");
+	bh = diva_os_enter_spin_lock(&adapter_lock, &old_irql, "ind_ready");
 	e = (divas_um_idi_entity_t *) entity;
 	a = e->adapter;
 
@@ -774,7 +791,8 @@ int diva_user_mode_idi_ind_ready(void *entity, void *os_handle)
 		/*
 		  Adapter was unloaded
 		*/
-		diva_os_leave_spin_lock(&adapter_lock, &old_irql, "ind_ready");
+		diva_os_leave_spin_lock(&adapter_lock, &old_irql, "ind_ready",
+					bh);
 		return (-1);	/* adapter was removed */
 	}
 	if (e->status & DIVA_UM_IDI_REMOVED) {
@@ -782,7 +800,8 @@ int diva_user_mode_idi_ind_ready(void *entity, void *os_handle)
 		  entity was removed as result of adapter removal
 		  user should assign this entity again
 		*/
-		diva_os_leave_spin_lock(&adapter_lock, &old_irql, "ind_ready");
+		diva_os_leave_spin_lock(&adapter_lock, &old_irql, "ind_ready",
+					bh);
 		return (-1);
 	}
 
@@ -792,7 +811,7 @@ int diva_user_mode_idi_ind_ready(void *entity, void *os_handle)
 		ret = 0;
 	}
 
-	diva_os_leave_spin_lock(&adapter_lock, &old_irql, "ind_ready");
+	diva_os_leave_spin_lock(&adapter_lock, &old_irql, "ind_ready", bh);
 
 	return (ret);
 }
@@ -804,19 +823,21 @@ void *diva_um_id_get_os_context(void *entity)
 
 int divas_um_idi_entity_assigned(void *entity)
 {
+	unsigned int bh;
 	divas_um_idi_entity_t *e;
 	diva_um_idi_adapter_t *a;
 	int ret;
 	diva_os_spin_lock_magic_t old_irql;
 
-	diva_os_enter_spin_lock(&adapter_lock, &old_irql, "assigned?");
+	bh = diva_os_enter_spin_lock(&adapter_lock, &old_irql, "assigned?");
 
 
 	e = (divas_um_idi_entity_t *) entity;
 	if (!e || (!(a = e->adapter)) ||
 	    (e->status & DIVA_UM_IDI_REMOVED) ||
 	    (a->status & DIVA_UM_IDI_ADAPTER_REMOVED)) {
-		diva_os_leave_spin_lock(&adapter_lock, &old_irql, "assigned?");
+		diva_os_leave_spin_lock(&adapter_lock, &old_irql, "assigned?",
+					bh);
 		return (0);
 	}
 
@@ -828,24 +849,27 @@ int divas_um_idi_entity_assigned(void *entity)
 	DBG_TRC(("Id:%02x, rc_count:%d, status:%08x", e->e.Id, e->rc_count,
 		 e->status))
 
-		diva_os_leave_spin_lock(&adapter_lock, &old_irql, "assigned?");
+		diva_os_leave_spin_lock(&adapter_lock, &old_irql, "assigned?",
+					bh);
 
 	return (ret);
 }
 
 int divas_um_idi_entity_start_remove(void *entity)
 {
+	unsigned int bh;
 	divas_um_idi_entity_t *e;
 	diva_um_idi_adapter_t *a;
 	diva_os_spin_lock_magic_t old_irql;
 
-	diva_os_enter_spin_lock(&adapter_lock, &old_irql, "start_remove");
+	bh = diva_os_enter_spin_lock(&adapter_lock, &old_irql, "start_remove");
 
 	e = (divas_um_idi_entity_t *) entity;
 	if (!e || (!(a = e->adapter)) ||
 	    (e->status & DIVA_UM_IDI_REMOVED) ||
 	    (a->status & DIVA_UM_IDI_ADAPTER_REMOVED)) {
-		diva_os_leave_spin_lock(&adapter_lock, &old_irql, "start_remove");
+		diva_os_leave_spin_lock(&adapter_lock, &old_irql,
+					"start_remove", bh);
 		return (0);
 	}
 
@@ -853,7 +877,8 @@ int divas_um_idi_entity_start_remove(void *entity)
 		/*
 		  Entity BUSY
 		*/
-		diva_os_leave_spin_lock(&adapter_lock, &old_irql, "start_remove");
+		diva_os_leave_spin_lock(&adapter_lock, &old_irql,
+					"start_remove", bh);
 		return (1);
 	}
 
@@ -861,7 +886,8 @@ int divas_um_idi_entity_start_remove(void *entity)
 		/*
 		  Remove request was already pending, and arrived now
 		*/
-		diva_os_leave_spin_lock(&adapter_lock, &old_irql, "start_remove");
+		diva_os_leave_spin_lock(&adapter_lock, &old_irql,
+					"start_remove", bh);
 		return (0);	/* REMOVE was pending */
 	}
 
@@ -880,7 +906,7 @@ int divas_um_idi_entity_start_remove(void *entity)
 	if (a->d.request)
 		(*(a->d.request)) (&e->e);
 
-	diva_os_leave_spin_lock(&adapter_lock, &old_irql, "start_remove");
+	diva_os_leave_spin_lock(&adapter_lock, &old_irql, "start_remove", bh);
 
 	return (0);
 }
-- 
2.7.4

