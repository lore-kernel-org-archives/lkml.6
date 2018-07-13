Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26072ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 07:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E040B2124D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 07:20:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E040B2124D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729592AbeGMHde (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 03:33:34 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:41810 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726605AbeGMHde (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 03:33:34 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 8DAE7D8D66353;
        Fri, 13 Jul 2018 15:20:12 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.382.0; Fri, 13 Jul 2018
 15:20:04 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <rjw@rjwysocki.net>, <lenb@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] ACPI: button: hide unused procfs helpers
Date:   Fri, 13 Jul 2018 15:19:59 +0800
Message-ID: <20180713071959.11220-1-yuehaibing@huawei.com>
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

When CONFIG_PROC_FS isn't set, gcc warning this:

drivers/acpi/button.c:255:12: warning: ‘acpi_button_state_seq_show’ defined but not used [-Wunused-function]
 static int acpi_button_state_seq_show(struct seq_file *seq, void *offset)
            ^
fix this by adding #ifdef around it.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/acpi/button.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 2345a5e..8538e25 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -252,6 +252,7 @@ static int acpi_lid_notify_state(struct acpi_device *device, int state)
 	return ret;
 }
 
+#ifdef CONFIG_PROC_FS
 static int acpi_button_state_seq_show(struct seq_file *seq, void *offset)
 {
 	struct acpi_device *device = seq->private;
@@ -262,6 +263,7 @@ static int acpi_button_state_seq_show(struct seq_file *seq, void *offset)
 		   state < 0 ? "unsupported" : (state ? "open" : "closed"));
 	return 0;
 }
+#endif
 
 static int acpi_button_add_fs(struct acpi_device *device)
 {
-- 
2.7.0


