Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D49E8C6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 09:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8299F21A6F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 09:30:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8299F21A6F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753730AbeGGJaT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 05:30:19 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:43995 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752080AbeGGJaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 05:30:15 -0400
X-UUID: 74a8f46f90b741efbea7f79eceae935c-20180707
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <jun.gao@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1213024681; Sat, 07 Jul 2018 17:30:06 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Sat, 7 Jul 2018 17:30:04 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Sat, 7 Jul 2018 17:30:04 +0800
From:   Jun Gao <jun.gao@mediatek.com>
To:     Wolfram Sang <wsa@the-dreams.de>
CC:     <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-i2c@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Jun Gao <jun.gao@mediatek.com>
Subject: [PATCH v2 1/3] i2c: mediatek: Register i2c adapter driver earlier
Date:   Sat, 7 Jul 2018 17:29:53 +0800
Message-ID: <1530955795-17714-2-git-send-email-jun.gao@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1530955795-17714-1-git-send-email-jun.gao@mediatek.com>
References: <1530955795-17714-1-git-send-email-jun.gao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jun Gao <jun.gao@mediatek.com>

As i2c adapter, i2c slave devices will depend on it. In order not to
block the initializations of i2c slave devices, register i2c adapter
driver at appropriate time.

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

