Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34168C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 20:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB6B7217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 20:08:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kF3u+fBA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728981AbfBRUIr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 15:08:47 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:51246 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728450AbfBRUIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 15:08:43 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1IK8gm3024794;
        Mon, 18 Feb 2019 14:08:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1550520522;
        bh=Cycs5QM9uKU23eLxQmyTFOJmeGX7Hw4SKUFgGRrofjA=;
        h=From:To:Subject:Date;
        b=kF3u+fBA5Uw4/sGRlW6aW3KQ22RwNReVioLE5PP2wwcijhrqqtnw0b/WOi6Ln72sX
         Uy/bwW7FzXV4gmGmGOsdjajQ6zsj9zxNl9TdhPHALt25zRzvwrT9yEpidDKtqH7CVC
         xSQjmGHKpnLgxfuXuXTnDtcxwTP/ZZeujUUSnj1Q=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1IK8gZm113345
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 18 Feb 2019 14:08:42 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 18
 Feb 2019 14:08:41 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 18 Feb 2019 14:08:41 -0600
Received: from uda0868495.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1IK8f0B018546;
        Mon, 18 Feb 2019 14:08:41 -0600
From:   Murali Karicheri <m-karicheri2@ti.com>
To:     <w-kwok2@ti.com>, <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] net: netcp: Fix ethss driver probe issue
Date:   Mon, 18 Feb 2019 15:10:51 -0500
Message-ID: <20190218201051.19623-1-m-karicheri2@ti.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recent commit below has introduced a bug in netcp driver that causes
the ethss driver probe failure and thus break the networking function
on K2 SoCs such as K2HK, K2L, K2E etc. This patch fixes the issue to
restore networking on the above SoCs.

Fixes: 21c328dcecfc ("net: ethernet: Convert to using %pOFn instead of device_node.name")
Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
---
 Failure log: https://pastebin.ubuntu.com/p/cGCFZC4WkC/
 With fix: https://pastebin.ubuntu.com/p/G9qYzXXNbw/

 drivers/net/ethernet/ti/netcp_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/netcp_core.c b/drivers/net/ethernet/ti/netcp_core.c
index 1f612268c998..d847f672a705 100644
--- a/drivers/net/ethernet/ti/netcp_core.c
+++ b/drivers/net/ethernet/ti/netcp_core.c
@@ -259,7 +259,7 @@ static int netcp_module_probe(struct netcp_device *netcp_device,
 		const char *name;
 		char node_name[32];
 
-		if (of_property_read_string(node, "label", &name) < 0) {
+		if (of_property_read_string(child, "label", &name) < 0) {
 			snprintf(node_name, sizeof(node_name), "%pOFn", child);
 			name = node_name;
 		}
-- 
2.17.0

