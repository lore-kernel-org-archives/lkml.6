Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 122BCECDFB3
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 23:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA94020840
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 23:32:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA94020840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbeGOX4m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 19:56:42 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34483 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbeGOX4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 19:56:42 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6FNVgEF921819
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 15 Jul 2018 16:31:42 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6FNVgJG921816;
        Sun, 15 Jul 2018 16:31:42 -0700
Date:   Sun, 15 Jul 2018 16:31:42 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Dan Williams <tipbot@zytor.com>
Message-ID: <tip-ca146f6f091e47b3fd18d6a7e76ec0297d202e0f@git.kernel.org>
Cc:     mingo@kernel.org, luto@amacapital.net, peterz@infradead.org,
        tony.luck@intel.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
        ross.zwisler@linux.intel.com, dan.j.williams@intel.com,
        torvalds@linux-foundation.org, bp@alien8.de,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        tglx@linutronix.de
Reply-To: tglx@linutronix.de, akpm@linux-foundation.org, bp@alien8.de,
          viro@zeniv.linux.org.uk, dan.j.williams@intel.com,
          torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
          ross.zwisler@linux.intel.com, tony.luck@intel.com, hpa@zytor.com,
          peterz@infradead.org, mingo@kernel.org, luto@amacapital.net
In-Reply-To: <153108277278.37979.3327916996902264102.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <153108277278.37979.3327916996902264102.stgit@dwillia2-desk3.amr.corp.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/urgent] lib/iov_iter: Fix pipe handling in
 _copy_to_iter_mcsafe()
Git-Commit-ID: ca146f6f091e47b3fd18d6a7e76ec0297d202e0f
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

Commit-ID:  ca146f6f091e47b3fd18d6a7e76ec0297d202e0f
Gitweb:     https://git.kernel.org/tip/ca146f6f091e47b3fd18d6a7e76ec0297d202e0f
Author:     Dan Williams <dan.j.williams@intel.com>
AuthorDate: Sun, 8 Jul 2018 13:46:12 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 16 Jul 2018 00:05:05 +0200

lib/iov_iter: Fix pipe handling in _copy_to_iter_mcsafe()

By mistake the ITER_PIPE early-exit / warning from copy_from_iter() was
cargo-culted in _copy_to_iter_mcsafe() rather than a machine-check-safe
version of copy_to_iter_pipe().

Implement copy_pipe_to_iter_mcsafe() being careful to return the
indication of short copies due to a CPU exception.

Without this regression-fix all splice reads to dax-mode files fail.

Reported-by: Ross Zwisler <ross.zwisler@linux.intel.com>
Tested-by: Ross Zwisler <ross.zwisler@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Acked-by: Al Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Luck <tony.luck@intel.com>
Fixes: 8780356ef630 ("x86/asm/memcpy_mcsafe: Define copy_to_iter_mcsafe()")
Link: http://lkml.kernel.org/r/153108277278.37979.3327916996902264102.stgit@dwillia2-desk3.amr.corp.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 lib/iov_iter.c | 37 +++++++++++++++++++++++++++++++++----
 1 file changed, 33 insertions(+), 4 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 09fb73ad9d54..8be175df3075 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -596,6 +596,37 @@ static unsigned long memcpy_mcsafe_to_page(struct page *page, size_t offset,
 	return ret;
 }
 
+static size_t copy_pipe_to_iter_mcsafe(const void *addr, size_t bytes,
+				struct iov_iter *i)
+{
+	struct pipe_inode_info *pipe = i->pipe;
+	size_t n, off, xfer = 0;
+	int idx;
+
+	if (!sanity(i))
+		return 0;
+
+	bytes = n = push_pipe(i, bytes, &idx, &off);
+	if (unlikely(!n))
+		return 0;
+	for ( ; n; idx = next_idx(idx, pipe), off = 0) {
+		size_t chunk = min_t(size_t, n, PAGE_SIZE - off);
+		unsigned long rem;
+
+		rem = memcpy_mcsafe_to_page(pipe->bufs[idx].page, off, addr,
+				chunk);
+		i->idx = idx;
+		i->iov_offset = off + chunk - rem;
+		xfer += chunk - rem;
+		if (rem)
+			break;
+		n -= chunk;
+		addr += chunk;
+	}
+	i->count -= xfer;
+	return xfer;
+}
+
 /**
  * _copy_to_iter_mcsafe - copy to user with source-read error exception handling
  * @addr: source kernel address
@@ -627,10 +658,8 @@ size_t _copy_to_iter_mcsafe(const void *addr, size_t bytes, struct iov_iter *i)
 	const char *from = addr;
 	unsigned long rem, curr_addr, s_addr = (unsigned long) addr;
 
-	if (unlikely(i->type & ITER_PIPE)) {
-		WARN_ON(1);
-		return 0;
-	}
+	if (unlikely(i->type & ITER_PIPE))
+		return copy_pipe_to_iter_mcsafe(addr, bytes, i);
 	if (iter_is_iovec(i))
 		might_fault();
 	iterate_and_advance(i, bytes, v,
