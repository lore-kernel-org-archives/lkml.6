Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEAD5C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B65F72087F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543110;
	bh=CdCyOrKL4CCccWbzqFqtATyV35J1nn5MOitfC/EkZkA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IEnljgezdCsVIU5iw6juwNGnLK4ekF1magpSjypulwPG8KcPxN6sHo+Oj63moApmc
	 vL/wSoGNR31ET1qMqorefBgKrFWRC2T+8Kvxl/8wdPDybpmddyItdSc+OfzCPKGqao
	 kSGpeWLwo3dhITuRgBbrFsFk3isTrvfZzMcAe6s4=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B65F72087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbeLKPpJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:45:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:33514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728014AbeLKPpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:45:06 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6161F2086D;
        Tue, 11 Dec 2018 15:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543105;
        bh=CdCyOrKL4CCccWbzqFqtATyV35J1nn5MOitfC/EkZkA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bTHia1pzbsYdthVUh2EVWqzRRz1/0pGWPC1QA7ANGL7XKWee5A1f3xPTvpV0bpCs+
         tAcsRul4/cPXxkM1+7Ai50zm1WFMPvVtVCW2l0nKdyly/Be2SJLXppqE588ycKJPAK
         bhm4hImPNnY7rmHZP0VWmkhs5JasKQlaai6Mv9ao=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Julian Wiedmann <jwi@linux.ibm.com>,
        Ursula Braun <ubraun@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 04/91] s390/qeth: fix length check in SNMP processing
Date:   Tue, 11 Dec 2018 16:40:23 +0100
Message-Id: <20181211151606.307207186@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151606.026852373@linuxfoundation.org>
References: <20181211151606.026852373@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Julian Wiedmann <jwi@linux.ibm.com>

[ Upstream commit 9a764c1e59684c0358e16ccaafd870629f2cfe67 ]

The response for a SNMP request can consist of multiple parts, which
the cmd callback stages into a kernel buffer until all parts have been
received. If the callback detects that the staging buffer provides
insufficient space, it bails out with error.
This processing is buggy for the first part of the response - while it
initially checks for a length of 'data_len', it later copies an
additional amount of 'offsetof(struct qeth_snmp_cmd, data)' bytes.

Fix the calculation of 'data_len' for the first part of the response.
This also nicely cleans up the memcpy code.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Reviewed-by: Ursula Braun <ubraun@linux.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/s390/net/qeth_core_main.c |   27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -4519,8 +4519,8 @@ static int qeth_snmp_command_cb(struct q
 {
 	struct qeth_ipa_cmd *cmd;
 	struct qeth_arp_query_info *qinfo;
-	struct qeth_snmp_cmd *snmp;
 	unsigned char *data;
+	void *snmp_data;
 	__u16 data_len;
 
 	QETH_CARD_TEXT(card, 3, "snpcmdcb");
@@ -4528,7 +4528,6 @@ static int qeth_snmp_command_cb(struct q
 	cmd = (struct qeth_ipa_cmd *) sdata;
 	data = (unsigned char *)((char *)cmd - reply->offset);
 	qinfo = (struct qeth_arp_query_info *) reply->param;
-	snmp = &cmd->data.setadapterparms.data.snmp;
 
 	if (cmd->hdr.return_code) {
 		QETH_CARD_TEXT_(card, 4, "scer1%x", cmd->hdr.return_code);
@@ -4541,10 +4540,15 @@ static int qeth_snmp_command_cb(struct q
 		return 0;
 	}
 	data_len = *((__u16 *)QETH_IPA_PDU_LEN_PDU1(data));
-	if (cmd->data.setadapterparms.hdr.seq_no == 1)
-		data_len -= (__u16)((char *)&snmp->data - (char *)cmd);
-	else
-		data_len -= (__u16)((char *)&snmp->request - (char *)cmd);
+	if (cmd->data.setadapterparms.hdr.seq_no == 1) {
+		snmp_data = &cmd->data.setadapterparms.data.snmp;
+		data_len -= offsetof(struct qeth_ipa_cmd,
+				     data.setadapterparms.data.snmp);
+	} else {
+		snmp_data = &cmd->data.setadapterparms.data.snmp.request;
+		data_len -= offsetof(struct qeth_ipa_cmd,
+				     data.setadapterparms.data.snmp.request);
+	}
 
 	/* check if there is enough room in userspace */
 	if ((qinfo->udata_len - qinfo->udata_offset) < data_len) {
@@ -4557,16 +4561,9 @@ static int qeth_snmp_command_cb(struct q
 	QETH_CARD_TEXT_(card, 4, "sseqn%i",
 		cmd->data.setadapterparms.hdr.seq_no);
 	/*copy entries to user buffer*/
-	if (cmd->data.setadapterparms.hdr.seq_no == 1) {
-		memcpy(qinfo->udata + qinfo->udata_offset,
-		       (char *)snmp,
-		       data_len + offsetof(struct qeth_snmp_cmd, data));
-		qinfo->udata_offset += offsetof(struct qeth_snmp_cmd, data);
-	} else {
-		memcpy(qinfo->udata + qinfo->udata_offset,
-		       (char *)&snmp->request, data_len);
-	}
+	memcpy(qinfo->udata + qinfo->udata_offset, snmp_data, data_len);
 	qinfo->udata_offset += data_len;
+
 	/* check if all replies received ... */
 		QETH_CARD_TEXT_(card, 4, "srtot%i",
 			       cmd->data.setadapterparms.hdr.used_total);


