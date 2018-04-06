Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/rMsL3CTOphWyx/1EmvbLZyMclwWvMSYLz4OQjBIyI4rQcfIihvhivCe0XJ23h5yUseJNN
ARC-Seal: i=1; a=rsa-sha256; t=1523022214; cv=none;
        d=google.com; s=arc-20160816;
        b=yqwEwBBfSMJ6gWxJDDH3Uhg/gW4vUWmNHgXUjK1JxyCh4S752y1dYo91EULFW/q+O4
         QJjWeROKtqLQhn07DicNpUwTWdNho5bRSBaadMQJ9OJLdO5U1KcHgVcJg3IO885r5eEb
         JbxDQH5Y8KKNtCVeaYSFbb/S523PdkuVxt9r9dd3/7t4W505v1NBU2dxrtKjUG/6pr8U
         bcqDmI+ebNLfagFrv7fbP4+GRgUhSDwedS4qxGy+8fnYLNzTZlUCBCizvo/mCOTtIkRl
         UdojpsqGtM7ulDn0Ha5olQohFO82FMcgJtn0ldpewWr6O88eGczkesx7agKDtqJ+EpIF
         uPSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=tjsXXLl+5LKRSBaw7V6b5f6OooVln746W2QRbOruJyQ=;
        b=GYJpKX9w4Dh9ynaWDSjHz83EOR4hiu+rCuKU5srHQgqsBToSIPgMGT40bPGvh70TRu
         4mNCFBrZdNEVQKI6TsTvPI5CQNLb2HcJnPizJ0dVtUSH0h7Ww12zK7FB2UVyD+kz5Zye
         qxsfIjl5MlbApt9juALgVsjn88/zH/HtRQoYWSrfivzPtS2M+jIMVBcRUGJV9sm0eL7S
         VCzW1zNCKcVyClyqJADVC1SNu6jXORI05nDwuklQDmelREkwh5bc+2N0+CQR0RZvIwfS
         EnjKxg5YPtrCotPman0JBI9HUbCc5xsbrURfzJiE5UZVSs5GTOobIk2e3rrCCCFDwceO
         crMQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Matthias Brugger <mbrugger@suse.com>,
	"David S. Miller" <davem@davemloft.net>,
	Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.15 67/72] net: hns: Fix ethtool private flags
Date: Fri,  6 Apr 2018 15:24:42 +0200
Message-Id: <20180406084353.884440565@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084349.367583460@linuxfoundation.org>
References: <20180406084349.367583460@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003799411742003?=
X-GMAIL-MSGID: =?utf-8?q?1597004542240487329?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthias Brugger <matthias.bgg@gmail.com>

commit d61d263c8d82db7c4404a29ebc29674b1c0c05c9 upstream.

The driver implementation returns support for private flags, while
no private flags are present. When asked for the number of private
flags it returns the number of statistic flag names.

Fix this by returning EOPNOTSUPP for not implemented ethtool flags.

Signed-off-by: Matthias Brugger <mbrugger@suse.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Cc: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c |    2 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.c  |    2 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c  |    2 +-
 drivers/net/ethernet/hisilicon/hns/hns_ethtool.c   |    4 +++-
 4 files changed, 6 insertions(+), 4 deletions(-)

--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c
@@ -666,7 +666,7 @@ static void hns_gmac_get_strings(u32 str
 
 static int hns_gmac_get_sset_count(int stringset)
 {
-	if (stringset == ETH_SS_STATS || stringset == ETH_SS_PRIV_FLAGS)
+	if (stringset == ETH_SS_STATS)
 		return ARRAY_SIZE(g_gmac_stats_string);
 
 	return 0;
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.c
@@ -422,7 +422,7 @@ void hns_ppe_update_stats(struct hns_ppe
 
 int hns_ppe_get_sset_count(int stringset)
 {
-	if (stringset == ETH_SS_STATS || stringset == ETH_SS_PRIV_FLAGS)
+	if (stringset == ETH_SS_STATS)
 		return ETH_PPE_STATIC_NUM;
 	return 0;
 }
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c
@@ -876,7 +876,7 @@ void hns_rcb_get_stats(struct hnae_queue
  */
 int hns_rcb_get_ring_sset_count(int stringset)
 {
-	if (stringset == ETH_SS_STATS || stringset == ETH_SS_PRIV_FLAGS)
+	if (stringset == ETH_SS_STATS)
 		return HNS_RING_STATIC_REG_NUM;
 
 	return 0;
--- a/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c
@@ -993,8 +993,10 @@ int hns_get_sset_count(struct net_device
 			cnt--;
 
 		return cnt;
-	} else {
+	} else if (stringset == ETH_SS_STATS) {
 		return (HNS_NET_STATS_CNT + ops->get_sset_count(h, stringset));
+	} else {
+		return -EOPNOTSUPP;
 	}
 }
 
