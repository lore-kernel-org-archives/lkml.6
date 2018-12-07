Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6834C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 06:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86BE620838
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 06:36:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86BE620838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725998AbeLGGgP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 01:36:15 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:33054 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725948AbeLGGgP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 01:36:15 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id AE81F5BAE0484;
        Fri,  7 Dec 2018 14:36:10 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.408.0; Fri, 7 Dec 2018 14:36:04 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>
CC:     YueHaibing <yuehaibing@huawei.com>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] powerpc/mm: drop test in pp_601
Date:   Fri, 7 Dec 2018 06:44:16 +0000
Message-ID: <1544165056-52579-1-git-send-email-yuehaibing@huawei.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The test selects between two identical values, so it doesn't look useful.
It turns out that the tested expression can only be true anyway, so drop
the test, the corresponding parameter, and the corresponding argument at
the only call site.

The semantic match that finds this problem is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@@
expression e,e1;
@@

* e ? e1 : e1
// </smpl>

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 arch/powerpc/mm/dump_bats.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/dump_bats.c b/arch/powerpc/mm/dump_bats.c
index a0d23e9..33450a8 100644
--- a/arch/powerpc/mm/dump_bats.c
+++ b/arch/powerpc/mm/dump_bats.c
@@ -17,8 +17,8 @@ static char *pp_601(int k, int pp)
 	if (pp == 1)
 		return k ? "ROX" : "RWX";
 	if (pp == 2)
-		return k ? "RWX" : "RWX";
-	return k ? "ROX" : "ROX";
+		return "RWX";
+	return "ROX";
 }
 
 static void bat_show_601(struct seq_file *m, int idx, u32 lower, u32 upper)



