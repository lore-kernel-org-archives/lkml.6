Return-Path: <SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrbWXiWJf6ReF854PxAskuL8NP8exZZCGWotjRVOIQ8xSvYCHG7WMZucvxjEqU+6awEbAXL
ARC-Seal: i=1; a=rsa-sha256; t=1526631730; cv=none;
        d=google.com; s=arc-20160816;
        b=Fh7EzXFz+NMZHCuPGzrfukmeBBEzQK7+8OZ14yoGppXGkddQ8ulguNx5uHNFmzT1Vn
         hF5VObU264vNQXclK/Qg5i96jQbUZrPCzEaOqLRhVyyy39EQ6Di2n+dbCsNAbhGz5+sl
         pzQXdM3cjtK6jeCKAeGrt/hiHcNTNy+sMTAPbExP2xwBBygVYaA5cybSo4CPVsoXTixv
         szbHL2EBpx9fbYlOBGCBUcXAyT04aPbd+QZpjo3NI5j48jtyaEDP3aTVLNzSd+xpaxZp
         716ktg2YDFdlHcysj0wS7LKxCrKXn3uqOnzhPl1CI05l4hQ9WBMzpM3OpOBK/pQT9/Xq
         OemQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=/B+GpvFTmOpG0wMYk4fLljlk2xzANvIvtftQuU2AcrE=;
        b=mhyqR9ZNoUV7nqZOLuy2zgltKu63PT+3EmqLxXGnv4bzISh+e1BOmUmfx5Df6xDKKB
         2nCdEYXiRwQwclqszuPQwI2mebzbO0ecQIzUInmSz5RjSvOCfb++fxt4yooX5Y5TTg+M
         94XjAnoMHbpaEJW6vNKVg41QoHmQ/ndWjXnMSDgBQn8QSUyIgcE9QxlfaJaBwjbuQoG0
         i/kjV5f6+wN3U8aIzg5Gy+BmXsph/mJ5NBn4V5T4DqUp9/hCMyPLVee7uvX5xez+WR4H
         rAkpAr+Z5Flrrb/O/9Fi7sHNiJW5Di9ph4bB6MTNqa8E8HlUWXk0CQ5rs9koMsMlgjQY
         fZDQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=nxiO0xM7;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=nxiO0xM7;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Moshe Shemesh <moshe@mellanox.com>,
	Tariq Toukan <tariqt@mellanox.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 08/33] net/mlx4_en: Verify coalescing parameters are in range
Date: Fri, 18 May 2018 10:15:47 +0200
Message-Id: <20180518081535.422987125@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518081535.096308218@linuxfoundation.org>
References: <20180518081535.096308218@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600789059023166362?=
X-GMAIL-MSGID: =?utf-8?q?1600789393126151128?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Moshe Shemesh <moshe@mellanox.com>

[ Upstream commit 6ad4e91c6d796b38a7f0e724db1de28eeb122bad ]

Add check of coalescing parameters received through ethtool are within
range of values supported by the HW.
Driver gets the coalescing rx/tx-usecs and rx/tx-frames as set by the
users through ethtool. The ethtool support up to 32 bit value for each.
However, mlx4 modify cq limits the coalescing time parameter and
coalescing frames parameters to 16 bits.
Return out of range error if user tries to set these parameters to
higher values.
Change type of sample-interval and adaptive_rx_coal parameters in mlx4
driver to u32 as the ethtool holds them as u32 and these parameters are
not limited due to mlx4 HW.

Fixes: c27a02cd94d6 ('mlx4_en: Add driver for Mellanox ConnectX 10GbE NIC')
Signed-off-by: Moshe Shemesh <moshe@mellanox.com>
Signed-off-by: Tariq Toukan <tariqt@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx4/en_ethtool.c |   16 ++++++++++++++++
 drivers/net/ethernet/mellanox/mlx4/mlx4_en.h    |    7 +++++--
 2 files changed, 21 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
@@ -970,6 +970,22 @@ static int mlx4_en_set_coalesce(struct n
 	if (!coal->tx_max_coalesced_frames_irq)
 		return -EINVAL;
 
+	if (coal->tx_coalesce_usecs > MLX4_EN_MAX_COAL_TIME ||
+	    coal->rx_coalesce_usecs > MLX4_EN_MAX_COAL_TIME ||
+	    coal->rx_coalesce_usecs_low > MLX4_EN_MAX_COAL_TIME ||
+	    coal->rx_coalesce_usecs_high > MLX4_EN_MAX_COAL_TIME) {
+		netdev_info(dev, "%s: maximum coalesce time supported is %d usecs\n",
+			    __func__, MLX4_EN_MAX_COAL_TIME);
+		return -ERANGE;
+	}
+
+	if (coal->tx_max_coalesced_frames > MLX4_EN_MAX_COAL_PKTS ||
+	    coal->rx_max_coalesced_frames > MLX4_EN_MAX_COAL_PKTS) {
+		netdev_info(dev, "%s: maximum coalesced frames supported is %d\n",
+			    __func__, MLX4_EN_MAX_COAL_PKTS);
+		return -ERANGE;
+	}
+
 	priv->rx_frames = (coal->rx_max_coalesced_frames ==
 			   MLX4_EN_AUTO_CONF) ?
 				MLX4_EN_RX_COAL_TARGET :
--- a/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
+++ b/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
@@ -141,6 +141,9 @@ enum {
 #define MLX4_EN_TX_COAL_PKTS	16
 #define MLX4_EN_TX_COAL_TIME	0x10
 
+#define MLX4_EN_MAX_COAL_PKTS	U16_MAX
+#define MLX4_EN_MAX_COAL_TIME	U16_MAX
+
 #define MLX4_EN_RX_RATE_LOW		400000
 #define MLX4_EN_RX_COAL_TIME_LOW	0
 #define MLX4_EN_RX_RATE_HIGH		450000
@@ -543,8 +546,8 @@ struct mlx4_en_priv {
 	u16 rx_usecs_low;
 	u32 pkt_rate_high;
 	u16 rx_usecs_high;
-	u16 sample_interval;
-	u16 adaptive_rx_coal;
+	u32 sample_interval;
+	u32 adaptive_rx_coal;
 	u32 msg_enable;
 	u32 loopback_ok;
 	u32 validate_loopback;
