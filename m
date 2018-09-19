Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIM_INVALID autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8406C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 11:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A39A214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 11:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="I+bxY4sS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A39A214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731338AbeISQwO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 12:52:14 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:56310 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731281AbeISQwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 12:52:13 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 089F88EE152;
        Wed, 19 Sep 2018 04:14:48 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id j0A-9adqR78p; Wed, 19 Sep 2018 04:14:47 -0700 (PDT)
Received: from [172.16.4.187] (unknown [65.196.126.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 34B7E8EE115;
        Wed, 19 Sep 2018 04:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1537355687;
        bh=rB+9OUVYKucIvGiiHIJdY07lLEGueFb70UBepuZZ+UM=;
        h=Subject:From:To:Cc:Date:From;
        b=I+bxY4sStC2RAaXYI56OapBcP/9z9hW3paa2MIOR+xoQM7MoIRn7Pw1bqQxYKoJO3
         W/BCghs4pWWqQaWPD5DQ6W9R4kaUw1HVErTub+ak289odZ+A3ksS/k4Bv3b1RClXGF
         XWhTITp3ihKM1QC8ZelHJySw4YqX3qPVt74e2cG0=
Message-ID: <1537355685.4640.5.camel@HansenPartnership.com>
Subject: [GIT PULL] SCSI fixes for 4.19-rc3
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <greg@kroah.com>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Wed, 19 Sep 2018 07:14:45 -0400
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A couple of small but important fixes, one affecting big endian and the
other fixing a BUG_ON in scatterlist processing.

The patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

The short changelog is:

Dan Carpenter (1):
      scsi: qla2xxx: Fix an endian bug in fcpcmd_is_corrupted()

Laura Abbott (1):
      scsi: iscsi: target: Don't use stack buffer for scatterlist

And the diffstat:

 drivers/scsi/qla2xxx/qla_target.h   |  4 ++--
 drivers/target/iscsi/iscsi_target.c | 22 ++++++++++++++--------
 2 files changed, 16 insertions(+), 10 deletions(-)

With full diff below.

James

---

diff --git a/drivers/scsi/qla2xxx/qla_target.h b/drivers/scsi/qla2xxx/qla_target.h
index fecf96f0225c..199d3ba1916d 100644
--- a/drivers/scsi/qla2xxx/qla_target.h
+++ b/drivers/scsi/qla2xxx/qla_target.h
@@ -374,8 +374,8 @@ struct atio_from_isp {
 static inline int fcpcmd_is_corrupted(struct atio *atio)
 {
 	if (atio->entry_type == ATIO_TYPE7 &&
-	    (le16_to_cpu(atio->attr_n_length & FCP_CMD_LENGTH_MASK) <
-	    FCP_CMD_LENGTH_MIN))
+	    ((le16_to_cpu(atio->attr_n_length) & FCP_CMD_LENGTH_MASK) <
+	     FCP_CMD_LENGTH_MIN))
 		return 1;
 	else
 		return 0;
diff --git a/drivers/target/iscsi/iscsi_target.c b/drivers/target/iscsi/iscsi_target.c
index 9cdfccbdd06f..cc756a123fd8 100644
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
