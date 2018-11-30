Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE6EC64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59B0E2146D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:27:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zcPS4NXI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59B0E2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbeLAFh6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 00:37:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:55826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727140AbeLAFh6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 00:37:58 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F35C32146F;
        Fri, 30 Nov 2018 18:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543602469;
        bh=uzT1hYDx8pnD8CLirNj4j+ITs922I2UHbZDprmE04Bo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zcPS4NXIn7jEDyhuL4MaTL1z8oKB9wRkdE9Vn1JfBpVc4G4RgKshcoKMaPdufbHTe
         6ibsPDCHEhnfLWcjn12bGvL03wEvEv3ovbsoo85CBdIAii4+hvb02GhKDnKW0AMaa0
         mbmakKNb4u/Fzw9qOmZfXAeOW990HoB8VOgN2J+E=
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
Subject: [PATCH 14/22] perf bpf: Use ERR_CAST instead of ERR_PTR(PTR_ERR())
Date:   Fri, 30 Nov 2018 15:26:44 -0300
Message-Id: <20181130182652.23620-15-acme@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181130182652.23620-1-acme@kernel.org>
References: <20181130182652.23620-1-acme@kernel.org>
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
2.19.1

