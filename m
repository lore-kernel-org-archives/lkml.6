Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id eEJyChk5GVvhBQAAmS7hNA
	; Thu, 07 Jun 2018 14:23:46 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 2472D607E7; Thu,  7 Jun 2018 14:23:46 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 93386602FC;
	Thu,  7 Jun 2018 14:23:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 93386602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933359AbeFGOV6 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:21:58 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:39439 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933075AbeFGOJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:09:10 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbA-0005Zj-MB; Thu, 07 Jun 2018 15:09:08 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb7-00032U-0u; Thu, 07 Jun 2018 15:09:05 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "David S. Miller" <davem@davemloft.net>,
        "Julian Wiedmann" <jwi@linux.vnet.ibm.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.851760249@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 223/410] s390/qeth: fix SETIP command handling
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Julian Wiedmann <jwi@linux.vnet.ibm.com>

commit 1c5b2216fbb973a9410e0b06389740b5c1289171 upstream.

send_control_data() applies some special handling to SETIP v4 IPA
commands. But current code parses *all* command types for the SETIP
command code. Limit the command code check to IPA commands.

Fixes: 5b54e16f1a54 ("qeth: do not spin for SETIP ip assist command")
Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/s390/net/qeth_core.h      |  5 +++++
 drivers/s390/net/qeth_core_main.c | 14 ++++++++------
 2 files changed, 13 insertions(+), 6 deletions(-)

--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -593,6 +593,11 @@ struct qeth_cmd_buffer {
 	void (*callback) (struct qeth_channel *, struct qeth_cmd_buffer *);
 };
 
+static inline struct qeth_ipa_cmd *__ipa_cmd(struct qeth_cmd_buffer *iob)
+{
+	return (struct qeth_ipa_cmd *)(iob->data + IPA_PDU_HEADER_SIZE);
+}
+
 /**
  * definition of a qeth channel, used for read and write
  */
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -2025,7 +2025,7 @@ int qeth_send_control_data(struct qeth_c
 	unsigned long flags;
 	struct qeth_reply *reply = NULL;
 	unsigned long timeout, event_timeout;
-	struct qeth_ipa_cmd *cmd;
+	struct qeth_ipa_cmd *cmd = NULL;
 
 	QETH_CARD_TEXT(card, 2, "sendctl");
 
@@ -2052,10 +2052,13 @@ int qeth_send_control_data(struct qeth_c
 	while (atomic_cmpxchg(&card->write.irq_pending, 0, 1)) ;
 	qeth_prepare_control_data(card, len, iob);
 
-	if (IS_IPA(iob->data))
+	if (IS_IPA(iob->data)) {
+		cmd = __ipa_cmd(iob);
 		event_timeout = QETH_IPA_TIMEOUT;
-	else
+	} else {
 		event_timeout = QETH_TIMEOUT;
+	}
+
 	timeout = jiffies + event_timeout;
 
 	QETH_CARD_TEXT(card, 6, "noirqpnd");
@@ -2080,9 +2083,8 @@ int qeth_send_control_data(struct qeth_c
 
 	/* we have only one long running ipassist, since we can ensure
 	   process context of this command we can sleep */
-	cmd = (struct qeth_ipa_cmd *)(iob->data+IPA_PDU_HEADER_SIZE);
-	if ((cmd->hdr.command == IPA_CMD_SETIP) &&
-	    (cmd->hdr.prot_version == QETH_PROT_IPV4)) {
+	if (cmd && cmd->hdr.command == IPA_CMD_SETIP &&
+	    cmd->hdr.prot_version == QETH_PROT_IPV4) {
 		if (!wait_event_timeout(reply->wait_q,
 		    atomic_read(&reply->received), event_timeout))
 			goto time_err;
