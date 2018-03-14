Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751840AbeCNXeW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 19:34:22 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35278 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751682AbeCNXeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 19:34:17 -0400
X-Google-Smtp-Source: AG47ELvfQcCVdV/jtPPrfag76HqZcOROb2Qvz28t8tYJ3N8KD1h0byDCZPpfdqk3WHnbu0CSn3uV7g==
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86: vdso: eliminate some redundant loads in update_vsyscall
Date: Thu, 15 Mar 2018 00:34:08 +0100
Message-Id: <20180314233408.30083-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Presumably due to -fno-strict-aliasing, gcc doesn't know that the
stores through vdata do not alter the value of tk->tkr_mono.shift. So
e.g. in the loop normalizing vdata->monotonic_time_snsec, gcc reloads
tk->tkr_mono.shift and recomputes the ((u64)NSEC_PER_SEC) <<
tk->tkr_mono.shift constant. While that loop is usually never entered,
so the constant is only used once, we might as well make the generated
code a little smaller and microscopically faster when we do enter the
loop. So make a local copy of shift and use that.

Do not do the assignment in the declaration, because there's another
shift operation (1 << vclock_mode) before we get to use the shift
variable, and there's no point in having gcc load it to some non-%ecx
register, or, on 32 bit, immediately spill it.

As a bonus, two awkward line breaks vanish. bloat-o-meter:

Function                                     old     new   delta
update_vsyscall                              480     398     -82 (i386)
update_vsyscall                              304     281     -23 (x86_64)

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
Other tricks are possible (reuse the initial monotonic_time
computation for the _coarse version, maybe alias
vdata->wall_time{,_coarse}_sec via a union (and rearrange to make sure
both are in the same cache line as their nsec buddy)), but I'm not
sure even this one is worth it.

arch/x86/entry/vsyscall/vsyscall_gtod.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/x86/entry/vsyscall/vsyscall_gtod.c b/arch/x86/entry/vsyscall/vsyscall_gtod.c
index e1216dd95c04..550447a43a50 100644
--- a/arch/x86/entry/vsyscall/vsyscall_gtod.c
+++ b/arch/x86/entry/vsyscall/vsyscall_gtod.c
@@ -31,6 +31,7 @@ void update_vsyscall(struct timekeeper *tk)
 {
 	int vclock_mode = tk->tkr_mono.clock->archdata.vclock_mode;
 	struct vsyscall_gtod_data *vdata = &vsyscall_gtod_data;
+	int shift;
 
 	/* Mark the new vclock used. */
 	BUILD_BUG_ON(VCLOCK_MAX >= 32);
@@ -43,7 +44,7 @@ void update_vsyscall(struct timekeeper *tk)
 	vdata->cycle_last	= tk->tkr_mono.cycle_last;
 	vdata->mask		= tk->tkr_mono.mask;
 	vdata->mult		= tk->tkr_mono.mult;
-	vdata->shift		= tk->tkr_mono.shift;
+	vdata->shift = shift 	= tk->tkr_mono.shift;
 
 	vdata->wall_time_sec		= tk->xtime_sec;
 	vdata->wall_time_snsec		= tk->tkr_mono.xtime_nsec;
@@ -52,17 +53,15 @@ void update_vsyscall(struct timekeeper *tk)
 					+ tk->wall_to_monotonic.tv_sec;
 	vdata->monotonic_time_snsec	= tk->tkr_mono.xtime_nsec
 					+ ((u64)tk->wall_to_monotonic.tv_nsec
-						<< tk->tkr_mono.shift);
-	while (vdata->monotonic_time_snsec >=
-					(((u64)NSEC_PER_SEC) << tk->tkr_mono.shift)) {
-		vdata->monotonic_time_snsec -=
-					((u64)NSEC_PER_SEC) << tk->tkr_mono.shift;
+						<< shift);
+	while (vdata->monotonic_time_snsec >= (((u64)NSEC_PER_SEC) << shift)) {
+		vdata->monotonic_time_snsec -= ((u64)NSEC_PER_SEC) << shift;
 		vdata->monotonic_time_sec++;
 	}
 
 	vdata->wall_time_coarse_sec	= tk->xtime_sec;
 	vdata->wall_time_coarse_nsec	= (long)(tk->tkr_mono.xtime_nsec >>
-						 tk->tkr_mono.shift);
+						 shift);
 
 	vdata->monotonic_time_coarse_sec =
 		vdata->wall_time_coarse_sec + tk->wall_to_monotonic.tv_sec;
-- 
2.15.1
