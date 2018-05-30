Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753476AbeE3LUo (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:20:44 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60989 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752525AbeE3LHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:07:07 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Julian Wiedmann" <jwi@linux.vnet.ibm.com>,
        "David S. Miller" <davem@davemloft.net>
Date: Wed, 30 May 2018 11:52:41 +0100
Message-ID: <lsq.1527677561.655940600@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 081/153] s390/qeth: fix SETIP command handling
In-Reply-To: <lsq.1527677560.486731940@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.2.102-rc1 review patch.  If anyone has any objections, please let me know.

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
@@ -578,6 +578,11 @@ struct qeth_cmd_buffer {
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
@@ -1932,7 +1932,7 @@ int qeth_send_control_data(struct qeth_c
 	unsigned long flags;
 	struct qeth_reply *reply = NULL;
 	unsigned long timeout, event_timeout;
-	struct qeth_ipa_cmd *cmd;
+	struct qeth_ipa_cmd *cmd = NULL;
 
 	QETH_CARD_TEXT(card, 2, "sendctl");
 
@@ -1959,10 +1959,13 @@ int qeth_send_control_data(struct qeth_c
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
@@ -1987,9 +1990,8 @@ int qeth_send_control_data(struct qeth_c
 
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
