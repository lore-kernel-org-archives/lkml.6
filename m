Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/v9tHRL6TdXUNHgxJ7Xx/e8S7jQF+ccR34GB2TJtXGHpy9Jl/GAx0EQb1nvxvr0cMS7ZHi
ARC-Seal: i=1; a=rsa-sha256; t=1523473324; cv=none;
        d=google.com; s=arc-20160816;
        b=AuSVqoIIXi+WnMryZHm8wQTdYX8JQRmuTGLBWeNbXcV9v0OmwGGtq/ljoEqH3I2DfH
         Y42XfbbIOzbxAvzkmKvoqLwDcZHvkeP61q66BP3eeHX2K+kV+EO803SV4DbQO31rifHV
         lrvp1azZFH9qidxqr6sVsQ9yvj/VrU4kVyg5KtiR7yFdoQ3CTsKWPRpsNj9wmxxxyKM6
         OPQ9J5bAgg/tzEK6bGPf70NzEYLjT/Tq5+eYe3XAKK3ay3ZVqi1qczDPoYi5eaxf7AMu
         w41IUroRoRGn+P6bFY+eXyqu+hx1UxLbh48rdHTUdWiXJu/XRos2GslGxYD0PBXfiCyH
         5a1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=yfIAeNlb5FI5utVWo09nHOFqQo7Tiha5BfUIbTGfjS0=;
        b=JdvJpyCmg2Kgo8FXTt0GrlAnfnxTIWRYXyLmNlpyre9KhpN+dzdCZjBrWgkp2fYmcZ
         ppf+OauydYL1xOYpyftCI7ohwkA73zJ88Z1qG2RjgidPCSkNA/xN3Xrd7P51sRIfR9sR
         H8ecYhegep3Q/PlGYWQzLW0YKuAzO0vVaLqHRgP5gA2es2qIslu1E/u09YGS+GqmY2EA
         XJF1uGSJbOkhQL17+4ldR8nXfDDIZG8LQ6L4U2r9pfTqWIfDYWBjdgwao8JhEmHHHc0R
         RoViOWW+3d6REQPcTqXyGIUMiXgZaKRugF5pOK+40iCkHWWt5qWlXp0DZ9Ej597VtxYv
         +Slg==
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
Subject: [PATCH 4.9 205/310] e1000e: fix race condition around skb_tstamp_tx()
Date: Wed, 11 Apr 2018 20:35:44 +0200
Message-Id: <20180411183631.389041225@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476237913134414?=
X-GMAIL-MSGID: =?utf-8?q?1597477565023765823?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
