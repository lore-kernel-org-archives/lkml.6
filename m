Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48nsDOmIFkPdN5tqrtEOZqQoHIUqZZFYTxOlrJmr+fTRZVPWqm/dl/poVurqYs+ig/uhlgP
ARC-Seal: i=1; a=rsa-sha256; t=1523399809; cv=none;
        d=google.com; s=arc-20160816;
        b=PFm1qIB5JHaaudXDoNh4ctvAjvTLNmMU8jL2+pvU3Zp+NsSPfUYxEKHtDJtrlOrkzT
         D2Fk+CzUn0xskVa4bV4cBVxrk63uk0r+COfxOFH5jUHY6gcwoArtwMmM3CRp8X89CdSz
         zX5VxBjkgxFDcZWW65NcleJtTfafC7OPMFtZ7PAGzpSTR1AcYTNPcCAMDiFRKP4ES/MT
         jqbYohcxSvq0w2aYscQaT+AGW6Qhjx13etgO3v3L0991WMSGv0M4s4WoAD+1umjgHUnj
         QMQ3RsnH2/gqmFNnpN6mskIEI2GvHq6chj6ssXvQ4mTpjGN6cgAOvS9+X5V6ukxk2/GY
         VlzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=grvrTE7riouWQ7Oo/+9DD5k4U9gmV0fVp9tSOhbAiWU=;
        b=w+hN2v4/1x1auipd8ukeY8HSRDRGx894tCLETlA/4EvspAFEnZA2Kjxk/AdI7rC9e6
         fbA32B68PqTtbi3QuoE/D+WNtFExY+amTiRYIjRj2CC+7AFv/QinZwGKAxIPcgSW5mei
         7ljex/wfm7YN87zYcIppmabJecVQu4xkS67rp6P8++s9fhBDJ2mg54JWlHhrSQl52T5c
         rq3ceT6aLq7TEXb28xGe9kpj/FOoR5pERNrEnWMCoHn5YMQO3RUXSdr2xIbbEVhB6WRR
         CJtz8JIJ1UR5OUZDv1kwiMuGA/0MmzItF66zkkP4xuUKhlwilUcNamLxUndJ4SeiFtkc
         x0uQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jian Shen <shenjian15@huawei.com>,
	Peng Li <lipeng321@huawei.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 053/138] net: hns3: Fix an error of total drop packet statistics
Date: Wed, 11 Apr 2018 00:24:03 +0200
Message-Id: <20180410212908.236927046@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212902.121524696@linuxfoundation.org>
References: <20180410212902.121524696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399975210554692?=
X-GMAIL-MSGID: =?utf-8?q?1597400478969193663?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jian Shen <shenjian15@huawei.com>


[ Upstream commit d2a5dca8404871be683c6bbc175ebf9c56dd2865 ]

The dropped tx/rx packets number of each tqp should also
be counted into the total drop tx/rx packets numbers.

Fixes: 76ad4f0ee74 ("net: hns3: Add support of HNS3 Ethernet Driver for hip08 SoC")
Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hns3_enet.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hns3_enet.c
@@ -1060,6 +1060,8 @@ hns3_nic_get_stats64(struct net_device *
 	u64 rx_bytes = 0;
 	u64 tx_pkts = 0;
 	u64 rx_pkts = 0;
+	u64 tx_drop = 0;
+	u64 rx_drop = 0;
 
 	for (idx = 0; idx < queue_num; idx++) {
 		/* fetch the tx stats */
@@ -1068,6 +1070,8 @@ hns3_nic_get_stats64(struct net_device *
 			start = u64_stats_fetch_begin_irq(&ring->syncp);
 			tx_bytes += ring->stats.tx_bytes;
 			tx_pkts += ring->stats.tx_pkts;
+			tx_drop += ring->stats.tx_busy;
+			tx_drop += ring->stats.sw_err_cnt;
 		} while (u64_stats_fetch_retry_irq(&ring->syncp, start));
 
 		/* fetch the rx stats */
@@ -1076,6 +1080,9 @@ hns3_nic_get_stats64(struct net_device *
 			start = u64_stats_fetch_begin_irq(&ring->syncp);
 			rx_bytes += ring->stats.rx_bytes;
 			rx_pkts += ring->stats.rx_pkts;
+			rx_drop += ring->stats.non_vld_descs;
+			rx_drop += ring->stats.err_pkt_len;
+			rx_drop += ring->stats.l2_err;
 		} while (u64_stats_fetch_retry_irq(&ring->syncp, start));
 	}
 
@@ -1091,8 +1098,8 @@ hns3_nic_get_stats64(struct net_device *
 	stats->rx_missed_errors = netdev->stats.rx_missed_errors;
 
 	stats->tx_errors = netdev->stats.tx_errors;
-	stats->rx_dropped = netdev->stats.rx_dropped;
-	stats->tx_dropped = netdev->stats.tx_dropped;
+	stats->rx_dropped = rx_drop + netdev->stats.rx_dropped;
+	stats->tx_dropped = tx_drop + netdev->stats.tx_dropped;
 	stats->collisions = netdev->stats.collisions;
 	stats->rx_over_errors = netdev->stats.rx_over_errors;
 	stats->rx_frame_errors = netdev->stats.rx_frame_errors;
