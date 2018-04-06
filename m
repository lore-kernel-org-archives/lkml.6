Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+YWekVRIt8P8QyLTi+L8vCy7KFn6nqlTS4BhEab7re8kEDoIYu33cQyhHrRlhgv7bcKOys
ARC-Seal: i=1; a=rsa-sha256; t=1523021507; cv=none;
        d=google.com; s=arc-20160816;
        b=RP07pjAmn9JLy2yZ+QdOJHy48ylxE32T17jcmGtqWIicYhFqkquoonIHtlEPqjCpNC
         Ir0Q6jw3KPusy4x+eneU71/7CYogcsG60zWnaWAbpAeiaSXlFJfu3KkOfsy0M5DANtG7
         WIwSAUVrS5tpC0+2GOvQqU/E+yIqKDS44nubUU0WmbWrSrfTqGFtQaMhb2vwj8l8zvQ5
         nDn2orrl45+lw5YpST+i9JhnfF43k/vc80M/UcX10joCnJqa4BZ9DromptKL4xlQSivf
         eZBrliCKZyY11osIkQm2NmEOUC1u1IHuJB9zMtmZNz2tcJE1DU0ZFqST6z0XfM2a74d4
         P+ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=m6FYVrj+PWUqpbi5ciM5RIYLlbo03pE7qkk+9zYiCt8=;
        b=UcucoesDyngUB4aJ92PdKjwnSLSuFfcyUZbBhMOOIIOe18zW8tRMc8vuuO9v24Jpmh
         6vCnqMoE3NH6qn5pbh4bs66c/LjOKeIoM4+JFqCqz7CO6y/EmQY/w7F56cgk/oRWzdrY
         TQH2BjYdT/bT8zCY6EaLEv6jBprgx8jlqbI2S9W11wmj3ir9rLh3T7dZJBVyZBclVpn6
         upZ6mCUlObJi13fKd/dNRrIOcxfLP1FWEjIjGldeJPvq57q0CGMAMTRPzwqfCvZOtD0H
         vnxNlnLm4Qw6BgjnqC0QZ1eG/ysVkQdWGZ+SGifJbHsk9Vch+QkC0dhykG7k3TdhXORV
         ZMdw==
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
Subject: [PATCH 4.4 62/72] net: hns: Fix ethtool private flags
Date: Fri,  6 Apr 2018 15:24:03 +0200
Message-Id: <20180406084310.646504452@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084305.210085169@linuxfoundation.org>
References: <20180406084305.210085169@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003799411742003?=
X-GMAIL-MSGID: =?utf-8?q?1597003799411742003?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -648,7 +648,7 @@ static void hns_gmac_get_strings(u32 str
 
 static int hns_gmac_get_sset_count(int stringset)
 {
-	if (stringset == ETH_SS_STATS || stringset == ETH_SS_PRIV_FLAGS)
+	if (stringset == ETH_SS_STATS)
 		return ARRAY_SIZE(g_gmac_stats_string);
 
 	return 0;
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.c
@@ -384,7 +384,7 @@ void hns_ppe_update_stats(struct hns_ppe
 
 int hns_ppe_get_sset_count(int stringset)
 {
-	if (stringset == ETH_SS_STATS || stringset == ETH_SS_PRIV_FLAGS)
+	if (stringset == ETH_SS_STATS)
 		return ETH_PPE_STATIC_NUM;
 	return 0;
 }
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c
@@ -807,7 +807,7 @@ void hns_rcb_get_stats(struct hnae_queue
  */
 int hns_rcb_get_ring_sset_count(int stringset)
 {
-	if (stringset == ETH_SS_STATS || stringset == ETH_SS_PRIV_FLAGS)
+	if (stringset == ETH_SS_STATS)
 		return HNS_RING_STATIC_REG_NUM;
 
 	return 0;
--- a/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c
@@ -1000,8 +1000,10 @@ int hns_get_sset_count(struct net_device
 			cnt--;
 
 		return cnt;
-	} else {
+	} else if (stringset == ETH_SS_STATS) {
 		return (HNS_NET_STATS_CNT + ops->get_sset_count(h, stringset));
+	} else {
+		return -EOPNOTSUPP;
 	}
 }
 
