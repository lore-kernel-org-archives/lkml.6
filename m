Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsp6aL/EZcrqEbPiueYqNbHafN+Gb+dbmNBD4ZcUssgQt2z85SgszBGCLAnT8YGmp5uLm5L
ARC-Seal: i=1; a=rsa-sha256; t=1520451943; cv=none;
        d=google.com; s=arc-20160816;
        b=uBpibjP6nV/4EWPu5/k82xFhIC3BNqXvyEYpVD+bUh9C5E8WkBfgPjfTM17X8UAo5G
         VtY51bvYvSalCgpHE3YEmG3jfUORe/pJEqt2af/K+t9n7y4mX1asPH9M2/qfew9MyL24
         gMSC50s+JT39rfgORz7ijLrWfd1Z6JD/KzYzfyueolZki5eURNc9aMNH+1UFAN24Aa/a
         HfpXE+v9a5ZNoiGVa5cXHTwtzjUTDzsd3hyr6hYhcEcthk8panjWShhpbT9BWQ0bdRJA
         xzbezhHtj5jK8sz7ATuu6iWFOZ7Dlxb2ThPHQKO5//bJcuc7X9GusjSoekKYByHQ8U+P
         Q+5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Scts/hJbY42HoF0zRz6TrXjmzzwhpfANbK5NY/nDezw=;
        b=WJwadjYJE4kCnR1YfYtQArIyCVaRMLJAiYbN58PdJ51bMOZ7RaOuV8NuhzHw9mDRcX
         HxkHxCFdkM8sb5jHdM8TXs0b+H8KFQDstGTlgrwCHR1ujfJbMcf0hVjylQylfbsLezXT
         mUFPAIHOz3D8bIDBiKX4C5glWQzs+GxshXwJVgXXExLXvKjYs3Er1A7W38WyWfhw08Ch
         DV0Oj171fJyJ1MeCz2xstSERLTzLuXfrbbQGA+yjMGUqrHl8/lFDsc3QGpez7pqaQPkY
         K7mAGO877Wj9ScqetNFpjDtsX/qWgrOCtohBnkN3LlfTta7lW46LntC5gV/CC5usudWx
         tZHQ==
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
Subject: [PATCH 4.14 040/110] net: fix race on decreasing number of TX queues
Date: Wed,  7 Mar 2018 11:38:23 -0800
Message-Id: <20180307191044.878257226@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191039.748351103@linuxfoundation.org>
References: <20180307191039.748351103@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309127138862131?=
X-GMAIL-MSGID: =?utf-8?q?1594309416860689969?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2343,8 +2343,11 @@ EXPORT_SYMBOL(netdev_set_num_tc);
  */
 int netif_set_real_num_tx_queues(struct net_device *dev, unsigned int txq)
 {
+	bool disabling;
 	int rc;
 
+	disabling = txq < dev->real_num_tx_queues;
+
 	if (txq < 1 || txq > dev->num_tx_queues)
 		return -EINVAL;
 
@@ -2360,15 +2363,19 @@ int netif_set_real_num_tx_queues(struct
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
