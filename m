Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49X+l218XCwME3xf2XSu4cvEzohE/Sg/VACynD5vrVrim/R+A7LgCEJhhdtksIYO4Y1EElq
ARC-Seal: i=1; a=rsa-sha256; t=1523981233; cv=none;
        d=google.com; s=arc-20160816;
        b=Grqz78xmrF1V6rNH9xoCRbHRD6wDg2O4PAbAh9YpBtIW5wCPQOV31s1xj4okafBAMo
         NAOWt4RoQySEshKEPRCIgA+l46CARm389dOL0ejOLWyk/ZsHYsVgB5GEmrS4ctpfSc7C
         58NhIFM+0h2U8tMs9ZOZo+aOpSWAItu286601aYfai4oDZQrQyY2aLS2A84HXixv+VRd
         CRpwCjMXbtqvgsJIw91XeVRQNCs7GxN/Hgpy5z9tDTZlw1SA3RZKcpDAIUuYZRGfSjbm
         93NTjh07UBh9zwyWJ0xw7U8z6GTMMtJvPn+KpltBxswBw03TI8nboiMHvQi0HZB4xYJX
         WwRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=uvpRq8wz8IUGEihtbYlJHh7WTngYbZKhTZ8hEp4QBmI=;
        b=utgPER3YqyWXoXxo0QGjZ+Pr9fvAAVxMuV7DFu7uMpEARWUPVNmofgmP2NqisJW8z0
         bcXrpfYAVf0MuvVq5ijO1Ie+4IZabY8VGlDjtE6OCzcPK2GRSB1L3No4CNX+/q3B2QSL
         Gw8z7VP184eyE8IIiC3Pe4SZSt5ld+XdItvWilLg/jqP63dgiyGWxarrk4lpCCzCzU12
         orMSJV6QN+k6gz5XaZWwj+nna1Cic+tTqqZgBKJbryCnvJ4fX+NznGBieP5jCiR5eP7s
         pWwvd+UqdgCRF1v6IoPZACBa1XEiKnIrm2Q87x/FsgU9PG4wozAKy2xw3q55S+1z4gHN
         IjRA==
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
Subject: [PATCH 4.14 41/49] ath9k: Protect queue draining by rcu_read_lock()
Date: Tue, 17 Apr 2018 17:59:20 +0200
Message-Id: <20180417155716.999760963@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155715.032245882@linuxfoundation.org>
References: <20180417155715.032245882@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009863461041684?=
X-GMAIL-MSGID: =?utf-8?q?1598010146497497089?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
