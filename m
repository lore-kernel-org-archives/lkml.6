Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DATE_IN_FUTURE_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C14C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 08:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEDC4217CC
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 08:21:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEDC4217CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731697AbeHGKeh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 06:34:37 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:10673 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726951AbeHGKeh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 06:34:37 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C38C4E5FA357D;
        Tue,  7 Aug 2018 16:21:19 +0800 (CST)
Received: from localhost.localdomain (10.143.28.90) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.399.0; Tue, 7 Aug 2018 16:21:14 +0800
From:   Dongjiu Geng <gengdongjiu@huawei.com>
To:     <will.deacon@arm.com>, <rafael.j.wysocki@intel.com>,
        <james.morse@arm.com>, <tbaicar@codeaurora.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <devel@acpica.org>, <linuxarm@huawei.com>
CC:     <gengdongjiu@huawei.com>
Subject: [PATCH RESEND v2] arm64: clean the additional checks before calling ghes_notify_sea()
Date:   Tue, 7 Aug 2018 12:26:15 -0400
Message-ID: <1533659175-47076-1-git-send-email-gengdongjiu@huawei.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.143.28.90]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to remove the additional check before calling the
ghes_notify_sea(), make stub definition when !CONFIG_ACPI_APEI_SEA.

After this cleanup, we can simply call the ghes_notify_sea() to let
APEI driver handle the SEA notification.

CC: Tyler Baicar <tbaicar@codeaurora.org>
CC: James Morse <james.morse@arm.com>
Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
Acked-by: Will Deacon <will.deacon@arm.com>
---
This cleanup is ever mentioned by Mark Rutland in [1]

[1]:
https://lkml.org/lkml/2018/5/31/289

Change since v1:
1. Update the commit messages
2. CC Tyler and James
3. Add Acked-by of Will
---
 arch/arm64/mm/fault.c | 7 +------
 include/acpi/ghes.h   | 4 ++++
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index b8eecc7..9ffe01d 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -727,12 +727,7 @@ static int do_sea(unsigned long addr, unsigned int esr, struct pt_regs *regs)
 
 int handle_guest_sea(phys_addr_t addr, unsigned int esr)
 {
-	int ret = -ENOENT;
-
-	if (IS_ENABLED(CONFIG_ACPI_APEI_SEA))
-		ret = ghes_notify_sea();
-
-	return ret;
+	return ghes_notify_sea();
 }
 
 asmlinkage void __exception do_mem_abort(unsigned long addr, unsigned int esr,
diff --git a/include/acpi/ghes.h b/include/acpi/ghes.h
index 1624e2b..82cb4eb 100644
--- a/include/acpi/ghes.h
+++ b/include/acpi/ghes.h
@@ -118,6 +118,10 @@ static inline void *acpi_hest_get_next(struct acpi_hest_generic_data *gdata)
 	     (void *)section - (void *)(estatus + 1) < estatus->data_length; \
 	     section = acpi_hest_get_next(section))
 
+#ifdef CONFIG_ACPI_APEI_SEA
 int ghes_notify_sea(void);
+#else
+static inline int ghes_notify_sea(void) { return -ENOENT; }
+#endif
 
 #endif /* GHES_H */
-- 
1.9.1

