Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DEDEC6778A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 17:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA36F21527
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 17:05:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA36F21527
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932846AbeGGRFP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 13:05:15 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33235 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754220AbeGGRFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 13:05:14 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w67H42Km2094608
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 7 Jul 2018 10:04:02 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w67H429O2094599;
        Sat, 7 Jul 2018 10:04:02 -0700
Date:   Sat, 7 Jul 2018 10:04:02 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jann Horn <tipbot@zytor.com>
Message-ID: <tip-15279df6f26cf2013d713904b4a0c957ae8abb96@git.kernel.org>
Cc:     andriy.shevchenko@linux.intel.com, jannh@google.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org, hpa@zytor.com,
        tglx@linutronix.de
Reply-To: hpa@zytor.com, tglx@linutronix.de,
          andriy.shevchenko@linux.intel.com, jannh@google.com,
          linux-kernel@vger.kernel.org, mingo@kernel.org
In-Reply-To: <20180706215003.156702-1-jannh@google.com>
References: <20180706215003.156702-1-jannh@google.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/mtrr: Don't copy out-of-bounds data in
 mtrr_write
Git-Commit-ID: 15279df6f26cf2013d713904b4a0c957ae8abb96
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

Commit-ID:  15279df6f26cf2013d713904b4a0c957ae8abb96
Gitweb:     https://git.kernel.org/tip/15279df6f26cf2013d713904b4a0c957ae8abb96
Author:     Jann Horn <jannh@google.com>
AuthorDate: Fri, 6 Jul 2018 23:50:03 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 7 Jul 2018 18:58:41 +0200

x86/mtrr: Don't copy out-of-bounds data in mtrr_write

Don't access the provided buffer out of bounds - this can cause a kernel
out-of-bounds read when invoked through sys_splice() or other things that
use kernel_write()/__kernel_write().

Fixes: 7f8ec5a4f01a ("x86/mtrr: Convert to use strncpy_from_user() helper")
Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20180706215003.156702-1-jannh@google.com

---
 arch/x86/kernel/cpu/mtrr/if.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mtrr/if.c b/arch/x86/kernel/cpu/mtrr/if.c
index 4021d3859499..40eee6cc4124 100644
--- a/arch/x86/kernel/cpu/mtrr/if.c
+++ b/arch/x86/kernel/cpu/mtrr/if.c
@@ -106,7 +106,8 @@ mtrr_write(struct file *file, const char __user *buf, size_t len, loff_t * ppos)
 
 	memset(line, 0, LINE_SIZE);
 
-	length = strncpy_from_user(line, buf, LINE_SIZE - 1);
+	len = min_t(size_t, len, LINE_SIZE - 1);
+	length = strncpy_from_user(line, buf, len);
 	if (length < 0)
 		return length;
 
