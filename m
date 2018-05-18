Return-Path: <SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqy9WqCZDf4BIi+KIWi0zA4qy8OIXBMKDvYRO1tr3sicikwRmFpHesRc+zJUXcTxKcdgqRX
ARC-Seal: i=1; a=rsa-sha256; t=1526631622; cv=none;
        d=google.com; s=arc-20160816;
        b=MeKOsjtMqE6VpPmOg3v6NJYnGvo4GWjFIBuB1CghbsdlnVcJQyWT08jD4BslLtQpvK
         jXtHN+GAL/6vXxaLOVjHWVhX+SYlFofgCuwSgN5Hzi+hhkY5KO/wEVkeTXazRZr6ydb3
         ZNCt4mc1QFAgawV+0rWkJoQ7Qz6MPo2EYqbOcpUUPWaGH3WbWpQY0k70GiG3o4yWNZV/
         YiwhF+FpzdR40t0DGjfpXvOKiK0jYgxilfyLiEndQrVphz8eYD/8JGj9AKlWNaEaouKy
         tB9vezIZZwYypCEyuTFIMCEAj1AcPYGBvC4YsnI9sCdQMYimla6r3jukgzq9vJtDfZB/
         C6JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=2qUqH7SPCG/3tpSVy7d1g7qZ83QmpagqTjGpEXRWbgg=;
        b=nxdaH1ZI/HeCcNQ/jvB8PVtAefu5jzC3qEJLFjwm4Z2/cx9PSJ38kD1MmcK8w+iKs3
         /fDwyY5VTBkk+F6LeLwCfndgJbU6FpTQVnmg2MPm2vGTHYzja2dWTkXDXFwqZIJikzqW
         lrW18VSRA37VKjjzbc1eBi/4way90TVZGiiPncDwF+5SjxsaMHT7lmwams0SMryyASvs
         zpUXHJXYSQ2rpAy4aWuPcQec0hpbkJIVdEaFWE80QjVItC3cwVXsN/XgIDf4QshZd2G7
         1F0cwJbZgXsNBZp9EQAkGqvvHx/piz0ZyXnV0RiR2V5cbYW1/Nqq3t8EONN0Bc1qLmsj
         kS1Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=J+2I5IlB;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=J+2I5IlB;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Tariq Toukan <tariqt@mellanox.com>,
	Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 4.14 33/45] net/mlx5e: TX, Use correct counter in dma_map error flow
Date: Fri, 18 May 2018 10:15:50 +0200
Message-Id: <20180518081532.063699617@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518081530.331586165@linuxfoundation.org>
References: <20180518081530.331586165@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600789128304951847?=
X-GMAIL-MSGID: =?utf-8?q?1600789279588497698?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tariq Toukan <tariqt@mellanox.com>

[ Upstream commit d9a96ec362e3da878c378854e25321c85bac52c2 ]

In case of a dma_mapping_error, do not use wi->num_dma
as a parameter for dma unmap function because it's yet
to be set, and holds an out-of-date value.
Use actual value (local variable num_dma) instead.

Fixes: 34802a42b352 ("net/mlx5e: Do not modify the TX SKB")
Fixes: e586b3b0baee ("net/mlx5: Ethernet Datapath files")
Signed-off-by: Tariq Toukan <tariqt@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_tx.c |   20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
@@ -234,7 +234,7 @@ mlx5e_txwqe_build_dsegs(struct mlx5e_txq
 		dma_addr = dma_map_single(sq->pdev, skb_data, headlen,
 					  DMA_TO_DEVICE);
 		if (unlikely(dma_mapping_error(sq->pdev, dma_addr)))
-			return -ENOMEM;
+			goto dma_unmap_wqe_err;
 
 		dseg->addr       = cpu_to_be64(dma_addr);
 		dseg->lkey       = sq->mkey_be;
@@ -252,7 +252,7 @@ mlx5e_txwqe_build_dsegs(struct mlx5e_txq
 		dma_addr = skb_frag_dma_map(sq->pdev, frag, 0, fsz,
 					    DMA_TO_DEVICE);
 		if (unlikely(dma_mapping_error(sq->pdev, dma_addr)))
-			return -ENOMEM;
+			goto dma_unmap_wqe_err;
 
 		dseg->addr       = cpu_to_be64(dma_addr);
 		dseg->lkey       = sq->mkey_be;
@@ -264,6 +264,10 @@ mlx5e_txwqe_build_dsegs(struct mlx5e_txq
 	}
 
 	return num_dma;
+
+dma_unmap_wqe_err:
+	mlx5e_dma_unmap_wqe_err(sq, num_dma);
+	return -ENOMEM;
 }
 
 static inline void
@@ -355,17 +359,15 @@ static netdev_tx_t mlx5e_sq_xmit(struct
 	num_dma = mlx5e_txwqe_build_dsegs(sq, skb, skb_data, headlen,
 					  (struct mlx5_wqe_data_seg *)cseg + ds_cnt);
 	if (unlikely(num_dma < 0))
-		goto dma_unmap_wqe_err;
+		goto err_drop;
 
 	mlx5e_txwqe_complete(sq, skb, opcode, ds_cnt + num_dma,
 			     num_bytes, num_dma, wi, cseg);
 
 	return NETDEV_TX_OK;
 
-dma_unmap_wqe_err:
+err_drop:
 	sq->stats.dropped++;
-	mlx5e_dma_unmap_wqe_err(sq, wi->num_dma);
-
 	dev_kfree_skb_any(skb);
 
 	return NETDEV_TX_OK;
@@ -594,17 +596,15 @@ netdev_tx_t mlx5i_sq_xmit(struct mlx5e_t
 	num_dma = mlx5e_txwqe_build_dsegs(sq, skb, skb_data, headlen,
 					  (struct mlx5_wqe_data_seg *)cseg + ds_cnt);
 	if (unlikely(num_dma < 0))
-		goto dma_unmap_wqe_err;
+		goto err_drop;
 
 	mlx5e_txwqe_complete(sq, skb, opcode, ds_cnt + num_dma,
 			     num_bytes, num_dma, wi, cseg);
 
 	return NETDEV_TX_OK;
 
-dma_unmap_wqe_err:
+err_drop:
 	sq->stats.dropped++;
-	mlx5e_dma_unmap_wqe_err(sq, wi->num_dma);
-
 	dev_kfree_skb_any(skb);
 
 	return NETDEV_TX_OK;
