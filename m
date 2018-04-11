Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+b7FxBQ2np6FQJ66hUJ/dYFh+zQjLl83OieLmdCfmDedEj31LErOIDJZd+MYEKpDo/M6MP
ARC-Seal: i=1; a=rsa-sha256; t=1523473288; cv=none;
        d=google.com; s=arc-20160816;
        b=KRJQQr/wLBFeeNkBlyDBh5TNIo1EFaPBE4SU9K90G9YSiqNRfXNmymIyOClZx7KskO
         /7Iz6u0sSbd8KEK5bmPFanDJE6UipKbdUV2J7pyrA7YwcgA6ABKgXBNtMlEGVaw3RD8B
         ApjIBzXY16qmj3OjVi80DhOf19PxiAflZH6mWa33UBsQ0ZbrCXrFhUEudAFtYHzgq1x8
         r8GnbLPch8BXQNr9y++pajsDTiY0EsyyzXvuLyvA3+7Xxjp60bBB6wDGCHfxSqB+IusQ
         7bPjJAApTTqt7Pg767Iw3nypHWYx7GdYrKvnOhGXKBtkkdkokEOGDF8Mszld7zhshBgH
         zPdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ynyvFaE51Q3Pt/mHaHBttv15qeOOoZ6LLa04Dd+EpK0=;
        b=WkOl5BmFRavA7ZcAj8EzcUgEK/ud9jGdLDdZI5le9xkN55WMHwiaWT4/9sDOmUpQP+
         ejZ/WDqbcQZE2+CUB/ZF8+GVOCfAxViFARO14yFfDKfLX9er3gpqgLA30BTvjG6YMsNT
         fU9g2oRnkiT0egO0SoXY302TtDHW3wFo4gmosZHrUfkAgK9aAisRnnHiiS+sEMraKIZw
         7pjE1B0ODi2wK1uRw4tQ0e8kEx3zQcUrY0LOo0904c2k4HEUnS78fAvoOpGmz9bl2TFD
         E96rjLQlQ3Hd2nbzaqGszKBJO245lR27ivlwgxJfVPJAnTj8/Zr7HsuWTwWyEbwsoEpa
         FKPw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Or Gerlitz <gerlitz.or@gmail.com>,
	Talat Batheesh <talatb@mellanox.com>,
	Tariq Toukan <tariqt@mellanox.com>,
	Or Gerlitz <ogerlitz@mellanox.com>,
	Leon Romanovsky <leonro@mellanox.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 193/310] net/mlx4: Fix the check in attaching steering rules
Date: Wed, 11 Apr 2018 20:35:32 +0200
Message-Id: <20180411183630.904534661@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476228730535775?=
X-GMAIL-MSGID: =?utf-8?q?1597477527690547428?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Talat Batheesh <talatb@mellanox.com>


[ Upstream commit 6dc06c08bef1c746ff8da33dab677cfbacdcad32 ]

Our previous patch (cited below) introduced a regression
for RAW Eth QPs.

Fix it by checking if the QP number provided by user-space
exists, hence allowing steering rules to be added for valid
QPs only.

Fixes: 89c557687a32 ("net/mlx4_en: Avoid adding steering rules with invalid ring")
Reported-by: Or Gerlitz <gerlitz.or@gmail.com>
Signed-off-by: Talat Batheesh <talatb@mellanox.com>
Signed-off-by: Tariq Toukan <tariqt@mellanox.com>
Acked-by: Or Gerlitz <ogerlitz@mellanox.com>
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx4/en_ethtool.c |    5 -----
 drivers/net/ethernet/mellanox/mlx4/mcg.c        |   15 +++++++++++----
 drivers/net/ethernet/mellanox/mlx4/qp.c         |   13 +++++++++++++
 include/linux/mlx4/qp.h                         |    1 +
 4 files changed, 25 insertions(+), 9 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
@@ -1520,11 +1520,6 @@ static int mlx4_en_flow_replace(struct n
 		qpn = priv->drop_qp.qpn;
 	else if (cmd->fs.ring_cookie & EN_ETHTOOL_QP_ATTACH) {
 		qpn = cmd->fs.ring_cookie & (EN_ETHTOOL_QP_ATTACH - 1);
-		if (qpn < priv->rss_map.base_qpn ||
-		    qpn >= priv->rss_map.base_qpn + priv->rx_ring_num) {
-			en_warn(priv, "rxnfc: QP (0x%x) doesn't exist\n", qpn);
-			return -EINVAL;
-		}
 	} else {
 		if (cmd->fs.ring_cookie >= priv->rx_ring_num) {
 			en_warn(priv, "rxnfc: RX ring (%llu) doesn't exist\n",
--- a/drivers/net/ethernet/mellanox/mlx4/mcg.c
+++ b/drivers/net/ethernet/mellanox/mlx4/mcg.c
@@ -35,6 +35,7 @@
 #include <linux/etherdevice.h>
 
 #include <linux/mlx4/cmd.h>
+#include <linux/mlx4/qp.h>
 #include <linux/export.h>
 
 #include "mlx4.h"
@@ -985,16 +986,21 @@ int mlx4_flow_attach(struct mlx4_dev *de
 	if (IS_ERR(mailbox))
 		return PTR_ERR(mailbox);
 
+	if (!mlx4_qp_lookup(dev, rule->qpn)) {
+		mlx4_err_rule(dev, "QP doesn't exist\n", rule);
+		ret = -EINVAL;
+		goto out;
+	}
+
 	trans_rule_ctrl_to_hw(rule, mailbox->buf);
 
 	size += sizeof(struct mlx4_net_trans_rule_hw_ctrl);
 
 	list_for_each_entry(cur, &rule->list, list) {
 		ret = parse_trans_rule(dev, cur, mailbox->buf + size);
-		if (ret < 0) {
-			mlx4_free_cmd_mailbox(dev, mailbox);
-			return ret;
-		}
+		if (ret < 0)
+			goto out;
+
 		size += ret;
 	}
 
@@ -1021,6 +1027,7 @@ int mlx4_flow_attach(struct mlx4_dev *de
 		}
 	}
 
+out:
 	mlx4_free_cmd_mailbox(dev, mailbox);
 
 	return ret;
--- a/drivers/net/ethernet/mellanox/mlx4/qp.c
+++ b/drivers/net/ethernet/mellanox/mlx4/qp.c
@@ -387,6 +387,19 @@ static void mlx4_qp_free_icm(struct mlx4
 		__mlx4_qp_free_icm(dev, qpn);
 }
 
+struct mlx4_qp *mlx4_qp_lookup(struct mlx4_dev *dev, u32 qpn)
+{
+	struct mlx4_qp_table *qp_table = &mlx4_priv(dev)->qp_table;
+	struct mlx4_qp *qp;
+
+	spin_lock(&qp_table->lock);
+
+	qp = __mlx4_qp_lookup(dev, qpn);
+
+	spin_unlock(&qp_table->lock);
+	return qp;
+}
+
 int mlx4_qp_alloc(struct mlx4_dev *dev, int qpn, struct mlx4_qp *qp, gfp_t gfp)
 {
 	struct mlx4_priv *priv = mlx4_priv(dev);
--- a/include/linux/mlx4/qp.h
+++ b/include/linux/mlx4/qp.h
@@ -470,6 +470,7 @@ struct mlx4_update_qp_params {
 	u16	rate_val;
 };
 
+struct mlx4_qp *mlx4_qp_lookup(struct mlx4_dev *dev, u32 qpn);
 int mlx4_update_qp(struct mlx4_dev *dev, u32 qpn,
 		   enum mlx4_update_qp_attr attr,
 		   struct mlx4_update_qp_params *params);
