Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932098AbeDWQwa (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 12:52:30 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:55486 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755925AbeDWQwY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 12:52:24 -0400
From: Peng Hao <peng.hao2@zte.com.cn>
To: tglx@linutronix.de, pbonzini@redhat.com, mingo@redhat.com,
        x86@kernel.org, peterz@infradead.org, len.brown@intel.com
Cc: linux-kernel@vger.kernel.org, Peng Hao <peng.hao2@zte.com.cn>
Subject: [PATCH] x86: tsc: fix L2 guest always in tsc_early clocksource
Date: Tue, 24 Apr 2018 09:08:54 +0800
Message-Id: <1524532134-31408-1-git-send-email-peng.hao2@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-04-24 00:52:17,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-04-24 00:52:13,
        Serialize complete at 2018-04-24 00:52:13
X-MAIL: mse01.zte.com.cn w3NGqDsg023865
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In L2 guest tsc_read_refs always return ULLONG_MAX, and that will
call tsc_refine_calibration_work periodly. So L2 guest will read
acpi timer port 0x608 periodly.
The patch will let it out of "if(tsc_start == -1){}" infinite loop.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 arch/x86/kernel/tsc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index ef32297..828ef50 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1236,7 +1236,7 @@ struct system_counterval_t convert_art_ns_to_tsc(u64 art_ns)
  */
 static void tsc_refine_calibration_work(struct work_struct *work)
 {
-	static u64 tsc_start = -1, ref_start;
+	static u64 tsc_start = 0, ref_start;
 	static int hpet;
 	u64 tsc_stop, ref_stop, delta;
 	unsigned long freq;
@@ -1251,7 +1251,7 @@ static void tsc_refine_calibration_work(struct work_struct *work)
 	 * delayed the first time we expire. So set the workqueue
 	 * again once we know timers are working.
 	 */
-	if (tsc_start == -1) {
+	if (tsc_start == 0) {
 		/*
 		 * Only set hpet once, to avoid mixing hardware
 		 * if the hpet becomes enabled later.
-- 
1.8.3.1
