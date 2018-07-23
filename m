Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D00CCECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 10:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96E9920846
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 10:23:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96E9920846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388196AbeGWLYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 07:24:03 -0400
Received: from mga09.intel.com ([134.134.136.24]:40349 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387887AbeGWLYD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 07:24:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jul 2018 03:23:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,393,1526367600"; 
   d="scan'208";a="248064003"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.48])
  by fmsmga006.fm.intel.com with ESMTP; 23 Jul 2018 03:23:14 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next 3/3] mei: add mei_msg_hdr_init wrapper.
Date:   Mon, 23 Jul 2018 13:21:24 +0300
Message-Id: <20180723102124.27788-3-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180723102124.27788-1-tomas.winkler@intel.com>
References: <20180723102124.27788-1-tomas.winkler@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wrap the mei header boilerplate initialization code in
mei_msg_hdr_init function. On the way remove 'completed'
field from mei_cl_cb structure as this information
is already included in the header and is local to particular
fragment.

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/client.c  | 33 ++++++++++++++++++++-------------
 drivers/misc/mei/mei_dev.h |  2 --
 2 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/drivers/misc/mei/client.c b/drivers/misc/mei/client.c
index ca917b84ca5e..207d2f5d5702 100644
--- a/drivers/misc/mei/client.c
+++ b/drivers/misc/mei/client.c
@@ -1539,6 +1539,22 @@ int mei_cl_read_start(struct mei_cl *cl, size_t length, const struct file *fp)
 	return rets;
 }
 
+/**
+ * mei_msg_hdr_init - initialize mei message header
+ *
+ * @mei_hdr: mei message header
+ * @cb: message callback structure
+ */
+static void mei_msg_hdr_init(struct mei_msg_hdr *mei_hdr, struct mei_cl_cb *cb)
+{
+	mei_hdr->host_addr = mei_cl_host_addr(cb->cl);
+	mei_hdr->me_addr = mei_cl_me_id(cb->cl);
+	mei_hdr->length = 0;
+	mei_hdr->reserved = 0;
+	mei_hdr->msg_complete = 0;
+	mei_hdr->internal = cb->internal;
+}
+
 /**
  * mei_cl_irq_write - write a message to device
  *	from the interrupt thread context
@@ -1579,12 +1595,6 @@ int mei_cl_irq_write(struct mei_cl *cl, struct mei_cl_cb *cb,
 		return 0;
 	}
 
-	mei_hdr.host_addr = mei_cl_host_addr(cl);
-	mei_hdr.me_addr = mei_cl_me_id(cl);
-	mei_hdr.reserved = 0;
-	mei_hdr.msg_complete = 0;
-	mei_hdr.internal = cb->internal;
-
 	len = buf->size - cb->buf_idx;
 	hbuf_slots = mei_hbuf_empty_slots(dev);
 	if (hbuf_slots < 0) {
@@ -1593,6 +1603,8 @@ int mei_cl_irq_write(struct mei_cl *cl, struct mei_cl_cb *cb,
 	}
 	hbuf_len = mei_slots2data(hbuf_slots) - sizeof(struct mei_msg_hdr);
 
+	mei_msg_hdr_init(&mei_hdr, cb);
+
 	/**
 	 * Split the message only if we can write the whole host buffer
 	 * otherwise wait for next time the host buffer is empty.
@@ -1616,7 +1628,6 @@ int mei_cl_irq_write(struct mei_cl *cl, struct mei_cl_cb *cb,
 	cl->status = 0;
 	cl->writing_state = MEI_WRITING;
 	cb->buf_idx += mei_hdr.length;
-	cb->completed = mei_hdr.msg_complete == 1;
 
 	if (first_chunk) {
 		if (mei_cl_tx_flow_ctrl_creds_reduce(cl)) {
@@ -1680,16 +1691,13 @@ ssize_t mei_cl_write(struct mei_cl *cl, struct mei_cl_cb *cb)
 	cb->buf_idx = 0;
 	cl->writing_state = MEI_IDLE;
 
-	mei_hdr.host_addr = mei_cl_host_addr(cl);
-	mei_hdr.me_addr = mei_cl_me_id(cl);
-	mei_hdr.reserved = 0;
-	mei_hdr.msg_complete = 0;
-	mei_hdr.internal = cb->internal;
 
 	rets = mei_cl_tx_flow_ctrl_creds(cl);
 	if (rets < 0)
 		goto err;
 
+	mei_msg_hdr_init(&mei_hdr, cb);
+
 	if (rets == 0) {
 		cl_dbg(dev, cl, "No flow control credentials: not sending.\n");
 		rets = len;
@@ -1726,7 +1734,6 @@ ssize_t mei_cl_write(struct mei_cl *cl, struct mei_cl_cb *cb)
 
 	cl->writing_state = MEI_WRITING;
 	cb->buf_idx = mei_hdr.length;
-	cb->completed = mei_hdr.msg_complete == 1;
 
 out:
 	if (mei_hdr.msg_complete)
diff --git a/drivers/misc/mei/mei_dev.h b/drivers/misc/mei/mei_dev.h
index fa543dcfc111..e9f37085a628 100644
--- a/drivers/misc/mei/mei_dev.h
+++ b/drivers/misc/mei/mei_dev.h
@@ -175,7 +175,6 @@ struct mei_cl;
  * @status: io status of the cb
  * @internal: communication between driver and FW flag
  * @blocking: transmission blocking mode
- * @completed: the transfer or reception has completed
  */
 struct mei_cl_cb {
 	struct list_head list;
@@ -187,7 +186,6 @@ struct mei_cl_cb {
 	int status;
 	u32 internal:1;
 	u32 blocking:1;
-	u32 completed:1;
 };
 
 /**
-- 
2.14.4

