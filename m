Return-Path: <SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrNlT30G82Jg8mQqnxF2XUqKWOIwE2Ko58OTxgliFwLF0N5acgSXWN7gYEAfnXsN6yS3Vtm
ARC-Seal: i=1; a=rsa-sha256; t=1526631542; cv=none;
        d=google.com; s=arc-20160816;
        b=ZCoE1fupdbOpfvzz1SW1IdNh/Z2VoL0Z0p+ygK3siTaeYD1DuYm6cDsXOlZ5TvEa5k
         bQHWzavaZLNh8uTTOnZstvogu13gaFBc09cPiuVCM5u3VI+QZaTijIDxKon8GMDG4imb
         Lwu7+BjeAjY/b45o1xKwh0WmXDdYnt8UXRLmzqiyNH8hfvPFfaMHLc8h+4+EqENW3Mal
         8pb8xCuR6vhC1or9cN21scp16CajcpjnPKzfONCTlDS6zt7tQDNqGlv4UdtMsrwAI0mJ
         1xW6bqVBJmkC2d3WJlVu4yuHfJONrYt2kr8jmnDBkVayzCx5NejruAkDSi2ihuHpzoBl
         fozA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=E2lE4OvHFGbMoMDmljrSA9Q1JNhOZPvp7ETJva03rKA=;
        b=Z1Db0cnYhmOeSod2UYvjnZEylGM84X68NwFmJ2LT7QZ3P7iC/uzmrC/N8csjXP4vON
         2tXm276lRHlQRE3+MLnWib4LPygwVjrhzdO52TkiESbIA3v32gb9mifp4rOWGgUSvmOs
         a1zBVchQGvx5ZhmBSH5IfJzc85i9bd9LYvvVTLdUx+SS/Fkb4UhT5DlKHl16YqukocoI
         iprHp5uNKXRma/4BM2h38Aa4/5n3dcPJ0ODKqPBrsfzK5yLOy2rPepnfpEbxPd4b12UB
         Aky+OwNW9ol0BqsTXtR+wXs0W16kH1DWzdvmkt4SLIVI5OjUB2MJNdRIVfy7uMYkkRty
         AVog==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=m87lN+Lv;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=m87lN+Lv;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Israel Rukshin <israelr@mellanox.com>,
	Max Gurtovoy <maxg@mellanox.com>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH 4.16 51/55] net/mlx5: Fix mlx5_get_vector_affinity function
Date: Fri, 18 May 2018 10:15:47 +0200
Message-Id: <20180518081459.785651055@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518081457.428920292@linuxfoundation.org>
References: <20180518081457.428920292@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600789196114601610?=
X-GMAIL-MSGID: =?utf-8?q?1600789196114601610?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Israel Rukshin <israelr@mellanox.com>

[ Upstream commit 6082d9c9c94a408d7409b5f2e4e42ac9e8b16d0d ]

Adding the vector offset when calling to mlx5_vector2eqn() is wrong.
This is because mlx5_vector2eqn() checks if EQ index is equal to vector number
and the fact that the internal completion vectors that mlx5 allocates
don't get an EQ index.

The second problem here is that using effective_affinity_mask gives the same
CPU for different vectors.
This leads to unmapped queues when calling it from blk_mq_rdma_map_queues().
This doesn't happen when using affinity_hint mask.

Fixes: 2572cf57d75a ("mlx5: fix mlx5_get_vector_affinity to start from completion vector 0")
Fixes: 05e0cc84e00c ("net/mlx5: Fix get vector affinity helper function")
Signed-off-by: Israel Rukshin <israelr@mellanox.com>
Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/hw/mlx5/main.c |    2 +-
 include/linux/mlx5/driver.h       |   12 +++---------
 2 files changed, 4 insertions(+), 10 deletions(-)

--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -4303,7 +4303,7 @@ mlx5_ib_get_vector_affinity(struct ib_de
 {
 	struct mlx5_ib_dev *dev = to_mdev(ibdev);
 
-	return mlx5_get_vector_affinity(dev->mdev, comp_vector);
+	return mlx5_get_vector_affinity_hint(dev->mdev, comp_vector);
 }
 
 /* The mlx5_ib_multiport_mutex should be held when calling this function */
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -1269,25 +1269,19 @@ enum {
 };
 
 static inline const struct cpumask *
-mlx5_get_vector_affinity(struct mlx5_core_dev *dev, int vector)
+mlx5_get_vector_affinity_hint(struct mlx5_core_dev *dev, int vector)
 {
-	const struct cpumask *mask;
 	struct irq_desc *desc;
 	unsigned int irq;
 	int eqn;
 	int err;
 
-	err = mlx5_vector2eqn(dev, MLX5_EQ_VEC_COMP_BASE + vector, &eqn, &irq);
+	err = mlx5_vector2eqn(dev, vector, &eqn, &irq);
 	if (err)
 		return NULL;
 
 	desc = irq_to_desc(irq);
-#ifdef CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK
-	mask = irq_data_get_effective_affinity_mask(&desc->irq_data);
-#else
-	mask = desc->irq_common_data.affinity;
-#endif
-	return mask;
+	return desc->affinity_hint;
 }
 
 #endif /* MLX5_DRIVER_H */
