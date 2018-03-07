Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtK7vEejZWVHSh0EamgaGNjIpasxaIXWUJBFAxsNhKxKucEnD3w5GPBykBX4GH9wQpByEP9
ARC-Seal: i=1; a=rsa-sha256; t=1520451691; cv=none;
        d=google.com; s=arc-20160816;
        b=zp+lnoSQ1jPrM2zV0CFXuuoikBedZbtNcwMxAxlP55DVbHdhZtCSOwHzUNGqhPYxET
         IHY5o1mpg4GyR6MBUFopVP7r3yNWJ46SyZLLr5+pxc/M5o22VUr/mXINE2AZQUldueBz
         HAucHZumE5xvQGV2h5i1Z2O9RhUt1ICmZSX3AHt6TTxelgC1N9UgyK/LypzMj8KVmzC8
         WQstZOQm6Ze8zlrjoWTE6MLStZpPJkntCExLG2hUAMjZIcCeObgEjYc7qhSe/COwqy/x
         OtR6BCOD9u9FQgYmyCp/dFw/1lIrINgf0noOLr/sdmzEGAFuGDJMQVeRWjmfRfCkafh6
         zZnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=47u1IIVB613sBLh00yvxu82uyS2XbyD/xwX/2D3l+i8=;
        b=OEmit+tO03yFxrDxwmi7wrr8Qqwwdo4INd5vOyJaUCukP7gybF5J9UBdiVTNY7bsGu
         JoBVIb2YegLQq5u70RhSlSybaHDHqZipy0l5tyYraOwrfsU1UMBcxKuZk5e2g2fPw8Mz
         r3GbdKU0ozm3wOcroeKsr4litT90LRru+vi3s8l06YGRLtsX8LRFsxON6KjFBfWHrJZR
         ykYIvPI4zE/JcWEqoQW44gnQB8UzHPivBt2jMGkZKP8xS819VM2N9USAq1bM0SNcgfyu
         cEOUTdjb+26VWAF1+Yhwhb8C/OIdYZWOyN62dqQHu9HUZTaE0DtvXq9sw+1TuYuXE3lq
         x1lg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Gal Pressman <galp@mellanox.com>,
	Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 4.15 055/122] net/mlx5e: Specify numa node when allocating drop rq
Date: Wed,  7 Mar 2018 11:37:47 -0800
Message-Id: <20180307191737.137654010@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191729.190879024@linuxfoundation.org>
References: <20180307191729.190879024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309152401504243?=
X-GMAIL-MSGID: =?utf-8?q?1594309152401504243?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gal Pressman <galp@mellanox.com>


[ Upstream commit 2f0db87901698cd73d828cc6fb1957b8916fc911 ]

When allocating a drop rq, no numa node is explicitly set which means
allocations are done on node zero. This is not necessarily the nearest
numa node to the HCA, and even worse, might even be a memoryless numa
node.

Choose the numa_node given to us by the pci device in order to properly
allocate the coherent dma memory instead of assuming zero is valid.

Fixes: 556dd1b9c313 ("net/mlx5e: Set drop RQ's necessary parameters only")
Signed-off-by: Gal Pressman <galp@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -1911,13 +1911,16 @@ static void mlx5e_build_rq_param(struct
 	param->wq.linear = 1;
 }
 
-static void mlx5e_build_drop_rq_param(struct mlx5e_rq_param *param)
+static void mlx5e_build_drop_rq_param(struct mlx5_core_dev *mdev,
+				      struct mlx5e_rq_param *param)
 {
 	void *rqc = param->rqc;
 	void *wq = MLX5_ADDR_OF(rqc, rqc, wq);
 
 	MLX5_SET(wq, wq, wq_type, MLX5_WQ_TYPE_LINKED_LIST);
 	MLX5_SET(wq, wq, log_wq_stride,    ilog2(sizeof(struct mlx5e_rx_wqe)));
+
+	param->wq.buf_numa_node = dev_to_node(&mdev->pdev->dev);
 }
 
 static void mlx5e_build_sq_param_common(struct mlx5e_priv *priv,
@@ -2774,6 +2777,9 @@ static int mlx5e_alloc_drop_cq(struct ml
 			       struct mlx5e_cq *cq,
 			       struct mlx5e_cq_param *param)
 {
+	param->wq.buf_numa_node = dev_to_node(&mdev->pdev->dev);
+	param->wq.db_numa_node  = dev_to_node(&mdev->pdev->dev);
+
 	return mlx5e_alloc_cq_common(mdev, param, cq);
 }
 
@@ -2785,7 +2791,7 @@ static int mlx5e_open_drop_rq(struct mlx
 	struct mlx5e_cq *cq = &drop_rq->cq;
 	int err;
 
-	mlx5e_build_drop_rq_param(&rq_param);
+	mlx5e_build_drop_rq_param(mdev, &rq_param);
 
 	err = mlx5e_alloc_drop_cq(mdev, cq, &cq_param);
 	if (err)
