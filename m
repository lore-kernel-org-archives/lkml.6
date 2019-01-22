Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC1CFC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 11:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2B2820879
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 11:34:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbfAVLeU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 06:34:20 -0500
Received: from terminus.zytor.com ([198.137.202.136]:50411 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727755AbfAVLeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 06:34:19 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0MBXwdY2929472
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 22 Jan 2019 03:33:58 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0MBXwV62929469;
        Tue, 22 Jan 2019 03:33:58 -0800
Date:   Tue, 22 Jan 2019 03:33:58 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-99d86c8b88393e29cf07c020585f2c8afbcdd97d@git.kernel.org>
Cc:     hpa@zytor.com, mingo@kernel.org, peterz@infradead.org,
        eranian@google.com, jolsa@kernel.org, namhyung@kernel.org,
        alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
        acme@redhat.com, tglx@linutronix.de, liu.song.a23@gmail.com
Reply-To: jolsa@kernel.org, hpa@zytor.com, mingo@kernel.org,
          peterz@infradead.org, eranian@google.com,
          linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com,
          namhyung@kernel.org, liu.song.a23@gmail.com, acme@redhat.com,
          tglx@linutronix.de
In-Reply-To: <20190117113017.12977-1-jolsa@kernel.org>
References: <20190117113017.12977-1-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf ordered_events: Fix crash in
 ordered_events__free
Git-Commit-ID: 99d86c8b88393e29cf07c020585f2c8afbcdd97d
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

Commit-ID:  99d86c8b88393e29cf07c020585f2c8afbcdd97d
Gitweb:     https://git.kernel.org/tip/99d86c8b88393e29cf07c020585f2c8afbcdd97d
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Thu, 17 Jan 2019 12:30:17 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 17 Jan 2019 11:07:00 -0300

perf ordered_events: Fix crash in ordered_events__free

Song Liu reported crash in 'perf record':

  > #0  0x0000000000500055 in ordered_events(float, long double,...)(...) ()
  > #1  0x0000000000500196 in ordered_events.reinit ()
  > #2  0x00000000004fe413 in perf_session.process_events ()
  > #3  0x0000000000440431 in cmd_record ()
  > #4  0x00000000004a439f in run_builtin ()
  > #5  0x000000000042b3e5 in main ()"

This can happen when we get out of buffers during event processing.

The subsequent ordered_events__free() call assumes oe->buffer != NULL
and crashes. Add a check to prevent that.

Reported-by: Song Liu <liu.song.a23@gmail.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Reviewed-by: Song Liu <liu.song.a23@gmail.com>
Tested-by: Song Liu <liu.song.a23@gmail.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20190117113017.12977-1-jolsa@kernel.org
Fixes: d5ceb62b3654 ("perf ordered_events: Add 'struct ordered_events_buffer' layer")
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/ordered-events.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/ordered-events.c b/tools/perf/util/ordered-events.c
index 897589507d97..ea523d3b248f 100644
--- a/tools/perf/util/ordered-events.c
+++ b/tools/perf/util/ordered-events.c
@@ -391,8 +391,10 @@ void ordered_events__free(struct ordered_events *oe)
 	 * Current buffer might not have all the events allocated
 	 * yet, we need to free only allocated ones ...
 	 */
-	list_del(&oe->buffer->list);
-	ordered_events_buffer__free(oe->buffer, oe->buffer_idx, oe);
+	if (oe->buffer) {
+		list_del(&oe->buffer->list);
+		ordered_events_buffer__free(oe->buffer, oe->buffer_idx, oe);
+	}
 
 	/* ... and continue with the rest */
 	list_for_each_entry_safe(buffer, tmp, &oe->to_free, list) {
