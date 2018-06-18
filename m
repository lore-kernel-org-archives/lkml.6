Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A78C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8968208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:25:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8968208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965880AbeFRIZn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:25:43 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56682 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965842AbeFRIZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:25:38 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3E13CC9F;
        Mon, 18 Jun 2018 08:25:37 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Leo Yan <leo.yan@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-arm-kernel@lists.infradead.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 222/279] perf cs-etm: Support unknown_thread in cs_etm_auxtrace
Date:   Mon, 18 Jun 2018 10:13:27 +0200
Message-Id: <20180618080618.029319701@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618080608.851973560@linuxfoundation.org>
References: <20180618080608.851973560@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Leo Yan <leo.yan@linaro.org>

[ Upstream commit 46d53620044f7b574c0f3216f8b4f2ce3559ce31 ]

CoreSight doesn't allocate thread structure for unknown_thread in ETM
auxtrace, so unknown_thread is NULL pointer.  If the perf data doesn't
contain valid tid and then cs_etm__mem_access() uses unknown_thread
instead as thread handler, this results in a segmentation fault when
thread__find_addr_map() accesses the thread handler.

This commit creates a new thread data which is used by unknown_thread, so
CoreSight tracing can roll back to use unknown_thread if perf data
doesn't include valid thread info.  This commit also releases thread
data for initialization failure case and for normal auxtrace free flow.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/1525924920-4381-1-git-send-email-leo.yan@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/perf/util/cs-etm.c |   24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -212,6 +212,7 @@ static void cs_etm__free(struct perf_ses
 	for (i = 0; i < aux->num_cpu; i++)
 		zfree(&aux->metadata[i]);
 
+	thread__zput(aux->unknown_thread);
 	zfree(&aux->metadata);
 	zfree(&aux);
 }
@@ -980,6 +981,23 @@ int cs_etm__process_auxtrace_info(union
 	etm->auxtrace.free = cs_etm__free;
 	session->auxtrace = &etm->auxtrace;
 
+	etm->unknown_thread = thread__new(999999999, 999999999);
+	if (!etm->unknown_thread)
+		goto err_free_queues;
+
+	/*
+	 * Initialize list node so that at thread__zput() we can avoid
+	 * segmentation fault at list_del_init().
+	 */
+	INIT_LIST_HEAD(&etm->unknown_thread->node);
+
+	err = thread__set_comm(etm->unknown_thread, "unknown", 0);
+	if (err)
+		goto err_delete_thread;
+
+	if (thread__init_map_groups(etm->unknown_thread, etm->machine))
+		goto err_delete_thread;
+
 	if (dump_trace) {
 		cs_etm__print_auxtrace_info(auxtrace_info->priv, num_cpu);
 		return 0;
@@ -994,16 +1012,18 @@ int cs_etm__process_auxtrace_info(union
 
 	err = cs_etm__synth_events(etm, session);
 	if (err)
-		goto err_free_queues;
+		goto err_delete_thread;
 
 	err = auxtrace_queues__process_index(&etm->queues, session);
 	if (err)
-		goto err_free_queues;
+		goto err_delete_thread;
 
 	etm->data_queued = etm->queues.populated;
 
 	return 0;
 
+err_delete_thread:
+	thread__zput(etm->unknown_thread);
 err_free_queues:
 	auxtrace_queues__free(&etm->queues);
 	session->auxtrace = NULL;


