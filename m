Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06AB3C10F19
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C820220866
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550955874;
	bh=ZE4JoFFvwR9Ffvm8mq7Aezvmh0cYz1AquUeXkrA9KTM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ckQjTTXHG59FaagVCZ1AFUbHz8A9VtWAq6K2QvFlvml69tp5KKBeC/vF89D5zowmK
	 ZGgYTPFTea667OGV9uVXp/EDFjyx8z9mzQTQIRWku3kJgCjjr+03FzJMH+JmGyly2Q
	 Tep0b4c1ueQiqQYkiE1t2pI2DiWGGM9D6qZC0KYY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbfBWVEb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 16:04:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:39616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727959AbfBWVEa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 16:04:30 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14BA320657;
        Sat, 23 Feb 2019 21:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550955870;
        bh=ZE4JoFFvwR9Ffvm8mq7Aezvmh0cYz1AquUeXkrA9KTM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D0l1TT0DgvE/5bNa0qG+d4otLVozOuwxZOE1JZAyKvthCfroedDRuyXOg9E4JeeUl
         T90pHBavSV5v5LS3MKyadpjFnkVSECx0KEjwA1AIZCl1zov2DpUO2stJBdbLGa/lOM
         GhnJ0YU1R/hQAVEoPpXNSW121TDBnkjRQ4BZkXT0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 04/72] perf ordered_events: Fix crash in ordered_events__free
Date:   Sat, 23 Feb 2019 16:03:14 -0500
Message-Id: <20190223210422.199966-4-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190223210422.199966-1-sashal@kernel.org>
References: <20190223210422.199966-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

[ Upstream commit 99d86c8b88393e29cf07c020585f2c8afbcdd97d ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/ordered-events.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/ordered-events.c b/tools/perf/util/ordered-events.c
index 1904e7f6ec84d..77126a5fa9b69 100644
--- a/tools/perf/util/ordered-events.c
+++ b/tools/perf/util/ordered-events.c
@@ -359,8 +359,10 @@ void ordered_events__free(struct ordered_events *oe)
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
-- 
2.19.1

