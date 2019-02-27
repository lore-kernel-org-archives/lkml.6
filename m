Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F702C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 16:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35ED0217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 16:06:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730258AbfB0QGp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 11:06:45 -0500
Received: from mga01.intel.com ([192.55.52.88]:6599 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729287AbfB0QFp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 11:05:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Feb 2019 08:05:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,420,1544515200"; 
   d="scan'208";a="303011631"
Received: from unknown (HELO luv-build.sc.intel.com) ([172.25.110.25])
  by orsmga005.jf.intel.com with ESMTP; 27 Feb 2019 08:05:42 -0800
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>
Cc:     Ashok Raj <ashok.raj@intel.com>, Andi Kleen <andi.kleen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri@intel.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
        Clemens Ladisch <clemens@ladisch.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [RFC PATCH v2 03/14] x86/hpet: Calculate ticks-per-second in a separate function
Date:   Wed, 27 Feb 2019 08:05:07 -0800
Message-Id: <1551283518-18922-4-git-send-email-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551283518-18922-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
References: <1551283518-18922-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is easier to compute the expiration times of an HPET timer by using
its frequency (i.e., the number of times it ticks in a second) than its
period, as given in the capabilities register.

In addition to the HPET char driver, the HPET-based hardlockup detector
will also need to know the timer's frequency. Thus, create a common
function that both can use.

Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Andi Kleen <andi.kleen@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Clemens Ladisch <clemens@ladisch.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: x86@kernel.org
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
 drivers/char/hpet.c  | 31 +++++++++++++++++++++++++------
 include/linux/hpet.h |  1 +
 2 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/char/hpet.c b/drivers/char/hpet.c
index 4a22b4b41aef..b73b68c0e127 100644
--- a/drivers/char/hpet.c
+++ b/drivers/char/hpet.c
@@ -836,6 +836,29 @@ static unsigned long hpet_calibrate(struct hpets *hpetp)
 	return ret;
 }
 
+u64 hpet_get_ticks_per_sec(u64 hpet_caps)
+{
+	u64 ticks_per_sec, period;
+
+	period = (hpet_caps & HPET_COUNTER_CLK_PERIOD_MASK) >>
+		 HPET_COUNTER_CLK_PERIOD_SHIFT; /* fs, 10^-15 */
+
+	/*
+	 * The frequency is the reciprocal of the period. The period is given
+	 * femtoseconds per second. Thus, prepare a dividend to obtain the
+	 * frequency in ticks per second.
+	 */
+
+	/* 10^15 femtoseconds per second */
+	ticks_per_sec = 1000000000000000uLL;
+	ticks_per_sec += period >> 1; /* round */
+
+	/* The quotient is put in the dividend. We drop the remainder. */
+	do_div(ticks_per_sec, period);
+
+	return ticks_per_sec;
+}
+
 int hpet_alloc(struct hpet_data *hdp)
 {
 	u64 cap, mcfg;
@@ -845,7 +868,6 @@ int hpet_alloc(struct hpet_data *hdp)
 	size_t siz;
 	struct hpet __iomem *hpet;
 	static struct hpets *last;
-	unsigned long period;
 	unsigned long long temp;
 	u32 remainder;
 
@@ -881,6 +903,8 @@ int hpet_alloc(struct hpet_data *hdp)
 
 	cap = readq(&hpet->hpet_cap);
 
+	temp = hpet_get_ticks_per_sec(cap);
+
 	ntimer = ((cap & HPET_NUM_TIM_CAP_MASK) >> HPET_NUM_TIM_CAP_SHIFT) + 1;
 
 	if (hpetp->hp_ntimer != ntimer) {
@@ -897,11 +921,6 @@ int hpet_alloc(struct hpet_data *hdp)
 
 	last = hpetp;
 
-	period = (cap & HPET_COUNTER_CLK_PERIOD_MASK) >>
-		HPET_COUNTER_CLK_PERIOD_SHIFT; /* fs, 10^-15 */
-	temp = 1000000000000000uLL; /* 10^15 femtoseconds per second */
-	temp += period >> 1; /* round */
-	do_div(temp, period);
 	hpetp->hp_tick_freq = temp; /* ticks per second */
 
 	printk(KERN_INFO "hpet%d: at MMIO 0x%lx, IRQ%s",
diff --git a/include/linux/hpet.h b/include/linux/hpet.h
index 8604564b985d..e7b36bcf4699 100644
--- a/include/linux/hpet.h
+++ b/include/linux/hpet.h
@@ -107,5 +107,6 @@ static inline void hpet_reserve_timer(struct hpet_data *hd, int timer)
 }
 
 int hpet_alloc(struct hpet_data *);
+u64 hpet_get_ticks_per_sec(u64 hpet_caps);
 
 #endif				/* !__HPET__ */
-- 
2.17.1

