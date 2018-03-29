Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+5m/CpQDPfVcWfnDtA8IzCBYbIdZ53vaz2Zlhk3v9bdMR3E+39sfRwE0WDyjDu59AKggX1
ARC-Seal: i=1; a=rsa-sha256; t=1522346643; cv=none;
        d=google.com; s=arc-20160816;
        b=BLlAlJrCQHWtgAnbpPW2PXIYOB3vk/iQCdKTsWQ/I8j1wdDKWICkcXROULBVl92Yo9
         xIAxNI0ulaIIAzFRcfr9qbvJeiSHdobqjsd0dSY0BIuZF1V0Ihg5gSbMkWP7pFvpnBTS
         1gqjlRSBg1/Te/wZyCTuIAO4t9RGolhTwqGW0lYUpkC0M5QMJxIyos+C9H9Valu5T8wg
         8PDO2EEowU4ya4ULdLmIwkByuWkBfglJ0tgpdXgIGKRRFTS20am7ssUNnGoOD6jgft03
         TcaCyjF0xCCovGhqZYE0q9Q1M8rEMUHHIH60HyFymLb4VsT20CetmjWlRVcp/pKb2mXD
         BmIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=/TFtExxiiPUrDq08JKg+R3cTqOupoQzOOlbnZlTF0Kk=;
        b=KZGMbUEE/EtE3oCbuWz3bmPwNjhjtK4UgeMWr6xOQPJu9SZQJmZgnZKVb7kuCoQ4gi
         7u7Sccy57Sx+jY/OwU2A73iud50wJVLmGMIWk8ZO7cDH5kOkqoD2aJ7GP39SPpf/mmyT
         5BRxWIt7T6a0d0P36FzUj73jtApn8LYIATsv6SJzVIIFjwg8UFlqPWMYuAS86D6PEfwy
         0ixXPsxzDeZ6aXp0ZVHCEzUEfCVYl3kq3avZODDCFdkQs0Z/A/y+pacXFLdDxA1HhCB8
         MVdlIOZxaVToP0nEbGCHWdOYKhdRVl5lAdBIHUV58Nn+yazmBEDYZNF/hEi5FBDhN383
         4K+A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.15 44/47] net: systemport: Rewrite __bcm_sysport_tx_reclaim()
Date: Thu, 29 Mar 2018 20:00:25 +0200
Message-Id: <20180329175733.195996483@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175729.225211114@linuxfoundation.org>
References: <20180329175729.225211114@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596296154266944554?=
X-GMAIL-MSGID: =?utf-8?q?1596296154266944554?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Fainelli <f.fainelli@gmail.com>


[ Upstream commit 484d802d0f2f29c335563fcac2a8facf174a1bbc ]

There is no need for complex checking between the last consumed index
and current consumed index, a simple subtraction will do.

This also eliminates the possibility of a permanent transmit queue stall
under the following conditions:

- one CPU bursts ring->size worth of traffic (up to 256 buffers), to the
  point where we run out of free descriptors, so we stop the transmit
  queue at the end of bcm_sysport_xmit()

- because of our locking, we have the transmit process disable
  interrupts which means we can be blocking the TX reclamation process

- when TX reclamation finally runs, we will be computing the difference
  between ring->c_index (last consumed index by SW) and what the HW
  reports through its register

- this register is masked with (ring->size - 1) = 0xff, which will lead
  to stripping the upper bits of the index (register is 16-bits wide)

- we will be computing last_tx_cn as 0, which means there is no work to
  be done, and we never wake-up the transmit queue, leaving it
  permanently disabled

A practical example is e.g: ring->c_index aka last_c_index = 12, we
pushed 256 entries, HW consumer index = 268, we mask it with 0xff = 12,
so last_tx_cn == 0, nothing happens.

Fixes: 80105befdb4b ("net: systemport: add Broadcom SYSTEMPORT Ethernet MAC driver")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/broadcom/bcmsysport.c |   33 +++++++++++++----------------
 drivers/net/ethernet/broadcom/bcmsysport.h |    2 -
 2 files changed, 16 insertions(+), 19 deletions(-)

--- a/drivers/net/ethernet/broadcom/bcmsysport.c
+++ b/drivers/net/ethernet/broadcom/bcmsysport.c
@@ -855,10 +855,12 @@ static void bcm_sysport_tx_reclaim_one(s
 static unsigned int __bcm_sysport_tx_reclaim(struct bcm_sysport_priv *priv,
 					     struct bcm_sysport_tx_ring *ring)
 {
-	unsigned int c_index, last_c_index, last_tx_cn, num_tx_cbs;
 	unsigned int pkts_compl = 0, bytes_compl = 0;
 	struct net_device *ndev = priv->netdev;
+	unsigned int txbds_processed = 0;
 	struct bcm_sysport_cb *cb;
+	unsigned int txbds_ready;
+	unsigned int c_index;
 	u32 hw_ind;
 
 	/* Clear status before servicing to reduce spurious interrupts */
@@ -871,29 +873,23 @@ static unsigned int __bcm_sysport_tx_rec
 	/* Compute how many descriptors have been processed since last call */
 	hw_ind = tdma_readl(priv, TDMA_DESC_RING_PROD_CONS_INDEX(ring->index));
 	c_index = (hw_ind >> RING_CONS_INDEX_SHIFT) & RING_CONS_INDEX_MASK;
-	ring->p_index = (hw_ind & RING_PROD_INDEX_MASK);
-
-	last_c_index = ring->c_index;
-	num_tx_cbs = ring->size;
-
-	c_index &= (num_tx_cbs - 1);
-
-	if (c_index >= last_c_index)
-		last_tx_cn = c_index - last_c_index;
-	else
-		last_tx_cn = num_tx_cbs - last_c_index + c_index;
+	txbds_ready = (c_index - ring->c_index) & RING_CONS_INDEX_MASK;
 
 	netif_dbg(priv, tx_done, ndev,
-		  "ring=%d c_index=%d last_tx_cn=%d last_c_index=%d\n",
-		  ring->index, c_index, last_tx_cn, last_c_index);
+		  "ring=%d old_c_index=%u c_index=%u txbds_ready=%u\n",
+		  ring->index, ring->c_index, c_index, txbds_ready);
 
-	while (last_tx_cn-- > 0) {
-		cb = ring->cbs + last_c_index;
+	while (txbds_processed < txbds_ready) {
+		cb = &ring->cbs[ring->clean_index];
 		bcm_sysport_tx_reclaim_one(ring, cb, &bytes_compl, &pkts_compl);
 
 		ring->desc_count++;
-		last_c_index++;
-		last_c_index &= (num_tx_cbs - 1);
+		txbds_processed++;
+
+		if (likely(ring->clean_index < ring->size - 1))
+			ring->clean_index++;
+		else
+			ring->clean_index = 0;
 	}
 
 	u64_stats_update_begin(&priv->syncp);
@@ -1406,6 +1402,7 @@ static int bcm_sysport_init_tx_ring(stru
 	netif_tx_napi_add(priv->netdev, &ring->napi, bcm_sysport_tx_poll, 64);
 	ring->index = index;
 	ring->size = size;
+	ring->clean_index = 0;
 	ring->alloc_size = ring->size;
 	ring->desc_cpu = p;
 	ring->desc_count = ring->size;
--- a/drivers/net/ethernet/broadcom/bcmsysport.h
+++ b/drivers/net/ethernet/broadcom/bcmsysport.h
@@ -706,7 +706,7 @@ struct bcm_sysport_tx_ring {
 	unsigned int	desc_count;	/* Number of descriptors */
 	unsigned int	curr_desc;	/* Current descriptor */
 	unsigned int	c_index;	/* Last consumer index */
-	unsigned int	p_index;	/* Current producer index */
+	unsigned int	clean_index;	/* Current clean index */
 	struct bcm_sysport_cb *cbs;	/* Transmit control blocks */
 	struct dma_desc	*desc_cpu;	/* CPU view of the descriptor */
 	struct bcm_sysport_priv *priv;	/* private context backpointer */
