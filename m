Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49TtuNeal8+nh/znnTnXNsxA608J+9JCkUP/8//36dFdOaje70PSpFYjMO4ZsRxmmx8rLkm
ARC-Seal: i=1; a=rsa-sha256; t=1523399550; cv=none;
        d=google.com; s=arc-20160816;
        b=ZWxTizCxkeakdEwskEq6TdfBAnr9ztV4DIZYEZSxb/Lx6xqm2U4bms0ewpeEhgA8ta
         vXb9FcCSnXnGry6o8/WW6Jhr6nl9ezIUbC/uCwD0A9JdIgnOzWDa25NLhwKiFAJqALQB
         FDyTqHEwMwWZjfECd/aMW33aSzKn+2wOFaWLRhNm5XHyxWofnhuEc/HNA6mRxFc/c/Iq
         5IMJtVzibY4Vkm7NpEbWXxMfi2jJ5yJ3Xjwu3msf4/5n7XBR5MdWkZjiVMRVug5GSJ1C
         subjZCWAD4rDtd8Q8AB9M5Dd5f6nl1Jb6aDu1BEmz2OaCB8P5Xa+Y0Mj9Nv5zF0stcyZ
         nxDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=+Mdf/SxS/1t7DXAVkuuNVS87YeaGCNqfDkBFnWT+isE=;
        b=p4de8Dhk8upqJUhU8hVzqPfCDLtXgm8ChT+MStt4FhR4Ta2+ytZHYpLg4CiZJ3cAQU
         6w4CoOk04yZZUGteeyS0GOWooydUyvlKQOMJrXo0bKYwdKBP+BykCtXravetu4SMT6HD
         BVivaOleZwdGnWQhApNr7bCosA2/sWY6Gm2LSlSnPOumWgRNMwd7iJP5TEHxICzN7Ekz
         zZVN2Jk66VpkVHEGNEootXxPrYbeN18GJOhVOuriXoilXsoZMfRRHJwEpr5veaeetLXs
         2VKVU1/0DjX0Rp4jhCQXh6+/kyD7LpzsWF+RK4KED7dP6mRW6/kbEgO/WKdBwCfJyIF5
         aXGw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Tal Gilboa <talgi@mellanox.com>,
	Saeed Mahameed <saeedm@mellanox.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.15 149/168] net/mlx5e: Set EQE based as default TX interrupt moderation mode
Date: Wed, 11 Apr 2018 00:24:51 +0200
Message-Id: <20180410212807.416276367@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597400207547328534?=
X-GMAIL-MSGID: =?utf-8?q?1597400207547328534?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tal Gilboa <talgi@mellanox.com>


[ Upstream commit 48bfc39791b8b4a25f165e711f18b9c1617cefbc ]

The default TX moderation mode was mistakenly set to CQE based. The
intention was to add a control ability in order to improve some specific
use-cases. In general, we prefer to use EQE based moderation as it gives
much better numbers for the common cases.

CQE based causes a degradation in the common case since it resets the
moderation timer on CQE generation. This causes an issue when TSO is
well utilized (large TSO sessions). The timer is set to 16us so traffic
of ~64KB TSO sessions per second would mean timer reset (CQE per TSO
session -> long time between CQEs). In this case we quickly reach the
tcp_limit_output_bytes (256KB by default) and cause a halt in TX traffic.

By setting EQE based moderation we make sure timer would expire after
16us regardless of the packet rate.
This fixes an up to 40% packet rate and up to 23% bandwidth degradtions.

Fixes: 0088cbbc4b66 ("net/mlx5e: Enable CQE based moderation on TX CQ")
Signed-off-by: Tal Gilboa <talgi@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -4075,7 +4075,7 @@ void mlx5e_build_nic_params(struct mlx5_
 			    struct mlx5e_params *params,
 			    u16 max_channels)
 {
-	u8 cq_period_mode = 0;
+	u8 rx_cq_period_mode;
 	u32 link_speed = 0;
 	u32 pci_bw = 0;
 
@@ -4111,12 +4111,12 @@ void mlx5e_build_nic_params(struct mlx5_
 	params->lro_timeout = mlx5e_choose_lro_timeout(mdev, MLX5E_DEFAULT_LRO_TIMEOUT);
 
 	/* CQ moderation params */
-	cq_period_mode = MLX5_CAP_GEN(mdev, cq_period_start_from_cqe) ?
+	rx_cq_period_mode = MLX5_CAP_GEN(mdev, cq_period_start_from_cqe) ?
 			MLX5_CQ_PERIOD_MODE_START_FROM_CQE :
 			MLX5_CQ_PERIOD_MODE_START_FROM_EQE;
 	params->rx_am_enabled = MLX5_CAP_GEN(mdev, cq_moderation);
-	mlx5e_set_rx_cq_mode_params(params, cq_period_mode);
-	mlx5e_set_tx_cq_mode_params(params, cq_period_mode);
+	mlx5e_set_rx_cq_mode_params(params, rx_cq_period_mode);
+	mlx5e_set_tx_cq_mode_params(params, MLX5_CQ_PERIOD_MODE_START_FROM_EQE);
 
 	/* TX inline */
 	params->tx_max_inline = mlx5e_get_max_inline_cap(mdev);
