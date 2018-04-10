Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49BnVGcVHxV35+JwRrn0GxZeRv4JcIbyJE9TtND+tYI9yEWTjUPnj3ITZ7MBYleOkQ1ON/x
ARC-Seal: i=1; a=rsa-sha256; t=1523399416; cv=none;
        d=google.com; s=arc-20160816;
        b=vyR3aTG0JP7XNAjfYRiCENMZSSYZdxmmQuuMEbHVGb5CJcNtrGM15UUnOfUlZWavpw
         rJAh8BBCG9MkIt8d9ei8jmgjFuWlOzKsnR7FKFpQb9rsXlmr1E1Vyg3384awiH/OKP+f
         t3QQ7OIklmxFZdHg8RVlEQedmfIKuFhaAKI9oS8QlmTjt2DOQNo7QMQ8gBrild3tVCpT
         r2v488+BQNfey3lil9hqkXIVMoiSBVlIIs3TByunH3wu9EINsuFcvzTBTfTb3Fk9Bjlj
         DnS8y+CoealEw0LF2Sp7GEULFiWnYuuy76xBj9hUSK25yWUR7JBy9S+xLzbnKq2gG/U0
         8HUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=WiwTsk1MEiV1yytlV9p4YvH8kQC99viClXsq152L4ag=;
        b=eLDmiaP4y04PWgiaef3X68HPfOq7t/uAuV3hbGU41j7q6nR4Q8dLyngJL36CDccnm+
         2g/vl+pNQFW8ISUXRZaj6DnLBVyfhRZdWLdYW8nmZhONX4ylfgSIbf9mcGwfQKdMxqca
         ybVafRWy2toZUkbDUIr4+PiqlEanEllMb0PgR/hhwPl+NDJPCTxdl/xvQeXjLYcwvDSr
         9PiTvGi4HXxmqDAd3dNeelH/Z8tFfonFmkYRVcRPpuDyfYAc0urCibnIpGckG8DzM5T1
         I/lLl6kCVNtSwiq3RM0hqCm36J/zpTZ6LsrEq98OqWlkbYdRtkIqKkvIsZaIJKwqr+mO
         3afg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Feras Daoud <ferasda@mellanox.com>,
	Saeed Mahameed <saeedm@mellanox.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 080/168] net/mlx5e: IPoIB, Use correct timestamp in child receive flow
Date: Wed, 11 Apr 2018 00:23:42 +0200
Message-Id: <20180410212803.686823298@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597400066724642274?=
X-GMAIL-MSGID: =?utf-8?q?1597400066724642274?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Feras Daoud <ferasda@mellanox.com>


[ Upstream commit 36e564b76f1862914ad32c35bab433e07da2ebf8 ]

The current implementation takes the child timestamp object from
the parent since the rq in mlx5i_complete_rx_cqe belongs to the parent.
This change fixes the issue by taking the correct timestamp.

Fixes: 7e7f4780c340 ("net/mlx5e: IPoIB, Use hash-table to map between QPN to child netdev")
Signed-off-by: Feras Daoud <ferasda@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -1196,7 +1196,9 @@ static inline void mlx5i_complete_rx_cqe
 					 u32 cqe_bcnt,
 					 struct sk_buff *skb)
 {
+	struct hwtstamp_config *tstamp;
 	struct net_device *netdev;
+	struct mlx5e_priv *priv;
 	char *pseudo_header;
 	u32 qpn;
 	u8 *dgid;
@@ -1215,6 +1217,9 @@ static inline void mlx5i_complete_rx_cqe
 		return;
 	}
 
+	priv = mlx5i_epriv(netdev);
+	tstamp = &priv->tstamp;
+
 	g = (be32_to_cpu(cqe->flags_rqpn) >> 28) & 3;
 	dgid = skb->data + MLX5_IB_GRH_DGID_OFFSET;
 	if ((!g) || dgid[0] != 0xff)
@@ -1235,7 +1240,7 @@ static inline void mlx5i_complete_rx_cqe
 	skb->ip_summed = CHECKSUM_COMPLETE;
 	skb->csum = csum_unfold((__force __sum16)cqe->check_sum);
 
-	if (unlikely(mlx5e_rx_hw_stamp(rq->tstamp)))
+	if (unlikely(mlx5e_rx_hw_stamp(tstamp)))
 		skb_hwtstamps(skb)->hwtstamp =
 				mlx5_timecounter_cyc2time(rq->clock, get_cqe_ts(cqe));
 
