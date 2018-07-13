Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C8AECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 07:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D54A2147C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 07:16:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D54A2147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731385AbeGMH35 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 03:29:57 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9620 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729764AbeGMH35 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 03:29:57 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 1B09C394F1564;
        Fri, 13 Jul 2018 15:16:22 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.382.0; Fri, 13 Jul 2018
 15:16:15 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] DAC960: hide unused procfs helpers
Date:   Fri, 13 Jul 2018 15:16:10 +0800
Message-ID: <20180713071610.14276-1-yuehaibing@huawei.com>
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

drivers/block/DAC960.c:6429:12: warning: ‘dac960_proc_show’ defined but not used [-Wunused-function]
 static int dac960_proc_show(struct seq_file *m, void *v)
            ^
drivers/block/DAC960.c:6449:12: warning: ‘dac960_initial_status_proc_show’ defined but not used [-Wunused-function]
 static int dac960_initial_status_proc_show(struct seq_file *m, void *v)
            ^
drivers/block/DAC960.c:6456:12: warning: ‘dac960_current_status_proc_show’ defined but not used [-Wunused-function]
 static int dac960_current_status_proc_show(struct seq_file *m, void *v)
            ^
fix this by adding #ifdef around them.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/block/DAC960.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/block/DAC960.c b/drivers/block/DAC960.c
index f651806..7a05831 100644
--- a/drivers/block/DAC960.c
+++ b/drivers/block/DAC960.c
@@ -6426,6 +6426,7 @@ static bool DAC960_V2_ExecuteUserCommand(DAC960_Controller_T *Controller,
   return true;
 }
 
+#ifdef CONFIG_PROC_FS
 static int dac960_proc_show(struct seq_file *m, void *v)
 {
   unsigned char *StatusMessage = "OK\n";
@@ -6485,6 +6486,7 @@ static int dac960_current_status_proc_show(struct seq_file *m, void *v)
 	seq_printf(m, "%.*s", Controller->CurrentStatusLength, Controller->CurrentStatusBuffer);
 	return 0;
 }
+#endif
 
 static int dac960_user_command_proc_show(struct seq_file *m, void *v)
 {
-- 
2.7.0


