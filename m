Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4098462-1520452644-2-13732117242376183386
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520452644; b=bjZpp7OgRMSuVZgigF5U8ElaU26cdNc00XDRwmLTPh4LPoQ
    HoH8FWfP2ExJEJg4jZSr0rjp5qkQmSW30cxLO2p9Z2HxBtNEhrNYdmn6dzVzx9mX
    hNDNZIJU1YRD4Xa2BwLcn6gaTnm2m2XXLTZMxRw1loRKg3qnISfGa3NsAuX6oAXD
    gWxJllASEotBjHuMR4JgO9zFQDuOkUyCBQIwADGhFihsKRaKWqoJef26Swvk3CMF
    WN2pEEnC1a0D5Co2Syg6p3lEP53UU7x9rHSCI/FweQTTDKTWB4bB1ysgsa7mGLnZ
    SUBAmZMiicnmj1yNfe8P/awuVmRcYsKQ9Gthxtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520452644; bh=x/iFTSEUYE/wiiH0vNiT8nAqg9
    zomX/V4eMG/YRQKas=; b=HcH74XA3C0g6acsEt5qTrqLBYShbrNxh8u90ZuhVZq
    bCSWx6Q/Zu1UrxtXZ/gbzN9LmXYbzfz57v/ef8AKlmy6VnD1Sk1BpCy8QjwrRoZ+
    1MNtAOGi81wdO4TZpClGiH64rphJIax2eW1bE2c7kWVm2EKfxqPiGpgtc9dpbMCE
    pL3v18B9Qqpl2UydZ0Z06wqmG+vnrnrN4Q66MFP1EdRleP7zBNX8OukWgfZLtkcE
    3tiHGzuFn5HPWxe2ijJ6JzHZUS1GvCw/WFXJdm5PfRVFO0h1IFuAXpM3NejxgNXn
    FuH8IDW/5ETgMgZ3O9uNtr6q3szEa0WKBFJbTyXW72Vg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965426AbeCGTrV (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 14:47:21 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:44944 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965684AbeCGTrS (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Mar 2018 14:47:18 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Julian Wiedmann <jwi@linux.vnet.ibm.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 082/110] s390/qeth: fix IPA command submission race
Date: Wed,  7 Mar 2018 11:39:05 -0800
Message-Id: <20180307191050.321639195@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191039.748351103@linuxfoundation.org>
References: <20180307191039.748351103@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2087,25 +2087,26 @@ int qeth_send_control_data(struct qeth_c
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
 
@@ -2896,7 +2897,7 @@ static void qeth_fill_ipacmd_header(stru
 	memset(cmd, 0, sizeof(struct qeth_ipa_cmd));
 	cmd->hdr.command = command;
 	cmd->hdr.initiator = IPA_CMD_INITIATOR_HOST;
-	cmd->hdr.seqno = card->seqno.ipa;
+	/* cmd->hdr.seqno is set by qeth_send_control_data() */
 	cmd->hdr.adapter_type = qeth_get_ipa_adp_type(card->info.link_type);
 	cmd->hdr.rel_adapter_no = (__u8) card->info.portno;
 	if (card->options.layer2)
