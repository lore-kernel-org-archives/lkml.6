Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3704313-1519413776-2-3199681767006384710
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519413776; b=oT/9hiOzlIekiklqPWPOa9m4gB+6DmEHSkggQQY6wwtOe69
    q4rnIP8VReg7E5BsGhbKccfXcKM6oU8weGF9mQLx0jvguGVyOu0UnPdgU/+Hk9BD
    Xw8vURckyZmQbNxDH9W5oWMpXcKlPEmgdQ3x3SNYcNsyKh2FKpLXNKYsZfjx4ICp
    A3wfDqqf/U0mgwpffBOBEL9pD3F7LDJyHoXBc2H0PVxvOmPdrSzxIbsinGfoOnUn
    daPGiUbE2iogl2i9vgre9zqc+93MSGGtIrhqRuYe7P71cQO47u0UormaOeR4bofo
    E7e8nrcVPk6xX3CltqnWEVaGTB/sehOQ7nhUVXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519413776; bh=OKD+af3WfCwPsCJ7M4YvKpQ7eD
    K60a3MKBKleWBoVkU=; b=ZMIUzmvyOarQuBkVxJJuQLPrcC9x7TWnwRm8ehlWpJ
    mcl9FHyJ9jcrlqqV5tSFyNDsXjw8wwL9n11B/dgMpLi6TJNWGhX+bcOzK5PTC+zp
    WVvEDzuQub8r1l9mfeRv/TQVgF7iMtIZqEeV5lBFbM16wu0Wtemsk4YjmrxtEyTR
    KGtCZGz8m2PWJN5RC8YDETvkvYURuPN/JMEpVzzZPnJvJFAxOJqUpzohHW8xWMAx
    NXV3dqEOLy7vSZ8e9WC0cl3p/jV4kEWwSCK47nyXAd7Kaw8bOjGIPMXo5ZKoxOOb
    kXVakyfzAMLsBIuO5ts6Eoi/ek23dvF/80PkN7jgAu/w==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935033AbeBWSxh (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:53:37 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:47422 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964785AbeBWSxf (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:53:35 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xin Long <lucien.xin@gmail.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 095/159] sctp: only update outstanding_bytes for transmitted queue when doing prsctp_prune
Date: Fri, 23 Feb 2018 19:26:43 +0100
Message-Id: <20180223170755.021741977@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
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

From: Xin Long <lucien.xin@gmail.com>


[ Upstream commit d30fc5126efb0c33b7adf5966d3051db2c3d7721 ]

Now outstanding_bytes is only increased when appending chunks into one
packet and sending it at 1st time, while decreased when it is about to
move into retransmit queue. It means outstanding_bytes value is already
decreased for all chunks in retransmit queue.

However sctp_prsctp_prune_sent is a common function to check the chunks
in both transmitted and retransmit queue, it decrease outstanding_bytes
when moving a chunk into abandoned queue from either of them.

It could cause outstanding_bytes underflow, as it also decreases it's
value for the chunks in retransmit queue.

This patch fixes it by only updating outstanding_bytes for transmitted
queue when pruning queues for prsctp prio policy, the same fix is also
needed in sctp_check_transmitted.

Fixes: 8dbdf1f5b09c ("sctp: implement prsctp PRIO policy")
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Acked-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sctp/outqueue.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/net/sctp/outqueue.c
+++ b/net/sctp/outqueue.c
@@ -368,7 +368,8 @@ static int sctp_prsctp_prune_sent(struct
 		asoc->abandoned_sent[SCTP_PR_INDEX(PRIO)]++;
 		streamout->abandoned_sent[SCTP_PR_INDEX(PRIO)]++;
 
-		if (!chk->tsn_gap_acked) {
+		if (queue != &asoc->outqueue.retransmit &&
+		    !chk->tsn_gap_acked) {
 			if (chk->transport)
 				chk->transport->flight_size -=
 						sctp_data_size(chk);
@@ -1429,7 +1430,8 @@ static void sctp_check_transmitted(struc
 			/* If this chunk has not been acked, stop
 			 * considering it as 'outstanding'.
 			 */
-			if (!tchunk->tsn_gap_acked) {
+			if (transmitted_queue != &q->retransmit &&
+			    !tchunk->tsn_gap_acked) {
 				if (tchunk->transport)
 					tchunk->transport->flight_size -=
 							sctp_data_size(tchunk);
