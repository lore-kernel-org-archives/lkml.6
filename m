Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC81C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 18:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 366DC2077C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 18:47:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 366DC2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbeIDXOJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 19:14:09 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:46046 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbeIDXOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 19:14:09 -0400
Received: by mail-qt0-f196.google.com with SMTP id g44-v6so5166961qtb.12
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 11:47:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uNMTaD34cNXpuKyXxVIDAmgW5Xj/HNcF73LOfiYXYV4=;
        b=fKkP37dwHNJ9mX5kppZhdd9XKv+AGAF09QHwFUL9+M0Y3VtFFenPKb8JwcxwQql2Fj
         y0vABmAydaE7efTe6gx6ydR+9q98fZA1Tgzxgori1z7zjCmVuuK07j73Z6B5txxn4HNH
         lMTJbMt8t6THWORa3dHNCuLrUTKexQFmPUgvRaKOYrZXHqhoFQRsUVrtLj60aLzNT2NR
         aSvsTuAF1gSfnU3zsRnThCc9X0hxmuv57+B63Tnqvz+Xnr7ijZl+EgBYuV/rZab8Hi2g
         Dmhc65HhxyLR7aPPJC6jzchP2RlBFMyFSGjRhY8R1y32tuwaQbi7+5Hyk8iwc5ZmKaU3
         fuMA==
X-Gm-Message-State: APzg51DrZwlUyvugsIOefONOi6x2fEeUzDxjwsD2JnSnl4D85P3QnPIq
        8zwYQB+x4/+X4i0n+OlHPbLqJQ==
X-Google-Smtp-Source: ANB0VdZHJGQxycee7FWyjMrb7Kj6PAkRmEKYRlGuISXzHfZea1EoCtcC5MSXnUpHtlPBON/5PXzCuw==
X-Received: by 2002:ac8:167a:: with SMTP id x55-v6mr31090803qtk.67.1536086866482;
        Tue, 04 Sep 2018 11:47:46 -0700 (PDT)
Received: from labbott-redhat.redhat.com ([2601:602:9802:a8dc::3c7a])
        by smtp.gmail.com with ESMTPSA id f63-v6sm12601473qtb.64.2018.09.04.11.47.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Sep 2018 11:47:45 -0700 (PDT)
From:   Laura Abbott <labbott@redhat.com>
To:     "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Mike Christie <mchristi@redhat.com>,
        Maurizio Lombardi <mlombard@redhat.com>
Cc:     Laura Abbott <labbott@redhat.com>, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: [PATCHv3] iscsi-target: Don't use stack buffer for scatterlist
Date:   Tue,  4 Sep 2018 11:47:40 -0700
Message-Id: <20180904184740.11102-1-labbott@redhat.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

This is a BUG_ON for using a stack buffer with a scatterlist.
There are two cases that trigger this bug. Switch to using a
dynamically allocated buffer for one case and do not assign
a NULL buffer in another case.

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
v3: Switched to kcalloc to drop an extra memset call. I was asked
offline about kmalloc vs. kmalloc_array and ended up asking about this
at the security summit since I was there last week. The preferred style
is kmalloc_array for all arrays, even those of one byte characters.
I will also switch it if people feel really strongly about this or I've
misunderstood the array guidelines.
---
 drivers/target/iscsi/iscsi_target.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/target/iscsi/iscsi_target.c b/drivers/target/iscsi/iscsi_target.c
index 94bad43c41ff..2a586b58a011 100644
--- a/drivers/target/iscsi/iscsi_target.c
+++ b/drivers/target/iscsi/iscsi_target.c
@@ -1416,7 +1416,8 @@ static void iscsit_do_crypto_hash_buf(struct ahash_request *hash,
 
 	sg_init_table(sg, ARRAY_SIZE(sg));
 	sg_set_buf(sg, buf, payload_length);
-	sg_set_buf(sg + 1, pad_bytes, padding);
+	if (padding)
+		sg_set_buf(sg + 1, pad_bytes, padding);
 
 	ahash_request_set_crypt(hash, sg, data_crc, payload_length + padding);
 
@@ -3910,10 +3911,14 @@ static bool iscsi_target_check_conn_state(struct iscsi_conn *conn)
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
@@ -3921,7 +3926,6 @@ static void iscsit_get_rx_pdu(struct iscsi_conn *conn)
 		 */
 		iscsit_thread_check_cpumask(conn, current, 0);
 
-		memset(buffer, 0, ISCSI_HDR_LEN);
 		memset(&iov, 0, sizeof(struct kvec));
 
 		iov.iov_base	= buffer;
@@ -3930,7 +3934,7 @@ static void iscsit_get_rx_pdu(struct iscsi_conn *conn)
 		ret = rx_data(conn, &iov, 1, ISCSI_HDR_LEN);
 		if (ret != ISCSI_HDR_LEN) {
 			iscsit_rx_thread_wait_for_tcp(conn);
-			return;
+			break;
 		}
 
 		if (conn->conn_ops->HeaderDigest) {
@@ -3940,7 +3944,7 @@ static void iscsit_get_rx_pdu(struct iscsi_conn *conn)
 			ret = rx_data(conn, &iov, 1, ISCSI_CRC_LEN);
 			if (ret != ISCSI_CRC_LEN) {
 				iscsit_rx_thread_wait_for_tcp(conn);
-				return;
+				break;
 			}
 
 			iscsit_do_crypto_hash_buf(conn->conn_rx_hash, buffer,
@@ -3964,7 +3968,7 @@ static void iscsit_get_rx_pdu(struct iscsi_conn *conn)
 		}
 
 		if (conn->conn_state == TARG_CONN_STATE_IN_LOGOUT)
-			return;
+			break;
 
 		opcode = buffer[0] & ISCSI_OPCODE_MASK;
 
@@ -3975,13 +3979,15 @@ static void iscsit_get_rx_pdu(struct iscsi_conn *conn)
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

