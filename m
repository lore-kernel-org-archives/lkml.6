Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsrvfDjBK6jkxr6FB0xxtCmB1KbPr2fAnezh8I28OfmR1SxjEB33cXGRseb5MOIYphzq4iu
ARC-Seal: i=1; a=rsa-sha256; t=1520451940; cv=none;
        d=google.com; s=arc-20160816;
        b=BEwPl3bHRGrp9QyxMSZRhNLwxUhjdQ+Kux59Q6DzN/Cjd6Yi5xOXOojQ7ubANMEnCQ
         hdzXO7LI8c+vpgKda4OwZDL6cz6sFuzcWHYoqiIy5t05ao83a4gCzm8VBcp8oZsK3wkP
         nAtGKNQ765bYuLqVM3qOOlpOalNxtK6FCPBC0CEodKEv3tWRYspEJeTxfQihrgN+HRAx
         XKtY6kPrhDwPd2rebL0q3NSbGWgkaVzs5YwC7jB4mYaOiwuQHgN5w0ZgGEfWKim5PcI2
         1Iui9np8BBJk1lwOR+c8A8z989GhK3XoLZ72O7RjAa89vSYuHKNcbvqVOihTh47b9lbp
         uiIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Pp313Izfvr8ZY5nW+VfeawtJ10mkRnK7PGPfUikvGeg=;
        b=xSHBkLGNKIhGRWS5SuhS+HKJW0FKzZ9wKyp0m9+BmdJ3z1w7PGdTCLU2V1xhEkMywP
         0XzukDfRdj1abNNqFVNok4yGnjF/PM++r7nlt1g2T7DfH45+hIQqW5JjaiPmZRcYXei+
         rD2fhtzgVeCUIECh+l/FD4XPZGbEfEUjpV90RSMa+3mxMJ4B/P7PFflMLqEXVH69V07R
         UHVoZ4HSX2fpl2NLbWWYMoFhbGcCm+PvpBM+8pzDGjnsfRsXHZLIJSmX+t6sTBkrZEsG
         q5fthi2lB7qpHuDUgQRTx7Hrw+GMFMGfCTWV5MHtDgDaLBZSts1238QAo+pAyAvBJXyZ
         fgoA==
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
Subject: [PATCH 4.14 039/110] net: ethernet: ti: cpsw: fix net watchdog timeout
Date: Wed,  7 Mar 2018 11:38:22 -0800
Message-Id: <20180307191044.746922564@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191039.748351103@linuxfoundation.org>
References: <20180307191039.748351103@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309128551674718?=
X-GMAIL-MSGID: =?utf-8?q?1594309414135907121?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
 
