Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+AJMbOcrJZfXYiSCAtyAXB28c/OrHR9ac5NL9lIE4ukfmn7PkKwTSuAyQFfDX2XFlp7WAY
ARC-Seal: i=1; a=rsa-sha256; t=1523399326; cv=none;
        d=google.com; s=arc-20160816;
        b=dF3QMx6et76CJ0GxhfLUMFLeS3hfoYQZzOJbjUq9DZtcsrtuJENKvK/qNc31OUp/IY
         ABMub7A0eanpvTDzX2+i5XVJuo1rzMqY7BLFLmkxVH7+9vIfRLKXMMbg1BzbbApyy87n
         /Rmfc17AUsZArdLiZxcLzny/TDpgut+oAJD1LEWfe2cmlqBPiRdIZRw1wa2xq4+uPOjZ
         srGsT8mWq5ep4kTFJgAeHU7bP3KjT/qvooGo8eGMM9wAIjPCRdRugJsnaZKVI/H+Z5Vd
         oZfyfSjg+50EVD5y3+qAHX+9Z0lHqfLZJnV4n/iSgFbXknQW2I0xuBcZZ3VLw0DEr0WY
         rMSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ZI1X5S+2K2qKmMab1LqzB7V5LFTRQd1Gp3+3JZUzlJ8=;
        b=dTjfKQjY7n/jCiwLvyP4pZ7kOSMTbHqBl+8NQAOz+0xH7IwU0dqqh0NdTMPXvYvzE6
         i7ryQ5cBO1trSS0l291tlnFjIpnxRcCOIaNTiWsq2FYDHrEEfFHq1AzRZnynEXSFQRv/
         Vxw7WthNJOmlnRqO6OSKvTzth2buztO0n3WNxpImvKzYcIQCJrCYIbJBJJHj2SceG8DT
         fr5PkyibY47gb5SghRVzNdw1ia3bIMCTfvuufQOczuUuYl25YGjmgUaMpzba5Ref3rDm
         Zzk7pHobATAhxYxutois1BdSs0R3A9R/V0D0vcmnw8hWtOqvKvhyXykQCLMSzmpBNP0N
         W/lg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Daniel Jurgens <danielj@mellanox.com>,
	Parav Pandit <parav@mellanox.com>,
	Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@mellanox.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 067/168] net/mlx5: Fix race for multiple RoCE enable
Date: Wed, 11 Apr 2018 00:23:29 +0200
Message-Id: <20180410212803.048734444@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399972510226774?=
X-GMAIL-MSGID: =?utf-8?q?1597399972510226774?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Jurgens <danielj@mellanox.com>


[ Upstream commit 734dc065fc41f6143ff88225aa5d335cb1e0f6aa ]

There are two potential problems with the existing implementation.

1. Enable and disable can race after the atomic operations.
2. If a command fails the refcount is left in an inconsistent state.

Introduce a lock and perform error checking.

Fixes: a6f7d2aff623 ("net/mlx5: Add support for multiple RoCE enable")
Signed-off-by: Daniel Jurgens <danielj@mellanox.com>
Reviewed-by: Parav Pandit <parav@mellanox.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/vport.c |   33 +++++++++++++++++++-----
 include/linux/mlx5/driver.h                     |    2 -
 2 files changed, 28 insertions(+), 7 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/vport.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/vport.c
@@ -36,6 +36,9 @@
 #include <linux/mlx5/vport.h>
 #include "mlx5_core.h"
 
+/* Mutex to hold while enabling or disabling RoCE */
+static DEFINE_MUTEX(mlx5_roce_en_lock);
+
 static int _mlx5_query_vport_state(struct mlx5_core_dev *mdev, u8 opmod,
 				   u16 vport, u32 *out, int outlen)
 {
@@ -998,17 +1001,35 @@ static int mlx5_nic_vport_update_roce_st
 
 int mlx5_nic_vport_enable_roce(struct mlx5_core_dev *mdev)
 {
-	if (atomic_inc_return(&mdev->roce.roce_en) != 1)
-		return 0;
-	return mlx5_nic_vport_update_roce_state(mdev, MLX5_VPORT_ROCE_ENABLED);
+	int err = 0;
+
+	mutex_lock(&mlx5_roce_en_lock);
+	if (!mdev->roce.roce_en)
+		err = mlx5_nic_vport_update_roce_state(mdev, MLX5_VPORT_ROCE_ENABLED);
+
+	if (!err)
+		mdev->roce.roce_en++;
+	mutex_unlock(&mlx5_roce_en_lock);
+
+	return err;
 }
 EXPORT_SYMBOL_GPL(mlx5_nic_vport_enable_roce);
 
 int mlx5_nic_vport_disable_roce(struct mlx5_core_dev *mdev)
 {
-	if (atomic_dec_return(&mdev->roce.roce_en) != 0)
-		return 0;
-	return mlx5_nic_vport_update_roce_state(mdev, MLX5_VPORT_ROCE_DISABLED);
+	int err = 0;
+
+	mutex_lock(&mlx5_roce_en_lock);
+	if (mdev->roce.roce_en) {
+		mdev->roce.roce_en--;
+		if (mdev->roce.roce_en == 0)
+			err = mlx5_nic_vport_update_roce_state(mdev, MLX5_VPORT_ROCE_DISABLED);
+
+		if (err)
+			mdev->roce.roce_en++;
+	}
+	mutex_unlock(&mlx5_roce_en_lock);
+	return err;
 }
 EXPORT_SYMBOL_GPL(mlx5_nic_vport_disable_roce);
 
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -826,7 +826,7 @@ struct mlx5_core_dev {
 	struct mlx5e_resources  mlx5e_res;
 	struct {
 		struct mlx5_rsvd_gids	reserved_gids;
-		atomic_t                roce_en;
+		u32			roce_en;
 	} roce;
 #ifdef CONFIG_MLX5_FPGA
 	struct mlx5_fpga_device *fpga;
