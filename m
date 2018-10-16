Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87324C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5159D2098A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:22:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mOjvQcIW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5159D2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731236AbeJQBOV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:14:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:60912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729116AbeJQBOU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:14:20 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D4A52098A;
        Tue, 16 Oct 2018 17:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710575;
        bh=vhf9LZD1kVikm1F6Dt3D6MYoSLBMC9QUwyTO5K6o7FY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mOjvQcIWCiXth8BxT6N+b70kRN4eRoafW51Qxq71egZQrGWFztYcRmQX1n9MSVfAw
         5a3jUdcWmCcPw9q94PX9sPefLWPBO2y66rLEZglatsLt/27A1rDgvDz99QvJSawSw1
         NKkYAkn9l22Rl8fI5cTi9E9dxfm0zjDh4cfTfpN0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Laura Abbott <labbott@redhat.com>,
        Mike Christie <mchristi@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 06/71] scsi: iscsi: target: Dont use stack buffer for scatterlist
Date:   Tue, 16 Oct 2018 19:09:03 +0200
Message-Id: <20181016170539.681041359@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170539.315587743@linuxfoundation.org>
References: <20181016170539.315587743@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/target/iscsi/iscsi_target.c |   22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

--- a/drivers/target/iscsi/iscsi_target.c
+++ b/drivers/target/iscsi/iscsi_target.c
@@ -1435,7 +1435,8 @@ static void iscsit_do_crypto_hash_buf(
 
 	sg_init_table(sg, ARRAY_SIZE(sg));
 	sg_set_buf(sg, buf, payload_length);
-	sg_set_buf(sg + 1, pad_bytes, padding);
+	if (padding)
+		sg_set_buf(sg + 1, pad_bytes, padding);
 
 	ahash_request_set_crypt(hash, sg, data_crc, payload_length + padding);
 
@@ -3949,10 +3950,14 @@ static bool iscsi_target_check_conn_stat
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
@@ -3960,7 +3965,6 @@ static void iscsit_get_rx_pdu(struct isc
 		 */
 		iscsit_thread_check_cpumask(conn, current, 0);
 
-		memset(buffer, 0, ISCSI_HDR_LEN);
 		memset(&iov, 0, sizeof(struct kvec));
 
 		iov.iov_base	= buffer;
@@ -3969,7 +3973,7 @@ static void iscsit_get_rx_pdu(struct isc
 		ret = rx_data(conn, &iov, 1, ISCSI_HDR_LEN);
 		if (ret != ISCSI_HDR_LEN) {
 			iscsit_rx_thread_wait_for_tcp(conn);
-			return;
+			break;
 		}
 
 		if (conn->conn_ops->HeaderDigest) {
@@ -3979,7 +3983,7 @@ static void iscsit_get_rx_pdu(struct isc
 			ret = rx_data(conn, &iov, 1, ISCSI_CRC_LEN);
 			if (ret != ISCSI_CRC_LEN) {
 				iscsit_rx_thread_wait_for_tcp(conn);
-				return;
+				break;
 			}
 
 			iscsit_do_crypto_hash_buf(conn->conn_rx_hash,
@@ -4003,7 +4007,7 @@ static void iscsit_get_rx_pdu(struct isc
 		}
 
 		if (conn->conn_state == TARG_CONN_STATE_IN_LOGOUT)
-			return;
+			break;
 
 		opcode = buffer[0] & ISCSI_OPCODE_MASK;
 
@@ -4014,13 +4018,15 @@ static void iscsit_get_rx_pdu(struct isc
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


