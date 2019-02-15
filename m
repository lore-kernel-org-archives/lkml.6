Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AADBC10F04
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 03:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7322B2192D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 03:14:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387594AbfBODOo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 22:14:44 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:43492 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726010AbfBODOo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 22:14:44 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D74401509A76C79214A0;
        Fri, 15 Feb 2019 11:14:41 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.408.0; Fri, 15 Feb 2019 11:14:31 +0800
From:   Xuefeng Wang <wxf.wang@hisilicon.com>
To:     <a.zummo@towertech.it>, <alexandre.belloni@bootlin.com>,
        <linux-rtc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <wxf.wang@hisilicon.com>, <tanxiaojun@huawei.com>
Subject: [PATCH] drivers/rtc/rtc-lib.c: check whether tm->tm_year in int32 range
Date:   Fri, 15 Feb 2019 11:13:59 +0800
Message-ID: <1550200439-62533-1-git-send-email-wxf.wang@hisilicon.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When setting rtc alarm (RTC_WKALM_SET), the tm_year is not checked if it
is in suiteable range. Use INT_MAX - 1900 to check it.

UBSAN: Undefined behaviour in drivers/rtc/rtc-lib.c:119:30
signed integer overflow:
2147483647 + 1900 cannot be represented in type 'int'
CPU: 1 PID: 20994 Comm: syz-executor0 Not tainted 4.19.18-514.55.6.9.x86_64
+ #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubuntu1
04/01/2014
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0xca/0x13e lib/dump_stack.c:113
 ubsan_epilogue+0xe/0x81 lib/ubsan.c:159
 handle_overflow+0x193/0x1e2 lib/ubsan.c:190
 rtc_tm_to_time64+0x267/0x280 drivers/rtc/rtc-lib.c:119
 rtc_tm_to_ktime+0x16/0x70 drivers/rtc/rtc-lib.c:129
 rtc_set_alarm+0x1a9/0x2d0 drivers/rtc/interface.c:466
 rtc_dev_ioctl+0x6db/0x810 drivers/rtc/rtc-dev.c:380
 vfs_ioctl fs/ioctl.c:46 [inline]
 do_vfs_ioctl+0x1a5/0x10b0 fs/ioctl.c:690
 ksys_ioctl+0x89/0xa0 fs/ioctl.c:705
 __do_sys_ioctl fs/ioctl.c:712 [inline]
 __se_sys_ioctl fs/ioctl.c:710 [inline]
 __x64_sys_ioctl+0x74/0xb0 fs/ioctl.c:710
 do_syscall_64+0xc8/0x580 arch/x86/entry/common.c:290
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x462589
Code: f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 48 89
f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08
0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8
64 89 01 48
RSP: 002b:00007f5348896c58 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 000000000072bf00 RCX: 0000000000462589
RDX: 0000000020000000 RSI: 000000004028700f RDI: 0000000000000003
RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f53488976bc
R13: 00000000004bf67e R14: 00000000006f96e0 R15: 00000000ffffffff
==========================================================================

Signed-off-by: Xuefeng Wang <wxf.wang@hisilicon.com>
---
 drivers/rtc/rtc-lib.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rtc/rtc-lib.c b/drivers/rtc/rtc-lib.c
index 4a3c0f3..a9db79f 100644
--- a/drivers/rtc/rtc-lib.c
+++ b/drivers/rtc/rtc-lib.c
@@ -100,6 +100,7 @@ int rtc_valid_tm(struct rtc_time *tm)
 	if (tm->tm_year < 70
 		|| ((unsigned)tm->tm_mon) >= 12
 		|| tm->tm_mday < 1
+		|| tm->tm_year > (INT_MAX - 1900)
 		|| tm->tm_mday > rtc_month_days(tm->tm_mon, tm->tm_year + 1900)
 		|| ((unsigned)tm->tm_hour) >= 24
 		|| ((unsigned)tm->tm_min) >= 60
-- 
1.7.12.4

