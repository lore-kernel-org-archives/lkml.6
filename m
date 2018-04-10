Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+xYhiTENJk2CSE7qqI1yduMY41lu4qcQ9MM5tvY5CiB1mTZlU1GSDDvxjv+k7Hs2ftipx8
ARC-Seal: i=1; a=rsa-sha256; t=1523399496; cv=none;
        d=google.com; s=arc-20160816;
        b=Kiv7wGeRoUdvkqjSKdbjxr34cTSTi+CROYGOZTm5D8Li0T6wboTu1pHho9cGqPbfQ5
         wI3UpELe11pXyKVOiUjJlmChsR3F4ZuWOoYxb3bUtn4JMoUUHtFEjjfGYaee+hadFx3V
         ekZ9yzXR95et7HHuJTvLT4rG1xM50g8miRVvl+h2rgjiEdDB4x6P2C+mE72y5++Wz9Bj
         0t2s2GHJsPdcopVs9UGNRitVf7TE2xhrSV50KOwEE5BRKNawJ93c/h0BXN/QVV2kkWG3
         oqZeLU+WIytk5Oa7Ik8WB5KW23KJTp6QFOIllmS7ErrbSuYgZ/GeCrWFFOcGbMj5jDr2
         oJmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=pwq9imH/Xw/UtngZMSHAWxpWsAlzRytWo0IzHf56yXM=;
        b=MVuY63cM43duV8Tv2p7eZAN7/it/uXdsMRH0iUCHGlCmqDd1TjRmnP7MMjh3D1z6sZ
         1nmRcYlXCYrQEnCykUq5HtXALYmNGOpBMUWGhzbQ2OpgxMH8B4Zl6FQTDTKp39SLyDnW
         5qiFgfQNC2SYF4D1KY62lC/mbkNmw9j/MPOuq5OxzKKHv9vC5otaUoL3zimWImtK1vFT
         GZ1fhS1u9ucl6c+nyLSooLiSLKldstcKuRQGI+oMOHCod08Z1vW18rfPahc6t1oBMlPX
         t6wm4pONkqc5AgyDVyRflHABGcr/47OfLfrSYbZ5dlrRCBpEvbZQZXBEF3PPVtvYXX+H
         WAog==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Moshe Shemesh <moshe@mellanox.com>,
	Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 4.15 129/168] net/mlx5e: Verify coalescing parameters in range
Date: Wed, 11 Apr 2018 00:24:31 +0200
Message-Id: <20180410212806.253071486@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597400150975051928?=
X-GMAIL-MSGID: =?utf-8?q?1597400150975051928?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Moshe Shemesh <moshe@mellanox.com>


[ Upstream commit b392a2078b5e0094ff38aa0c9d2a31b3f607d4ef ]

Add check of coalescing parameters received through ethtool are within
range of values supported by the HW.
Driver gets the coalescing rx/tx-usecs and rx/tx-frames as set by the
users through ethtool. The ethtool support up to 32 bit value for each.
However, mlx5 modify cq limits the coalescing time parameter to 12 bit
and coalescing frames parameters to 16 bits.
Return out of range error if user tries to set these parameters to
higher values.

Fixes: f62b8bb8f2d3 ('net/mlx5: Extend mlx5_core to support ConnectX-4 Ethernet functionality')
Signed-off-by: Moshe Shemesh <moshe@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -492,6 +492,9 @@ static int mlx5e_get_coalesce(struct net
 	return mlx5e_ethtool_get_coalesce(priv, coal);
 }
 
+#define MLX5E_MAX_COAL_TIME		MLX5_MAX_CQ_PERIOD
+#define MLX5E_MAX_COAL_FRAMES		MLX5_MAX_CQ_COUNT
+
 static void
 mlx5e_set_priv_channels_coalesce(struct mlx5e_priv *priv, struct ethtool_coalesce *coal)
 {
@@ -526,6 +529,20 @@ int mlx5e_ethtool_set_coalesce(struct ml
 	if (!MLX5_CAP_GEN(mdev, cq_moderation))
 		return -EOPNOTSUPP;
 
+	if (coal->tx_coalesce_usecs > MLX5E_MAX_COAL_TIME ||
+	    coal->rx_coalesce_usecs > MLX5E_MAX_COAL_TIME) {
+		netdev_info(priv->netdev, "%s: maximum coalesce time supported is %lu usecs\n",
+			    __func__, MLX5E_MAX_COAL_TIME);
+		return -ERANGE;
+	}
+
+	if (coal->tx_max_coalesced_frames > MLX5E_MAX_COAL_FRAMES ||
+	    coal->rx_max_coalesced_frames > MLX5E_MAX_COAL_FRAMES) {
+		netdev_info(priv->netdev, "%s: maximum coalesced frames supported is %lu\n",
+			    __func__, MLX5E_MAX_COAL_FRAMES);
+		return -ERANGE;
+	}
+
 	mutex_lock(&priv->state_lock);
 	new_channels.params = priv->channels.params;
 
