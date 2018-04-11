Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49qw2+gDKHVqxm7gpmXZUBttdaoK3skMVuuhQ8xzAjzRwnzkdOSO1LxnLC9tIVS5hD6IdNb
ARC-Seal: i=1; a=rsa-sha256; t=1523473008; cv=none;
        d=google.com; s=arc-20160816;
        b=fA2osGCcXNvMqO8wxy2xCP3Qw9yro+5v/r+AruVSZDQamAreyGqpwWBb9jius8l0mm
         vX0aHihF4itnj+3Q4N9geeTnOxKyv1b31Qqsb+Rxrku3TnZyRnhVo6O36nUEmmVA7GxE
         vyvFcy4d90cJNvU8d4Z3tJHUQuHGvnElWEAsgyMefg3Bgp4LXGRd/Wb2FR7+25L5eEwD
         SmHwRK/GODqUdFvPxUqhyW0zjdcwqXpDqB3N1lzmFtHNQGTlPLsXfWfqbMaNHmADBVSz
         US1C0aVtbPp4dohpEqi6IsvtVL+4YWtqBVtdtR+I2rqaPSUeq7W6JvfElUgocltpuOXZ
         O7cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=EExqPyOi/9+8sqzx5BByI+6zqpb77EbxuvqSHO9iQFA=;
        b=SuZo66z3flsVUv/vxQf3BQ1vmVtazQk8UpgmCzgx2H0dE25pLde53pzq3QMtWBbbLd
         uRRRG5i/OqesvRR6dSPJu5X17FTIhtGqcm0JexLCnOh6zodBD8BDDXxi7IoRww5ZA1xZ
         IMuDf4KUzEmEGlt7xcqkE3ErSuxq/7WL/1ZU/FXjyZl/oUuyye7Rkw/oldn5AJoMbA/e
         S4rGwS798Olu2jfHmW1dikTa/DXwTeLR4elaxOIEG2pzHHUWtbHh2jXb8rk3kv6oG+M1
         BYt3gApUrkHy9NiDr2tyjWl4DkbfGawl/00rXUNh6HtN6Y1AghmaNd18TqzYCE9rvpjs
         kiyA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Tariq Toukan <tariqt@mellanox.com>,
	kernel-team@fb.com,
	Saeed Mahameed <saeedm@mellanox.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 095/310] net/mlx5: Tolerate irq_set_affinity_hint() failures
Date: Wed, 11 Apr 2018 20:33:54 +0200
Message-Id: <20180411183626.322061586@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476666941351616?=
X-GMAIL-MSGID: =?utf-8?q?1597477233829020840?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tariq Toukan <tariqt@mellanox.com>


[ Upstream commit b665d98edc9ab295169be2fc5bb4e89a46de0a1a ]

Add tolerance to failures of irq_set_affinity_hint().
Its role is to give hints that optimizes performance,
and should not block the driver load.

In non-SMP systems, functionality is not available as
there is a single core, and all these calls definitely
fail.  Hence, do not call the function and avoid the
warning prints.

Fixes: db058a186f98 ("net/mlx5_core: Set irq affinity hints")
Signed-off-by: Tariq Toukan <tariqt@mellanox.com>
Cc: kernel-team@fb.com
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/main.c |   15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -548,7 +548,6 @@ static int mlx5_irq_set_affinity_hint(st
 	struct mlx5_priv *priv  = &mdev->priv;
 	struct msix_entry *msix = priv->msix_arr;
 	int irq                 = msix[i + MLX5_EQ_VEC_COMP_BASE].vector;
-	int err;
 
 	if (!zalloc_cpumask_var(&priv->irq_info[i].mask, GFP_KERNEL)) {
 		mlx5_core_warn(mdev, "zalloc_cpumask_var failed");
@@ -558,18 +557,12 @@ static int mlx5_irq_set_affinity_hint(st
 	cpumask_set_cpu(cpumask_local_spread(i, priv->numa_node),
 			priv->irq_info[i].mask);
 
-	err = irq_set_affinity_hint(irq, priv->irq_info[i].mask);
-	if (err) {
-		mlx5_core_warn(mdev, "irq_set_affinity_hint failed,irq 0x%.4x",
-			       irq);
-		goto err_clear_mask;
-	}
+#ifdef CONFIG_SMP
+	if (irq_set_affinity_hint(irq, priv->irq_info[i].mask))
+		mlx5_core_warn(mdev, "irq_set_affinity_hint failed, irq 0x%.4x", irq);
+#endif
 
 	return 0;
-
-err_clear_mask:
-	free_cpumask_var(priv->irq_info[i].mask);
-	return err;
 }
 
 static void mlx5_irq_clear_affinity_hint(struct mlx5_core_dev *mdev, int i)
