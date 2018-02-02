Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2948269-1517591511-2-13080876308148693606
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517591510; b=marOUwrzVxIt9nk/lfY9ccJouuhAPE7Bkm5NCuxKPKPV7up
    pPFXjfdbGfrrzyTX+pKpI7IP5LKvazmM7ov1fTiB+DwIcpvvOHm3fkZQdI4aikr6
    uME3qUkLguEVGXf9i5k+gRy//EecQRmfYMXSDKn3BOti0xwOuSwq+qAJ7UwQ+N5B
    QR4QFSYk6Cy2V9R/wAhx9wF7EFwv822WKVWu8ka7I5OxucfXsqwbK9vVpBpHreU/
    CRDdcwS93WKNqiF37hBlvRIjQra2g3hoTUQB1r/VdIaMtwjUp/K6Un2/LcvUiEDw
    Y8G5ZNJ6uufZVpTvjZ9mSEBV44bi1NJbU064SUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517591510; bh=31807pIAv9n2+Zh7QhBzyK+hG5
    BUrXc0GiNTncabKfE=; b=E8+BpH7pgigm0DK8iA3e3TOEvksnV9//2/FxMIwvjv
    6j3QY+L4C4my8ITMATzQl9/mE961YNvyCqJ3seCdbfzDDiPDr8Y1mdqg3CHiWYCo
    hZTmfhXMcJg6BsMN7hdSZKV6nhI3ET+h9Uy75WwSkcZgXnRLNSH87Q4WJchqaumT
    leDIWu0iCF8y797ZR12SpDBc/C2OpenlR/e0XX+aQ0E5q5QLlUU+hsagB3cN/cJi
    5zR+xf/thwkv1OGwiR1Fqs+lpYDIOS/Xd7YM8ip2olshPmBch2cHI+YFREJECcC0
    ldTQS7ETmO3a0Qr6iLs49o2FIatonxCK55My5WLggAWQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753415AbeBBRLr (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 12:11:47 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:38740 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753146AbeBBRLn (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 12:11:43 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xin Long <lucien.xin@gmail.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 073/156] sctp: avoid flushing unsent queue when doing asoc reset
Date: Fri,  2 Feb 2018 17:57:34 +0100
Message-Id: <20180202140843.584159834@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xin Long <lucien.xin@gmail.com>


[ Upstream commit 159f2a7456c6ae95c1e1a58e8b8ec65ef12d51cf ]

Now when doing asoc reset, it cleans up sacked and abandoned queues
by calling sctp_outq_free where it also cleans up unsent, retransmit
and transmitted queues.

It's safe for the sender of response, as these 3 queues are empty at
that time. But when the receiver of response is doing the reset, the
users may already enqueue some chunks into unsent during the time
waiting the response, and these chunks should not be flushed.

To void the chunks in it would be removed, it moves the queue into a
temp list, then gets it back after sctp_outq_free is done.

The patch also fixes some incorrect comments in
sctp_process_strreset_tsnreq.

Signed-off-by: Xin Long <lucien.xin@gmail.com>
Acked-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sctp/stream.c |   21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

--- a/net/sctp/stream.c
+++ b/net/sctp/stream.c
@@ -563,9 +563,10 @@ struct sctp_chunk *sctp_process_strreset
 		goto out;
 	}
 
-	/* G3: The same processing as though a SACK chunk with no gap report
-	 *     and a cumulative TSN ACK of the Sender's Next TSN minus 1 were
-	 *     received MUST be performed.
+	/* G4: The same processing as though a FWD-TSN chunk (as defined in
+	 *     [RFC3758]) with all streams affected and a new cumulative TSN
+	 *     ACK of the Receiver's Next TSN minus 1 were received MUST be
+	 *     performed.
 	 */
 	max_tsn_seen = sctp_tsnmap_get_max_tsn_seen(&asoc->peer.tsn_map);
 	sctp_ulpq_reasm_flushtsn(&asoc->ulpq, max_tsn_seen);
@@ -580,10 +581,9 @@ struct sctp_chunk *sctp_process_strreset
 	sctp_tsnmap_init(&asoc->peer.tsn_map, SCTP_TSN_MAP_INITIAL,
 			 init_tsn, GFP_ATOMIC);
 
-	/* G4: The same processing as though a FWD-TSN chunk (as defined in
-	 *     [RFC3758]) with all streams affected and a new cumulative TSN
-	 *     ACK of the Receiver's Next TSN minus 1 were received MUST be
-	 *     performed.
+	/* G3: The same processing as though a SACK chunk with no gap report
+	 *     and a cumulative TSN ACK of the Sender's Next TSN minus 1 were
+	 *     received MUST be performed.
 	 */
 	sctp_outq_free(&asoc->outqueue);
 
@@ -844,6 +844,7 @@ struct sctp_chunk *sctp_process_strreset
 		if (result == SCTP_STRRESET_PERFORMED) {
 			__u32 mtsn = sctp_tsnmap_get_max_tsn_seen(
 						&asoc->peer.tsn_map);
+			LIST_HEAD(temp);
 
 			sctp_ulpq_reasm_flushtsn(&asoc->ulpq, mtsn);
 			sctp_ulpq_abort_pd(&asoc->ulpq, GFP_ATOMIC);
@@ -852,7 +853,13 @@ struct sctp_chunk *sctp_process_strreset
 					 SCTP_TSN_MAP_INITIAL,
 					 stsn, GFP_ATOMIC);
 
+			/* Clean up sacked and abandoned queues only. As the
+			 * out_chunk_list may not be empty, splice it to temp,
+			 * then get it back after sctp_outq_free is done.
+			 */
+			list_splice_init(&asoc->outqueue.out_chunk_list, &temp);
 			sctp_outq_free(&asoc->outqueue);
+			list_splice_init(&temp, &asoc->outqueue.out_chunk_list);
 
 			asoc->next_tsn = rtsn;
 			asoc->ctsn_ack_point = asoc->next_tsn - 1;
