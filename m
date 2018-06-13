Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 88004C5CFF1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 01:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4642B20660
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 01:05:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4642B20660
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935243AbeFMBFh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 21:05:37 -0400
Received: from mga14.intel.com ([192.55.52.115]:64691 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933390AbeFMBBg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 21:01:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jun 2018 18:01:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,216,1526367600"; 
   d="scan'208";a="47283478"
Received: from voyager.sc.intel.com ([10.3.52.149])
  by fmsmga008.fm.intel.com with ESMTP; 12 Jun 2018 18:01:32 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     Andi Kleen <andi.kleen@intel.com>, Ashok Raj <ashok.raj@intel.com>,
        Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>, x86@kernel.org,
        sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@intel.com>,
        Clemens Ladisch <clemens@ladisch.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        iommu@lists.linux-foundation.org
Subject: [RFC PATCH 08/23] x86/hpet: Calculate ticks-per-second in a separate function
Date:   Tue, 12 Jun 2018 17:57:28 -0700
Message-Id: <1528851463-21140-9-git-send-email-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
References: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
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

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Andi Kleen <andi.kleen@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Jacob Pan <jacob.jun.pan@intel.com>
Cc: Clemens Ladisch <clemens@ladisch.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: x86@kernel.org
Cc: iommu@lists.linux-foundation.org
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
 drivers/char/hpet.c  | 31 +++++++++++++++++++++++++------
 include/linux/hpet.h |  1 +
 2 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/char/hpet.c b/drivers/char/hpet.c
index be426eb..1c9584a 100644
--- a/drivers/char/hpet.c
+++ b/drivers/char/hpet.c
@@ -838,6 +838,29 @@ static unsigned long hpet_calibrate(struct hpets *hpetp)
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
@@ -847,7 +870,6 @@ int hpet_alloc(struct hpet_data *hdp)
 	size_t siz;
 	struct hpet __iomem *hpet;
 	static struct hpets *last;
-	unsigned long period;
 	unsigned long long temp;
 	u32 remainder;
 
@@ -883,6 +905,8 @@ int hpet_alloc(struct hpet_data *hdp)
 
 	cap = readq(&hpet->hpet_cap);
 
+	temp = hpet_get_ticks_per_sec(cap);
+
 	ntimer = ((cap & HPET_NUM_TIM_CAP_MASK) >> HPET_NUM_TIM_CAP_SHIFT) + 1;
 
 	if (hpetp->hp_ntimer != ntimer) {
@@ -899,11 +923,6 @@ int hpet_alloc(struct hpet_data *hdp)
 
 	last = hpetp;
 
-	period = (cap & HPET_COUNTER_CLK_PERIOD_MASK) >>
-		HPET_COUNTER_CLK_PERIOD_SHIFT; /* fs, 10^-15 */
-	temp = 1000000000000000uLL; /* 10^15 femtoseconds per second */
-	temp += period >> 1; /* round */
-	do_div(temp, period);
 	hpetp->hp_tick_freq = temp; /* ticks per second */
 
 	printk(KERN_INFO "hpet%d: at MMIO 0x%lx, IRQ%s",
diff --git a/include/linux/hpet.h b/include/linux/hpet.h
index 8604564..e7b36bcf4 100644
--- a/include/linux/hpet.h
+++ b/include/linux/hpet.h
@@ -107,5 +107,6 @@ static inline void hpet_reserve_timer(struct hpet_data *hd, int timer)
 }
 
 int hpet_alloc(struct hpet_data *);
+u64 hpet_get_ticks_per_sec(u64 hpet_caps);
 
 #endif				/* !__HPET__ */
-- 
2.7.4

