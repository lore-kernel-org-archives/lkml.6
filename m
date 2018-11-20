Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 205B9C28CF8
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E892E206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:21:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E892E206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729766AbeKUAul (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 19:50:41 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:15127 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725995AbeKUAul (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 19:50:41 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A4F36BC48BAFA;
        Tue, 20 Nov 2018 22:21:14 +0800 (CST)
Received: from localhost.localdomain (10.175.124.28) by smtp.huawei.com
 (10.3.19.204) with Microsoft SMTP Server (TLS) id 14.3.408.0; Tue, 20 Nov
 2018 22:21:05 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, "Chao Yu" <yuchao0@huawei.com>,
        Miao Xie <miaoxie@huawei.com>, <weidu.du@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH 05/10] staging: erofs: add a full barrier in erofs_workgroup_unfreeze
Date:   Tue, 20 Nov 2018 22:34:20 +0800
Message-ID: <20181120143425.43637-6-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181120143425.43637-1-gaoxiang25@huawei.com>
References: <20181120143425.43637-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just like other generic locks, insert a full barrier
in case of memory reorder.

Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 drivers/staging/erofs/internal.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/erofs/internal.h b/drivers/staging/erofs/internal.h
index 2e0ef92c138b..f77653d33633 100644
--- a/drivers/staging/erofs/internal.h
+++ b/drivers/staging/erofs/internal.h
@@ -209,6 +209,7 @@ static inline bool erofs_workgroup_try_to_freeze(struct erofs_workgroup *grp,
 static inline void erofs_workgroup_unfreeze(struct erofs_workgroup *grp,
 					    int orig_val)
 {
+	smp_mb();
 	atomic_set(&grp->refcount, orig_val);
 	preempt_enable();
 }
-- 
2.14.4

