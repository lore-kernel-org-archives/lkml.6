Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39ACDC64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2EBD2146F
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544131654;
	bh=2pd8yOeeINGdtZQjAq4z0CPkZ4XYFqeZHLnJAl/EQeo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AkxlSIsz5IjjK4A92j2jPbsBHSiUseBej6Xm6Rx4yCHomMpn0An0jmtMyDgEEyNhv
	 9cKINK1wl4H3oLG+1nx/nilWc4rzwknIDprs7iHcM320UohU+lfuDuCbAOlTxB5UpR
	 rQsxqeguRAN6tXS++zdAwMGbVkWSLpgfdR5QAQFw=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2EBD2146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbeLFV1d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 16:27:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:46270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726148AbeLFV1c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 16:27:32 -0500
Received: from quaco.ghostprotocols.net (179.187.13.223.dynamic.adsl.gvt.net.br [179.187.13.223])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8779A2146D;
        Thu,  6 Dec 2018 21:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544131651;
        bh=2pd8yOeeINGdtZQjAq4z0CPkZ4XYFqeZHLnJAl/EQeo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y0uzy/ci4VCNDepMJWgXJa4bu5Y2WJa64zOLfZrD4hVnna7ceiX4Y8N7mAy8Kly2V
         hYjR3/ivQQdhbfD4GEUja6W7BzxEOdPKVuMDhlgp4hu+f9oBvzCW3EUEW1DSa1QnK5
         bGUZI/GSK8/thr2WjzdpEjpJh05yiKhCvBRmzflo=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Wen Yang <wen.yang99@zte.com.cn>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Wen Yang <yellowriver2010@hotmail.com>,
        zhong.weidong@zte.com.cn,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 14/75] perf bpf: Use ERR_CAST instead of ERR_PTR(PTR_ERR())
Date:   Thu,  6 Dec 2018 18:25:01 -0300
Message-Id: <20181206212602.20474-15-acme@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206212602.20474-1-acme@kernel.org>
References: <20181206212602.20474-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wen Yang <wen.yang99@zte.com.cn>

Use ERR_CAST inlined function instead of ERR_PTR(PTR_ERR(...)).  This
makes it more readable and also fix this warning detected by
err_cast.cocci:

  tools/perf/util/bpf-loader.c:1606:11-18: WARNING: ERR_CAST can be used with op

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Julia Lawall <julia.lawall@lip6.fr>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wen Yang <yellowriver2010@hotmail.com>
Cc: zhong.weidong@zte.com.cn
Link: http://lkml.kernel.org/r/20181127090610.28488-1-wen.yang99@zte.com.cn
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/bpf-loader.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
index f9ae1a993806..9a280647d829 100644
--- a/tools/perf/util/bpf-loader.c
+++ b/tools/perf/util/bpf-loader.c
@@ -1603,7 +1603,7 @@ struct perf_evsel *bpf__setup_output_event(struct perf_evlist *evlist, const cha
 
 			op = bpf_map__add_newop(map, NULL);
 			if (IS_ERR(op))
-				return ERR_PTR(PTR_ERR(op));
+				return ERR_CAST(op);
 			op->op_type = BPF_MAP_OP_SET_EVSEL;
 			op->v.evsel = evsel;
 		}
-- 
2.19.2

