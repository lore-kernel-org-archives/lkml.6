Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F68C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5870121527
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:08:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="R31R3v15"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5870121527
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388123AbeKVFnl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 00:43:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:38520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732097AbeKVFnl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 00:43:41 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84CB721527;
        Wed, 21 Nov 2018 19:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542827288;
        bh=86bpagLTLS0C/Qv6BbTqtkfrjobH6t4ntvMmSycc6cI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R31R3v159QCQ03KRlZuanDtpjHM2+jBp4jW6KP5qrA8RtjizYjjQCfs4/E4nrsB0U
         Pq5V8wN7pwxJW2qKzeRVVejH65isS02yHQ5IWr+if56TUOU9MWDoSksUxZpLaCwSyM
         duKjDzVgLYUgzRAUezQeIgDg8s9/H6zjJuVY7MFQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jon Maloy <jon.maloy@ericsson.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 11/42] tipc: dont assume linear buffer when reading ancillary data
Date:   Wed, 21 Nov 2018 20:05:47 +0100
Message-Id: <20181121183148.469188747@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181121183147.869199006@linuxfoundation.org>
References: <20181121183147.869199006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jon Maloy <donmalo99@gmail.com>

[ Upstream commit 1c1274a56999fbdf9cf84e332b28448bb2d55221 ]

The code for reading ancillary data from a received buffer is assuming
the buffer is linear. To make this assumption true we have to linearize
the buffer before message data is read.

Signed-off-by: Jon Maloy <jon.maloy@ericsson.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/tipc/socket.c |   15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

--- a/net/tipc/socket.c
+++ b/net/tipc/socket.c
@@ -1548,16 +1548,17 @@ static void tipc_sk_set_orig_addr(struct
 /**
  * tipc_sk_anc_data_recv - optionally capture ancillary data for received message
  * @m: descriptor for message info
- * @msg: received message header
+ * @skb: received message buffer
  * @tsk: TIPC port associated with message
  *
  * Note: Ancillary data is not captured if not requested by receiver.
  *
  * Returns 0 if successful, otherwise errno
  */
-static int tipc_sk_anc_data_recv(struct msghdr *m, struct tipc_msg *msg,
+static int tipc_sk_anc_data_recv(struct msghdr *m, struct sk_buff *skb,
 				 struct tipc_sock *tsk)
 {
+	struct tipc_msg *msg;
 	u32 anc_data[3];
 	u32 err;
 	u32 dest_type;
@@ -1566,6 +1567,7 @@ static int tipc_sk_anc_data_recv(struct
 
 	if (likely(m->msg_controllen == 0))
 		return 0;
+	msg = buf_msg(skb);
 
 	/* Optionally capture errored message object(s) */
 	err = msg ? msg_errcode(msg) : 0;
@@ -1576,6 +1578,9 @@ static int tipc_sk_anc_data_recv(struct
 		if (res)
 			return res;
 		if (anc_data[1]) {
+			if (skb_linearize(skb))
+				return -ENOMEM;
+			msg = buf_msg(skb);
 			res = put_cmsg(m, SOL_TIPC, TIPC_RETDATA, anc_data[1],
 				       msg_data(msg));
 			if (res)
@@ -1737,9 +1742,10 @@ static int tipc_recvmsg(struct socket *s
 
 	/* Collect msg meta data, including error code and rejected data */
 	tipc_sk_set_orig_addr(m, skb);
-	rc = tipc_sk_anc_data_recv(m, hdr, tsk);
+	rc = tipc_sk_anc_data_recv(m, skb, tsk);
 	if (unlikely(rc))
 		goto exit;
+	hdr = buf_msg(skb);
 
 	/* Capture data if non-error msg, otherwise just set return value */
 	if (likely(!err)) {
@@ -1849,9 +1855,10 @@ static int tipc_recvstream(struct socket
 		/* Collect msg meta data, incl. error code and rejected data */
 		if (!copied) {
 			tipc_sk_set_orig_addr(m, skb);
-			rc = tipc_sk_anc_data_recv(m, hdr, tsk);
+			rc = tipc_sk_anc_data_recv(m, skb, tsk);
 			if (rc)
 				break;
+			hdr = buf_msg(skb);
 		}
 
 		/* Copy data if msg ok, otherwise return error/partial data */


