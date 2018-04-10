Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/xqAuBzTMsvC2d526sLC4DsTlJoCI50cJPB3V6bi0hPwDvc1I7RUoLD4eBr6sheTPkyWdC
ARC-Seal: i=1; a=rsa-sha256; t=1523399626; cv=none;
        d=google.com; s=arc-20160816;
        b=XsKrpiCymrWiGRL3BLAdpHGokoxeyxKVKfC4HTyRnhIj9H/WRvdQ+4r4HyyCLFdhw2
         6ogyNK1/wGHI0AGHu+NEGTAwYeO3QaY5zmGrOMs2a3WkHScj4D/6+nnsyjWd88u+pnBZ
         AfIvs+jjepqMMGTSwU6rD4/h4lKis4IYq6UQJnT6xgAGtssm0l3M6NcSwmxABRlt4DlQ
         OmTuNXqLspR7cJsZ6edOrBhyL2mdNkTYCxNe0OoZJY5NV5/TiZO6yVh836LOJXjgZ9+p
         Ab7T/RdceC0brTQe2wqZtQ48Ojsq9zQ6jUFgr7dLCf4uT4rvbwD5aL2CDRwJH3JnHYIN
         sizA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=kQn74l3oIAB1zf2rDsYEOGZbIHUpB/jK8fOvS3qmhiw=;
        b=KV8ZBYeG7XKOmtU7+WKGxWDehsES1vv9Y2YFbCNdfr7PSThNAkPJF0CicUjwdlJTz2
         P6MiixVDQrCR3PM5dI5hWsiM1Am0x75LJi9qgqMqt4sj9HFM4rWX5xDIz9Shb0c/yRv8
         3Y+HLHG4uAQHbUAQ5iJMFBt2iFL62E2TxZ9I0ildefNw6F2eX9j4igenVjPR+qg6d/c7
         lRYDJPMA+GD2L9gNTc4JAz2InlKBTFkA709LENUpoIszNqrRFo1bvGEuI9ifvVcF8jjp
         FyLQuhYCsm9QcR9Xq+kar3OHI0G84xQbX4jdjhqyUi3bN8HSEmEf1CJ9sqR1A9yATOO8
         lXLA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Roi Dayan <roid@mellanox.com>,
	Paul Blakey <paulb@mellanox.com>,
	Or Gerlitz <ogerlitz@mellanox.com>,
	Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 4.15 163/168] net/mlx5e: Fix traffic being dropped on VF representor
Date: Wed, 11 Apr 2018 00:25:05 +0200
Message-Id: <20180410212808.165760465@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597400286836712603?=
X-GMAIL-MSGID: =?utf-8?q?1597400286836712603?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Roi Dayan <roid@mellanox.com>


[ Upstream commit 4246f698dd58e3c6246fa919ef0b0a1d29a57e4a ]

Increase representor netdev RQ size to avoid dropped packets.
The current size (two) is just too small to keep up with
conventional slow path traffic patterns.
Also match the SQ size to the RQ size.

Fixes: cb67b832921c ("net/mlx5e: Introduce SRIOV VF representors")
Signed-off-by: Roi Dayan <roid@mellanox.com>
Reviewed-by: Paul Blakey <paulb@mellanox.com>
Reviewed-by: Or Gerlitz <ogerlitz@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
@@ -44,6 +44,11 @@
 #include "en_tc.h"
 #include "fs_core.h"
 
+#define MLX5E_REP_PARAMS_LOG_SQ_SIZE \
+	max(0x6, MLX5E_PARAMS_MINIMUM_LOG_SQ_SIZE)
+#define MLX5E_REP_PARAMS_LOG_RQ_SIZE \
+	max(0x6, MLX5E_PARAMS_MINIMUM_LOG_RQ_SIZE)
+
 static const char mlx5e_rep_driver_name[] = "mlx5e_rep";
 
 static void mlx5e_rep_get_drvinfo(struct net_device *dev,
@@ -824,9 +829,9 @@ static void mlx5e_build_rep_params(struc
 					 MLX5_CQ_PERIOD_MODE_START_FROM_CQE :
 					 MLX5_CQ_PERIOD_MODE_START_FROM_EQE;
 
-	params->log_sq_size = MLX5E_PARAMS_MINIMUM_LOG_SQ_SIZE;
+	params->log_sq_size = MLX5E_REP_PARAMS_LOG_SQ_SIZE;
 	params->rq_wq_type  = MLX5_WQ_TYPE_LINKED_LIST;
-	params->log_rq_size = MLX5E_PARAMS_MINIMUM_LOG_RQ_SIZE;
+	params->log_rq_size = MLX5E_REP_PARAMS_LOG_RQ_SIZE;
 
 	params->rx_am_enabled = MLX5_CAP_GEN(mdev, cq_moderation);
 	mlx5e_set_rx_cq_mode_params(params, cq_period_mode);
