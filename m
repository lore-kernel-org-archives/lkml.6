Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48C0SeaYepuou6PKFPqCD8xIhggz5aAKb/TW3Eoh1TcqwCg5CPK9M8MbCgQI1oBO025sQ13
ARC-Seal: i=1; a=rsa-sha256; t=1523981035; cv=none;
        d=google.com; s=arc-20160816;
        b=v5DaBxp5dXq+Ov4oDDWGA3/A/gW4cFfdB9RFqelK5OeDS6nfgsnj5+ZST5Bf7SmC28
         7q1aRX6vH7N+SGp8MK9nQQAkhwK3C57bjGv3nFrqCHswi9KbQO8n/soXpXiXdkS3ZhAG
         sgQj89k45wGWwyK+VhO3NT65XdELiLkH7HtD2rOIknGa7AVsgg8YYbqMILqkBQkPxjbB
         kQ2X86jyL6cza2KTrr+UhOYVVBb8paOwK2SbRIfrhTGflWpjQKjcJN7bqkGxFSQkpRqs
         LNcD8ee6sTGJ6UJzFuFSHEqbwIAsefgChlqgfQy/LuRelXa69v+aeWYrDT+sf5fqjDqR
         IrcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Isjd6v8/1g8s0bfztld3gOdFSckbL7MZM6PqujuvPqk=;
        b=z8u2hy264TC2n9ClJbNjm5BonEimkswfGdlntd3rW45JzIyXfiwcDmYJG9rRKzd7+b
         9kenpnKVvR1t7lQchFnjoTVT+4f/IH+joBtdFQsdh0jmMYmJUbKsZkP+7qMd0XTKIDJD
         z4SN7PQ7qnBL1426XONKjrJpKmXalWOPlqxUJPtuYVzP7Mc4/fKYn+FAoFcCPUA/lPog
         POi7MLNCOqsuQj13aXJ1gwIq4ddueLI4Ung8nPWcmcNxe8NgDJVRxrjc08C3C7AekdA2
         k3TPcAqCKnyCe8GHKN3q021Mf9+9QYbdXMIsGRihMEcl0516+iwg2t54c2IrBUUe4PSc
         1/uw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ben Greear <greearb@candelatech.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 4.15 24/53] ath9k: Protect queue draining by rcu_read_lock()
Date: Tue, 17 Apr 2018 17:58:49 +0200
Message-Id: <20180417155724.294002947@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155723.091120060@linuxfoundation.org>
References: <20180417155723.091120060@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009863461041684?=
X-GMAIL-MSGID: =?utf-8?q?1598009938556158791?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Toke Høiland-Jørgensen <toke@toke.dk>

commit 182b1917109892ab9f26d66bfdcbc4ba6f0a0a65 upstream.

When ath9k was switched over to use the mac80211 intermediate queues,
node cleanup now drains the mac80211 queues. However, this call path is
not protected by rcu_read_lock() as it was previously entirely internal
to the driver which uses its own locking.

This leads to a possible rcu_dereference() without holding
rcu_read_lock(); but only if a station is cleaned up while having
packets queued on the TXQ. Fix this by adding the rcu_read_lock() to the
caller in ath9k.

Fixes: 50f08edf9809 ("ath9k: Switch to using mac80211 intermediate software queues.")
Cc: stable@vger.kernel.org
Reported-by: Ben Greear <greearb@candelatech.com>
Signed-off-by: Toke Høiland-Jørgensen <toke@toke.dk>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/ath/ath9k/xmit.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/net/wireless/ath/ath9k/xmit.c
+++ b/drivers/net/wireless/ath/ath9k/xmit.c
@@ -2892,6 +2892,8 @@ void ath_tx_node_cleanup(struct ath_soft
 	struct ath_txq *txq;
 	int tidno;
 
+	rcu_read_lock();
+
 	for (tidno = 0; tidno < IEEE80211_NUM_TIDS; tidno++) {
 		tid = ath_node_to_tid(an, tidno);
 		txq = tid->txq;
@@ -2909,6 +2911,8 @@ void ath_tx_node_cleanup(struct ath_soft
 		if (!an->sta)
 			break; /* just one multicast ath_atx_tid */
 	}
+
+	rcu_read_unlock();
 }
 
 #ifdef CONFIG_ATH9K_TX99
