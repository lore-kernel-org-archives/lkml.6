Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6160C3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 20:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CACD208AF
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 20:56:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CACD208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932834AbeGHU4G (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 16:56:06 -0400
Received: from mga05.intel.com ([192.55.52.43]:32021 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932162AbeGHU4F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 16:56:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jul 2018 13:56:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,327,1526367600"; 
   d="scan'208";a="65327802"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga003.jf.intel.com with ESMTP; 08 Jul 2018 13:56:05 -0700
Subject: [PATCH 2/4] lib/iov_iter: Document _copy_to_iter_flushcache()
From:   Dan Williams <dan.j.williams@intel.com>
To:     mingo@kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Date:   Sun, 08 Jul 2018 13:46:07 -0700
Message-ID: <153108276767.37979.9462477994086841699.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <153108275728.37979.14771120672220174225.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <153108275728.37979.14771120672220174225.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add some theory of operation documentation to _copy_to_iter_flushcache().

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Luck <tony.luck@intel.com>
Reported-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 lib/iov_iter.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 94fa361be7bb..09fb73ad9d54 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -727,6 +727,20 @@ size_t _copy_from_iter_nocache(void *addr, size_t bytes, struct iov_iter *i)
 EXPORT_SYMBOL(_copy_from_iter_nocache);
 
 #ifdef CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE
+/**
+ * _copy_from_iter_flushcache - write destination through cpu cache
+ * @addr: destination kernel address
+ * @bytes: total transfer length
+ * @iter: source iterator
+ *
+ * The pmem driver arranges for filesystem-dax to use this facility via
+ * dax_copy_from_iter() for ensuring that writes to persistent memory
+ * are flushed through the CPU cache. It is differentiated from
+ * _copy_from_iter_nocache() in that guarantees all data is flushed for
+ * all iterator types. The _copy_from_iter_nocache() only attempts to
+ * bypass the cache for the ITER_IOVEC case, and on some archs may use
+ * instructions that strand dirty-data in the cache.
+ */
 size_t _copy_from_iter_flushcache(void *addr, size_t bytes, struct iov_iter *i)
 {
 	char *to = addr;

