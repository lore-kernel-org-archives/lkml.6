Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DEBCC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 18:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF65C2064A
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 18:02:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mXIYtc0t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF65C2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728789AbeJFBCf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 21:02:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:34414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727941AbeJFBCe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 21:02:34 -0400
Received: from localhost (c-71-202-137-17.hsd1.ca.comcast.net [71.202.137.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2537D2064A;
        Fri,  5 Oct 2018 18:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538762565;
        bh=an+GhQYi9c/4jQ9PQutGRBz/WGwZmlIjwEqUrUgvL2c=;
        h=From:To:Cc:Subject:Date:From;
        b=mXIYtc0t3HoTi5aMslcJWgUPoLBL3lifhDTMWz4y8OlWwHiE29RnY1j4lz//Y0m0n
         DSi1SS/lDvggjucnkMl0XwVYNr6tDlGwI59yCpxhylxTVOnHHc4BDz4ZE8KiA9s0HS
         kVp9Nm/WKOc6xgdIKuo5bJfviDQCfYLofIknEYf4=
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v2] x86/vdso: Rearrange do_hres() to improve code generation
Date:   Fri,  5 Oct 2018 11:02:43 -0700
Message-Id: <3c05644d010b72216aa286a6d20b5078d5fae5cd.1538762487.git.luto@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---

v2: Fix the obvious race -- this doesn't appear to affect performance
    Thanks, tglx, for noticing it.

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
-- 
2.17.1

