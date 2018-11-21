Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F7EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 07:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD80420989
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 07:42:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD80420989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbeKUSPr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 13:15:47 -0500
Received: from out1.zte.com.cn ([202.103.147.172]:43892 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725999AbeKUSPr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 13:15:47 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id B911D9CA145E18F7F588;
        Wed, 21 Nov 2018 15:42:19 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id wAL7gBIT087733;
        Wed, 21 Nov 2018 15:42:11 +0800 (GMT-8)
        (envelope-from wen.yang99@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018112115423327-12071666 ;
          Wed, 21 Nov 2018 15:42:33 +0800 
From:   Wen Yang <wen.yang99@zte.com.cn>
To:     peterz@infradead.org
Cc:     mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, adrian.hunter@intel.com, ak@linux.intel.com,
        linux-kernel@vger.kernel.org, zhong.weidong@zte.com.cn,
        wang.yi59@zte.com.cn, Wen Yang <wen.yang99@zte.com.cn>,
        Julia Lawall <julia.lawall@lip6.fr>
Subject: [PATCH 4/4] perf intel-pt/bts: fix potential NULL pointer dereference in intel_bts_process_auxtrace_info
Date:   Wed, 21 Nov 2018 15:43:40 +0800
Message-Id: <1542786220-19338-1-git-send-email-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-11-21 15:42:33,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-11-21 15:42:03,
        Serialize complete at 2018-11-21 15:42:03
X-MAIL: mse01.zte.com.cn wAL7gBIT087733
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a possible null pointer dereference in
intel_bts_process_auxtrace_info, detected by the semantic patch
deref_null.cocci, with the following warning:

./tools/perf/util/intel-bts.c:921:32-49: ERROR: session -> itrace_synth_opts is NULL but dereferenced.

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Reviewed-by: Tan Hu <tan.hu@zte.com.cn>
CC: Julia Lawall <julia.lawall@lip6.fr>
---
 tools/perf/util/intel-bts.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/intel-bts.c b/tools/perf/util/intel-bts.c
index 7b27d77..b0258f4 100644
--- a/tools/perf/util/intel-bts.c
+++ b/tools/perf/util/intel-bts.c
@@ -917,7 +917,8 @@ int intel_bts_process_auxtrace_info(union perf_event *event,
 	if (session->itrace_synth_opts && session->itrace_synth_opts->set) {
 		bts->synth_opts = *session->itrace_synth_opts;
 	} else {
-		itrace_synth_opts__set_default(&bts->synth_opts,
+		if (session->itrace_synth_opts)
+			itrace_synth_opts__set_default(&bts->synth_opts,
 				session->itrace_synth_opts->default_no_sample);
 		if (session->itrace_synth_opts)
 			bts->synth_opts.thread_stack =
-- 
2.9.5

