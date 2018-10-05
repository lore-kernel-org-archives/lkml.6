Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FBD7C65BA7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA062214C2
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:17:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="F1oyyb2v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA062214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730186AbeJEXQg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 19:16:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:54742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730141AbeJEXQf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:16:35 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B95892148C;
        Fri,  5 Oct 2018 16:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538756231;
        bh=hywgDrlljZ0Lin0JeClugNBK9f4qfF6lEQ4q46IVopo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F1oyyb2vp0H3rjmJRLnGbmfp7dJsmcPlDD456tqngeApDXVD62ZPmCshCQu8mmazC
         lmPBaeHRElIfwhWPjY15ZjXEb6A1UaqQHTAhVy5rqoCkCENUSasXDBSXen6YtTnvfx
         nhk6dLTwaM95FadeNDF+pZNkfU0mRwbZ8PkZ+MMs=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Laura Abbott <labbott@redhat.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 06/14] scsi: iscsi: target: Don't use stack buffer for scatterlist
Date:   Fri,  5 Oct 2018 12:16:56 -0400
Message-Id: <20181005161704.20704-6-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181005161704.20704-1-sashal@kernel.org>
References: <20181005161704.20704-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Laura Abbott <labbott@redhat.com>

[ Upstream commit 679fcae46c8b2352bba3485d521da070cfbe68e6 ]

Fedora got a bug report of a crash with iSCSI:

kernel BUG at include/linux/scatterlist.h:143!
...
RIP: 0010:iscsit_do_crypto_hash_buf+0x154/0x180 [iscsi_target_mod]
...
 Call Trace:
  ? iscsi_target_tx_thread+0x200/0x200 [iscsi_target_mod]
  iscsit_get_rx_pdu+0x4cd/0xa90 [iscsi_target_mod]
  ? native_sched_clock+0x3e/0xa0
  ? iscsi_target_tx_thread+0x200/0x200 [iscsi_target_mod]
  iscsi_target_rx_thread+0x81/0xf0 [iscsi_target_mod]
  kthread+0x120/0x140
  ? kthread_create_worker_on_cpu+0x70/0x70
  ret_from_fork+0x3a/0x50

This is a BUG_ON for using a stack buffer with a scatterlist.  There
are two cases that trigger this bug. Switch to using a dynamically
allocated buffer for one case and do not assign a NULL buffer in
another case.

Signed-off-by: Laura Abbott <labbott@redhat.com>
Reviewed-by: Mike Christie <mchristi@redhat.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/target/iscsi/iscsi_target.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/target/iscsi/iscsi_target.c b/drivers/target/iscsi/iscsi_target.c
index 04d2b6e25503..80205f3362d4 100644
--- a/drivers/target/iscsi/iscsi_target.c
+++ b/drivers/target/iscsi/iscsi_target.c
@@ -1435,7 +1435,8 @@ static void iscsit_do_crypto_hash_buf(
 
 	sg_init_table(sg, ARRAY_SIZE(sg));
 	sg_set_buf(sg, buf, payload_length);
-	sg_set_buf(sg + 1, pad_bytes, padding);
+	if (padding)
+		sg_set_buf(sg + 1, pad_bytes, padding);
 
 	ahash_request_set_crypt(hash, sg, data_crc, payload_length + padding);
 
@@ -3949,10 +3950,14 @@ static bool iscsi_target_check_conn_state(struct iscsi_conn *conn)
 static void iscsit_get_rx_pdu(struct iscsi_conn *conn)
 {
 	int ret;
-	u8 buffer[ISCSI_HDR_LEN], opcode;
+	u8 *buffer, opcode;
 	u32 checksum = 0, digest = 0;
 	struct kvec iov;
 
+	buffer = kcalloc(ISCSI_HDR_LEN, sizeof(*buffer), GFP_KERNEL);
+	if (!buffer)
+		return;
+
 	while (!kthread_should_stop()) {
 		/*
 		 * Ensure that both TX and RX per connection kthreads
@@ -3960,7 +3965,6 @@ static void iscsit_get_rx_pdu(struct iscsi_conn *conn)
 		 */
 		iscsit_thread_check_cpumask(conn, current, 0);
 
-		memset(buffer, 0, ISCSI_HDR_LEN);
 		memset(&iov, 0, sizeof(struct kvec));
 
 		iov.iov_base	= buffer;
@@ -3969,7 +3973,7 @@ static void iscsit_get_rx_pdu(struct iscsi_conn *conn)
 		ret = rx_data(conn, &iov, 1, ISCSI_HDR_LEN);
 		if (ret != ISCSI_HDR_LEN) {
 			iscsit_rx_thread_wait_for_tcp(conn);
-			return;
+			break;
 		}
 
 		if (conn->conn_ops->HeaderDigest) {
@@ -3979,7 +3983,7 @@ static void iscsit_get_rx_pdu(struct iscsi_conn *conn)
 			ret = rx_data(conn, &iov, 1, ISCSI_CRC_LEN);
 			if (ret != ISCSI_CRC_LEN) {
 				iscsit_rx_thread_wait_for_tcp(conn);
-				return;
+				break;
 			}
 
 			iscsit_do_crypto_hash_buf(conn->conn_rx_hash,
@@ -4003,7 +4007,7 @@ static void iscsit_get_rx_pdu(struct iscsi_conn *conn)
 		}
 
 		if (conn->conn_state == TARG_CONN_STATE_IN_LOGOUT)
-			return;
+			break;
 
 		opcode = buffer[0] & ISCSI_OPCODE_MASK;
 
@@ -4014,13 +4018,15 @@ static void iscsit_get_rx_pdu(struct iscsi_conn *conn)
 			" while in Discovery Session, rejecting.\n", opcode);
 			iscsit_add_reject(conn, ISCSI_REASON_PROTOCOL_ERROR,
 					  buffer);
-			return;
+			break;
 		}
 
 		ret = iscsi_target_rx_opcode(conn, buffer);
 		if (ret < 0)
-			return;
+			break;
 	}
+
+	kfree(buffer);
 }
 
 int iscsi_target_rx_thread(void *arg)
-- 
2.17.1

