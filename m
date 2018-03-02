Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELso1gfop6MvyOkE6Tc3BGRL+pqzLgvxS87IrMbqh16Sh/cusmEgTr6eBWDlM3TJRZV6GTlA
ARC-Seal: i=1; a=rsa-sha256; t=1519981258; cv=none;
        d=google.com; s=arc-20160816;
        b=yfZu9hEpIJPXs+cZprZwY9mZ3wiUVd56CWZ2xg7Fg+9EAskvXtFcLDRkgbyEV2KUSn
         ApBLjVl0kDeoHP04d48vQs6x6jAa1PdrO+zsVBcOVldGxl/xxJmDVJuocxaY1BTvFPES
         aYHH+mA668RYKcntYvHps6WuJGPVPzxlUbLQsqT7MsxcDw4N03dnbLbZW68czVoqUjAq
         GsQJNlVNL94UHXlS2fcD7acHHTZRydjkUBsBjL1YmGxKGcuq7tZ39ALSIvfvebFiGUKw
         ZwTcAW5Hyy/QkOvSwa9Rer2wfzS7B1lXRY29cZuUsx9C8qvHKdWB5tI0bgX6PCe+E/BO
         4xLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=CQNLpJTkt44drMc1YwIsqetxmSThsxt4pR0RwZGKZJ8=;
        b=GHAgRZAHBwaOkoC1QQ0Ai3BIeFg7iSsOFWP5FJFhIxd3xVfuo+nUQsxHtcc/zIU5u4
         te2Yv856zj7d+vsn7eC4HEboB5K1FbroPR2v+mHuymvGjr9yU9BpoJ+OUxnb1SPy63S2
         lSmpr9UyMZZIcl48Z/qnH5mzvJf7w012j8W9RIHhJKd6xz3Cv7RUUhhKMrf1HR1sVyKr
         tc4XQnmIg0YTNSBBe1VdQVOYnq7dTzHPR7fZuP80nXQJeYe2Frz60BW9BFmXzbsgrq9v
         bhxJKt/lTTPlx0F4Tto3a1oe9klOQo2TICMXXAGzv7HFLYimyYx5IiD+OR4tW78uOho6
         sUmA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Moshe Shemesh <moshe@mellanox.com>,
	Saeed Mahameed <saeedm@mellanox.com>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 039/115] net/mlx5: Cleanup IRQs in case of unload failure
Date: Fri,  2 Mar 2018 09:50:42 +0100
Message-Id: <20180302084505.463099021@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
References: <20180302084503.856536800@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815868132873268?=
X-GMAIL-MSGID: =?utf-8?q?1593815868132873268?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Moshe Shemesh <moshe@mellanox.com>


[ Upstream commit d6b2785cd55ee72e9608762650b3ef299f801b1b ]

When mlx5_stop_eqs fails to destroy any of the eqs it returns with an error.
In such failure flow the function will return without
releasing all EQs irqs and then pci_free_irq_vectors will fail.
Fix by only warn on destroy EQ failure and continue to release other
EQs and their irqs.

It fixes the following kernel trace:
kernel: kernel BUG at drivers/pci/msi.c:352!
...
...
kernel: Call Trace:
kernel: pci_disable_msix+0xd3/0x100
kernel: pci_free_irq_vectors+0xe/0x20
kernel: mlx5_load_one.isra.17+0x9f5/0xec0 [mlx5_core]

Fixes: e126ba97dba9 ("mlx5: Add driver for Mellanox Connect-IB adapters")
Signed-off-by: Moshe Shemesh <moshe@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/eq.c |   20 +++++++++++++-------
 include/linux/mlx5/driver.h                  |    2 +-
 2 files changed, 14 insertions(+), 8 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/eq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
@@ -776,7 +776,7 @@ err1:
 	return err;
 }
 
-int mlx5_stop_eqs(struct mlx5_core_dev *dev)
+void mlx5_stop_eqs(struct mlx5_core_dev *dev)
 {
 	struct mlx5_eq_table *table = &dev->priv.eq_table;
 	int err;
@@ -785,22 +785,28 @@ int mlx5_stop_eqs(struct mlx5_core_dev *
 	if (MLX5_CAP_GEN(dev, pg)) {
 		err = mlx5_destroy_unmap_eq(dev, &table->pfault_eq);
 		if (err)
-			return err;
+			mlx5_core_err(dev, "failed to destroy page fault eq, err(%d)\n",
+				      err);
 	}
 #endif
 
 	err = mlx5_destroy_unmap_eq(dev, &table->pages_eq);
 	if (err)
-		return err;
+		mlx5_core_err(dev, "failed to destroy pages eq, err(%d)\n",
+			      err);
 
-	mlx5_destroy_unmap_eq(dev, &table->async_eq);
+	err = mlx5_destroy_unmap_eq(dev, &table->async_eq);
+	if (err)
+		mlx5_core_err(dev, "failed to destroy async eq, err(%d)\n",
+			      err);
 	mlx5_cmd_use_polling(dev);
 
 	err = mlx5_destroy_unmap_eq(dev, &table->cmd_eq);
-	if (err)
+	if (err) {
+		mlx5_core_err(dev, "failed to destroy command eq, err(%d)\n",
+			      err);
 		mlx5_cmd_use_events(dev);
-
-	return err;
+	}
 }
 
 int mlx5_core_eq_query(struct mlx5_core_dev *dev, struct mlx5_eq *eq,
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -1017,7 +1017,7 @@ int mlx5_create_map_eq(struct mlx5_core_
 		       enum mlx5_eq_type type);
 int mlx5_destroy_unmap_eq(struct mlx5_core_dev *dev, struct mlx5_eq *eq);
 int mlx5_start_eqs(struct mlx5_core_dev *dev);
-int mlx5_stop_eqs(struct mlx5_core_dev *dev);
+void mlx5_stop_eqs(struct mlx5_core_dev *dev);
 int mlx5_vector2eqn(struct mlx5_core_dev *dev, int vector, int *eqn,
 		    unsigned int *irqn);
 int mlx5_core_attach_mcg(struct mlx5_core_dev *dev, union ib_gid *mgid, u32 qpn);
