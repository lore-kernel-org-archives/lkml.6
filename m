Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpGR7do/cxMn0OPtFVtVMBOUVxki8vSL/2I4/IU7X4mi3H7Gl5+wN98/VfxBqaKc6xO2YiW
ARC-Seal: i=1; a=rsa-sha256; t=1527156011; cv=none;
        d=google.com; s=arc-20160816;
        b=Ovb4AmZfW7fRYgJLK0pk+/X45n/Ig8k1sutcJrTAoxsSECOiV0HMwpz32leORh5TuC
         tBoIA1sqgyrNtN5/eMthkyz2QoFJtwq0EjtIqJWQ0fbZYG1MIWEnjynsEP7o8MJ1Zyjq
         9u2EUMkIuSKAcBm59FakifzEJrN49pa8ylodF5at20/rcYM4vpKDQ00TOb6WPwK4907L
         Yj3vwj9R7iNv4c/L2R/TVwoJ2nfKFJ33pD52V5bDSCPGIFtP3JpRog/2ptZ2IHSIAlBm
         DrVFhDr5yNa6DJtGY1ITuxSF+gLAbEngUS+MSrqywTFOkvZL6qyOUE7bE8XrYE5g76b/
         T02g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=Nz9+RdAtPamUIrXRwwYbvR1sqOlV94E98VR+HW0vWV8=;
        b=luyte65EyrUXc5P3FQoD5+4rxVzd8P0+LR/Z6OHBNyi2ovEp2nAUqgJ+bJnw5PYjv8
         6QZH4WJIV+shpT5tY3OxBAv8lWx1GjUX/ahUGYD9edY9wtsF/Da2nL9E5Pr14pZgF68a
         3tBs+SMywjo5QpifLH0EVaxLi65NEnPcFg865uH2/BQMr6NfIr7U20AAwZPNUnecykoW
         tK1RHB6xM4oIUnIqwUc2hNtKs7diYzzBzyP2aqpUohQru7Anozh1BNUNwPq9Ly3B/BHd
         swkzbJZIUtWhArQD/NpbPr+THjIKC3UAVBti7hcOISpCyaFxJj4XQANxkM1Sj8B+zumK
         uUIw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=DczaX/34;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=DczaX/34;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ariel Elior <Ariel.Elior@cavium.com>,
	Michal Kalderon <Michal.Kalderon@cavium.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 032/161] qed: Fix LL2 race during connection terminate
Date: Thu, 24 May 2018 11:37:37 +0200
Message-Id: <20180524093022.201857268@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601339142348149029?=
X-GMAIL-MSGID: =?utf-8?q?1601339142348149029?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michal Kalderon <Michal.Kalderon@cavium.com>

[ Upstream commit 490068deaef0c76e47bf89c457de899b7d3995c7 ]

Stress on qedi/qedr load unload lead to list_del corruption.
This is due to ll2 connection terminate freeing resources without
verifying that no more ll2 processing will occur.

This patch unregisters the ll2 status block before terminating
the connection to assure this race does not occur.

Fixes: 1d6cff4fca4366 ("qed: Add iSCSI out of order packet handling")
Signed-off-by: Ariel Elior <Ariel.Elior@cavium.com>
Signed-off-by: Michal Kalderon <Michal.Kalderon@cavium.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/qlogic/qed/qed_ll2.c |   24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

--- a/drivers/net/ethernet/qlogic/qed/qed_ll2.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_ll2.c
@@ -842,6 +842,9 @@ static int qed_ll2_lb_rxq_completion(str
 	struct qed_ll2_info *p_ll2_conn = (struct qed_ll2_info *)p_cookie;
 	int rc;
 
+	if (!QED_LL2_RX_REGISTERED(p_ll2_conn))
+		return 0;
+
 	rc = qed_ll2_lb_rxq_handler(p_hwfn, p_ll2_conn);
 	if (rc)
 		return rc;
@@ -862,6 +865,9 @@ static int qed_ll2_lb_txq_completion(str
 	u16 new_idx = 0, num_bds = 0;
 	int rc;
 
+	if (!QED_LL2_TX_REGISTERED(p_ll2_conn))
+		return 0;
+
 	new_idx = le16_to_cpu(*p_tx->p_fw_cons);
 	num_bds = ((s16)new_idx - (s16)p_tx->bds_idx);
 
@@ -1915,17 +1921,25 @@ int qed_ll2_terminate_connection(void *c
 
 	/* Stop Tx & Rx of connection, if needed */
 	if (QED_LL2_TX_REGISTERED(p_ll2_conn)) {
+		p_ll2_conn->tx_queue.b_cb_registred = false;
+		smp_wmb(); /* Make sure this is seen by ll2_lb_rxq_completion */
 		rc = qed_sp_ll2_tx_queue_stop(p_hwfn, p_ll2_conn);
 		if (rc)
 			goto out;
+
 		qed_ll2_txq_flush(p_hwfn, connection_handle);
+		qed_int_unregister_cb(p_hwfn, p_ll2_conn->tx_queue.tx_sb_index);
 	}
 
 	if (QED_LL2_RX_REGISTERED(p_ll2_conn)) {
+		p_ll2_conn->rx_queue.b_cb_registred = false;
+		smp_wmb(); /* Make sure this is seen by ll2_lb_rxq_completion */
 		rc = qed_sp_ll2_rx_queue_stop(p_hwfn, p_ll2_conn);
 		if (rc)
 			goto out;
+
 		qed_ll2_rxq_flush(p_hwfn, connection_handle);
+		qed_int_unregister_cb(p_hwfn, p_ll2_conn->rx_queue.rx_sb_index);
 	}
 
 	if (p_ll2_conn->input.conn_type == QED_LL2_TYPE_OOO)
@@ -1973,16 +1987,6 @@ void qed_ll2_release_connection(void *cx
 	if (!p_ll2_conn)
 		return;
 
-	if (QED_LL2_RX_REGISTERED(p_ll2_conn)) {
-		p_ll2_conn->rx_queue.b_cb_registred = false;
-		qed_int_unregister_cb(p_hwfn, p_ll2_conn->rx_queue.rx_sb_index);
-	}
-
-	if (QED_LL2_TX_REGISTERED(p_ll2_conn)) {
-		p_ll2_conn->tx_queue.b_cb_registred = false;
-		qed_int_unregister_cb(p_hwfn, p_ll2_conn->tx_queue.tx_sb_index);
-	}
-
 	kfree(p_ll2_conn->tx_queue.descq_mem);
 	qed_chain_free(p_hwfn->cdev, &p_ll2_conn->tx_queue.txq_chain);
 
