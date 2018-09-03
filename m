Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04DDBC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE14B20645
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:15:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE14B20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729635AbeICVgc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:36:32 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42390 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728054AbeICVgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:36:31 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 49256D06;
        Mon,  3 Sep 2018 17:15:27 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Varun Prakash <varun@chelsio.com>,
        Mike Christie <mchristi@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 010/165] scsi: target: iscsi: cxgbit: fix max iso npdu calculation
Date:   Mon,  3 Sep 2018 18:54:56 +0200
Message-Id: <20180903165655.530127497@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903165655.003605184@linuxfoundation.org>
References: <20180903165655.003605184@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Varun Prakash <varun@chelsio.com>

[ Upstream commit 1b350ea0c2f4df9aa30426614c8eb755a8c32814 ]

- rounddown CXGBIT_MAX_ISO_PAYLOAD by csk->emss before calculating
  max_iso_npdu to get max TCP payload in multiple of mss.

- call cxgbit_set_digest() before cxgbit_set_iso_npdu() to set
  csk->submode, it is used in calculating number of iso pdus.

Signed-off-by: Varun Prakash <varun@chelsio.com>
Reviewed-by: Mike Christie <mchristi@redhat.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/target/iscsi/cxgbit/cxgbit_target.c |   16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

--- a/drivers/target/iscsi/cxgbit/cxgbit_target.c
+++ b/drivers/target/iscsi/cxgbit/cxgbit_target.c
@@ -652,6 +652,7 @@ static int cxgbit_set_iso_npdu(struct cx
 	struct iscsi_param *param;
 	u32 mrdsl, mbl;
 	u32 max_npdu, max_iso_npdu;
+	u32 max_iso_payload;
 
 	if (conn->login->leading_connection) {
 		param = iscsi_find_param_from_key(MAXBURSTLENGTH,
@@ -670,8 +671,10 @@ static int cxgbit_set_iso_npdu(struct cx
 	mrdsl = conn_ops->MaxRecvDataSegmentLength;
 	max_npdu = mbl / mrdsl;
 
-	max_iso_npdu = CXGBIT_MAX_ISO_PAYLOAD /
-			(ISCSI_HDR_LEN + mrdsl +
+	max_iso_payload = rounddown(CXGBIT_MAX_ISO_PAYLOAD, csk->emss);
+
+	max_iso_npdu = max_iso_payload /
+		       (ISCSI_HDR_LEN + mrdsl +
 			cxgbit_digest_len[csk->submode]);
 
 	csk->max_iso_npdu = min(max_npdu, max_iso_npdu);
@@ -741,6 +744,9 @@ static int cxgbit_set_params(struct iscs
 	if (conn_ops->MaxRecvDataSegmentLength > cdev->mdsl)
 		conn_ops->MaxRecvDataSegmentLength = cdev->mdsl;
 
+	if (cxgbit_set_digest(csk))
+		return -1;
+
 	if (conn->login->leading_connection) {
 		param = iscsi_find_param_from_key(ERRORRECOVERYLEVEL,
 						  conn->param_list);
@@ -764,7 +770,7 @@ static int cxgbit_set_params(struct iscs
 			if (is_t5(cdev->lldi.adapter_type))
 				goto enable_ddp;
 			else
-				goto enable_digest;
+				return 0;
 		}
 
 		if (test_bit(CDEV_ISO_ENABLE, &cdev->flags)) {
@@ -781,10 +787,6 @@ enable_ddp:
 		}
 	}
 
-enable_digest:
-	if (cxgbit_set_digest(csk))
-		return -1;
-
 	return 0;
 }
 


