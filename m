Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68848FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 12:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BAFF20882
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 12:52:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BAFF20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbeINSGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 14:06:22 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:49580 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728125AbeINSGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 14:06:21 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g0nZm-0005w0-QQ; Fri, 14 Sep 2018 14:51:58 +0200
Message-Id: <20180914125118.457665349@linutronix.de>
User-Agent: quilt/0.65
Date:   Fri, 14 Sep 2018 14:50:10 +0200
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
Subject: [patch 04/11] x86/vdso: Use unsigned int consistently for
 vsyscall_gtod_data::seq
References: <20180914125006.349747096@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=x86-vdso--Mintor-cleanups.patch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sequence count in vgtod_data is unsigned int, but the call sites use
unsigned long, which is a pointless exercise. Fix the call sites and
replace 'unsigned' with unsinged 'int' while at it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/entry/vdso/vclock_gettime.c |    8 ++++----
 arch/x86/include/asm/vgtod.h         |   10 +++++-----
 2 files changed, 9 insertions(+), 9 deletions(-)

--- a/arch/x86/entry/vdso/vclock_gettime.c
+++ b/arch/x86/entry/vdso/vclock_gettime.c
@@ -206,7 +206,7 @@ notrace static inline u64 vgetsns(int *m
 /* Code size doesn't matter (vdso is 4k anyway) and this is faster. */
 notrace static int __always_inline do_realtime(struct timespec *ts)
 {
-	unsigned long seq;
+	unsigned int seq;
 	u64 ns;
 	int mode;
 
@@ -227,7 +227,7 @@ notrace static int __always_inline do_re
 
 notrace static int __always_inline do_monotonic(struct timespec *ts)
 {
-	unsigned long seq;
+	unsigned int seq;
 	u64 ns;
 	int mode;
 
@@ -248,7 +248,7 @@ notrace static int __always_inline do_mo
 
 notrace static void do_realtime_coarse(struct timespec *ts)
 {
-	unsigned long seq;
+	unsigned int seq;
 	do {
 		seq = gtod_read_begin(gtod);
 		ts->tv_sec = gtod->wall_time_coarse_sec;
@@ -258,7 +258,7 @@ notrace static void do_realtime_coarse(s
 
 notrace static void do_monotonic_coarse(struct timespec *ts)
 {
-	unsigned long seq;
+	unsigned int seq;
 	do {
 		seq = gtod_read_begin(gtod);
 		ts->tv_sec = gtod->monotonic_time_coarse_sec;
--- a/arch/x86/include/asm/vgtod.h
+++ b/arch/x86/include/asm/vgtod.h
@@ -15,9 +15,9 @@ typedef unsigned long gtod_long_t;
  * so be carefull by modifying this structure.
  */
 struct vsyscall_gtod_data {
-	unsigned seq;
+	unsigned int seq;
 
-	int vclock_mode;
+	int	vclock_mode;
 	u64	cycle_last;
 	u64	mask;
 	u32	mult;
@@ -44,9 +44,9 @@ static inline bool vclock_was_used(int v
 	return READ_ONCE(vclocks_used) & (1 << vclock);
 }
 
-static inline unsigned gtod_read_begin(const struct vsyscall_gtod_data *s)
+static inline unsigned int gtod_read_begin(const struct vsyscall_gtod_data *s)
 {
-	unsigned ret;
+	unsigned int ret;
 
 repeat:
 	ret = READ_ONCE(s->seq);
@@ -59,7 +59,7 @@ static inline unsigned gtod_read_begin(c
 }
 
 static inline int gtod_read_retry(const struct vsyscall_gtod_data *s,
-					unsigned start)
+				  unsigned int start)
 {
 	smp_rmb();
 	return unlikely(s->seq != start);


