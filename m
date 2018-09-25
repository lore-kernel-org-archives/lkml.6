Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E0F1C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F327720877
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:29:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F327720877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728790AbeIYPgP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 11:36:15 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46231 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbeIYPgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 11:36:15 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8P9RsIO3385692
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 25 Sep 2018 02:27:54 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8P9Rsbp3385689;
        Tue, 25 Sep 2018 02:27:54 -0700
Date:   Tue, 25 Sep 2018 02:27:54 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Alexander Shishkin <tipbot@zytor.com>
Message-ID: <tip-1627314fb54a33ebd23bd08f2e215eaed0f44712@git.kernel.org>
Cc:     markus.t.metzger@intel.com, will.deacon@arm.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org, hpa@zytor.com,
        alexander.shishkin@linux.intel.com, mingo@kernel.org,
        peterz@infradead.org, acme@redhat.com, adrian.hunter@intel.com
Reply-To: markus.t.metzger@intel.com, will.deacon@arm.com,
          mingo@kernel.org, peterz@infradead.org, acme@redhat.com,
          linux-kernel@vger.kernel.org, tglx@linutronix.de,
          alexander.shishkin@linux.intel.com, hpa@zytor.com,
          adrian.hunter@intel.com
In-Reply-To: <20180404145323.28651-1-alexander.shishkin@linux.intel.com>
References: <20180404145323.28651-1-alexander.shishkin@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf: Suppress AUX/OVERWRITE records
Git-Commit-ID: 1627314fb54a33ebd23bd08f2e215eaed0f44712
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

Commit-ID:  1627314fb54a33ebd23bd08f2e215eaed0f44712
Gitweb:     https://git.kernel.org/tip/1627314fb54a33ebd23bd08f2e215eaed0f44712
Author:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
AuthorDate: Wed, 4 Apr 2018 17:53:23 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 18 Sep 2018 17:21:13 -0300

perf: Suppress AUX/OVERWRITE records

It has been pointed out to me many times that it is useful to be able to
switch off AUX records to save the bandwidth for records that actually
matter, for example, in AUX overwrite mode.

The usefulness of PERF_RECORD_AUX is in some of its flags, like the
TRUNCATED flag that tells the decoder where exactly gaps in the trace
are.  The OVERWRITE flag, on the other hand will be set on every single
record in overwrite mode. However, a PERF_RECORD_AUX[flags=OVERWRITE] is
generated on every target task's sched_out, which over time adds up to a
lot of useless information.

If any folks out there have userspace that depends on a constant stream
of OVERWRITE records for a good reason, they'll have to let us know.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Acked-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Acked-by: Will Deacon <will.deacon@arm.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Markus T Metzger <markus.t.metzger@intel.com>
Link: http://lkml.kernel.org/r/20180404145323.28651-1-alexander.shishkin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 kernel/events/ring_buffer.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 5d3cf407e374..4a9937076331 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -459,10 +459,20 @@ void perf_aux_output_end(struct perf_output_handle *handle, unsigned long size)
 	if (size || handle->aux_flags) {
 		/*
 		 * Only send RECORD_AUX if we have something useful to communicate
+		 *
+		 * Note: the OVERWRITE records by themselves are not considered
+		 * useful, as they don't communicate any *new* information,
+		 * aside from the short-lived offset, that becomes history at
+		 * the next event sched-in and therefore isn't useful.
+		 * The userspace that needs to copy out AUX data in overwrite
+		 * mode should know to use user_page::aux_head for the actual
+		 * offset. So, from now on we don't output AUX records that
+		 * have *only* OVERWRITE flag set.
 		 */
 
-		perf_event_aux_event(handle->event, aux_head, size,
-		                     handle->aux_flags);
+		if (handle->aux_flags & ~(u64)PERF_AUX_FLAG_OVERWRITE)
+			perf_event_aux_event(handle->event, aux_head, size,
+			                     handle->aux_flags);
 	}
 
 	rb->user_page->aux_head = rb->aux_head;
