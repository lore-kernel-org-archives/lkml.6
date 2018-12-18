Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F72C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8D81214C6
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:22:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbeLRIWM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 03:22:12 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:36037 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726316AbeLRIWM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 03:22:12 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id BB2809DAA8E6B;
        Tue, 18 Dec 2018 16:22:08 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.408.0; Tue, 18 Dec 2018
 16:22:02 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <boris.ostrovsky@oracle.com>, <jgross@suse.com>,
        <sstabellini@kernel.org>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <bp@alien8.de>, <hpa@zytor.com>
CC:     <linux-kernel@vger.kernel.org>, <xen-devel@lists.xenproject.org>,
        <x86@kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] x86/xen: Fix read buffer overflow
Date:   Tue, 18 Dec 2018 16:19:10 +0800
Message-ID: <20181218081910.18080-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix smatch warning:

arch/x86/xen/enlighten_pv.c:649 get_trap_addr() error:
 buffer overflow 'early_idt_handler_array' 32 <= 32

Fixes: 42b3a4cb5609 ("x86/xen: Support early interrupts in xen pv guests")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 arch/x86/xen/enlighten_pv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 2f6787f..81f200d 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -646,7 +646,7 @@ static bool __ref get_trap_addr(void **addr, unsigned int ist)
 
 	if (nr == ARRAY_SIZE(trap_array) &&
 	    *addr >= (void *)early_idt_handler_array[0] &&
-	    *addr < (void *)early_idt_handler_array[NUM_EXCEPTION_VECTORS]) {
+	    *addr < (void *)early_idt_handler_array[NUM_EXCEPTION_VECTORS - 1]) {
 		nr = (*addr - (void *)early_idt_handler_array[0]) /
 		     EARLY_IDT_HANDLER_SIZE;
 		*addr = (void *)xen_early_idt_handler_array[nr];
-- 
2.7.0


