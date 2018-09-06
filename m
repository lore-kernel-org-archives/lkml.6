Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55BB9C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17CD120861
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:15:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17CD120861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729197AbeIFRvM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 13:51:12 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:21847 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727790AbeIFRvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 13:51:12 -0400
X-UUID: f61f148e3b394a25a02d3be55e2b90b7-20180906
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <jun.gao@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 612535395; Thu, 06 Sep 2018 21:15:39 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Thu, 6 Sep 2018 21:15:37 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Thu, 6 Sep 2018 21:15:37 +0800
From:   Jun Gao <jun.gao@mediatek.com>
To:     Wolfram Sang <wsa@the-dreams.de>
CC:     <srv_heupstream@mediatek.com>, <linux-i2c@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Jun Gao <jun.gao@mediatek.com>
Subject: [PATCH v3 1/2] i2c: mediatek: Register i2c adapter driver earlier
Date:   Thu, 6 Sep 2018 21:15:28 +0800
Message-ID: <1536239729-10008-2-git-send-email-jun.gao@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1536239729-10008-1-git-send-email-jun.gao@mediatek.com>
References: <1536239729-10008-1-git-send-email-jun.gao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jun Gao <jun.gao@mediatek.com>

In order not to block the initializations of some i2c devices.
Register i2c adapter driver at appropriate time.

Signed-off-by: Jun Gao <jun.gao@mediatek.com>
---
 drivers/i2c/busses/i2c-mt65xx.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-mt65xx.c b/drivers/i2c/busses/i2c-mt65xx.c
index 1e57f58..806e8b90 100644
--- a/drivers/i2c/busses/i2c-mt65xx.c
+++ b/drivers/i2c/busses/i2c-mt65xx.c
@@ -888,7 +888,17 @@ static int mtk_i2c_resume(struct device *dev)
 	},
 };
 
-module_platform_driver(mtk_i2c_driver);
+static int __init mtk_i2c_adap_init(void)
+{
+	return platform_driver_register(&mtk_i2c_driver);
+}
+subsys_initcall(mtk_i2c_adap_init);
+
+static void __exit mtk_i2c_adap_exit(void)
+{
+	platform_driver_unregister(&mtk_i2c_driver);
+}
+module_exit(mtk_i2c_adap_exit);
 
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("MediaTek I2C Bus Driver");
-- 
1.8.1.1

