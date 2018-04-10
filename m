Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/QJgxaMsyc4txdGwQL4RLj6WScpkiXJOLUGHLRT7rkENeCU31UV/HloJqHd8NE6833A1xb
ARC-Seal: i=1; a=rsa-sha256; t=1523399813; cv=none;
        d=google.com; s=arc-20160816;
        b=ItCghqtzYntbQXGGvTDizCEuTEFFwROXmqevna2d5a3nxG6eeSjM8TaWdexttHZskg
         Hb8xgadIxShCN2NgK41xfbbBxQQlbmWuq8MJMgjhRnZgMaGL8tgzJMVDrx++nh2U4yXV
         gvWSjMO10yrQniQQOUEfWD7Vg+rFkBdzKE2KXaJ8QZMYTChsu9Te05Ra6pm/LjhM6PZg
         +W9VMwFDxxk4TWP0dzztFICwCr4sVYZ9D2VDnrrKHCIle7D8Jj/PVp7GSmZNYs5ov16P
         k8RbZY3bGwI75OAIeYu470oOo07mas5QfWr0Y6mC5W/7gwXdeTXq+/yDy7rtfdXql+UV
         yyxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=on1fYisco1lEV1Z+GN0p/gZ4BszWjK8EN4O3Bj5KR9E=;
        b=kEdYRquzP/FFJSNUMFVP5BOzgIKxQ233wB+6yGvyZO349IcGs+HCdSPiDS1Jsj5lZM
         g/GJ4Fw7yqqVROKowM3LmucZECw4BQDi02ifqnjkjmmb36T4MSXsKn5WMDnC2ufvCrk0
         /Vne4kPvRPeqD9XFTUeibnxH6+duqUBeqHCEl8I+ePm+GEITZmEguczMr1ftmXhYUWLN
         Esq0bM6wNlwdqOi5WlJB+GutI5QmsHLp9I3j+fW5+5dh3HsQwI5KYfrsetNPMn93C/x5
         xWQ6WnT442KPBL8+jbHGC3XEGr1ORmNw4g0+Ocpju6PETP9SE14SzgF/araHfxT5mjgn
         TBSw==
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
Subject: [PATCH 4.14 054/138] net: hns3: Fix a loop index error of tqp statistics query
Date: Wed, 11 Apr 2018 00:24:04 +0200
Message-Id: <20180410212908.378080215@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212902.121524696@linuxfoundation.org>
References: <20180410212902.121524696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399979145603129?=
X-GMAIL-MSGID: =?utf-8?q?1597400482339236853?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jian Shen <shenjian15@huawei.com>


[ Upstream commit 94bfaafac9d2a3c0bcca00d01e38f7597b741799 ]

An error loop index was used while querying statistics data
of tqps, which may cause call trace.

Fixes: 496d03e960ae ("net: hns3: Add Ethtool support to HNS3 driver")
Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hns3_ethtool.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hns3_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hns3_ethtool.c
@@ -189,13 +189,13 @@ static u64 *hns3_get_stats_tqps(struct h
 	struct hnae3_knic_private_info *kinfo = &handle->kinfo;
 	struct hns3_enet_ring *ring;
 	u8 *stat;
-	u32 i;
+	int i, j;
 
 	/* get stats for Tx */
 	for (i = 0; i < kinfo->num_tqps; i++) {
 		ring = nic_priv->ring_data[i].ring;
-		for (i = 0; i < HNS3_TXQ_STATS_COUNT; i++) {
-			stat = (u8 *)ring + hns3_txq_stats[i].stats_offset;
+		for (j = 0; j < HNS3_TXQ_STATS_COUNT; j++) {
+			stat = (u8 *)ring + hns3_txq_stats[j].stats_offset;
 			*data++ = *(u64 *)stat;
 		}
 	}
@@ -203,8 +203,8 @@ static u64 *hns3_get_stats_tqps(struct h
 	/* get stats for Rx */
 	for (i = 0; i < kinfo->num_tqps; i++) {
 		ring = nic_priv->ring_data[i + kinfo->num_tqps].ring;
-		for (i = 0; i < HNS3_RXQ_STATS_COUNT; i++) {
-			stat = (u8 *)ring + hns3_rxq_stats[i].stats_offset;
+		for (j = 0; j < HNS3_RXQ_STATS_COUNT; j++) {
+			stat = (u8 *)ring + hns3_rxq_stats[j].stats_offset;
 			*data++ = *(u64 *)stat;
 		}
 	}
