Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F9D8ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 16:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A98A20652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 16:22:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="n6tSlkqW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A98A20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387941AbeGTRLl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 13:11:41 -0400
Received: from 8bytes.org ([81.169.241.247]:35772 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387899AbeGTRLk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 13:11:40 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 2C1D8257; Fri, 20 Jul 2018 18:22:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=8bytes.org; s=mail-1;
        t=1532103759; bh=Mf9lS0qkLiHNasS6CeFKKOwNfTQB9DBJzg6ADMqVxH0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n6tSlkqWtba2Ob6NAdePKpBAwofVcfKinGkae42J4H+DMR7xjvLdEJvnBdRhIvNY8
         3doxlalxMYfwfIbuSHi6ZxL/2iGtJ9+RFhNYNFxOjL7xWJaWG74p8GW8ySZbx4hUrs
         TEP4BAQ6bff2Ewk3KWjMU8R4uO9Pt7gbPdNp7daqGYTcdgEGQjavapIqhNovlS6au4
         SfvSllyLzaF29+Xj5Ga9oeXNmTrAkZtUvJSHb3GGAlYneXPJipz1vFdDklHkvByhb+
         2dxbN5QD+hLEiJ+DDbT3V8JKEsErznSKtLDBy3aYsLSRYzDgDAaunbDu/G6K/+ChTw
         y/1rjSlJgGgyQ==
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
Subject: [PATCH 1/3] perf/core: Make sure the ring-buffer is mapped in all page-tables
Date:   Fri, 20 Jul 2018 18:22:22 +0200
Message-Id: <1532103744-31902-2-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1532103744-31902-1-git-send-email-joro@8bytes.org>
References: <1532103744-31902-1-git-send-email-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

The ring-buffer is accessed in the NMI handler, so we better
avoid faulting on it. Sync the vmalloc range with all
page-tables in system to make sure everyone has it mapped.

This fixes a WARN_ON_ONCE() that can be triggered with PTI
enabled on x86-32:

	WARNING: CPU: 4 PID: 0 at arch/x86/mm/fault.c:320 vmalloc_fault+0x220/0x230

This triggers because with PTI enabled on an PAE kernel the
PMDs are no longer shared between the page-tables, so the
vmalloc changes do not propagate automatically.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 kernel/events/ring_buffer.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 5d3cf40..7b0e9aa 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -814,6 +814,9 @@ static void rb_free_work(struct work_struct *work)
 
 	vfree(base);
 	kfree(rb);
+
+	/* Make sure buffer is unmapped in all page-tables */
+	vmalloc_sync_all();
 }
 
 void rb_free(struct ring_buffer *rb)
@@ -840,6 +843,13 @@ struct ring_buffer *rb_alloc(int nr_pages, long watermark, int cpu, int flags)
 	if (!all_buf)
 		goto fail_all_buf;
 
+	/*
+	 * The buffer is accessed in NMI handlers, make sure it is
+	 * mapped in all page-tables in the system so that we don't
+	 * fault on the range in an NMI handler.
+	 */
+	vmalloc_sync_all();
+
 	rb->user_page = all_buf;
 	rb->data_pages[0] = all_buf + PAGE_SIZE;
 	if (nr_pages) {
-- 
2.7.4

