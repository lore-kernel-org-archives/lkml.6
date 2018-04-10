Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48reqTgk/SXcsfPPL6VbObOICKVf0UQv0DZXXw8RohhwkFoDEhuOxl6gomUCDlrfOBU1yie
ARC-Seal: i=1; a=rsa-sha256; t=1523399333; cv=none;
        d=google.com; s=arc-20160816;
        b=ax0SpZgcnMWt3vxy1PbFgBVdtqZ8dkzpGIV+7v+FvFw7lgEmbza+sLrDtz/J5WTxLL
         4Vtk3WH3EKGCIEajm6eBunt03w/Us0vdRsdrgdzpn/7ZI/ytFSfJWLx/XvhV7Re+eXYd
         WswoximLnGScll2P/RPQqL+bX2ht145/CmoLS6m2GtkQU8HnEv3CYOEWUYPvwxZTkQsg
         x6IsHKW3ZKOy9oy8Zsf89AFulGGxtwpqpZ7uRhAQ/kKdqqS/l9uoZvkshnBsLKYyK5pa
         h7U/dPXqgBKVtnpNSKm+eFOW9DDcMfwJm3x5ojrkqPy216dzX9pZDdQSSdkaemVyBheq
         xoGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=AVvBXRTVARfpq5CbvKsouwit6F2XPV9o9+M994NQPyU=;
        b=ysvQ4ArAvPUA7nxoxK0y345IKyZ/9bWSfty/W9qfg5ghEC1Uwks2AiFxiCqARbjUIS
         MpYntRB4AGN6EJx0k8a0H9ckXD2xG+bB641gx79V50eCkpdf2uixHyKAZ4mguGopRoj+
         N0ibIA+THI+AuEqVoRzrRWpnpqZ9Jw9z/uxXOlarP1iJcJh1YdM5ZOB9opbwaFtIJCRD
         7lOtdryR29mpBwN6+yzE7O/KZRpDetpyeAGXozpokB7G2vJ93/s7IAml4aF5HUIhQaqL
         H7SG8y3MC8u0iiG7/hxHR7+ak3CfGzdm7QxYzQoVUzYf7QLlUfp/tGtbNtybwz0uZbxp
         EPIQ==
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
Subject: [PATCH 4.15 069/168] net: hns3: Fix a loop index error of tqp statistics query
Date: Wed, 11 Apr 2018 00:23:31 +0200
Message-Id: <20180410212803.132706603@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399979145603129?=
X-GMAIL-MSGID: =?utf-8?q?1597399979145603129?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -455,13 +455,13 @@ static u64 *hns3_get_stats_tqps(struct h
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
@@ -469,8 +469,8 @@ static u64 *hns3_get_stats_tqps(struct h
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
