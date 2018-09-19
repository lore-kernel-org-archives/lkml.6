Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F371ECE565
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 14:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1962C2150E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 14:25:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vArZZ3OL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1962C2150E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732145AbeISUED (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 16:04:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:49352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727825AbeISUEB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 16:04:01 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C40E52151C;
        Wed, 19 Sep 2018 14:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537367151;
        bh=WlSYqcMRXjlr9gBN0f6nuhLW/Q54bekTEMFzkiC+o6Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vArZZ3OLkNu5aBvyG8O1mZtEv2jlRQwr0Qpq0bdDeexDJKN+266X/Wx6pGeiaKB9t
         wdpQ6URHgkXQg8I5sxfllgQyWirsDIjjkprLf5NVbmSRQurc7PpLlawpCJvj0mHpVt
         uZnALwlob2+I3/6+ZegNe2AB9mfYvax1CeeqnGsk=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Markus T Metzger <markus.t.metzger@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 01/13] perf: Suppress AUX/OVERWRITE records
Date:   Wed, 19 Sep 2018 11:25:25 -0300
Message-Id: <20180919142537.29985-2-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180919142537.29985-1-acme@kernel.org>
References: <20180919142537.29985-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Shishkin <alexander.shishkin@linux.intel.com>

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
-- 
2.14.4

