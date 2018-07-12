Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 066F3C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 14:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7966213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 14:11:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7966213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732441AbeGLOUz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 10:20:55 -0400
Received: from mga17.intel.com ([192.55.52.151]:62688 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727642AbeGLOUz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 10:20:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jul 2018 07:11:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,343,1526367600"; 
   d="scan'208";a="57137139"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.43])
  by orsmga006.jf.intel.com with ESMTP; 12 Jul 2018 07:11:09 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next 1/3] mei: check for error returned from mei_hbuf_empty_slots()
Date:   Thu, 12 Jul 2018 17:10:08 +0300
Message-Id: <20180712141010.11277-2-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180712141010.11277-1-tomas.winkler@intel.com>
References: <20180712141010.11277-1-tomas.winkler@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mei_hbuf_empty_slots() may return with an error in case
of circular buffer overflow. This type of error may
be caused only by a bug. However currently, the error
won't be detected due signed type promotion in comparison to u32.
We add explicit check for less then zero and explicit cast
in comparison to suppress singn-compare warning.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/client.c    | 22 ++++++++++++++++------
 drivers/misc/mei/hw-me.c     |  5 ++++-
 drivers/misc/mei/hw-txe.c    |  2 +-
 drivers/misc/mei/interrupt.c | 15 +++++++++++----
 4 files changed, 32 insertions(+), 12 deletions(-)

diff --git a/drivers/misc/mei/client.c b/drivers/misc/mei/client.c
index 8d6197a88b54..f8fb7589192e 100644
--- a/drivers/misc/mei/client.c
+++ b/drivers/misc/mei/client.c
@@ -865,8 +865,10 @@ int mei_cl_irq_disconnect(struct mei_cl *cl, struct mei_cl_cb *cb,
 
 	msg_slots = mei_data2slots(sizeof(struct hbm_client_connect_request));
 	slots = mei_hbuf_empty_slots(dev);
+	if (slots < 0)
+		return -EOVERFLOW;
 
-	if (slots < msg_slots)
+	if ((u32)slots < msg_slots)
 		return -EMSGSIZE;
 
 	ret = mei_cl_send_disconnect(cl, cb);
@@ -1054,12 +1056,15 @@ int mei_cl_irq_connect(struct mei_cl *cl, struct mei_cl_cb *cb,
 	int rets;
 
 	msg_slots = mei_data2slots(sizeof(struct hbm_client_connect_request));
-	slots = mei_hbuf_empty_slots(dev);
 
 	if (mei_cl_is_other_connecting(cl))
 		return 0;
 
-	if (slots < msg_slots)
+	slots = mei_hbuf_empty_slots(dev);
+	if (slots < 0)
+		return -EOVERFLOW;
+
+	if ((u32)slots < msg_slots)
 		return -EMSGSIZE;
 
 	rets = mei_cl_send_connect(cl, cb);
@@ -1296,8 +1301,10 @@ int mei_cl_irq_notify(struct mei_cl *cl, struct mei_cl_cb *cb,
 
 	msg_slots = mei_data2slots(sizeof(struct hbm_client_connect_request));
 	slots = mei_hbuf_empty_slots(dev);
+	if (slots < 0)
+		return -EOVERFLOW;
 
-	if (slots < msg_slots)
+	if ((u32)slots < msg_slots)
 		return -EMSGSIZE;
 
 	request = mei_cl_notify_fop2req(cb->fop_type);
@@ -1573,6 +1580,9 @@ int mei_cl_irq_write(struct mei_cl *cl, struct mei_cl_cb *cb,
 	}
 
 	slots = mei_hbuf_empty_slots(dev);
+	if (slots < 0)
+		return -EOVERFLOW;
+
 	len = buf->size - cb->buf_idx;
 	msg_slots = mei_data2slots(len);
 
@@ -1581,11 +1591,11 @@ int mei_cl_irq_write(struct mei_cl *cl, struct mei_cl_cb *cb,
 	mei_hdr.reserved = 0;
 	mei_hdr.internal = cb->internal;
 
-	if (slots >= msg_slots) {
+	if ((u32)slots >= msg_slots) {
 		mei_hdr.length = len;
 		mei_hdr.msg_complete = 1;
 	/* Split the message only if we can write the whole host buffer */
-	} else if (slots == dev->hbuf_depth) {
+	} else if ((u32)slots == dev->hbuf_depth) {
 		msg_slots = slots;
 		len = (slots * sizeof(u32)) - sizeof(struct mei_msg_hdr);
 		mei_hdr.length = len;
diff --git a/drivers/misc/mei/hw-me.c b/drivers/misc/mei/hw-me.c
index 334ab02e1de2..a12b464bc0b4 100644
--- a/drivers/misc/mei/hw-me.c
+++ b/drivers/misc/mei/hw-me.c
@@ -540,8 +540,11 @@ static int mei_me_hbuf_write(struct mei_device *dev,
 	empty_slots = mei_hbuf_empty_slots(dev);
 	dev_dbg(dev->dev, "empty slots = %hu.\n", empty_slots);
 
+	if (empty_slots < 0)
+		return -EOVERFLOW;
+
 	dw_cnt = mei_data2slots(length);
-	if (empty_slots < 0 || dw_cnt > empty_slots)
+	if (dw_cnt > (u32)empty_slots)
 		return -EMSGSIZE;
 
 	mei_me_hcbww_write(dev, *((u32 *) header));
diff --git a/drivers/misc/mei/hw-txe.c b/drivers/misc/mei/hw-txe.c
index c2c8993e2a51..4c1acf68089e 100644
--- a/drivers/misc/mei/hw-txe.c
+++ b/drivers/misc/mei/hw-txe.c
@@ -709,7 +709,7 @@ static int mei_txe_write(struct mei_device *dev,
 	struct mei_txe_hw *hw = to_txe_hw(dev);
 	unsigned long rem;
 	unsigned long length;
-	int slots = dev->hbuf_depth;
+	u32 slots = dev->hbuf_depth;
 	u32 *reg_buf = (u32 *)buf;
 	u32 dw_cnt;
 	int i;
diff --git a/drivers/misc/mei/interrupt.c b/drivers/misc/mei/interrupt.c
index 6649f0d56d2f..6217cebcad3d 100644
--- a/drivers/misc/mei/interrupt.c
+++ b/drivers/misc/mei/interrupt.c
@@ -173,10 +173,12 @@ static int mei_cl_irq_disconnect_rsp(struct mei_cl *cl, struct mei_cl_cb *cb,
 	int slots;
 	int ret;
 
-	slots = mei_hbuf_empty_slots(dev);
 	msg_slots = mei_data2slots(sizeof(struct hbm_client_connect_response));
+	slots = mei_hbuf_empty_slots(dev);
+	if (slots < 0)
+		return -EOVERFLOW;
 
-	if (slots < msg_slots)
+	if ((u32)slots < msg_slots)
 		return -EMSGSIZE;
 
 	ret = mei_hbm_cl_disconnect_rsp(dev, cl);
@@ -208,8 +210,10 @@ static int mei_cl_irq_read(struct mei_cl *cl, struct mei_cl_cb *cb,
 
 	msg_slots = mei_data2slots(sizeof(struct hbm_flow_control));
 	slots = mei_hbuf_empty_slots(dev);
+	if (slots < 0)
+		return -EOVERFLOW;
 
-	if (slots < msg_slots)
+	if ((u32)slots < msg_slots)
 		return -EMSGSIZE;
 
 	ret = mei_hbm_cl_flow_control_req(dev, cl);
@@ -368,7 +372,10 @@ int mei_irq_write_handler(struct mei_device *dev, struct list_head *cmpl_list)
 		return 0;
 
 	slots = mei_hbuf_empty_slots(dev);
-	if (slots <= 0)
+	if (slots < 0)
+		return -EOVERFLOW;
+
+	if (slots == 0)
 		return -EMSGSIZE;
 
 	/* complete all waiting for write CB */
-- 
2.14.4

