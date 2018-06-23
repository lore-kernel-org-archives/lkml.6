Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB83CC43142
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 12:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6201524BEA
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 12:31:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6201524BEA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752294AbeFWMb0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 08:31:26 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41319 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751869AbeFWMbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 08:31:25 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5NCVKWG468251
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 23 Jun 2018 05:31:20 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5NCVKus468248;
        Sat, 23 Jun 2018 05:31:20 -0700
Date:   Sat, 23 Jun 2018 05:31:20 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Kirill A. Shutemov" <tipbot@zytor.com>
Message-ID: <tip-2458e53ff74cd1063ed3e00459da1d35c559d369@git.kernel.org>
Cc:     mingo@kernel.org, kirill.shutemov@linux.intel.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, hpa@zytor.com
Reply-To: hpa@zytor.com, linux-kernel@vger.kernel.org, tglx@linutronix.de,
          kirill.shutemov@linux.intel.com, mingo@kernel.org
In-Reply-To: <20180622220841.54135-3-kirill.shutemov@linux.intel.com>
References: <20180622220841.54135-3-kirill.shutemov@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/mm: Fix 'no5lvl' handling
Git-Commit-ID: 2458e53ff74cd1063ed3e00459da1d35c559d369
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

Commit-ID:  2458e53ff74cd1063ed3e00459da1d35c559d369
Gitweb:     https://git.kernel.org/tip/2458e53ff74cd1063ed3e00459da1d35c559d369
Author:     Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate: Sat, 23 Jun 2018 01:08:41 +0300
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 23 Jun 2018 14:20:37 +0200

x86/mm: Fix 'no5lvl' handling

early_identify_cpu() has to use early version of pgtable_l5_enabled()
that doesn't rely on cpu_feature_enabled().

Defining USE_EARLY_PGTABLE_L5 before all includes does the trick.

I lost the define in one of reworks of the original patch.

Fixes: 372fddf70904 ("x86/mm: Introduce the 'no5lvl' kernel parameter")
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Link: https://lkml.kernel.org/r/20180622220841.54135-3-kirill.shutemov@linux.intel.com

---
 arch/x86/kernel/cpu/common.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 0df7151cfef4..eb4cb3efd20e 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1,3 +1,6 @@
+/* cpu_feature_enabled() cannot be used this early */
+#define USE_EARLY_PGTABLE_L5
+
 #include <linux/bootmem.h>
 #include <linux/linkage.h>
 #include <linux/bitops.h>
