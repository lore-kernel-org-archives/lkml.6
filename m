Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C8DC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 04:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75E8D2173D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 04:44:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qyy2vrIS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75E8D2173D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728499AbeI1LGE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 07:06:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:57472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726106AbeI1LGE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 07:06:04 -0400
Received: from localhost (c-71-202-137-17.hsd1.ca.comcast.net [71.202.137.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED5BD2170E;
        Fri, 28 Sep 2018 04:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538109855;
        bh=auUKGtk9R4m16ZE0rC/nI6N0K0OKYQT6FN/1Q+NhGZI=;
        h=From:To:Cc:Subject:Date:From;
        b=Qyy2vrISg8VJPpEsp9nCG3l/uFYvKRGMXgzYkuFvbXR0HS04ajnFt3A406SDZE94x
         hzOVRZeck4eLgKRhgZ79HunrsztY+5vzZFFfx6qHUTU+C5Lk1Ef6klON2q/Z10W4S7
         29Eta/nJZzaW8bklIv4sTe83O88wwc/H0HXAROVE=
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>, linux-s390@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Finn Thain <fthain@telegraphics.com.au>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] futex: Set USER_DS for the futex_detect_cmpxchg() test
Date:   Thu, 27 Sep 2018 21:44:13 -0700
Message-Id: <74fb6ce22f62e0fb48b91ca9918b74cedbcecaf1.1538096323.git.luto@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

futex_detect_cmpxchg() checks whether cmpxchg is available by trying
it on the NULL pointer and seeing what the error code is (EFAULT vs
ENOSYS).  This happens with KERNEL_DS set, which is impolite: while
the NULL *user* pointer is definitely invalid when there is no user
program running, the NULL *kernel* pointer seems more like a
programming error than a safe place to do an intentionally-failing
access.  An upcoming hardening series I'm working on causes the
existing code to OOPS, because it considers any failed uaccess with
KERNEL_DS to be a sign of a bug.

Explicitly set USER_DS to avoid this problem.

Cc: linux-s390@vger.kernel.org
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Finn Thain <fthain@telegraphics.com.au>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
---

I have a couple questions here:

 - Is this actually okay on all architectures?  That is, are there
   cases where we'll screw up if we fail a USER_DS access this early?
   s390 stands out as the obvious special case (where USER_DS is not
   than just a subset of KERNEL_DS), but s390 opts out.

 - Why doesn't x86 set HAVE_FUTEX_CMPXCHG?  Or do we still support
   some 32-bit configurations that don't have cmpxchg and don't know
   about it at compile time?

 kernel/futex.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/futex.c b/kernel/futex.c
index 11fc3bb456d6..16bd3e72602a 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -3593,6 +3593,7 @@ static void __init futex_detect_cmpxchg(void)
 {
 #ifndef CONFIG_HAVE_FUTEX_CMPXCHG
 	u32 curval;
+	mm_segment_t old_seg;
 
 	/*
 	 * This will fail and we want it. Some arch implementations do
@@ -3604,8 +3605,11 @@ static void __init futex_detect_cmpxchg(void)
 	 * implementation, the non-functional ones will return
 	 * -ENOSYS.
 	 */
+	old_seg = get_fs();
+	set_fs(USER_DS);
 	if (cmpxchg_futex_value_locked(&curval, NULL, 0, 0) == -EFAULT)
 		futex_cmpxchg_enabled = 1;
+	set_fs(old_seg);
 #endif
 }
 
-- 
2.17.1

