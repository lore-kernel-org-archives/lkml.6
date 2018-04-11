Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/yZkSUYhrJz/pfhcu3fEUCT36x4lTNXsfIn/RI0f6IPdjWtso54gEKkqOcxPuAFcSRkIZV
ARC-Seal: i=1; a=rsa-sha256; t=1523472544; cv=none;
        d=google.com; s=arc-20160816;
        b=glZp2f4+YvQfHnx/Mf23qqqRRtMGibaKgDtCKTe2REjE4aLu3VP0YlneYuLk+rMfQ8
         tmdkqseuEOZpI7ZVxgceQvaHRHj9/NyQ6jH9yupuUzkAputslnHoMFWi2PIj6RNKLPTW
         sPvolskMB5VoolUi4vKJ8TLq8ExRMnq54XfAwZSgoH4pCh81Y72DDEGk694c5uyxKJyC
         rJ4Vrz2CvB/tJvoz6fMRE8hOk/mAV4MeIJsN0ufW1yN1WAcpf0U9iq2PhvOYL1uKaXfY
         B6Ln6RXAUNzaUs4mvKE0Bo3nBTVeIDwWjNfkrhNU6qNVmXGlQTfdmsG12LmITqMNf1xA
         tMLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=opCStgWmGV/Qrwi4VYslxc5p4r/kQZIfNPXqw5bwJyE=;
        b=UZPdtKsFFnniyZKMmymooG99qMfsU+ihqEWRV4Jx0LZABlbKbmjHULkuytUtw8fkHt
         L6/Tca+pEjwoKg/27nG0dS6Wi2taBQLEjpWIbdeZJBvUaujV6xeqq2xAG9Gp7SXTwM0s
         ee//gCOlhhOXXN/QWBIOHR0wOgRYSktj1z6D9mu4e+hEV2s4MskWbuCo84Bjavrrbasa
         4iuKdEf2dG/AMDeBKpHPh4e3QVd5i4JRA9ANz8CZP+tFGNhX5aOH3BTeJRjOfDJx00m9
         b7o9OKH8rrwZTDx7pe5mz9kswOxTCGLV1tbHzccuYqcoM6D3yr36r0eXyk1iKgMUt5bL
         Eelg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	David Mirabito <davidm@metamako.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Aaron Brown <aaron.f.brown@intel.com>,
	Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 124/190] e1000e: fix race condition around skb_tstamp_tx()
Date: Wed, 11 Apr 2018 20:36:10 +0200
Message-Id: <20180411183559.178781614@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476237913134414?=
X-GMAIL-MSGID: =?utf-8?q?1597476746870897877?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jacob Keller <jacob.e.keller@intel.com>


[ Upstream commit 5012863b7347866764c4a4e58b62fb05346b0d06 ]

The e1000e driver and related hardware has a limitation on Tx PTP
packets which requires we limit to timestamping a single packet at once.
We do this by verifying that we never request a new Tx timestamp while
we still have a tx_hwtstamp_skb pointer.

Unfortunately the driver suffers from a race condition around this. The
tx_hwtstamp_skb pointer is not set to NULL until after skb_tstamp_tx()
is called. This function notifies the stack and applications of a new
timestamp. Even a well behaved application that only sends a new request
when the first one is finished might be woken up and possibly send
a packet before we can free the timestamp in the driver again. The
result is that we needlessly ignore some Tx timestamp requests in this
corner case.

Fix this by assigning the tx_hwtstamp_skb pointer prior to calling
skb_tstamp_tx() and use a temporary pointer to hold the timestamped skb
until that function finishes. This ensures that the application is not
woken up until the driver is ready to begin timestamping a new packet.

This ensures that well behaved applications do not accidentally race
with condition to skip Tx timestamps. Obviously an application which
sends multiple Tx timestamp requests at once will still only timestamp
one packet at a time. Unfortunately there is nothing we can do about
this.

Reported-by: David Mirabito <davidm@metamako.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/intel/e1000e/netdev.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -1182,6 +1182,7 @@ static void e1000e_tx_hwtstamp_work(stru
 	struct e1000_hw *hw = &adapter->hw;
 
 	if (er32(TSYNCTXCTL) & E1000_TSYNCTXCTL_VALID) {
+		struct sk_buff *skb = adapter->tx_hwtstamp_skb;
 		struct skb_shared_hwtstamps shhwtstamps;
 		u64 txstmp;
 
@@ -1190,9 +1191,14 @@ static void e1000e_tx_hwtstamp_work(stru
 
 		e1000e_systim_to_hwtstamp(adapter, &shhwtstamps, txstmp);
 
-		skb_tstamp_tx(adapter->tx_hwtstamp_skb, &shhwtstamps);
-		dev_kfree_skb_any(adapter->tx_hwtstamp_skb);
+		/* Clear the global tx_hwtstamp_skb pointer and force writes
+		 * prior to notifying the stack of a Tx timestamp.
+		 */
 		adapter->tx_hwtstamp_skb = NULL;
+		wmb(); /* force write prior to skb_tstamp_tx */
+
+		skb_tstamp_tx(skb, &shhwtstamps);
+		dev_kfree_skb_any(skb);
 	} else if (time_after(jiffies, adapter->tx_hwtstamp_start
 			      + adapter->tx_timeout_factor * HZ)) {
 		dev_kfree_skb_any(adapter->tx_hwtstamp_skb);
