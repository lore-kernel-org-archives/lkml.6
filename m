Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49KeIebjb+OnSs6wXhfvoHIZgKoI7Uz9ic2eeB8BmOJcHvAZ8xK/sBeBgwHtmu2MFvSysmB
ARC-Seal: i=1; a=rsa-sha256; t=1523399321; cv=none;
        d=google.com; s=arc-20160816;
        b=rtnEu4Yv9CRMh2R9q4j5lyAXW5Fzf9xojrkL59XO9TvZ4aI5hTNZgZmCzDEw8UZ1mQ
         4UsYBgvJfzSAH909//GR87Id+WPXBP9SNrpTDgjEkajh/9kiGUQHN86jRsl9eucI7O+q
         YGehDB4XorEJkChxyJV1AWortAJgBwwKX35advS1RsJswRJnCUNaaZldFlIG3iDIWxzP
         EKUIUrSW9094zkn5ZvAjqwDrAtWThqy8eEyeQyVFqDBUxAaD9lholxynRXraZw+4xipX
         dm9sZlbtIXvKh/KVqfjCrT7ivLLfMEJ4MxjJTarkM9zYA2SuFx1imIOPopKVjkfL69rB
         0kFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=LzYD4BPP+ZvHGZpc824plZ1vfwsCpcdyL8+OqmDnh50=;
        b=bvzGON+UHdf4uVnwQmkTdjMzYAtemdW8y989wlAFMWxhKkvcqdfuYWLmOqNPczKN4K
         4Yuj1FlezSTmm5f0b8N0S0g69uLTFNrtpxnklQ7KHRhFQqIfzm1Bn6vhSHjEnFAV5MaF
         WmHD7Ni+RyRwkN+OQSSAAxFuLP5r3M/MCDAkHMfb8nZytr9GIb+ZPzyAHfrrT81BUJ8t
         r9urdn4dB1GgZub6dzgQRpJQTokvaVadvUOsIFT8fxkBka08C5ig0w6WUrb03QV9dihc
         k7FCE+2hsC9ThimeVKyJgCTx386op5IPkPp8DGp5+ouPHCJk/V6oyFPDqaTkxS11mYok
         axeA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Stanislaw Gruszka <sgruszka@redhat.com>,
	Enrico Mioso <mrkiko.rs@gmail.com>,
	Kalle Valo <kvalo@codeaurora.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 065/168] rt2x00: do not pause queue unconditionally on error path
Date: Wed, 11 Apr 2018 00:23:27 +0200
Message-Id: <20180410212802.964674567@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399967509576176?=
X-GMAIL-MSGID: =?utf-8?q?1597399967509576176?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stanislaw Gruszka <sgruszka@redhat.com>


[ Upstream commit 6dd80efd75ce7c2dbd9f117cf585ee2b33a42ee1 ]

Pausing queue without checking threshold is racy with txdone path.
Moreover we do not need pause queue on any error, but only if queue
is full - in case when we send RTS frame ( other cases of almost full
queue are already handled in rt2x00queue_write_tx_frame() ).

Patch fixes of theoretically possible problem of pausing empty
queue.

Signed-off-by: Stanislaw Gruszka <sgruszka@redhat.com>
Tested-by: Enrico Mioso <mrkiko.rs@gmail.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/ralink/rt2x00/rt2x00mac.c |   22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

--- a/drivers/net/wireless/ralink/rt2x00/rt2x00mac.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00mac.c
@@ -142,15 +142,25 @@ void rt2x00mac_tx(struct ieee80211_hw *h
 	if (!rt2x00dev->ops->hw->set_rts_threshold &&
 	    (tx_info->control.rates[0].flags & (IEEE80211_TX_RC_USE_RTS_CTS |
 						IEEE80211_TX_RC_USE_CTS_PROTECT))) {
-		if (rt2x00queue_available(queue) <= 1)
-			goto exit_fail;
+		if (rt2x00queue_available(queue) <= 1) {
+			/*
+			 * Recheck for full queue under lock to avoid race
+			 * conditions with rt2x00lib_txdone().
+			 */
+			spin_lock(&queue->tx_lock);
+			if (rt2x00queue_threshold(queue))
+				rt2x00queue_pause_queue(queue);
+			spin_unlock(&queue->tx_lock);
+
+			goto exit_free_skb;
+		}
 
 		if (rt2x00mac_tx_rts_cts(rt2x00dev, queue, skb))
-			goto exit_fail;
+			goto exit_free_skb;
 	}
 
 	if (unlikely(rt2x00queue_write_tx_frame(queue, skb, control->sta, false)))
-		goto exit_fail;
+		goto exit_free_skb;
 
 	/*
 	 * Pausing queue has to be serialized with rt2x00lib_txdone(). Note
@@ -164,10 +174,6 @@ void rt2x00mac_tx(struct ieee80211_hw *h
 
 	return;
 
- exit_fail:
-	spin_lock(&queue->tx_lock);
-	rt2x00queue_pause_queue(queue);
-	spin_unlock(&queue->tx_lock);
  exit_free_skb:
 	ieee80211_free_txskb(hw, skb);
 }
