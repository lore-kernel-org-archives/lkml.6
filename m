Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EFE0C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 08:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFD4A20652
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 08:28:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFD4A20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728485AbeJEP0c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 11:26:32 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35171 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728389AbeJEP0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 11:26:31 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w958SYT93071711
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 5 Oct 2018 01:28:34 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w958SXo33071707;
        Fri, 5 Oct 2018 01:28:33 -0700
Date:   Fri, 5 Oct 2018 01:28:33 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andy Lutomirski <tipbot@zytor.com>
Message-ID: <tip-bcc4a62a73cb65327d7268fbfa3a786d603f52dc@git.kernel.org>
Cc:     mingo@kernel.org, tglx@linutronix.de, luto@kernel.org,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        peterz@infradead.org, hpa@zytor.com
Reply-To: peterz@infradead.org, hpa@zytor.com,
          torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
          luto@kernel.org, tglx@linutronix.de, mingo@kernel.org
In-Reply-To: <f66f53d81150bbad47d7b282c9207a71a3ce1c16.1538689401.git.luto@kernel.org>
References: <f66f53d81150bbad47d7b282c9207a71a3ce1c16.1538689401.git.luto@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/vdso] x86/vdso: Document vgtod_ts better
Git-Commit-ID: bcc4a62a73cb65327d7268fbfa3a786d603f52dc
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

Commit-ID:  bcc4a62a73cb65327d7268fbfa3a786d603f52dc
Gitweb:     https://git.kernel.org/tip/bcc4a62a73cb65327d7268fbfa3a786d603f52dc
Author:     Andy Lutomirski <luto@kernel.org>
AuthorDate: Thu, 4 Oct 2018 14:44:45 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 5 Oct 2018 10:12:18 +0200

x86/vdso: Document vgtod_ts better

After reading do_hres() and do_course() and scratching my head a
bit, I figured out why the arithmetic is strange.  Document it.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/f66f53d81150bbad47d7b282c9207a71a3ce1c16.1538689401.git.luto@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/vgtod.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/x86/include/asm/vgtod.h b/arch/x86/include/asm/vgtod.h
index d17b092b9f1b..69d05c6d47f5 100644
--- a/arch/x86/include/asm/vgtod.h
+++ b/arch/x86/include/asm/vgtod.h
@@ -13,6 +13,15 @@ typedef u64 gtod_long_t;
 typedef unsigned long gtod_long_t;
 #endif
 
+/*
+ * There is one of these objects in the vvar page for each
+ * vDSO-accelerated clockid.  For high-resolution clocks, this encodes
+ * the time corresponding to vsyscall_gtod_data.cycle_last.  For coarse
+ * clocks, this encodes the actual time.
+ *
+ * To confuse the reader, for high-resolution clocks, nsec is left-shifted
+ * by vsyscall_gtod_data.shift.
+ */
 struct vgtod_ts {
 	u64		sec;
 	u64		nsec;
