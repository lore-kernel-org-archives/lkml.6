Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B7FC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9361420844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:14:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9361420844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728322AbeIHB47 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 21:56:59 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41962 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727217AbeIHB46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 21:56:58 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 8FFC5FEB;
        Fri,  7 Sep 2018 21:14:11 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bart Van Assche <bart.vanassche@wdc.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 4.18 042/145] IB/srpt: Fix srpt_cm_req_recv() error path (1/2)
Date:   Fri,  7 Sep 2018 23:08:28 +0200
Message-Id: <20180907210907.997832027@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907210903.617721278@linuxfoundation.org>
References: <20180907210903.617721278@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bart Van Assche <bart.vanassche@wdc.com>

commit 847462de3a0aabc5343a1e338537f69a03bb61af upstream.

Once a target session has been allocated, if an error occurs, the session
must be freed. Since it is not safe to call blocking code from the context
of an connection manager callback, trigger target session release in this
case by calling srpt_close_ch().

Fixes: db7683d7deb2 ("IB/srpt: Fix login-related race conditions")
Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/ulp/srpt/ib_srpt.c |   17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -2087,7 +2087,7 @@ static int srpt_cm_req_recv(struct srpt_
 		struct rdma_conn_param rdma_cm;
 		struct ib_cm_rep_param ib_cm;
 	} *rep_param = NULL;
-	struct srpt_rdma_ch *ch;
+	struct srpt_rdma_ch *ch = NULL;
 	char i_port_id[36];
 	u32 it_iu_len;
 	int i, ret;
@@ -2234,13 +2234,15 @@ static int srpt_cm_req_recv(struct srpt_
 						TARGET_PROT_NORMAL,
 						i_port_id + 2, ch, NULL);
 	if (IS_ERR_OR_NULL(ch->sess)) {
+		WARN_ON_ONCE(ch->sess == NULL);
 		ret = PTR_ERR(ch->sess);
+		ch->sess = NULL;
 		pr_info("Rejected login for initiator %s: ret = %d.\n",
 			ch->sess_name, ret);
 		rej->reason = cpu_to_be32(ret == -ENOMEM ?
 				SRP_LOGIN_REJ_INSUFFICIENT_RESOURCES :
 				SRP_LOGIN_REJ_CHANNEL_LIMIT_REACHED);
-		goto reject;
+		goto destroy_ib;
 	}
 
 	mutex_lock(&sport->mutex);
@@ -2279,7 +2281,7 @@ static int srpt_cm_req_recv(struct srpt_
 		rej->reason = cpu_to_be32(SRP_LOGIN_REJ_INSUFFICIENT_RESOURCES);
 		pr_err("rejected SRP_LOGIN_REQ because enabling RTR failed (error code = %d)\n",
 		       ret);
-		goto destroy_ib;
+		goto reject;
 	}
 
 	pr_debug("Establish connection sess=%p name=%s ch=%p\n", ch->sess,
@@ -2379,6 +2381,15 @@ reject:
 		ib_send_cm_rej(ib_cm_id, IB_CM_REJ_CONSUMER_DEFINED, NULL, 0,
 			       rej, sizeof(*rej));
 
+	if (ch && ch->sess) {
+		srpt_close_ch(ch);
+		/*
+		 * Tell the caller not to free cm_id since
+		 * srpt_release_channel_work() will do that.
+		 */
+		ret = 0;
+	}
+
 out:
 	kfree(rep_param);
 	kfree(rsp);


