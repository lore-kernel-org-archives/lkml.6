Return-Path: <SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZq82a4kbwAzP5d0tAQwytG9NRkTdn94IBStQ4PM8yo5klkNPJ9oZ5M/a9U1pqSnGPspwf2h
ARC-Seal: i=1; a=rsa-sha256; t=1526631477; cv=none;
        d=google.com; s=arc-20160816;
        b=W/6g3NboUur8V4UMEcRMLsFwdBwgURiOXJZV5s5UZ5GpTvxt5OqaaB4mmEFY6m/oHK
         nXoahfSRgWY/ldRp+xZsb8EXg+teXAF8Qolsit2mBE8e7NHThgoZj4ydTevYYO6VY00/
         0ZPf5zp77A9csMSkBquJmV/YQ6/p4kcRNGcl5IWksRoUhTVdpeO0QBt64wiMVFtO8I+2
         cavWq2tCfCRd+x5Ugrb8Ilz+YNwMkXzVWtb8NtOANqq8B59+7KgXI1kFHEynf4NF6wLi
         4pKfeq7Ggknn+5QoDPBVlvGkAU9b6wgQIWnv55COG5BOls958EhDDNnQ6wWdVVAutjgJ
         O2yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=ObqVHdoexNC/6o/mxznDZUbnXRv8c12cGzSKWogVNHo=;
        b=Fe9x2K8XUJ7MxekzdKf8vhlQHFQwlfWhxABCU24h9AtyLVlzvc29e6HZVwPn8xEIpU
         wCGfrqvDlR+VGtCcT11ADpTLKey92HdBTeIpjTa8iy/k3eIuW39xwjynYefSjkxOpouz
         9RFq58Xg2OScTGhY8+t4RUzjyYrZukNJaNn9pktga8suhPtC4EqevN7OMdJLlW1KTLCP
         xJl9nW5W513gyL8wqYHb2cQVVmkaZklcYny8tk58gYSg1lpoqYuyvkLD4NaFAwoEOkoC
         m3nJaNzGTA8/PQDZKdPr3iP/n/8RCpz2oxnq6nG6qqBQkqooIYzMhxh4CjAUoGDnMQLE
         Uwzw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=LcDU3amg;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=LcDU3amg;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Tariq Toukan <tariqt@mellanox.com>,
	Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 4.16 34/55] net/mlx5e: TX, Use correct counter in dma_map error flow
Date: Fri, 18 May 2018 10:15:30 +0200
Message-Id: <20180518081459.089439074@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518081457.428920292@linuxfoundation.org>
References: <20180518081457.428920292@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600789128304951847?=
X-GMAIL-MSGID: =?utf-8?q?1600789128304951847?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -255,7 +255,7 @@ mlx5e_txwqe_build_dsegs(struct mlx5e_txq
 		dma_addr = dma_map_single(sq->pdev, skb_data, headlen,
 					  DMA_TO_DEVICE);
 		if (unlikely(dma_mapping_error(sq->pdev, dma_addr)))
-			return -ENOMEM;
+			goto dma_unmap_wqe_err;
 
 		dseg->addr       = cpu_to_be64(dma_addr);
 		dseg->lkey       = sq->mkey_be;
@@ -273,7 +273,7 @@ mlx5e_txwqe_build_dsegs(struct mlx5e_txq
 		dma_addr = skb_frag_dma_map(sq->pdev, frag, 0, fsz,
 					    DMA_TO_DEVICE);
 		if (unlikely(dma_mapping_error(sq->pdev, dma_addr)))
-			return -ENOMEM;
+			goto dma_unmap_wqe_err;
 
 		dseg->addr       = cpu_to_be64(dma_addr);
 		dseg->lkey       = sq->mkey_be;
@@ -285,6 +285,10 @@ mlx5e_txwqe_build_dsegs(struct mlx5e_txq
 	}
 
 	return num_dma;
+
+dma_unmap_wqe_err:
+	mlx5e_dma_unmap_wqe_err(sq, num_dma);
+	return -ENOMEM;
 }
 
 static inline void
@@ -380,17 +384,15 @@ static netdev_tx_t mlx5e_sq_xmit(struct
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
@@ -620,17 +622,15 @@ netdev_tx_t mlx5i_sq_xmit(struct mlx5e_t
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
