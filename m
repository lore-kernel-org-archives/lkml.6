Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6764FECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 20:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C05D20652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 20:38:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C05D20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728747AbeGTV1z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 17:27:55 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37993 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728396AbeGTV1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 17:27:54 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6KKasFm2784959
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 20 Jul 2018 13:36:54 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6KKaq2Q2784955;
        Fri, 20 Jul 2018 13:36:52 -0700
Date:   Fri, 20 Jul 2018 13:36:52 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Joerg Roedel <tipbot@zytor.com>
Message-ID: <tip-77754cfa09a6c528c38cbca9ee4cc4f7cf6ad6f2@git.kernel.org>
Cc:     brgerst@gmail.com, torvalds@linux-foundation.org, jroedel@suse.de,
        hpa@zytor.com, jkosina@suse.cz, acme@kernel.org,
        tglx@linutronix.de, eduval@amazon.com, jpoimboe@redhat.com,
        dhgutteridge@sympatico.ca, namhyung@kernel.org, llong@redhat.com,
        boris.ostrovsky@oracle.com, jolsa@redhat.com,
        dave.hansen@intel.com, mingo@kernel.org, bp@alien8.de,
        jgross@suse.com, luto@kernel.org, aarcange@redhat.com,
        dvlasenk@redhat.com, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, pavel@ucw.cz, will.deacon@arm.com,
        David.Laight@aculab.com, peterz@infradead.org,
        alexander.shishkin@linux.intel.com
Reply-To: dvlasenk@redhat.com, linux-kernel@vger.kernel.org,
          gregkh@linuxfoundation.org, pavel@ucw.cz, will.deacon@arm.com,
          David.Laight@aculab.com, peterz@infradead.org,
          alexander.shishkin@linux.intel.com, boris.ostrovsky@oracle.com,
          llong@redhat.com, jolsa@redhat.com, dave.hansen@intel.com,
          mingo@kernel.org, bp@alien8.de, jgross@suse.com, luto@kernel.org,
          aarcange@redhat.com, jpoimboe@redhat.com,
          dhgutteridge@sympatico.ca, namhyung@kernel.org,
          brgerst@gmail.com, torvalds@linux-foundation.org,
          jroedel@suse.de, hpa@zytor.com, jkosina@suse.cz, acme@kernel.org,
          eduval@amazon.com, tglx@linutronix.de
In-Reply-To: <1532103744-31902-2-git-send-email-joro@8bytes.org>
References: <1532103744-31902-2-git-send-email-joro@8bytes.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] perf/core: Make sure the ring-buffer is mapped in all
 page-tables
Git-Commit-ID: 77754cfa09a6c528c38cbca9ee4cc4f7cf6ad6f2
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

Commit-ID:  77754cfa09a6c528c38cbca9ee4cc4f7cf6ad6f2
Gitweb:     https://git.kernel.org/tip/77754cfa09a6c528c38cbca9ee4cc4f7cf6ad6f2
Author:     Joerg Roedel <jroedel@suse.de>
AuthorDate: Fri, 20 Jul 2018 18:22:22 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 20 Jul 2018 22:33:41 +0200

perf/core: Make sure the ring-buffer is mapped in all page-tables

The ring-buffer is accessed in the NMI handler, so it's better to avoid
faulting on it. Sync the vmalloc range with all page-tables in system to
make sure everyone has it mapped.

This fixes a WARN_ON_ONCE() that can be triggered with PTI enabled on
x86-32:

  WARNING: CPU: 4 PID: 0 at arch/x86/mm/fault.c:320 vmalloc_fault+0x220/0x230

This triggers because with PTI enabled on an PAE kernel the PMDs are no
longer shared between the page-tables, so the vmalloc changes do not
propagate automatically.

Note: Andy said rightfully that we should try to fix the vmalloc code for
that case, but that's not a hot fix for the issue at hand.

Fixes: 7757d607c6b3 ("x86/pti: Allow CONFIG_PAGE_TABLE_ISOLATION for x86_32")
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: linux-mm@kvack.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: David Laight <David.Laight@aculab.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: Eduardo Valentin <eduval@amazon.com>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: aliguori@amazon.com
Cc: daniel.gruss@iaik.tugraz.at
Cc: hughd@google.com
Cc: keescook@google.com
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Waiman Long <llong@redhat.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: "David H . Gutteridge" <dhgutteridge@sympatico.ca>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: joro@8bytes.org
Link: https://lkml.kernel.org/r/1532103744-31902-2-git-send-email-joro@8bytes.org

---
 kernel/events/ring_buffer.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 5d3cf407e374..df2d8cf0072c 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -814,6 +814,13 @@ static void rb_free_work(struct work_struct *work)
 
 	vfree(base);
 	kfree(rb);
+
+	/*
+	 * FIXME: PAE workaround for vmalloc_fault(): Make sure buffer is
+	 * unmapped in all page-tables.
+	 */
+	if (IS_ENABLED(CONFIG_X86_PAE))
+		vmalloc_sync_all();
 }
 
 void rb_free(struct ring_buffer *rb)
@@ -840,6 +847,15 @@ struct ring_buffer *rb_alloc(int nr_pages, long watermark, int cpu, int flags)
 	if (!all_buf)
 		goto fail_all_buf;
 
+	/*
+	 * FIXME: PAE workaround for vmalloc_fault(): The buffer is
+	 * accessed in NMI handlers, make sure it is mapped in all
+	 * page-tables in the system so that we don't fault on the range in
+	 * an NMI handler.
+	 */
+	if (IS_ENABLED(CONFIG_X86_PAE))
+		vmalloc_sync_all();
+
 	rb->user_page = all_buf;
 	rb->data_pages[0] = all_buf + PAGE_SIZE;
 	if (nr_pages) {
