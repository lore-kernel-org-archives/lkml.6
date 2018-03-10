Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELslcYhZyLDE4lWZfRra2YlH4E3/NMwKzE3NiorISYTEI88jN/T+lyunkxrBxYCHK30m/VMD
ARC-Seal: i=1; a=rsa-sha256; t=1520641209; cv=none;
        d=google.com; s=arc-20160816;
        b=LKKbDv1mWD1Lz+if6s/EtZd93ccKQvH3MTvI0pNUaWwmwRLO5odPDr3/ykpoHbIhgk
         8sflHnoo5p4k0KjPKeJLIzV/34I22EoafD1ciYQZ+bqOpGabKjm4MC90uq6udQXsiC48
         Qt2Fs0k3+GkE34XPE7ea+A+FZupm8gMuuvTqmAbuS09yHz6PNyVh+d7K0dS0EFZYmc1h
         mPriqigscKCExrVXXaH6BKKzJtzgdX8x9RW2KgN4vEMfaBu2c5gQLO9u9E9MACOsORTT
         n59uzpiMcqlZiscYkaQYejAOEHujAMKONL7ZzvaRmqE+fXOCi2EsE8tAqSzPBjFnJoC/
         stoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Oo9ctgVeMRZBr9hgxeI51d20fo4SR4FvDcwZG4Mu9eY=;
        b=GIM3C4PK6PuU5tHNQPD4ZcTZBggRoMmXAb5AJX4etXzghOEstfR7w4i8JMBjNO57G/
         Ur7spnSVJxiqKkAchcUQkCwvPe4Y+Eg4wLkiG/11yuGQS2CGIyaOr+AWYDoQu5lMacB4
         HFZbUPbjSTfm/NpFmt7PX21zBcaApZlJWl/Lxl7v/KQIG41qsAakQwob3/02V2Ov/Ay1
         ynV0KOV6x4pbMSgiupZesteqMOvzhqL3LDzwpEr4VHNSjaIAGa5uPVzE8HKIX48aebw1
         Q3avyUbpvZKsuH7gRd+/29mhdrRMFaGn/xDzTJzwjoyPNZ4JOU1qZjlKERJfPjgKSVU+
         8Jmg==
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
Subject: [PATCH 4.4 22/36] net: fix race on decreasing number of TX queues
Date: Fri,  9 Mar 2018 16:18:38 -0800
Message-Id: <20180310001808.579152274@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310001807.213987241@linuxfoundation.org>
References: <20180310001807.213987241@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594507800170011350?=
X-GMAIL-MSGID: =?utf-8?q?1594507877276017589?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2183,8 +2183,11 @@ EXPORT_SYMBOL(netif_set_xps_queue);
  */
 int netif_set_real_num_tx_queues(struct net_device *dev, unsigned int txq)
 {
+	bool disabling;
 	int rc;
 
+	disabling = txq < dev->real_num_tx_queues;
+
 	if (txq < 1 || txq > dev->num_tx_queues)
 		return -EINVAL;
 
@@ -2200,15 +2203,19 @@ int netif_set_real_num_tx_queues(struct
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
