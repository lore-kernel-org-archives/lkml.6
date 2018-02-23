Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3759000-1519415911-2-533023181707205754
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
    t=1519415911; b=MP501fuBzuIU6rFzVBhgY6VUreTcIvhgSQgipzNzYFcRto2
    zYWmd9pPbDWK4goG88pWlCcieuqEwfeBCy3BMGBWoq2SIT01BHin2YbJ1CYnhD4s
    vHphprIK/O2po8mrVonE3ru5Ro601whSMBPrPH/+ChzOL3aKsaf+v50URg01Wv+M
    ZVKiJFCdSml5OPztU2k5TLmHiJGl7ykl7JDPIsZuAyhHM6EDqzbOF/rENaJaBWOq
    KxceDEIBE3Bf6QnNluOB2Vs/T+Rjv3qg+JYxX5AU2UJ5QmiHI+eapP4CkULykHQO
    rcB5tu+U7eDO4EV4GUPj7P+JCyDc226+6wYzA1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519415911; bh=ovxd4J9vtVnX5kQldVxMrr0dic
    cpDltU0JoH1IIvS4g=; b=oNYfvnc+QtEI4XA4BHCnHLvYx0qHfRXnY3MDgExKvs
    8HoSp2kvrTSHOS3scIk038F5UOVEWZCIVK9W3D5orGNcDAg93zar+zMkEBQXbfcq
    7AwMyNAH2h7+PEuOkQF33IoaeNxcguTW0SQ3gcEC9rJyPh3yQT+nrotu5m3XIoCc
    luPGrVfoWgyRhgymR9lJMZCR0OrS17CB9ggPoWCfa0kHkJ6Ov2a84D6fWX6/k0Pg
    3lsRvjT9NwqH/kQ19/ylAINqAKTttXMaY1GWonMivIsWHl73wLUjf3FaOT5sJee3
    Dq++DLWY1lDfVCuKeMKLK4n6DRyHMhXD6GzeBOf+ogHQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933041AbeBWSoR (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:44:17 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:42504 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932663AbeBWSoP (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:44:15 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+114b15f2be420a8886c3@syzkaller.appspotmail.com,
        Tom Herbert <tom@quantonium.net>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 002/145] kcm: Check if sk_user_data already set in kcm_attach
Date: Fri, 23 Feb 2018 19:25:08 +0100
Message-Id: <20180223170724.968449379@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170724.669759283@linuxfoundation.org>
References: <20180223170724.669759283@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tom Herbert <tom@quantonium.net>

commit e5571240236c5652f3e079b1d5866716a7ad819c upstream.

This is needed to prevent sk_user_data being overwritten.
The check is done under the callback lock. This should prevent
a socket from being attached twice to a KCM mux. It also prevents
a socket from being attached for other use cases of sk_user_data
as long as the other cases set sk_user_data under the lock.
Followup work is needed to unify all the use cases of sk_user_data
to use the same locking.

Reported-by: syzbot+114b15f2be420a8886c3@syzkaller.appspotmail.com
Fixes: ab7ac4eb9832 ("kcm: Kernel Connection Multiplexor module")
Signed-off-by: Tom Herbert <tom@quantonium.net>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/kcm/kcmsock.c |   16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

--- a/net/kcm/kcmsock.c
+++ b/net/kcm/kcmsock.c
@@ -1404,9 +1404,18 @@ static int kcm_attach(struct socket *soc
 		return err;
 	}
 
-	sock_hold(csk);
-
 	write_lock_bh(&csk->sk_callback_lock);
+
+	/* Check if sk_user_data is aready by KCM or someone else.
+	 * Must be done under lock to prevent race conditions.
+	 */
+	if (csk->sk_user_data) {
+		write_unlock_bh(&csk->sk_callback_lock);
+		strp_done(&psock->strp);
+		kmem_cache_free(kcm_psockp, psock);
+		return -EALREADY;
+	}
+
 	psock->save_data_ready = csk->sk_data_ready;
 	psock->save_write_space = csk->sk_write_space;
 	psock->save_state_change = csk->sk_state_change;
@@ -1414,8 +1423,11 @@ static int kcm_attach(struct socket *soc
 	csk->sk_data_ready = psock_data_ready;
 	csk->sk_write_space = psock_write_space;
 	csk->sk_state_change = psock_state_change;
+
 	write_unlock_bh(&csk->sk_callback_lock);
 
+	sock_hold(csk);
+
 	/* Finished initialization, now add the psock to the MUX. */
 	spin_lock_bh(&mux->lock);
 	head = &mux->psocks;
