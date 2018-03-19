Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsT5VAMZVrKdSOCaJrky50mfS5MdivzKywvFHoO9TtNCyuom7/9LDOLWPsrNGvGNRzfOzWn
ARC-Seal: i=1; a=rsa-sha256; t=1521483739; cv=none;
        d=google.com; s=arc-20160816;
        b=OzuoO+Hnli340zPC10C0hndTGAJoHA7/vlDYKBxHSXm70L46ZSbeG+to3Pbt3OtSnm
         AdqsdPLs0T4peHeNP4GqKGisMMcv3dnxoVISraXioHtEz3U5X+XYD0SWLsyumWpFjXtq
         2tmKF0Bk6kXb1HR6ctSTIJnjfINDwREx28tl/ujLaxYFH9QoMJKmcHvki6H8Z1zTfOHf
         q4Azoffm5fzxxYsmPELl7hEaCB0qnadruh3bMaczrWLZtnzfbYJWFU82Eqz9SF66XpEc
         ERp3s6VoBu4285Az+HfJ+44gLpNajLE7OgBN6upgOz4oNV8SR10nbSv5vJls0qTkW2A2
         uu4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Jas5Sog+5XkCobqAjXr6AC9T5w+t/+KLQ72ae0WNzms=;
        b=BmURA7ubiDIdN7UBIWqs7MFEP7VXioL5Vt5NuqPJzlY8z3tWZm7b1TIad7qqYOfh9e
         MBjvkQLVwT/LwGhsIvoGa24ZN+VZBFADGdOCnUpoBgR/qxbwQHkQ7pt2uRJBigwmd4Gu
         4vKuSzw+Z0gl0U6JwhIDHKWIKhjHQy11rCIK43ROuKJYt+r8tfHKatQJP3YkOnSuPIz0
         2Knm3E7NV6sAijnUUPy8hWUaIAbarsHDap4YH6f0RO3y3uXinAzdcWikIDc8H/QLqZ6n
         965H803pSjZrtx30Xv7htk5oOS1sEd8aGKad4b+71FhSnzSQ2WPq7av3m14gKbcbWWb+
         R6zg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	lipeng <lipeng321@huawei.com>,
	Yisen Zhuang <yisen.zhuang@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 098/241] net: hns: Correct HNS RSS key set function
Date: Mon, 19 Mar 2018 19:06:03 +0100
Message-Id: <20180319180755.252239348@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391333579099540?=
X-GMAIL-MSGID: =?utf-8?q?1595391333579099540?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: lipeng <lipeng321@huawei.com>


[ Upstream commit 64ec10dc2ab8ef5bc6e76b1d4bc8203c08a6da1e ]

This patch fixes below ethtool configuration error:

localhost:~ # ethtool -X eth0 hkey XX:XX:XX...
Cannot set Rx flow hash configuration: Operation not supported

Signed-off-by: lipeng <lipeng321@huawei.com>
Reviewed-by: Yisen Zhuang <yisen.zhuang@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c |   27 +++++++++++++---------
 drivers/net/ethernet/hisilicon/hns/hns_ethtool.c  |    9 +++----
 2 files changed, 20 insertions(+), 16 deletions(-)

--- a/drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c
@@ -773,8 +773,9 @@ static int hns_ae_get_rss(struct hnae_ha
 		memcpy(key, ppe_cb->rss_key, HNS_PPEV2_RSS_KEY_SIZE);
 
 	/* update the current hash->queue mappings from the shadow RSS table */
-	memcpy(indir, ppe_cb->rss_indir_table,
-	       HNS_PPEV2_RSS_IND_TBL_SIZE * sizeof(*indir));
+	if (indir)
+		memcpy(indir, ppe_cb->rss_indir_table,
+		       HNS_PPEV2_RSS_IND_TBL_SIZE  * sizeof(*indir));
 
 	return 0;
 }
@@ -785,15 +786,19 @@ static int hns_ae_set_rss(struct hnae_ha
 	struct hns_ppe_cb *ppe_cb = hns_get_ppe_cb(handle);
 
 	/* set the RSS Hash Key if specififed by the user */
-	if (key)
-		hns_ppe_set_rss_key(ppe_cb, (u32 *)key);
-
-	/* update the shadow RSS table with user specified qids */
-	memcpy(ppe_cb->rss_indir_table, indir,
-	       HNS_PPEV2_RSS_IND_TBL_SIZE * sizeof(*indir));
-
-	/* now update the hardware */
-	hns_ppe_set_indir_table(ppe_cb, ppe_cb->rss_indir_table);
+	if (key) {
+		memcpy(ppe_cb->rss_key, key, HNS_PPEV2_RSS_KEY_SIZE);
+		hns_ppe_set_rss_key(ppe_cb, ppe_cb->rss_key);
+	}
+
+	if (indir) {
+		/* update the shadow RSS table with user specified qids */
+		memcpy(ppe_cb->rss_indir_table, indir,
+		       HNS_PPEV2_RSS_IND_TBL_SIZE  * sizeof(*indir));
+
+		/* now update the hardware */
+		hns_ppe_set_indir_table(ppe_cb, ppe_cb->rss_indir_table);
+	}
 
 	return 0;
 }
--- a/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c
@@ -1243,6 +1243,7 @@ hns_set_rss(struct net_device *netdev, c
 {
 	struct hns_nic_priv *priv = netdev_priv(netdev);
 	struct hnae_ae_ops *ops;
+	int ret;
 
 	if (AE_IS_VER1(priv->enet_ver)) {
 		netdev_err(netdev,
@@ -1252,12 +1253,10 @@ hns_set_rss(struct net_device *netdev, c
 
 	ops = priv->ae_handle->dev->ops;
 
-	/* currently hfunc can only be Toeplitz hash */
-	if (key ||
-	    (hfunc != ETH_RSS_HASH_NO_CHANGE && hfunc != ETH_RSS_HASH_TOP))
+	if (hfunc != ETH_RSS_HASH_NO_CHANGE && hfunc != ETH_RSS_HASH_TOP) {
+		netdev_err(netdev, "Invalid hfunc!\n");
 		return -EOPNOTSUPP;
-	if (!indir)
-		return 0;
+	}
 
 	return ops->set_rss(priv->ae_handle, indir, key, hfunc);
 }
