Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F78C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EF1D20675
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:44:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393261AbfBOJow (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 04:44:52 -0500
Received: from terminus.zytor.com ([198.137.202.136]:53421 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389363AbfBOJov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 04:44:51 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1F9iaOg1120550
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 15 Feb 2019 01:44:36 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1F9iZG61120546;
        Fri, 15 Feb 2019 01:44:35 -0800
Date:   Fri, 15 Feb 2019 01:44:35 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Mathieu Poirier <tipbot@zytor.com>
Message-ID: <tip-4b6df11ab6cf13c5babe9ed1a935cd99d50bf3fe@git.kernel.org>
Cc:     hpa@zytor.com, jolsa@redhat.com, mingo@kernel.org, acme@redhat.com,
        leo.yan@linaro.org, suzuki.poulose@arm.com, peterz@infradead.org,
        tglx@linutronix.de, mathieu.poirier@linaro.org,
        linux-kernel@vger.kernel.org
Reply-To: leo.yan@linaro.org, suzuki.poulose@arm.com, peterz@infradead.org,
          tglx@linutronix.de, mathieu.poirier@linaro.org,
          linux-kernel@vger.kernel.org, hpa@zytor.com, jolsa@redhat.com,
          mingo@kernel.org, acme@redhat.com
In-Reply-To: <20190212171618.25355-10-mathieu.poirier@linaro.org>
References: <20190212171618.25355-10-mathieu.poirier@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf cs-etm: Rethink kernel address initialisation
Git-Commit-ID: 4b6df11ab6cf13c5babe9ed1a935cd99d50bf3fe
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

Commit-ID:  4b6df11ab6cf13c5babe9ed1a935cd99d50bf3fe
Gitweb:     https://git.kernel.org/tip/4b6df11ab6cf13c5babe9ed1a935cd99d50bf3fe
Author:     Mathieu Poirier <mathieu.poirier@linaro.org>
AuthorDate: Tue, 12 Feb 2019 10:16:14 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 14 Feb 2019 15:18:07 -0300

perf cs-etm: Rethink kernel address initialisation

Moving initialisation of the kernel start address to function
cs_etm__setup_queues(), considered to be the common denominator for
queue initialisation.  That way we don't have to repeat the same code
at different places.

No change of functionatlity is introduced by this patch.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Suzuki K Poulouse <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/20190212171618.25355-10-mathieu.poirier@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index c9a5b4935209..2d2de898ea68 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -523,6 +523,9 @@ static int cs_etm__setup_queues(struct cs_etm_auxtrace *etm)
 	unsigned int i;
 	int ret;
 
+	if (!etm->kernel_start)
+		etm->kernel_start = machine__kernel_start(etm->machine);
+
 	for (i = 0; i < etm->queues.nr_queues; i++) {
 		ret = cs_etm__setup_queue(etm, &etm->queues.queue_array[i], i);
 		if (ret)
@@ -1490,14 +1493,10 @@ static int cs_etm__set_sample_flags(struct cs_etm_queue *etmq)
 
 static int cs_etm__run_decoder(struct cs_etm_queue *etmq)
 {
-	struct cs_etm_auxtrace *etm = etmq->etm;
 	struct cs_etm_buffer buffer;
 	size_t buffer_used, processed;
 	int err = 0;
 
-	if (!etm->kernel_start)
-		etm->kernel_start = machine__kernel_start(etm->machine);
-
 	/* Go through each buffer in the queue and decode them one by one */
 	while (1) {
 		buffer_used = 0;
