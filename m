Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F682C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 21:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E52322084D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 21:45:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PC2g+B2q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E52322084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbeJEEke (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 00:40:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:38774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726570AbeJEEkd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 00:40:33 -0400
Received: from localhost (unknown [198.217.64.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 656F32084D;
        Thu,  4 Oct 2018 21:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538689515;
        bh=mQBzNNO4z/XWBj1Ua6nrwvXNMEsH6cSabZ5p6i2MJ8Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=PC2g+B2qaYLLgz7T8fprMLxmEjKOH02+lO9YSQnMXzyE5Cw56yl95KwIwMrDuA2xn
         kP+Zts2Qdnav7+yMK6j/bEYEzrZ2+ln6P47kaB6djHckjH9pUkq5zEjzTkDLFaY37H
         Sh6P91PgFwdg22np9KQcg+Vl6snS3vvVmSjM91eM=
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 2/3] x86/vdso: Rearrange do_hres() to improve code generation
Date:   Thu,  4 Oct 2018 14:44:44 -0700
Message-Id: <99e93a6be59916959ad259482f4cf347e8af9bac.1538689401.git.luto@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1538689401.git.luto@kernel.org>
References: <cover.1538689401.git.luto@kernel.org>
In-Reply-To: <cover.1538689401.git.luto@kernel.org>
References: <cover.1538689401.git.luto@kernel.org>
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
 arch/x86/entry/vdso/vclock_gettime.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/entry/vdso/vclock_gettime.c b/arch/x86/entry/vdso/vclock_gettime.c
index 18c8a78d1ec9..419de7552c2f 100644
--- a/arch/x86/entry/vdso/vclock_gettime.c
+++ b/arch/x86/entry/vdso/vclock_gettime.c
@@ -147,10 +147,9 @@ notrace static int do_hres(clockid_t clk, struct timespec *ts)
 
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
@@ -158,7 +157,7 @@ notrace static int do_hres(clockid_t clk, struct timespec *ts)
 		ns >>= gtod->shift;
 	} while (unlikely(gtod_read_retry(gtod, seq)));
 
-	ts->tv_sec += __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
+	ts->tv_sec = base->sec + __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
 	ts->tv_nsec = ns;
 
 	return 0;
-- 
2.17.1

