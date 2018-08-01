Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59969C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 07:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3365208A2
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 07:11:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3365208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733254AbeHAIza (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 04:55:30 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:34135 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733096AbeHAIza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 04:55:30 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 71EB1D8713F1B;
        Wed,  1 Aug 2018 15:11:09 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.399.0; Wed, 1 Aug 2018
 15:11:04 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <doronrk@fb.com>, <tom@quantonium.net>,
        <vakul.garg@nxp.com>, <davejwatson@fb.com>, <ebiggers@google.com>,
        <john.fastabend@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] strparser: remove redundant variable 'rd_desc'
Date:   Wed, 1 Aug 2018 15:10:37 +0800
Message-ID: <20180801071037.12508-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variable 'rd_desc' is being assigned but never used,
so can be removed.

fix this clang warning:
net/strparser/strparser.c:411:20: warning: variable ‘rd_desc’ set but not used [-Wunused-but-set-variable]

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 net/strparser/strparser.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/net/strparser/strparser.c b/net/strparser/strparser.c
index 3a51293..da1a676 100644
--- a/net/strparser/strparser.c
+++ b/net/strparser/strparser.c
@@ -408,8 +408,6 @@ EXPORT_SYMBOL_GPL(strp_data_ready);
 
 static void do_strp_work(struct strparser *strp)
 {
-	read_descriptor_t rd_desc;
-
 	/* We need the read lock to synchronize with strp_data_ready. We
 	 * need the socket lock for calling strp_read_sock.
 	 */
@@ -421,8 +419,6 @@ static void do_strp_work(struct strparser *strp)
 	if (strp->paused)
 		goto out;
 
-	rd_desc.arg.data = strp;
-
 	if (strp_read_sock(strp) == -ENOMEM)
 		queue_work(strp_wq, &strp->work);
 
-- 
2.7.0


