Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtk3arPVDGQMVxZK5+uKfyGVOM9PrYC+KbrGGaAvHzDRtPXw755VNHhOyWKawtjBlS7Jhn7
ARC-Seal: i=1; a=rsa-sha256; t=1520641136; cv=none;
        d=google.com; s=arc-20160816;
        b=QrRDMb9aVumUZS0gBstw9JA2JMqORamyWmBa86RJ0xqyf+1A3ECMociAVoBztbzvf0
         FdkAFJFscD66JxfJaimTHxWk/Vw7fabakYpdQebmEgxnpLaNsq7H7xPY/ahacmBHuoAa
         7yn60yLQFF1kxnYRFSxlaSmvE1RsGkcUqX0Q0xSVjCmc9TQ3GsY/ZhJAHT585VEU56Ml
         S38HNcXlD3wQiSDtp9YXqqCYL7WcTSyseD03vAKGrxn6pKbBlrv1mUKm1c+DAS9kN83N
         /HGaW202ENrwxZYJIS91Aihxil0yT0SfYWEcbMRa5Fu2n7GUueAqaw+VMFKJ374yxyT2
         Sw4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=AniGun/sYuP+3HmlIHSEDC8nc1MvDFZt9j9KN7V1+/8=;
        b=g7ocxOwd9g6s8ZpCcnY4867IyK8Q9YR/XLyNCE7Ow4jiN/jsSyAao6IAx7e7F75dqJ
         s0mSGNCGPwGuCTVSbPeFZFN58neGwazK3E7tbhd0CXYl6I1iw1jqKcjCTWwAgLJcHBSX
         f0ESBabucxtQSasCcb73P0DkGiThgbPVqv90rTAUg983vD+XA7Mtr620GwG6GCwiTUKY
         twyF0if68hdxjHwpa38+fiVbsvL3tztfK5xLLfX9VFBmRUtTrx96B/9oA4XAGzY5/xd4
         xANAoXFGh5zyhxZW/tNdD7zmw3qcjb2IMiuwBUmSCNd7WGIVJTjKZdcnzlHZYvFXkR+v
         T3nw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jakub Kicinski <jakub.kicinski@netronome.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 3.18 11/21] net: fix race on decreasing number of TX queues
Date: Fri,  9 Mar 2018 16:18:33 -0800
Message-Id: <20180310001801.708384251@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310001801.045114869@linuxfoundation.org>
References: <20180310001801.045114869@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594507800170011350?=
X-GMAIL-MSGID: =?utf-8?q?1594507800170011350?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jakub Kicinski <jakub.kicinski@netronome.com>


[ Upstream commit ac5b70198adc25c73fba28de4f78adcee8f6be0b ]

netif_set_real_num_tx_queues() can be called when netdev is up.
That usually happens when user requests change of number of
channels/rings with ethtool -L.  The procedure for changing
the number of queues involves resetting the qdiscs and setting
dev->num_tx_queues to the new value.  When the new value is
lower than the old one, extra care has to be taken to ensure
ordering of accesses to the number of queues vs qdisc reset.

Currently the queues are reset before new dev->num_tx_queues
is assigned, leaving a window of time where packets can be
enqueued onto the queues going down, leading to a likely
crash in the drivers, since most drivers don't check if TX
skbs are assigned to an active queue.

Fixes: e6484930d7c7 ("net: allocate tx queues in register_netdevice")
Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/dev.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -2070,8 +2070,11 @@ EXPORT_SYMBOL(netif_set_xps_queue);
  */
 int netif_set_real_num_tx_queues(struct net_device *dev, unsigned int txq)
 {
+	bool disabling;
 	int rc;
 
+	disabling = txq < dev->real_num_tx_queues;
+
 	if (txq < 1 || txq > dev->num_tx_queues)
 		return -EINVAL;
 
@@ -2087,15 +2090,19 @@ int netif_set_real_num_tx_queues(struct
 		if (dev->num_tc)
 			netif_setup_tc(dev, txq);
 
-		if (txq < dev->real_num_tx_queues) {
+		dev->real_num_tx_queues = txq;
+
+		if (disabling) {
+			synchronize_net();
 			qdisc_reset_all_tx_gt(dev, txq);
 #ifdef CONFIG_XPS
 			netif_reset_xps_queues_gt(dev, txq);
 #endif
 		}
+	} else {
+		dev->real_num_tx_queues = txq;
 	}
 
-	dev->real_num_tx_queues = txq;
 	return 0;
 }
 EXPORT_SYMBOL(netif_set_real_num_tx_queues);
