Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtIZwMlXsJT+vNN3sDQmGwzgVoObCslu7En8S1sFe25BbAk8Sri6GEoUuatT5jOnI/G89bV
ARC-Seal: i=1; a=rsa-sha256; t=1520641161; cv=none;
        d=google.com; s=arc-20160816;
        b=QsrisAQjIkliF8a/VXQp/5oInDlSooeXJ6L/P8yzbWbG4O+vKjUXs5JrvExrC2tkmn
         iuIjsPxioDzYWFkQdYZ9oSjWi33Megzd6XhkkE6MLPSTnicqmdl2IukryHaYlSaFwprG
         +4geqhlpPp25SKbzX6C5uuFnp3iuZmJX1QmbAZwNlMfrEB3s31+G4Xa+CXjuyuEJ2MI/
         IeU86I7ZrTLBGXl7qbRbzjHtTMv5x9g9G8xXnBIqxz9tfukbpNckmu3wDM+DQp6NeX2/
         Eb2c9VneJCqW2si1y2/5tJXd2DIvdRzcxBQHcJqjztzz6J49vL8EbU7A8b0QfhVz3UHT
         kLEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=k5LEE/Fhaz12dAhBlUcegOjC6LJtcdVe7hE/q1VikrM=;
        b=l9mKS5PkXkDxBrKmkMKwha5orzjivqtIfyoLyVo+bEs+z1KV6FmY4YWp1YfUgHFwmK
         I221w+3PAueF6WEHcRHaIVvX/5sc4C1ndodJU0FVSReCIs8KGK7uJPf4LReifzt+tqaA
         g4hrPe8BYPuwz9P966K14dxF+F99pq9YTThqzFVpGWPkIqHoT3Nbtf8ps8vX61NOzJuz
         eLxdszsTaTbaKuV75S+QvwCSo4kauLRNQ66FF5oN3CPQfQGTTT79ToI8AY31ayxCQyac
         5WBjxNAjRfbLU4adMM9qhkhkvPFyrBZknCmA9hmOh91wcGD7/jxwrN3VevNsKNszxQrI
         Aulw==
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
Subject: [PATCH 3.18 16/21] s390/qeth: fix SETIP command handling
Date: Fri,  9 Mar 2018 16:18:38 -0800
Message-Id: <20180310001802.060960819@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310001801.045114869@linuxfoundation.org>
References: <20180310001801.045114869@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594507826559003537?=
X-GMAIL-MSGID: =?utf-8?q?1594507826559003537?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2023,7 +2023,7 @@ int qeth_send_control_data(struct qeth_c
 	unsigned long flags;
 	struct qeth_reply *reply = NULL;
 	unsigned long timeout, event_timeout;
-	struct qeth_ipa_cmd *cmd;
+	struct qeth_ipa_cmd *cmd = NULL;
 
 	QETH_CARD_TEXT(card, 2, "sendctl");
 
@@ -2050,10 +2050,13 @@ int qeth_send_control_data(struct qeth_c
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
@@ -2078,9 +2081,8 @@ int qeth_send_control_data(struct qeth_c
 
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
