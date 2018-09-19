Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D986C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 14:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 059682086E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 14:26:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="x8UvyJI3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 059682086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732278AbeISUES (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 16:04:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:49836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732215AbeISUES (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 16:04:18 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE78621523;
        Wed, 19 Sep 2018 14:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537367168;
        bh=eWf3hV08MRCxTJNm9ukz318C2N3G0yC4Z9st7Az+FCc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x8UvyJI3Jubf9VU8GwYDHrEYBZsQDiT2db9edIp+qm7IOcjwAMN/GQL1vruptKVfr
         fBrCiT64+wDMdVFle9p1zSEcFgPdXS0LDubQpWKzjEvFKNCsMk4VsyGfhAHh052h1S
         5jWKaLoaMKo4CqWXQHe3zemQ1y9zjg3l7qDb3E9c=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Ding Xiang <dingxiang@cmss.chinamobile.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 06/13] perf bpf-loader: use PTR_ERR_OR_ZERO inetead of return code
Date:   Wed, 19 Sep 2018 11:25:30 -0300
Message-Id: <20180919142537.29985-7-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180919142537.29985-1-acme@kernel.org>
References: <20180919142537.29985-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ding Xiang <dingxiang@cmss.chinamobile.com>

Use PTR_ERR_OR_ZERO() in bpf__setup_stdout() return code instead of open
coded equivalent.

Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1536284082-23466-2-git-send-email-dingxiang@cmss.chinamobile.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/bpf-loader.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
index 47aac41349a2..f9ae1a993806 100644
--- a/tools/perf/util/bpf-loader.c
+++ b/tools/perf/util/bpf-loader.c
@@ -1615,7 +1615,7 @@ struct perf_evsel *bpf__setup_output_event(struct perf_evlist *evlist, const cha
 int bpf__setup_stdout(struct perf_evlist *evlist)
 {
 	struct perf_evsel *evsel = bpf__setup_output_event(evlist, "__bpf_stdout__");
-	return IS_ERR(evsel) ? PTR_ERR(evsel) : 0;
+	return PTR_ERR_OR_ZERO(evsel);
 }
 
 #define ERRNO_OFFSET(e)		((e) - __BPF_LOADER_ERRNO__START)
-- 
2.14.4

