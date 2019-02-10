Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04668C282C2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 05:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C36B821736
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 05:28:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725984AbfBJF17 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 00:27:59 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:36340 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725862AbfBJF17 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 00:27:59 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 7B19F9A484A186AA9593;
        Sun, 10 Feb 2019 13:27:55 +0800 (CST)
Received: from HGHY2Y004646261.china.huawei.com (10.184.12.158) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.408.0; Sun, 10 Feb 2019 13:27:46 +0800
From:   Zenghui Yu <yuzenghui@huawei.com>
To:     <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <marc.zyngier@arm.com>
CC:     <shankerd@codeaurora.org>, <wanghaibin.wang@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH] irqchip/gic-v3-its: Avoid parsing _indirect_ twice for Device table
Date:   Sun, 10 Feb 2019 05:24:10 +0000
Message-ID: <1549776250-4464-1-git-send-email-yuzenghui@huawei.com>
X-Mailer: git-send-email 2.6.4.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.184.12.158]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In current logic, its_parse_indirect_baser() will be invoked twice
when allocating Device tables. Add a *break* to omit the unnecessary
and annoying (might be ...) invoking.

Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index db20e99..9f529a6 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1946,6 +1946,8 @@ static int its_alloc_tables(struct its_node *its)
 			indirect = its_parse_indirect_baser(its, baser,
 							    psz, &order,
 							    its->device_ids);
+			break;
+
 		case GITS_BASER_TYPE_VCPU:
 			indirect = its_parse_indirect_baser(its, baser,
 							    psz, &order,
-- 
1.8.3.1


