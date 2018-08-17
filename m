Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 532DEC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 12:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19B9E20C0C
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 12:09:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19B9E20C0C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=softrans.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbeHQPM6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 11:12:58 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:43451 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726280AbeHQPM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 11:12:58 -0400
Received: from smtp.starsoftware.com.au (n175-33-133-183.meb2.vic.optusnet.com.au [175.33.133.183])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTP id 72FFA104D72D
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 22:09:44 +1000 (AEST)
Received: from virtux64.softrans.com.au (unknown [192.168.0.6])
        by smtp.starsoftware.com.au (Postfix) with ESMTP id 3600F677E164;
        Fri, 17 Aug 2018 22:09:44 +1000 (AEST)
Received: by virtux64.softrans.com.au (Postfix, from userid 1000)
        id 2A36A18E01A1; Fri, 17 Aug 2018 22:09:44 +1000 (AEST)
From:   Matt Rickard <matt@softrans.com.au>
Subject: [RESEND PATCH] x86/vdso: Handle clock_gettime(CLOCK_TAI) in vDSO
To:     Matt Rickard <matt@softrans.com.au>
CC:     LKML <linux-kernel@vger.kernel.org>
Message-Id: <20180817120944.2A36A18E01A1@virtux64.softrans.com.au>
Date:   Fri, 17 Aug 2018 22:09:44 +1000 (AEST)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=FNpr/6gs c=1 sm=1 tr=0
        a=0SUgGFgJIhXJJGNlngNSLg==:117 a=0SUgGFgJIhXJJGNlngNSLg==:17
        a=dapMudl6Dx4A:10 a=PIVNZ80yAAAA:8 a=qvPKsAL-236YqDqrpyAA:9
        a=3YJQTRF3V1zcZZCg0gjL:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Process clock_gettime(CLOCK_TAI) in vDSO. This makes the call about as fast as
CLOCK_REALTIME instead of taking about four times as long.

Signed-off-by: Matt Rickard <matt@softrans.com.au>
---
 arch/x86/entry/vdso/vclock_gettime.c    | 25 +++++++++++++++++++++++++
 arch/x86/entry/vsyscall/vsyscall_gtod.c |  2 ++
 arch/x86/include/asm/vgtod.h            |  1 +
 3 files changed, 28 insertions(+)

diff --git a/arch/x86/entry/vdso/vclock_gettime.c b/arch/x86/entry/vdso/vclock_gettime.c
index f19856d95c60..91ed1bb2a3bb 100644
--- a/arch/x86/entry/vdso/vclock_gettime.c
+++ b/arch/x86/entry/vdso/vclock_gettime.c
@@ -246,6 +246,27 @@ notrace static int __always_inline do_monotonic(struct timespec *ts)
 	return mode;
 }
 
+notrace static int __always_inline do_tai(struct timespec *ts)
+{
+	unsigned long seq;
+	u64 ns;
+	int mode;
+
+	do {
+		seq = gtod_read_begin(gtod);
+		mode = gtod->vclock_mode;
+		ts->tv_sec = gtod->tai_time_sec;
+		ns = gtod->wall_time_snsec;
+		ns += vgetsns(&mode);
+		ns >>= gtod->shift;
+	} while (unlikely(gtod_read_retry(gtod, seq)));
+
+	ts->tv_sec += __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
+	ts->tv_nsec = ns;
+
+	return mode;
+}
+
 notrace static void do_realtime_coarse(struct timespec *ts)
 {
 	unsigned long seq;
@@ -277,6 +298,10 @@ notrace int __vdso_clock_gettime(clockid_t clock, struct timespec *ts)
 		if (do_monotonic(ts) == VCLOCK_NONE)
 			goto fallback;
 		break;
+	case CLOCK_TAI:
+		if (do_tai(ts) == VCLOCK_NONE)
+			goto fallback;
+		break;
 	case CLOCK_REALTIME_COARSE:
 		do_realtime_coarse(ts);
 		break;
diff --git a/arch/x86/entry/vsyscall/vsyscall_gtod.c b/arch/x86/entry/vsyscall/vsyscall_gtod.c
index e1216dd95c04..d61392fe17f6 100644
--- a/arch/x86/entry/vsyscall/vsyscall_gtod.c
+++ b/arch/x86/entry/vsyscall/vsyscall_gtod.c
@@ -53,6 +53,8 @@ void update_vsyscall(struct timekeeper *tk)
 	vdata->monotonic_time_snsec	= tk->tkr_mono.xtime_nsec
 					+ ((u64)tk->wall_to_monotonic.tv_nsec
 						<< tk->tkr_mono.shift);
+	vdata->tai_time_sec	        = tk->xtime_sec
+					+ tk->tai_offset;
 	while (vdata->monotonic_time_snsec >=
 					(((u64)NSEC_PER_SEC) << tk->tkr_mono.shift)) {
 		vdata->monotonic_time_snsec -=
diff --git a/arch/x86/include/asm/vgtod.h b/arch/x86/include/asm/vgtod.h
index fb856c9f0449..adc9f7b20b9c 100644
--- a/arch/x86/include/asm/vgtod.h
+++ b/arch/x86/include/asm/vgtod.h
@@ -32,6 +32,7 @@ struct vsyscall_gtod_data {
 	gtod_long_t	wall_time_coarse_nsec;
 	gtod_long_t	monotonic_time_coarse_sec;
 	gtod_long_t	monotonic_time_coarse_nsec;
+	gtod_long_t	tai_time_sec;
 
 	int		tz_minuteswest;
 	int		tz_dsttime;
