Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49ae7JdhsNfSFXPFBtiS5D3+PFffBOF3OM8A3QX/TC9DGr986BXL86s5GdmBk+tTEf+coeU
ARC-Seal: i=1; a=rsa-sha256; t=1523399329; cv=none;
        d=google.com; s=arc-20160816;
        b=SWmaKBzdRTYrUEchGRbw/y/INgew2vMOb6UotmO8P8cJWgI81xFSd3xtT+dWzjjYoo
         6t49aFXIYeYxzt4fKJSNEoQOdj2z20Tz7Pm7vytjSPU6077glm2jYXR8CKwVKLtDoiKb
         MuadVvUTzWAQCbdhbzAXDAfJlfALuJo+kCT1LzxNFbjqVc1IMOWi84nki5tiZ0Fc96jv
         c/gl0tVltydJue6pO8npJ19UBK4agZLAU6n5Tv/lrlyVrqTk6O0UyvXx75Vow12Ztfix
         c15Q+Ldy7YNkGmRhHJ+wfj21n0/2osWPCA78BmhdfLYsWkUFnSmFcGljaW7hUTDh+niS
         d+FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=TGrRXSxrVQcad35tIBivESRDU53D40KE8Ej4hgoFd2c=;
        b=TyNMzBG+Rf+3CxwRhAr8uJNLb6V+VWkrNCp2QihVkTe4IErN6xq0NHb6jt4L4pjkXh
         Q7wPPIurph7FR9Shl0QiThpIfOAqEvlerbuUU0yB6m59KFr6UhB1OSAkodcpplULTJ9r
         /pcdd1Jd3PO2ivNdv9OCokXp9MXtUfZGwfDQ0EaKH+q3zzZyi5Q4zvbcWqDpkLsuKpzG
         A1lGnAjxzzt0kaFx/ec2vLd0gcgBo6J4vDXFZ1dLjsW/iCpigpkqUzTrShe97yRfDBcN
         svntXK8lmtTqpiTRQCINztL/xGCGTGKvp5PXSNRm3JQagMJqxCSGOfWp16HYlDCm9Dj0
         1KVw==
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
Subject: [PATCH 4.15 068/168] net: hns3: Fix an error of total drop packet statistics
Date: Wed, 11 Apr 2018 00:23:30 +0200
Message-Id: <20180410212803.096339984@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399975210554692?=
X-GMAIL-MSGID: =?utf-8?q?1597399975210554692?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1055,6 +1055,8 @@ hns3_nic_get_stats64(struct net_device *
 	u64 rx_bytes = 0;
 	u64 tx_pkts = 0;
 	u64 rx_pkts = 0;
+	u64 tx_drop = 0;
+	u64 rx_drop = 0;
 
 	for (idx = 0; idx < queue_num; idx++) {
 		/* fetch the tx stats */
@@ -1063,6 +1065,8 @@ hns3_nic_get_stats64(struct net_device *
 			start = u64_stats_fetch_begin_irq(&ring->syncp);
 			tx_bytes += ring->stats.tx_bytes;
 			tx_pkts += ring->stats.tx_pkts;
+			tx_drop += ring->stats.tx_busy;
+			tx_drop += ring->stats.sw_err_cnt;
 		} while (u64_stats_fetch_retry_irq(&ring->syncp, start));
 
 		/* fetch the rx stats */
@@ -1071,6 +1075,9 @@ hns3_nic_get_stats64(struct net_device *
 			start = u64_stats_fetch_begin_irq(&ring->syncp);
 			rx_bytes += ring->stats.rx_bytes;
 			rx_pkts += ring->stats.rx_pkts;
+			rx_drop += ring->stats.non_vld_descs;
+			rx_drop += ring->stats.err_pkt_len;
+			rx_drop += ring->stats.l2_err;
 		} while (u64_stats_fetch_retry_irq(&ring->syncp, start));
 	}
 
@@ -1086,8 +1093,8 @@ hns3_nic_get_stats64(struct net_device *
 	stats->rx_missed_errors = netdev->stats.rx_missed_errors;
 
 	stats->tx_errors = netdev->stats.tx_errors;
-	stats->rx_dropped = netdev->stats.rx_dropped;
-	stats->tx_dropped = netdev->stats.tx_dropped;
+	stats->rx_dropped = rx_drop + netdev->stats.rx_dropped;
+	stats->tx_dropped = tx_drop + netdev->stats.tx_dropped;
 	stats->collisions = netdev->stats.collisions;
 	stats->rx_over_errors = netdev->stats.rx_over_errors;
 	stats->rx_frame_errors = netdev->stats.rx_frame_errors;
