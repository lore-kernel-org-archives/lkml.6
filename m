Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 426E2C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 12:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED9E221529
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 12:49:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED9E221529
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388353AbeITScU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 14:32:20 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12660 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387764AbeITScT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 14:32:19 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C52AE7C16A8C3;
        Thu, 20 Sep 2018 20:48:51 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.399.0; Thu, 20 Sep 2018
 20:48:45 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <dmitry.tarnyagin@lockless.no>,
        <wg@grandegger.com>, <mkl@pengutronix.de>,
        <michal.simek@xilinx.com>, <hsweeten@visionengravers.com>,
        <madalin.bucur@nxp.com>, <pantelis.antoniou@gmail.com>,
        <claudiu.manoil@nxp.com>, <leoyang.li@nxp.com>,
        <linux@armlinux.org.uk>, <sammy@sammy.net>, <ralf@linux-mips.org>,
        <nico@fluxnic.net>, <steve.glendinning@shawell.net>,
        <f.fainelli@gmail.com>, <grygorii.strashko@ti.com>,
        <w-kwok2@ti.com>, <m-karicheri2@ti.com>, <t.sailer@alumni.ethz.ch>,
        <jreuter@yaina.de>, <kys@microsoft.com>, <haiyangz@microsoft.com>,
        <wei.liu2@citrix.com>, <paul.durrant@citrix.com>,
        <arvid.brodin@alten.se>, <pshelar@ovn.org>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-can@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-mips@linux-mips.org>,
        <linux-omap@vger.kernel.org>, <linux-hams@vger.kernel.org>,
        <devel@linuxdriverproject.org>, <linux-usb@vger.kernel.org>,
        <xen-devel@lists.xenproject.org>, <dev@openvswitch.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next 17/22] hv_netvsc: fix return type of ndo_start_xmit function
Date:   Thu, 20 Sep 2018 20:33:01 +0800
Message-ID: <20180920123306.14772-18-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
In-Reply-To: <20180920123306.14772-1-yuehaibing@huawei.com>
References: <20180920123306.14772-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
which is a typedef for an enum type, so make sure the implementation in
this driver has returns 'netdev_tx_t' value, and change the function
return type to netdev_tx_t.

Found by coccinelle.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/hyperv/netvsc_drv.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index 3af6d8d..056c472 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -511,7 +511,8 @@ static int netvsc_vf_xmit(struct net_device *net, struct net_device *vf_netdev,
 	return rc;
 }
 
-static int netvsc_start_xmit(struct sk_buff *skb, struct net_device *net)
+static netdev_tx_t
+netvsc_start_xmit(struct sk_buff *skb, struct net_device *net)
 {
 	struct net_device_context *net_device_ctx = netdev_priv(net);
 	struct hv_netvsc_packet *packet = NULL;
@@ -528,8 +529,11 @@ static int netvsc_start_xmit(struct sk_buff *skb, struct net_device *net)
 	 */
 	vf_netdev = rcu_dereference_bh(net_device_ctx->vf_netdev);
 	if (vf_netdev && netif_running(vf_netdev) &&
-	    !netpoll_tx_running(net))
-		return netvsc_vf_xmit(net, vf_netdev, skb);
+	    !netpoll_tx_running(net)) {
+		ret = netvsc_vf_xmit(net, vf_netdev, skb);
+		if (ret)
+			return NETDEV_TX_BUSY;
+	}
 
 	/* We will atmost need two pages to describe the rndis
 	 * header. We can only transmit MAX_PAGE_BUFFER_COUNT number
-- 
1.8.3.1


