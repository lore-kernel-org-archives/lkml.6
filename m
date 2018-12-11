Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D66C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0753C2084E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544545481;
	bh=NadqNZpm5Jfi5A8+/vBUrMuR0JPbQ0U46WI8ggTOlrU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=O6BKojoMBNZjKeGhW90fDKQPxBcN7TJ8Pk+IQGtzPD+zk0t35g9G1Sj6JzgCbUE/Q
	 HaAp0vNW1ixNxSH7O9PUJ/s0ltaP9Y9bzzgW1/exWE800FbFR0HHYIILbg6XaEQtgU
	 JK6bwtvh3uyEdKXt0om/6URg3FQ+C0zE+qGdIMpw=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0753C2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbeLKPmh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:42:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:58922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727263AbeLKPme (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:42:34 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F412020672;
        Tue, 11 Dec 2018 15:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544542953;
        bh=NadqNZpm5Jfi5A8+/vBUrMuR0JPbQ0U46WI8ggTOlrU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qgAiP+UAqo76BV95zc0SX1WCUhn98jzvbqvfKfVe6JdGflB6jxh1xrs3l0kmtWqR3
         TvtACKQdA7fqsVtYnZaVciSTbhg0P9XYRXEn/XE0j/hqwoEBia5H+IaJyZf1MjqRF3
         jtnviCcvOHXRaTtKjc75FTNdkIdKcSfXCoN61nZY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Julian Wiedmann <jwi@linux.ibm.com>,
        Ursula Braun <ubraun@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 3.18 03/54] s390/qeth: fix length check in SNMP processing
Date:   Tue, 11 Dec 2018 16:40:51 +0100
Message-Id: <20181211151546.202527983@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151546.010073210@linuxfoundation.org>
References: <20181211151546.010073210@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -4496,8 +4496,8 @@ static int qeth_snmp_command_cb(struct q
 {
 	struct qeth_ipa_cmd *cmd;
 	struct qeth_arp_query_info *qinfo;
-	struct qeth_snmp_cmd *snmp;
 	unsigned char *data;
+	void *snmp_data;
 	__u16 data_len;
 
 	QETH_CARD_TEXT(card, 3, "snpcmdcb");
@@ -4505,7 +4505,6 @@ static int qeth_snmp_command_cb(struct q
 	cmd = (struct qeth_ipa_cmd *) sdata;
 	data = (unsigned char *)((char *)cmd - reply->offset);
 	qinfo = (struct qeth_arp_query_info *) reply->param;
-	snmp = &cmd->data.setadapterparms.data.snmp;
 
 	if (cmd->hdr.return_code) {
 		QETH_CARD_TEXT_(card, 4, "scer1%i", cmd->hdr.return_code);
@@ -4518,10 +4517,15 @@ static int qeth_snmp_command_cb(struct q
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
@@ -4534,16 +4538,9 @@ static int qeth_snmp_command_cb(struct q
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


