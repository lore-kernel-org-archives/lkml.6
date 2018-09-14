Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 800D2ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 12:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 422FF20881
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 12:52:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 422FF20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728399AbeINSGy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 14:06:54 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:49588 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728100AbeINSGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 14:06:22 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g0nZo-0005wI-20; Fri, 14 Sep 2018 14:52:00 +0200
Message-Id: <20180914125118.658760051@linutronix.de>
User-Agent: quilt/0.65
Date:   Fri, 14 Sep 2018 14:50:12 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Matt Rickard <matt@softrans.com.au>,
        Stephen Boyd <sboyd@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Florian Weimer <fweimer@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        devel@linuxdriverproject.org,
        virtualization@lists.linux-foundation.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Juergen Gross <jgross@suse.com>
Subject: [patch 06/11] x86/vdso: Collapse high resolution functions
References: <20180914125006.349747096@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline;
 filename=x86-vdso--Collapse-high-res-functions.patch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

do_realtime() and do_monotonic() are now the same except for the storage
array index. Hand the index in as an argument and collapse the functions.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/entry/vdso/vclock_gettime.c |   35 +++++++----------------------------
 1 file changed, 7 insertions(+), 28 deletions(-)

--- a/arch/x86/entry/vdso/vclock_gettime.c
+++ b/arch/x86/entry/vdso/vclock_gettime.c
@@ -203,35 +203,12 @@ notrace static inline u64 vgetsns(int *m
 	return v * gtod->mult;
 }
 
-/* Code size doesn't matter (vdso is 4k anyway) and this is faster. */
-notrace static int __always_inline do_realtime(struct timespec *ts)
+notrace static int do_hres(clockid_t clk, struct timespec *ts)
 {
-	struct vgtod_ts *base = &gtod->basetime[CLOCK_REALTIME];
+	struct vgtod_ts *base = &gtod->basetime[clk];
 	unsigned int seq;
-	u64 ns;
 	int mode;
-
-	do {
-		seq = gtod_read_begin(gtod);
-		mode = gtod->vclock_mode;
-		ts->tv_sec = base->sec;
-		ns = base->nsec;
-		ns += vgetsns(&mode);
-		ns >>= gtod->shift;
-	} while (unlikely(gtod_read_retry(gtod, seq)));
-
-	ts->tv_sec += __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
-	ts->tv_nsec = ns;
-
-	return mode;
-}
-
-notrace static int __always_inline do_monotonic(struct timespec *ts)
-{
-	struct vgtod_ts *base = &gtod->basetime[CLOCK_MONOTONIC];
-	unsigned int seq;
 	u64 ns;
-	int mode;
 
 	do {
 		seq = gtod_read_begin(gtod);
@@ -276,11 +253,11 @@ notrace int __vdso_clock_gettime(clockid
 {
 	switch (clock) {
 	case CLOCK_REALTIME:
-		if (do_realtime(ts) == VCLOCK_NONE)
+		if (do_hres(CLOCK_REALTIME, ts) == VCLOCK_NONE)
 			goto fallback;
 		break;
 	case CLOCK_MONOTONIC:
-		if (do_monotonic(ts) == VCLOCK_NONE)
+		if (do_hres(CLOCK_MONOTONIC, ts) == VCLOCK_NONE)
 			goto fallback;
 		break;
 	case CLOCK_REALTIME_COARSE:
@@ -303,7 +280,9 @@ int clock_gettime(clockid_t, struct time
 notrace int __vdso_gettimeofday(struct timeval *tv, struct timezone *tz)
 {
 	if (likely(tv != NULL)) {
-		if (unlikely(do_realtime((struct timespec *)tv) == VCLOCK_NONE))
+		struct timespec *ts = (struct timespec *) tv;
+
+		if (unlikely(do_hres(CLOCK_REALTIME, ts) == VCLOCK_NONE))
 			return vdso_fallback_gtod(tv, tz);
 		tv->tv_usec /= 1000;
 	}


