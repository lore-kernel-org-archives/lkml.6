Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELs5gKjPIMiPGuxsG4uR1+F06ftAN+YL6M0e+0y7DrfQDgKeWArauJRfaobYpbsXXFr2LVU5
ARC-Seal: i=1; a=rsa-sha256; t=1521800201; cv=none;
        d=google.com; s=arc-20160816;
        b=juRANAWFoOWnJo6aULM/jRQPDr6Nc63tH6ihX4AEvDOZYEGQcI55QormSrk15SRm2s
         ICoU9g9gHkNjPMSYFF0h6p3dFob/KZsXGLaLa0TUz1U2fMEcnQFkBtlA2/jx6oTGD5Hw
         2E34PEfMhjfPfkenxBPR9DSITh/bdZ6UVWQ6E/nMPkkk7wM3hcilyEq57lNnJ7z8OLVC
         LSZLzT1itL7Nn23FVy5a1h/nURfpMNlsI9507h2eJYfKVhvGovVlDoCPbvWaewjd9Myw
         obgY1VFXtyKU57xtjjNkcFh8Q0IPEIYu2k2KBnHmR0ZJOZLUd0DCjbhQJq/rrfy62wuQ
         XHlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=UGws0b67YCuq7oJZ6qq1IWwHrXYCm0ynqDnLdKdFL+s=;
        b=tZUuUQ3NCv5QNsExV8wiEeTqRvdHdSgi0PZK+TXecRe8sufiF6gxhoWKfH2dhLcpfV
         5oUwncpdfWpg+MRG4JT217SpQNHt2jNQKjwzS+0UEpewruIfZABQ2rbqWoz4PNsxZUzl
         ap01f2djxAVpOTBEQVu3NIWnXMIZF/I84Cbbbc2KiOaCT+7D2I+O31ZRY4lRXjILt7Ry
         DwhAheixxHrXmJqkrcqGM2mFqdsyhsl3xB4lMUeC4arUiz8ANNEnJEn4epq0Ws4B8q9o
         XXbVHC0hBY8jJBBEMxyCxUW/m6tsCEP+MTQ0yITHE86cd5Z+2HkYie7TQPcsTyZPHgHk
         U71Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Timmy Li <lixiaoping3@huawei.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 68/97] net: hns: fix ethtool_get_strings overflow in hns driver
Date: Fri, 23 Mar 2018 10:54:55 +0100
Message-Id: <20180323094201.429866014@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094157.535925724@linuxfoundation.org>
References: <20180323094157.535925724@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595722779519970871?=
X-GMAIL-MSGID: =?utf-8?q?1595723168205932149?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Timmy Li <lixiaoping3@huawei.com>


[ Upstream commit 412b65d15a7f8a93794653968308fc100f2aa87c ]

hns_get_sset_count() returns HNS_NET_STATS_CNT and the data space allocated
is not enough for ethtool_get_strings(), which will cause random memory
corruption.

When SLAB and DEBUG_SLAB are both enabled, memory corruptions like the
the following can be observed without this patch:
[   43.115200] Slab corruption (Not tainted): Acpi-ParseExt start=ffff801fb0b69030, len=80
[   43.115206] Redzone: 0x9f911029d006462/0x5f78745f31657070.
[   43.115208] Last user: [<5f7272655f746b70>](0x5f7272655f746b70)
[   43.115214] 010: 70 70 65 31 5f 74 78 5f 70 6b 74 00 6b 6b 6b 6b  ppe1_tx_pkt.kkkk
[   43.115217] 030: 70 70 65 31 5f 74 78 5f 70 6b 74 5f 6f 6b 00 6b  ppe1_tx_pkt_ok.k
[   43.115218] Next obj: start=ffff801fb0b69098, len=80
[   43.115220] Redzone: 0x706d655f6f666966/0x9f911029d74e35b.
[   43.115229] Last user: [<ffff0000084b11b0>](acpi_os_release_object+0x28/0x38)
[   43.115231] 000: 74 79 00 6b 6b 6b 6b 6b 70 70 65 31 5f 74 78 5f  ty.kkkkkppe1_tx_
[   43.115232] 010: 70 6b 74 5f 65 72 72 5f 63 73 75 6d 5f 66 61 69  pkt_err_csum_fai

Signed-off-by: Timmy Li <lixiaoping3@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c  |    2 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.c   |    2 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c   |    2 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_xgmac.c |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c
@@ -648,7 +648,7 @@ static void hns_gmac_get_strings(u32 str
 
 static int hns_gmac_get_sset_count(int stringset)
 {
-	if (stringset == ETH_SS_STATS)
+	if (stringset == ETH_SS_STATS || stringset == ETH_SS_PRIV_FLAGS)
 		return ARRAY_SIZE(g_gmac_stats_string);
 
 	return 0;
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.c
@@ -384,7 +384,7 @@ void hns_ppe_update_stats(struct hns_ppe
 
 int hns_ppe_get_sset_count(int stringset)
 {
-	if (stringset == ETH_SS_STATS)
+	if (stringset == ETH_SS_STATS || stringset == ETH_SS_PRIV_FLAGS)
 		return ETH_PPE_STATIC_NUM;
 	return 0;
 }
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c
@@ -807,7 +807,7 @@ void hns_rcb_get_stats(struct hnae_queue
  */
 int hns_rcb_get_ring_sset_count(int stringset)
 {
-	if (stringset == ETH_SS_STATS)
+	if (stringset == ETH_SS_STATS || stringset == ETH_SS_PRIV_FLAGS)
 		return HNS_RING_STATIC_REG_NUM;
 
 	return 0;
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_xgmac.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_xgmac.c
@@ -776,7 +776,7 @@ static void hns_xgmac_get_strings(u32 st
  */
 static int hns_xgmac_get_sset_count(int stringset)
 {
-	if (stringset == ETH_SS_STATS)
+	if (stringset == ETH_SS_STATS || stringset == ETH_SS_PRIV_FLAGS)
 		return ARRAY_SIZE(g_xgmac_stats_string);
 
 	return 0;
