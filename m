Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7561C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90E182087F
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:48:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yrwmDd6d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90E182087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729278AbeLEJsZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:48:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:51576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729558AbeLEJqL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:46:11 -0500
Received: from sasha-vm.mshome.net (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DE8E20878;
        Wed,  5 Dec 2018 09:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544003170;
        bh=QI9KjFox9ChtohRfEi/OKph3qLoWW1iE1U3EOPusId0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yrwmDd6dyfdweq9xdOvZjEAAHM4d06f59baURkBYBYvThCV7AGWso9hjcLjjC+QCd
         hOvX5h9QBldroUAd5/ecHCuuC69bvIiUvO04kDvYjp/HhvIVs7VDyWHuHs0eDkEIBM
         mc572IjtIFraFAwVE1c2PFBs1EY8BNFpmoOGl2tg=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Julian Wiedmann <jwi@linux.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 52/69] s390/qeth: fix length check in SNMP processing
Date:   Wed,  5 Dec 2018 04:42:30 -0500
Message-Id: <20181205094247.6556-52-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205094247.6556-1-sashal@kernel.org>
References: <20181205094247.6556-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/net/qeth_core_main.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 169dd7127f9e..69ef5f4060ed 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -4545,8 +4545,8 @@ static int qeth_snmp_command_cb(struct qeth_card *card,
 {
 	struct qeth_ipa_cmd *cmd;
 	struct qeth_arp_query_info *qinfo;
-	struct qeth_snmp_cmd *snmp;
 	unsigned char *data;
+	void *snmp_data;
 	__u16 data_len;
 
 	QETH_CARD_TEXT(card, 3, "snpcmdcb");
@@ -4554,7 +4554,6 @@ static int qeth_snmp_command_cb(struct qeth_card *card,
 	cmd = (struct qeth_ipa_cmd *) sdata;
 	data = (unsigned char *)((char *)cmd - reply->offset);
 	qinfo = (struct qeth_arp_query_info *) reply->param;
-	snmp = &cmd->data.setadapterparms.data.snmp;
 
 	if (cmd->hdr.return_code) {
 		QETH_CARD_TEXT_(card, 4, "scer1%x", cmd->hdr.return_code);
@@ -4567,10 +4566,15 @@ static int qeth_snmp_command_cb(struct qeth_card *card,
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
@@ -4583,16 +4587,9 @@ static int qeth_snmp_command_cb(struct qeth_card *card,
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
-- 
2.17.1

