Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3243DC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 15:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF39220882
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 15:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="pQwHZjV+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF39220882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729160AbeGYRAh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 13:00:37 -0400
Received: from 8bytes.org ([81.169.241.247]:40166 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728503AbeGYRAg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 13:00:36 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id A25381EB; Wed, 25 Jul 2018 17:48:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=8bytes.org; s=mail-1;
        t=1532533699; bh=ykRHdAWzkL9irMORgQ3yCGBj8VygOYQR3zKjFy1te0g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pQwHZjV+Hsuy/UbgSaVcSi+/79PBz/0jUAGxon4xT3VYFfAELiMBFwtdhiEFS3k1I
         SaCSLOQLHLrxHDMlUeepWNNwDcka98DxxWd6GSKwnHJDTz8DMnYK1AoY5op7DdlSTT
         cZ9Utz6IpkmJIbUo2jerBINddG4/P489XP228bM3tPjkPs5KZ7ZBwj7ybO/DwwIc6Q
         IBS/g3pxjlfkCDp9HXcX9udwzhbODpSQ03oqGyEwDpOPkaZVS0f979VnKR9JrjSo/X
         o/NJcYMrEIJJsMJo23ZVTsVHhYvMPTUQT5btkkVSJjUVLTDW7u0yarxS2d4fT0a0MX
         Ml+mp/m7n1wmw==
From:   Joerg Roedel <joro@8bytes.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Brian Gerst <brgerst@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Eduardo Valentin <eduval@amazon.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Will Deacon <will.deacon@arm.com>, aliguori@amazon.com,
        daniel.gruss@iaik.tugraz.at, hughd@google.com, keescook@google.com,
        Andrea Arcangeli <aarcange@redhat.com>,
        Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        "David H . Gutteridge" <dhgutteridge@sympatico.ca>,
        jroedel@suse.de, Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>, joro@8bytes.org
Subject: [PATCH 2/3] Revert "perf/core: Make sure the ring-buffer is mapped in all page-tables"
Date:   Wed, 25 Jul 2018 17:48:02 +0200
Message-Id: <1532533683-5988-3-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1532533683-5988-1-git-send-email-joro@8bytes.org>
References: <1532533683-5988-1-git-send-email-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

This reverts commit 77754cfa09a6c528c38cbca9ee4cc4f7cf6ad6f2.

The patch was necessary to silence a WARN_ON_ONCE(in_nmi())
that triggered in the vmalloc_fault() function when PTI was
enabled on x86-32.

Faulting in an NMI handler turned out to be safe and the
warning in vmalloc_fault() is gone now. So the above patch
can be reverted.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 kernel/events/ring_buffer.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index df2d8cf..5d3cf40 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -814,13 +814,6 @@ static void rb_free_work(struct work_struct *work)
 
 	vfree(base);
 	kfree(rb);
-
-	/*
-	 * FIXME: PAE workaround for vmalloc_fault(): Make sure buffer is
-	 * unmapped in all page-tables.
-	 */
-	if (IS_ENABLED(CONFIG_X86_PAE))
-		vmalloc_sync_all();
 }
 
 void rb_free(struct ring_buffer *rb)
@@ -847,15 +840,6 @@ struct ring_buffer *rb_alloc(int nr_pages, long watermark, int cpu, int flags)
 	if (!all_buf)
 		goto fail_all_buf;
 
-	/*
-	 * FIXME: PAE workaround for vmalloc_fault(): The buffer is
-	 * accessed in NMI handlers, make sure it is mapped in all
-	 * page-tables in the system so that we don't fault on the range in
-	 * an NMI handler.
-	 */
-	if (IS_ENABLED(CONFIG_X86_PAE))
-		vmalloc_sync_all();
-
 	rb->user_page = all_buf;
 	rb->data_pages[0] = all_buf + PAGE_SIZE;
 	if (nr_pages) {
-- 
2.7.4

