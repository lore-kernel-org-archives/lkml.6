Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B75B8C43612
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8404F206BB
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546977013;
	bh=4enYwcjVLRZLoW9eHu6cMZAIioC6s1jBpogHG/w2YEA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZcMGK7GovfKxzK/YCAB0HmFJMatTKu+c0dTO7t1UJTVj5/uKftcYkpzghPxdGqNh9
	 Me9vwbzqkkxhHeF43GTaGkOJhXmOOoI4oF2GLttanjoYDus0YxRI+W2Bcbxtm73L2k
	 913r3sB0j9JVlfl7u5hY5Qi4gBZSup7Y7LyIuC4s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732835AbfAHTuN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:50:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:40080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731213AbfAHTbv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:31:51 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E56BE2176F;
        Tue,  8 Jan 2019 19:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546975911;
        bh=4enYwcjVLRZLoW9eHu6cMZAIioC6s1jBpogHG/w2YEA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A9xy1fcv6qDH8+E0clyfL4aH3R4yNI8Z52Vdm6QBfGGI/zWggzOl11YY/WIHcxBPP
         MYdplQJs9wc529CuwP6tm5jAkUBG7CnOrXMkwFN++1wTj3gIWNp9TaiCXzi2ZPxJFU
         /UwLEgeh+GI44OXJ+X3AWf+ebW5dxGmnrjBVHdE4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Mike Leach <mike.leach@linaro.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Robert Walker <robert.walker@arm.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 77/97] perf cs-etm: Correct packets swapping in cs_etm__flush()
Date:   Tue,  8 Jan 2019 14:29:26 -0500
Message-Id: <20190108192949.122407-77-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108192949.122407-1-sashal@kernel.org>
References: <20190108192949.122407-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leo Yan <leo.yan@linaro.org>

[ Upstream commit 43fd56669c28cd354e9228bdb58e4bca1c1a8b66 ]

The structure cs_etm_queue uses 'prev_packet' to point to previous
packet, this can be used to combine with new coming packet to generate
samples.

In function cs_etm__flush() it swaps packets only when the flag
'etm->synth_opts.last_branch' is true, this means that it will not swap
packets if without option '--itrace=il' to generate last branch entries;
thus for this case the 'prev_packet' doesn't point to the correct
previous packet and the stale packet still will be used to generate
sequential sample.  Thus if dump trace with 'perf script' command we can
see the incorrect flow with the stale packet's address info.

This patch corrects packets swapping in cs_etm__flush(); except using
the flag 'etm->synth_opts.last_branch' it also checks the another flag
'etm->sample_branches', if any flag is true then it swaps packets so can
save correct content to 'prev_packet'.  Finally this can fix the wrong
program flow dumping issue.

The patch has a minor refactoring to use 'etm->synth_opts.last_branch'
instead of 'etmq->etm->synth_opts.last_branch' for condition checking,
this is consistent with that is done in cs_etm__sample().

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Robert Walker <robert.walker@arm.com>
Cc: coresight@lists.linaro.org
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/1544513908-16805-2-git-send-email-leo.yan@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/cs-etm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index ca577658e890..7b5e15cc6b71 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1005,7 +1005,7 @@ static int cs_etm__flush(struct cs_etm_queue *etmq)
 	}
 
 swap_packet:
-	if (etmq->etm->synth_opts.last_branch) {
+	if (etm->sample_branches || etm->synth_opts.last_branch) {
 		/*
 		 * Swap PACKET with PREV_PACKET: PACKET becomes PREV_PACKET for
 		 * the next incoming packet.
-- 
2.19.1

