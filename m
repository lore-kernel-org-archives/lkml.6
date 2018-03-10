Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvhCwXmbhFWEQZxlGK8ASEKSzW0Di6ay47CU3fKEJN2vOECWQssI+ql0kAK91iRy2TnKz/9
ARC-Seal: i=1; a=rsa-sha256; t=1520641245; cv=none;
        d=google.com; s=arc-20160816;
        b=tcJCHvWYscfY8p8hUt82+VHNo7G3bhy+p2R2QAqFuFGgvJZD9WKMu1smOpmdz2o4EZ
         JykyQ6v3nBUH0ffycrmAoclLrYiAHt/uxURCWo8xu/Prqr7bK9cVCCmaiIDJldyIlh6d
         ItnglC5xO5AnfOFa3SuARcptj72Ot/4IdOqH1U+JHmvcdZ8i5ZqWSmRxBatwPjeogxEg
         qRq7vZcIq9maFijhLBkm373FUZaTXhudPByb1iRC/Ny50bmOWYLg5qgQw8Ku2tJ3f498
         R+suJYp83dNRtK14gc7nEgMkd0Wg16+xSTAOSp2XJjRJ2zMV0XyYji24YzBXjcxxZEZO
         Ntnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=XgTUyqdSLVPir9YBkYnqB3kXpeaQ2cTfaEOHnVHCdq4=;
        b=OqvAutGH2b4vej6MQsuZwrXrQh9wGPz8O02/PmEr0xj2UnswF7y+3QqsqUpVCggFOH
         PlJyOIvaa8aysY4FQ8uuc7mF0SC3yP29QSamehtwKcfgNZE4++A4IXjwmu0eYWSRPbSh
         HHJ8rp9n3U3HooL+Dnr0voITNx+H0MweKQxkY0p/ZKhIwhP1PT5x/saP00/qql4hJ6DE
         Wxy/PE4QBkTAfFy5Y5NrYCVLH4qbUpp8b3ifdh8hi1piJlFW+bZuTskD1yXki+z2uski
         D1uRORU9qm96r4dL3aibRN+SPhcPLRa0ESFRMnJGQA3yJ0onL8zY6MA+qHlXEcQ66iWc
         ak2Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Julian Wiedmann <jwi@linux.vnet.ibm.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 29/36] s390/qeth: fix SETIP command handling
Date: Fri,  9 Mar 2018 16:18:45 -0800
Message-Id: <20180310001808.973365521@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310001807.213987241@linuxfoundation.org>
References: <20180310001807.213987241@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594507826559003537?=
X-GMAIL-MSGID: =?utf-8?q?1594507914337428725?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Julian Wiedmann <jwi@linux.vnet.ibm.com>


[ Upstream commit 1c5b2216fbb973a9410e0b06389740b5c1289171 ]

send_control_data() applies some special handling to SETIP v4 IPA
commands. But current code parses *all* command types for the SETIP
command code. Limit the command code check to IPA commands.

Fixes: 5b54e16f1a54 ("qeth: do not spin for SETIP ip assist command")
Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/s390/net/qeth_core.h      |    5 +++++
 drivers/s390/net/qeth_core_main.c |   14 ++++++++------
 2 files changed, 13 insertions(+), 6 deletions(-)

--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -591,6 +591,11 @@ struct qeth_cmd_buffer {
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
@@ -2054,7 +2054,7 @@ int qeth_send_control_data(struct qeth_c
 	unsigned long flags;
 	struct qeth_reply *reply = NULL;
 	unsigned long timeout, event_timeout;
-	struct qeth_ipa_cmd *cmd;
+	struct qeth_ipa_cmd *cmd = NULL;
 
 	QETH_CARD_TEXT(card, 2, "sendctl");
 
@@ -2081,10 +2081,13 @@ int qeth_send_control_data(struct qeth_c
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
@@ -2109,9 +2112,8 @@ int qeth_send_control_data(struct qeth_c
 
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
