Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuJg31yxaj+AWz8n+h8Lech6PXi/0gHsS04fxfwjk02p1lWmHXSnqMkbyB7Jfu3D9NFG4wG
ARC-Seal: i=1; a=rsa-sha256; t=1520641359; cv=none;
        d=google.com; s=arc-20160816;
        b=ahudu3eHFBHC55DTQgRGOWrqMs2PtgQlatitt10YUWjrN4uC1+tcYA0wr5+CLDr4v1
         YOkD+zE1/FErkvZpYGBVtmw2d0NOmCUmiiLF1Kci13dgBSnTqqUkqb3z03ISQII+HIbu
         TfAhmKmyVzqjbfij8uhHBplN0Z2XSbpFiV5b6xZBBNQ9Am/ZtpgGkKOTTFKlBY/wy2t7
         V9mkDJGt138OIEhqTVp6OHySKhYghE2sr9IvlgKu04DR6ydeENPaj1GyX87/EDm5vha2
         CxsxHFExcamsnPqv1h7CWI4A3o3DYDj9UFIUXEIEgTMojQKVkLR+z4XDbkXpey9umZFV
         oj5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=1XbuzA4nOxTqL+XvVW/rEtn7zaVrXbSCeTim6MU5ouA=;
        b=XACjiqk30SgrVefDxBPcM7Z2IpSySjJGfkpJQZ3rUp9EVkCJCsMjbCw8h1Eki5tnnZ
         2Dsx63myyGmykAl7GIwUry+UWA2sB9PQAhAKEpWG92fssZ81YV7PxvpRVcDG/CcP963U
         ux9Molf4eCvPFGCrC9KmWiLD+WcAUYMDkwiP4Kzpf6edQSeKMuhqhDCKyZE8/DgNUadM
         AzFgRvwPlbSfOFmgZEneFIcv+ej903Evcr13OdYuljTbUJSKR0Qf42+kZejiWmV2hheu
         IRLXTjB24yJkKH2op2vrUpOSoRBusJn3GIqSvFRCy+8ds+mzQ8FdeNZyhsgiYoTx23z3
         E8+g==
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
Subject: [PATCH 4.9 55/65] s390/qeth: fix IPA command submission race
Date: Fri,  9 Mar 2018 16:18:55 -0800
Message-Id: <20180310001829.478393332@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310001824.927996722@linuxfoundation.org>
References: <20180310001824.927996722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594507828423441186?=
X-GMAIL-MSGID: =?utf-8?q?1594508034477362172?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Julian Wiedmann <jwi@linux.vnet.ibm.com>


[ Upstream commit d22ffb5a712f9211ffd104c38fc17cbfb1b5e2b0 ]

If multiple IPA commands are build & sent out concurrently,
fill_ipacmd_header() may assign a seqno value to a command that's
different from what send_control_data() later assigns to this command's
reply.
This is due to other commands passing through send_control_data(),
and incrementing card->seqno.ipa along the way.

So one IPA command has no reply that's waiting for its seqno, while some
other IPA command has multiple reply objects waiting for it.
Only one of those waiting replies wins, and the other(s) times out and
triggers a recovery via send_ipa_cmd().

Fix this by making sure that the same seqno value is assigned to
a command and its reply object.
Do so immediately before submitting the command & while holding the
irq_pending "lock", to produce nicely ascending seqnos.

As a side effect, *all* IPA commands now use a reply object that's
waiting for its actual seqno. Previously, early IPA commands that were
submitted while the card was still DOWN used the "catch-all" IDX seqno.

Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/s390/net/qeth_core_main.c |   19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -2064,25 +2064,26 @@ int qeth_send_control_data(struct qeth_c
 	}
 	reply->callback = reply_cb;
 	reply->param = reply_param;
-	if (card->state == CARD_STATE_DOWN)
-		reply->seqno = QETH_IDX_COMMAND_SEQNO;
-	else
-		reply->seqno = card->seqno.ipa++;
+
 	init_waitqueue_head(&reply->wait_q);
-	spin_lock_irqsave(&card->lock, flags);
-	list_add_tail(&reply->list, &card->cmd_waiter_list);
-	spin_unlock_irqrestore(&card->lock, flags);
 	QETH_DBF_HEX(CTRL, 2, iob->data, QETH_DBF_CTRL_LEN);
 
 	while (atomic_cmpxchg(&card->write.irq_pending, 0, 1)) ;
-	qeth_prepare_control_data(card, len, iob);
 
 	if (IS_IPA(iob->data)) {
 		cmd = __ipa_cmd(iob);
+		cmd->hdr.seqno = card->seqno.ipa++;
+		reply->seqno = cmd->hdr.seqno;
 		event_timeout = QETH_IPA_TIMEOUT;
 	} else {
+		reply->seqno = QETH_IDX_COMMAND_SEQNO;
 		event_timeout = QETH_TIMEOUT;
 	}
+	qeth_prepare_control_data(card, len, iob);
+
+	spin_lock_irqsave(&card->lock, flags);
+	list_add_tail(&reply->list, &card->cmd_waiter_list);
+	spin_unlock_irqrestore(&card->lock, flags);
 
 	timeout = jiffies + event_timeout;
 
@@ -2873,7 +2874,7 @@ static void qeth_fill_ipacmd_header(stru
 	memset(cmd, 0, sizeof(struct qeth_ipa_cmd));
 	cmd->hdr.command = command;
 	cmd->hdr.initiator = IPA_CMD_INITIATOR_HOST;
-	cmd->hdr.seqno = card->seqno.ipa;
+	/* cmd->hdr.seqno is set by qeth_send_control_data() */
 	cmd->hdr.adapter_type = qeth_get_ipa_adp_type(card->info.link_type);
 	cmd->hdr.rel_adapter_no = (__u8) card->info.portno;
 	if (card->options.layer2)
