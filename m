Return-Path: <SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqxN7qURc+mBPfz9gPf/Rve5PgpyuU7rugaT2VSYvyQ67z3xbYsghL5H3sQ/QaGQiJbM2ij
ARC-Seal: i=1; a=rsa-sha256; t=1526631560; cv=none;
        d=google.com; s=arc-20160816;
        b=zCEs4w5bYo9z8iERx2DxNMR0Vyk362zNLVJ0bzinaia1VzrsWO79njCYeedOXjiwyA
         iF3Ydd+GxEotUx5BxL2zO2HRWEtE+atUY2+WDPRmV4hRntfwlvPpLW4xPmPDRPX/bk18
         i+BJTS2N+gAsrKvHesoPP0IhOPrKsjirCq4QY56EgOAeNMYZgj2EbiUvE9gCnOsiidJR
         CBdSvZgoJUf9RwJQGIWbgPTbows+5Ki9ddGWO2pdVuK/f+if+siE1dq11k3IkTxwKUv3
         rkY4yyLvH1F2/b3efF0PqI/mHS7UyQJP7zi195vK2teW8lEQZbapKhflK2VgPw6sa1o1
         s9Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=ZzL6Vv2hA3/ZNYl9Z5r03U0SKdk2SLIgB+KlbteLsw0=;
        b=slIMH0PuwMgdyiSIzxURSwQVzw5GHRQ9UBzpVdjMrWlIzYggfFOWBtPcL0KOxroDb9
         FBvyegfbimceoAnW7ikkKccCw7oqDmXej9UxeAsn0fQWPxLxxll/pEXKTnLLb1koh3y1
         7reTkUdiFDJLrUwNSFcpmTwHPo6M78g7QeCTCueZpcr+cbdk4Aj+RscREy5aYS84XaVY
         dMymEbGGINlWOmF1wqfYNlRUZAOSQTNFT5YTcrq6/rd+YRkbDFP9Of7s6vdGc8VR2UDB
         q6xYnM/rzEhrFWFsj7PyN5SEGAurEglrfktq4WPOV8OPW7Z7zSQtJibZXgtASVT5Urfj
         s6PA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=UYByxyLC;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=UYByxyLC;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Moshe Shemesh <moshe@mellanox.com>,
	Tariq Toukan <tariqt@mellanox.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 10/45] net/mlx4_en: Verify coalescing parameters are in range
Date: Fri, 18 May 2018 10:15:27 +0200
Message-Id: <20180518081530.849720962@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518081530.331586165@linuxfoundation.org>
References: <20180518081530.331586165@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600789059023166362?=
X-GMAIL-MSGID: =?utf-8?q?1600789215272480723?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1013,6 +1013,22 @@ static int mlx4_en_set_coalesce(struct n
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
@@ -131,6 +131,9 @@
 #define MLX4_EN_TX_COAL_PKTS	16
 #define MLX4_EN_TX_COAL_TIME	0x10
 
+#define MLX4_EN_MAX_COAL_PKTS	U16_MAX
+#define MLX4_EN_MAX_COAL_TIME	U16_MAX
+
 #define MLX4_EN_RX_RATE_LOW		400000
 #define MLX4_EN_RX_COAL_TIME_LOW	0
 #define MLX4_EN_RX_RATE_HIGH		450000
@@ -547,8 +550,8 @@ struct mlx4_en_priv {
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
