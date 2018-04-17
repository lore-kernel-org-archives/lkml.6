Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/RuC5juehJV79+OItj23dVAo7YUkY4ShEiZbIEwaDokegutdtykov4yO03S42HbgQ6ijyn
ARC-Seal: i=1; a=rsa-sha256; t=1523980964; cv=none;
        d=google.com; s=arc-20160816;
        b=kemh6spIYgcgFjiFjb3UxZY7R8wR+575Fq0rRmDfF1CNzuIBm66uQuQjeczrVrUAgW
         FrNuCokXzvGZn6mYsEiEj50KzRLF5kLZUrF4mtLpU5k5eCYbOp6rUXfqRYJtNWq8SSWS
         KfzAXDontrgG6Jj46oyTYFv9ps9HjEUH02veFZAP8CBCLipEdH2dUXYJZjAPoljM/y7m
         wDZqopHte7fNNqwOnJ8XJXCyuNzDkdY8WUiwjpX2Y7aXYm59AuJKcT627tLn69gPEDdX
         LuLBOHhLmpmvQitiwWicOcICKTesUuhCmH6iYmH5p++8d7wMQo2Tu3un52Oi1q/pz4kJ
         RU8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=jkDu/oOs/Jj3r5TbNjmmEpSBi66FltMvdYhum2LF3NQ=;
        b=ATBz+J0WwecAZt4RCYvyYne73ss+2XlY7vrG/HcLgH+oiLMOxvo6ebwwthhCN/9TiE
         anIeHqeMZk2+5rZZtueMv9wEkcTNkCQ6jDnW1jofGXTpaB4RekmU0WjaDJpsNLqXkuEi
         3swj4FyEHfzgxbEFTv61vjtwO7lM9S/zvJaYXIK69ciBTfEpo2MyzOQQP/9gT/3P2tDo
         80AYPK9HYrh6YGpUwVeUXLyUMc2dUpVn9DvAavCJJccfoML22Egz8fzWKP6NE51sNel2
         PjTOMJWLFSJutQrHctX5c79gII6Nkj96NJjNTin6gjnDx7+o5porOy3cWB8hSBqlkaOI
         bC5w==
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
Subject: [PATCH 4.16 31/68] ath9k: Protect queue draining by rcu_read_lock()
Date: Tue, 17 Apr 2018 17:57:44 +0200
Message-Id: <20180417155750.607392965@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155749.341779147@linuxfoundation.org>
References: <20180417155749.341779147@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009863461041684?=
X-GMAIL-MSGID: =?utf-8?q?1598009863461041684?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
