Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsghsxqJVtf328H9a51azhqPf7J3WTwhCslcYarHTiEd3S80ipUx//ETGsHPC5uS9pxIJRp
ARC-Seal: i=1; a=rsa-sha256; t=1520451668; cv=none;
        d=google.com; s=arc-20160816;
        b=qTiHY2iun1V8wQ9sxZ1qf2JInHqaVlIi3SllLDlBMPSfF1NGk6PLAFGV/t+mca8FGP
         TUOeeKXnAmJsbJ3/7gqJv3lh7l6VYYqmyzgYR+G8n3cFLWJ2qtNTlKEXnuz/02w9LtSh
         KbNgudxDiD2890KzB5NLWg8Cn+pSfejtkuNWQiX01mbB522gDbZYlTqjNRZmklrkiJUK
         UlnTITcBdIrBfIag3/hped1XbFz57FshrWw2md14cZTnvrJJwxz3vpBWQJ3RpgrEVfWD
         ERTAFtK6VyMTxpqj9SRVx1RmLLqiUGFNgVpPeNMSzn7mQkCXl8lsYD76Z/y8RGVkfI/D
         R5Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=KQhasd6Z4uKLuhFEDan5Tfcb0qtkwC7hCuPjdOagqyU=;
        b=JYh/85MHr/lBJqEXw9CPWv0+jtcCiGVI4P46bVPAih1bkFm4hiXQrAoT99wE/KNS6l
         hFWq7IVmQ5/OAB/kyeaiKWe7NLV1IXyTRkr0BAlpH8UEC2+tx7PR47LDcnDZGAqYEwJn
         t1p85/K5Rlz3Z5cp2zC+xWQiiHbQuL2bPtZcObmksKUR8twQcsZog1W8qA8J22l+aoSP
         wf/jXZnSkOd0Tvx5toJlMtadAZyH3i3JAjI97n8BnJfwBuddzAogbP2widWT3Dbk0vcy
         +YDRkq7iSnEwT9qDA6waHZttcPZNonkSduCYy72DfTgk+8uQXZGVZAl8Lypk0YvlDZrN
         mk8A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.15 044/122] net: ethernet: ti: cpsw: fix net watchdog timeout
Date: Wed,  7 Mar 2018 11:37:36 -0800
Message-Id: <20180307191735.374113232@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191729.190879024@linuxfoundation.org>
References: <20180307191729.190879024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309128551674718?=
X-GMAIL-MSGID: =?utf-8?q?1594309128551674718?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Grygorii Strashko <grygorii.strashko@ti.com>


[ Upstream commit 62f94c2101f35cd45775df00ba09bde77580e26a ]

It was discovered that simple program which indefinitely sends 200b UDP
packets and runs on TI AM574x SoC (SMP) under RT Kernel triggers network
watchdog timeout in TI CPSW driver (<6 hours run). The network watchdog
timeout is triggered due to race between cpsw_ndo_start_xmit() and
cpsw_tx_handler() [NAPI]

cpsw_ndo_start_xmit()
	if (unlikely(!cpdma_check_free_tx_desc(txch))) {
		txq = netdev_get_tx_queue(ndev, q_idx);
		netif_tx_stop_queue(txq);

^^ as per [1] barier has to be used after set_bit() otherwise new value
might not be visible to other cpus
	}

cpsw_tx_handler()
	if (unlikely(netif_tx_queue_stopped(txq)))
		netif_tx_wake_queue(txq);

and when it happens ndev TX queue became disabled forever while driver's HW
TX queue is empty.

Fix this, by adding smp_mb__after_atomic() after netif_tx_stop_queue()
calls and double check for free TX descriptors after stopping ndev TX queue
- if there are free TX descriptors wake up ndev TX queue.

[1] https://www.kernel.org/doc/html/latest/core-api/atomic_ops.html
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
Reviewed-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/ti/cpsw.c |   16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -1618,6 +1618,7 @@ static netdev_tx_t cpsw_ndo_start_xmit(s
 		q_idx = q_idx % cpsw->tx_ch_num;
 
 	txch = cpsw->txv[q_idx].ch;
+	txq = netdev_get_tx_queue(ndev, q_idx);
 	ret = cpsw_tx_packet_submit(priv, skb, txch);
 	if (unlikely(ret != 0)) {
 		cpsw_err(priv, tx_err, "desc submit failed\n");
@@ -1628,15 +1629,26 @@ static netdev_tx_t cpsw_ndo_start_xmit(s
 	 * tell the kernel to stop sending us tx frames.
 	 */
 	if (unlikely(!cpdma_check_free_tx_desc(txch))) {
-		txq = netdev_get_tx_queue(ndev, q_idx);
 		netif_tx_stop_queue(txq);
+
+		/* Barrier, so that stop_queue visible to other cpus */
+		smp_mb__after_atomic();
+
+		if (cpdma_check_free_tx_desc(txch))
+			netif_tx_wake_queue(txq);
 	}
 
 	return NETDEV_TX_OK;
 fail:
 	ndev->stats.tx_dropped++;
-	txq = netdev_get_tx_queue(ndev, skb_get_queue_mapping(skb));
 	netif_tx_stop_queue(txq);
+
+	/* Barrier, so that stop_queue visible to other cpus */
+	smp_mb__after_atomic();
+
+	if (cpdma_check_free_tx_desc(txch))
+		netif_tx_wake_queue(txq);
+
 	return NETDEV_TX_BUSY;
 }
 
