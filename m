Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53094ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 04:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9F0B204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 04:12:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9F0B204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbeGMEY0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 00:24:26 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:9233 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725908AbeGMEY0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 00:24:26 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 4D76FAFAADFEA;
        Fri, 13 Jul 2018 12:11:27 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.382.0; Fri, 13 Jul 2018
 12:11:19 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <isdn@linux-pingi.de>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <keescook@chromium.org>, <viro@zeniv.linux.org.uk>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] isdn/capi: hide unused procfs helpers
Date:   Fri, 13 Jul 2018 12:11:14 +0800
Message-ID: <20180713041114.16112-1-yuehaibing@huawei.com>
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

drivers/isdn/capi/capi.c:1324:12: warning: ‘capi20_proc_show’ defined but not used [-Wunused-function]
 static int capi20_proc_show(struct seq_file *m, void *v)
            ^
drivers/isdn/capi/capi.c:1347:12: warning: ‘capi20ncci_proc_show’ defined but not used [-Wunused-function]
 static int capi20ncci_proc_show(struct seq_file *m, void *v)
            ^
drivers/isdn/capi/capidrv.c:2454:12: warning: ‘capidrv_proc_show’ defined but not used [-Wunused-function]
 static int capidrv_proc_show(struct seq_file *m, void *v)
            ^

We can fix the warning by adding the same #ifdef around them.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/isdn/capi/capi.c    | 2 ++
 drivers/isdn/capi/capidrv.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/isdn/capi/capi.c b/drivers/isdn/capi/capi.c
index 6e0c281..594f767 100644
--- a/drivers/isdn/capi/capi.c
+++ b/drivers/isdn/capi/capi.c
@@ -1317,6 +1317,7 @@ static inline void capinc_tty_exit(void) { }
 
 /* -------- /proc functions ----------------------------------------- */
 
+#ifdef CONFIG_PROC_FS
 /*
  * /proc/capi/capi20:
  *  minor applid nrecvctlpkt nrecvdatapkt nsendctlpkt nsenddatapkt
@@ -1359,6 +1360,7 @@ static int capi20ncci_proc_show(struct seq_file *m, void *v)
 	mutex_unlock(&capidev_list_lock);
 	return 0;
 }
+#endif
 
 static void __init proc_init(void)
 {
diff --git a/drivers/isdn/capi/capidrv.c b/drivers/isdn/capi/capidrv.c
index ee510f9..c6f45d7 100644
--- a/drivers/isdn/capi/capidrv.c
+++ b/drivers/isdn/capi/capidrv.c
@@ -2447,6 +2447,7 @@ lower_callback(struct notifier_block *nb, unsigned long val, void *v)
 	return NOTIFY_OK;
 }
 
+#ifdef CONFIG_PROC_FS
 /*
  * /proc/capi/capidrv:
  * nrecvctlpkt nrecvdatapkt nsendctlpkt nsenddatapkt
@@ -2460,6 +2461,7 @@ static int capidrv_proc_show(struct seq_file *m, void *v)
 		   global.ap.nsentdatapkt);
 	return 0;
 }
+#endif
 
 static void __init proc_init(void)
 {
-- 
2.7.0


