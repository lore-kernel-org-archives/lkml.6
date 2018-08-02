Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4CDBC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 854762145D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:13:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 854762145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731978AbeHBKD3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 06:03:29 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51885 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727354AbeHBKD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 06:03:29 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w728D49T3431312
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 2 Aug 2018 01:13:04 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w728D4KW3431309;
        Thu, 2 Aug 2018 01:13:04 -0700
Date:   Thu, 2 Aug 2018 01:13:04 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Leo Yan <tipbot@zytor.com>
Message-ID: <tip-3eb3e07bcfee0670d7142f839c76f33f3d265793@git.kernel.org>
Cc:     tglx@linutronix.de, kim.phillips@arm.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com, robert.walker@arm.com,
        jolsa@redhat.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, peterz@infradead.org, mike.leach@linaro.org,
        mathieu.poirier@linaro.org, leo.yan@linaro.org, acme@redhat.com,
        mingo@kernel.org
Reply-To: linux-kernel@vger.kernel.org, tglx@linutronix.de,
          kim.phillips@arm.com, robert.walker@arm.com,
          alexander.shishkin@linux.intel.com, jolsa@redhat.com,
          namhyung@kernel.org, hpa@zytor.com, peterz@infradead.org,
          mike.leach@linaro.org, acme@redhat.com, leo.yan@linaro.org,
          mingo@kernel.org, mathieu.poirier@linaro.org
In-Reply-To: <1531295145-596-4-git-send-email-leo.yan@linaro.org>
References: <1531295145-596-4-git-send-email-leo.yan@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf cs-etm: Fix start tracing packet handling
Git-Commit-ID: 3eb3e07bcfee0670d7142f839c76f33f3d265793
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

Commit-ID:  3eb3e07bcfee0670d7142f839c76f33f3d265793
Gitweb:     https://git.kernel.org/tip/3eb3e07bcfee0670d7142f839c76f33f3d265793
Author:     Leo Yan <leo.yan@linaro.org>
AuthorDate: Wed, 11 Jul 2018 15:45:42 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 31 Jul 2018 10:57:56 -0300

perf cs-etm: Fix start tracing packet handling

Usually the start tracing packet is a CS_ETM_TRACE_ON packet, this
packet is passed to cs_etm__flush();  cs_etm__flush() will check the
condition 'prev_packet->sample_type == CS_ETM_RANGE' but 'prev_packet'
is allocated by zalloc() so 'prev_packet->sample_type' is zero in
initialization and this condition is false.  So cs_etm__flush() will
directly bail out without handling the start tracing packet.

This patch is to introduce a new sample type CS_ETM_EMPTY, which is used
to indicate the packet is an empty packet.  cs_etm__flush() will swap
packets when it finds the previous packet is empty, so this can record
the start tracing packet into 'etmq->prev_packet'.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kim Phillips <kim.phillips@arm.com>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Robert Walker <robert.walker@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/1531295145-596-4-git-send-email-leo.yan@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.h |  1 +
 tools/perf/util/cs-etm.c                        | 19 ++++++++++++++++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
index 743f5f444304..612b5755f742 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
@@ -23,6 +23,7 @@ struct cs_etm_buffer {
 };
 
 enum cs_etm_sample_type {
+	CS_ETM_EMPTY = 0,
 	CS_ETM_RANGE = 1 << 0,
 	CS_ETM_TRACE_ON = 1 << 1,
 };
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 8b2c099e750a..ae7c9c880cb2 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -924,8 +924,14 @@ static int cs_etm__flush(struct cs_etm_queue *etmq)
 	int err = 0;
 	struct cs_etm_packet *tmp;
 
+	if (!etmq->prev_packet)
+		return 0;
+
+	/* Handle start tracing packet */
+	if (etmq->prev_packet->sample_type == CS_ETM_EMPTY)
+		goto swap_packet;
+
 	if (etmq->etm->synth_opts.last_branch &&
-	    etmq->prev_packet &&
 	    etmq->prev_packet->sample_type == CS_ETM_RANGE) {
 		/*
 		 * Generate a last branch event for the branches left in the
@@ -944,6 +950,10 @@ static int cs_etm__flush(struct cs_etm_queue *etmq)
 
 		etmq->period_instructions = 0;
 
+	}
+
+swap_packet:
+	if (etmq->etm->synth_opts.last_branch) {
 		/*
 		 * Swap PACKET with PREV_PACKET: PACKET becomes PREV_PACKET for
 		 * the next incoming packet.
@@ -1023,6 +1033,13 @@ static int cs_etm__run_decoder(struct cs_etm_queue *etmq)
 					 */
 					cs_etm__flush(etmq);
 					break;
+				case CS_ETM_EMPTY:
+					/*
+					 * Should not receive empty packet,
+					 * report error.
+					 */
+					pr_err("CS ETM Trace: empty packet\n");
+					return -EINVAL;
 				default:
 					break;
 				}
