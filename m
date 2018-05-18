Return-Path: <SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZosm2kQeqike9Q6nK4ANy2tkU0EMz4Ea+oitVKJd+ZR3S8kBBpyZvrhySSf1q+3ccecb1XH
ARC-Seal: i=1; a=rsa-sha256; t=1526631498; cv=none;
        d=google.com; s=arc-20160816;
        b=mnqNhBU1mC2JboIKbE4YTWxPOQigLEjMdDAon6Tt57Q+WiEXTZqng/aiKwmmbwIMVH
         LpWWnImbVorKtbK9NR3ey3bB8UP3L5JYd774xMpMRvkCto9I2KeNEhAChMG9dA50GsGW
         DPvV4svHIBFxSQgsMor82Dt+ny8zN05R/Ye2kFD8WmpbRYyzhRClGT2FjCipBm8USH91
         fWE2JPDq9/pRnCHblK09H4lCAubSR3TZj55oz+2AWdQwl6LKGYp0P58yTWedjbl+TOIP
         qZYpERfv9R6g1NCs5WssRfxzxs+4CnOXyppMBgEqxoPU4d8OmJ5LW37QdebE5Ew30Y5q
         3cdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=RXDr5Kh+69ZTjb2vIq7OmHUwaXIR99ataHNAAMfN2fg=;
        b=prhZ3Szk5XufdMAt8GlOCa+uo+1EIOIgouiBDbH1E9UoHrlMBhndkHvnnDJfwC1A+P
         t6DpOHxifVh/t8NCKy9h7GT5zDwCBtzikhJI8E8ZHaSNPE1XWpTOoJBm9iHV067CA2Tg
         RjDKK+bysvtvtRJcok87BjIk/REwgYgaTovCvXpZS54isp0Sl3E4YLv1olHGXQsR2xet
         xjooVWzU8DFVtwd/jg3OXu7k8RgKRT7SAxdc94yvint1+92E9aT3F0UKX/WPHP495Z85
         pxc9N2G114j4RyE0p8/HNs7scXmTA0DQcdikDMR8/mQVyJicRDLuu0M4mgwYfmKW2gaQ
         JGWA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=CiHQpoxt;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=CiHQpoxt;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Huy Nguyen <huyn@mellanox.com>,
	Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 4.16 42/55] net/mlx5e: DCBNL fix min inline header size for dscp
Date: Fri, 18 May 2018 10:15:38 +0200
Message-Id: <20180518081459.426028506@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518081457.428920292@linuxfoundation.org>
References: <20180518081457.428920292@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600789150821632730?=
X-GMAIL-MSGID: =?utf-8?q?1600789150821632730?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Huy Nguyen <huyn@mellanox.com>

[ Upstream commit 35f80acb24cd53dabd65e0660e46afdf5c45991d ]

When the trust state is set to dscp and the netdev is down, the inline
header size is not updated. When netdev is up, the inline header size
stays at L2 instead of IP.

Fix this issue by updating the private parameter when the netdev is in
down so that when netdev is up, it picks up the right header size.

Fixes: fbcb127e89ba ("net/mlx5e: Support DSCP trust state ...")
Signed-off-by: Huy Nguyen <huyn@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c
@@ -1007,12 +1007,14 @@ static void mlx5e_trust_update_sq_inline
 
 	mutex_lock(&priv->state_lock);
 
-	if (!test_bit(MLX5E_STATE_OPENED, &priv->state))
-		goto out;
-
 	new_channels.params = priv->channels.params;
 	mlx5e_trust_update_tx_min_inline_mode(priv, &new_channels.params);
 
+	if (!test_bit(MLX5E_STATE_OPENED, &priv->state)) {
+		priv->channels.params = new_channels.params;
+		goto out;
+	}
+
 	/* Skip if tx_min_inline is the same */
 	if (new_channels.params.tx_min_inline_mode ==
 	    priv->channels.params.tx_min_inline_mode)
