Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECF8AECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 19:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABA8720671
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 19:38:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABA8720671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731799AbeGTU2c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 16:28:32 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42187 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731492AbeGTU2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 16:28:31 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6KJb7EE2769209
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 20 Jul 2018 12:37:07 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6KJb7ug2769206;
        Fri, 20 Jul 2018 12:37:07 -0700
Date:   Fri, 20 Jul 2018 12:37:07 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Joerg Roedel <tipbot@zytor.com>
Message-ID: <tip-cdbaf0a372db2bc3c3127e8b63fd15bd6e6757ee@git.kernel.org>
Cc:     will.deacon@arm.com, acme@kernel.org, namhyung@kernel.org,
        jpoimboe@redhat.com, jgross@suse.com, bp@alien8.de,
        dhgutteridge@sympatico.ca, pavel@ucw.cz, David.Laight@aculab.com,
        boris.ostrovsky@oracle.com, gregkh@linuxfoundation.org,
        jolsa@redhat.com, brgerst@gmail.com, jkosina@suse.cz,
        eduval@amazon.com, aarcange@redhat.com,
        torvalds@linux-foundation.org, alexander.shishkin@linux.intel.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com, luto@kernel.org,
        peterz@infradead.org, mingo@kernel.org, tglx@linutronix.de,
        dvlasenk@redhat.com, jroedel@suse.de, llong@redhat.com,
        dave.hansen@intel.com
Reply-To: luto@kernel.org, hpa@zytor.com, peterz@infradead.org,
          jroedel@suse.de, dvlasenk@redhat.com, tglx@linutronix.de,
          mingo@kernel.org, dave.hansen@intel.com, llong@redhat.com,
          jkosina@suse.cz, jolsa@redhat.com, brgerst@gmail.com,
          eduval@amazon.com, torvalds@linux-foundation.org,
          aarcange@redhat.com, alexander.shishkin@linux.intel.com,
          linux-kernel@vger.kernel.org, bp@alien8.de,
          dhgutteridge@sympatico.ca, pavel@ucw.cz, David.Laight@aculab.com,
          gregkh@linuxfoundation.org, boris.ostrovsky@oracle.com,
          acme@kernel.org, will.deacon@arm.com, namhyung@kernel.org,
          jgross@suse.com, jpoimboe@redhat.com
In-Reply-To: <1532103744-31902-2-git-send-email-joro@8bytes.org>
References: <1532103744-31902-2-git-send-email-joro@8bytes.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] perf/core: Make sure the ring-buffer is mapped in all
 page-tables
Git-Commit-ID: cdbaf0a372db2bc3c3127e8b63fd15bd6e6757ee
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

Commit-ID:  cdbaf0a372db2bc3c3127e8b63fd15bd6e6757ee
Gitweb:     https://git.kernel.org/tip/cdbaf0a372db2bc3c3127e8b63fd15bd6e6757ee
Author:     Joerg Roedel <jroedel@suse.de>
AuthorDate: Fri, 20 Jul 2018 18:22:22 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 20 Jul 2018 21:32:08 +0200

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
 kernel/events/ring_buffer.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 5d3cf407e374..7b0e9aafafdf 100644
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
