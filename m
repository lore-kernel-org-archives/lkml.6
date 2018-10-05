Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F66DC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 19:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA56320875
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 19:07:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA56320875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729223AbeJFCHC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 22:07:02 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52601 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728044AbeJFCHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 22:07:02 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w95J6qNY3256709
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 5 Oct 2018 12:06:52 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w95J6qvq3256706;
        Fri, 5 Oct 2018 12:06:52 -0700
Date:   Fri, 5 Oct 2018 12:06:52 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andy Lutomirski <tipbot@zytor.com>
Message-ID: <tip-99c19e6a8fe4a95fa0dac191207a1d40461b1604@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@kernel.org,
        luto@kernel.org, hpa@zytor.com
Reply-To: tglx@linutronix.de, mingo@kernel.org,
          linux-kernel@vger.kernel.org, hpa@zytor.com, luto@kernel.org
In-Reply-To: <3c05644d010b72216aa286a6d20b5078d5fae5cd.1538762487.git.luto@kernel.org>
References: <3c05644d010b72216aa286a6d20b5078d5fae5cd.1538762487.git.luto@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/vdso] x86/vdso: Rearrange do_hres() to improve code
 generation
Git-Commit-ID: 99c19e6a8fe4a95fa0dac191207a1d40461b1604
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  99c19e6a8fe4a95fa0dac191207a1d40461b1604
Gitweb:     https://git.kernel.org/tip/99c19e6a8fe4a95fa0dac191207a1d40461b1604
Author:     Andy Lutomirski <luto@kernel.org>
AuthorDate: Fri, 5 Oct 2018 11:02:43 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 5 Oct 2018 21:03:23 +0200

x86/vdso: Rearrange do_hres() to improve code generation

vgetcyc() is full of barriers, so fetching values out of the vvar
page before vgetcyc() for use after vgetcyc() results in poor code
generation.  Put vgetcyc() first to avoid this problem.

Also, pull the tv_sec division into the loop and put all the ts
writes together.  The old code wrote ts->tv_sec on each iteration
before the syscall fallback check and then added in the offset
afterwards, which forced the compiler to pointlessly copy base->sec
to ts->tv_sec on each iteration.  The new version seems to generate
sensible code.

Saves several cycles.  With this patch applied, the result is faster
than before the clock_gettime() rewrite.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/3c05644d010b72216aa286a6d20b5078d5fae5cd.1538762487.git.luto@kernel.org

---
 arch/x86/entry/vdso/vclock_gettime.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/x86/entry/vdso/vclock_gettime.c b/arch/x86/entry/vdso/vclock_gettime.c
index 18c8a78d1ec9..007b3fe9d727 100644
--- a/arch/x86/entry/vdso/vclock_gettime.c
+++ b/arch/x86/entry/vdso/vclock_gettime.c
@@ -142,23 +142,27 @@ notrace static inline u64 vgetcyc(int mode)
 notrace static int do_hres(clockid_t clk, struct timespec *ts)
 {
 	struct vgtod_ts *base = &gtod->basetime[clk];
-	u64 cycles, last, ns;
+	u64 cycles, last, sec, ns;
 	unsigned int seq;
 
 	do {
 		seq = gtod_read_begin(gtod);
-		ts->tv_sec = base->sec;
+		cycles = vgetcyc(gtod->vclock_mode);
 		ns = base->nsec;
 		last = gtod->cycle_last;
-		cycles = vgetcyc(gtod->vclock_mode);
 		if (unlikely((s64)cycles < 0))
 			return vdso_fallback_gettime(clk, ts);
 		if (cycles > last)
 			ns += (cycles - last) * gtod->mult;
 		ns >>= gtod->shift;
+		sec = base->sec;
 	} while (unlikely(gtod_read_retry(gtod, seq)));
 
-	ts->tv_sec += __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
+	/*
+	 * Do this outside the loop: a race inside the loop could result
+	 * in __iter_div_u64_rem() being extremely slow.
+	 */
+	ts->tv_sec = sec + __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
 	ts->tv_nsec = ns;
 
 	return 0;
