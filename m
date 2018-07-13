Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 946C5ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 08:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BAE62124D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 08:02:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BAE62124D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387689AbeGMIPb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 04:15:31 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:58021 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729790AbeGMIPa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 04:15:30 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 27910CD3E268F;
        Fri, 13 Jul 2018 16:01:56 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.382.0; Fri, 13 Jul 2018
 16:01:51 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <gregkh@linuxfoundation.org>, <christophe.jaillet@wanadoo.fr>
CC:     <linux-kernel@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] staging/rtl8192u: hide unused procfs helpers
Date:   Fri, 13 Jul 2018 16:01:46 +0800
Message-ID: <20180713080146.8268-1-yuehaibing@huawei.com>
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

drivers/staging/rtl8192u/r8192U_core.c:508:12: warning: ‘proc_get_stats_ap’ defined but not used [-Wunused-function]
 static int proc_get_stats_ap(struct seq_file *m, void *v)
            ^
drivers/staging/rtl8192u/r8192U_core.c:527:12: warning: ‘proc_get_registers’ defined but not used [-Wunused-function]
 static int proc_get_registers(struct seq_file *m, void *v)
            ^
drivers/staging/rtl8192u/r8192U_core.c:568:12: warning: ‘proc_get_stats_tx’ defined but not used [-Wunused-function]
 static int proc_get_stats_tx(struct seq_file *m, void *v)
            ^
drivers/staging/rtl8192u/r8192U_core.c:627:12: warning: ‘proc_get_stats_rx’ defined but not used [-Wunused-function]
 static int proc_get_stats_rx(struct seq_file *m, void *v)
            ^
fix this by adding #ifdef around them.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/staging/rtl8192u/r8192U_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
index 8b17400..b9724d9 100644
--- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -505,6 +505,7 @@ static void watch_dog_timer_callback(struct timer_list *t);
 
 static struct proc_dir_entry *rtl8192_proc;
 
+#ifdef CONFIG_PROC_FS
 static int proc_get_stats_ap(struct seq_file *m, void *v)
 {
 	struct net_device *dev = m->private;
@@ -639,6 +640,7 @@ static int proc_get_stats_rx(struct seq_file *m, void *v)
 
 	return 0;
 }
+#endif
 
 static void rtl8192_proc_module_init(void)
 {
-- 
2.7.0


