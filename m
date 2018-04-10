Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49K9zvft5li9F/irs2S+ZLUg7q19IpzpNCibLGDq25skpjqGdeBJwoSE4XVpTGTztRq7Yma
ARC-Seal: i=1; a=rsa-sha256; t=1523399806; cv=none;
        d=google.com; s=arc-20160816;
        b=Z6SQT7vsB7zP76CDeFNbWQO/HRoUI0uDtHt2IAYU3eSMVfqajSavlHCoPtZN+AXVeA
         hiQSTQhbFAijRQ0ejnLpyMnAtABVcZ2L0vPRsiqoUXN4FyhcB/ZXT10Ts0XPTO7nIvfu
         X+OnD1VLc8Rwo6RXE/FrBCZFxBB6kU4voM+ac4s/HYlgbFEJosOdyjCaV+45b7rDQvwI
         h2W3e+wWgzc5TeeI4agyGdW5kh00eVTSbXz+suujUEubC0/su8ehOwZxBOBrUpCgHgt0
         d2tTMXb26dnTGCnSGE2kYbHlFCEsiu+LvbYxR9eG+i7qfpj4y8y5utr9779acfESWfTO
         fVvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=boe27rqBEzu3WxklJ+68FjwyhcM8zB2CoowH/idjOpU=;
        b=M030EetFXRWspdStCNkw/AiFg7zfxWWTLIPRPO3Zr3yK/8x1epErRRQS/E4HB0iKtP
         TL2ALc2VjvtpJDLVtDVqjFG4SqNGk/fMG31r8CE1bCT9zH9X2uM4yxh4Mi3TSIXkoAFJ
         54Vzlw2RD1g8NNP3sy0GigWSERN2VPZQrW1cEsB4xt5eWCLNVJVPiNuc1Y6ube6aaYTZ
         zpw1SIxAiqZfjuPnBoOzP7NXJ9BSjvpXEMFGHArHqHSd3Of6qeFoIWBRYh4T9etzwXjN
         c5nm4qbUeibzNZGlRJ5Q1umzBn4zLl/1BUuxLZnOTzZM9cjrWfHTTe/RHn0wkhz0EtvH
         UOjA==
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
Subject: [PATCH 4.14 052/138] net/mlx5: Fix race for multiple RoCE enable
Date: Wed, 11 Apr 2018 00:24:02 +0200
Message-Id: <20180410212908.138081833@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212902.121524696@linuxfoundation.org>
References: <20180410212902.121524696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399972510226774?=
X-GMAIL-MSGID: =?utf-8?q?1597400476053447976?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -794,7 +794,7 @@ struct mlx5_core_dev {
 	struct mlx5e_resources  mlx5e_res;
 	struct {
 		struct mlx5_rsvd_gids	reserved_gids;
-		atomic_t                roce_en;
+		u32			roce_en;
 	} roce;
 #ifdef CONFIG_MLX5_FPGA
 	struct mlx5_fpga_device *fpga;
