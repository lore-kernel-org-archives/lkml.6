Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B83C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 10:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FB592146F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 10:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545992309;
	bh=yCWmwWaEhFtogSzEM/QLTajVT9XB3H3QnFVCBnxgGpU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LvIRCJVdfydXWtpGX565Vwbq/orOlPo1m9jWGzO6aje7AZy+kkbALzd9paxvEVNCa
	 f8xi+mF5zJPfD1eSs46ltCpH2XJifIQVvO01JfXB+awrVgBMncrTGJpon54wCqEoAl
	 kqrHDZReA64b4AB/E8rcxX9ByVa485rlwGBsj7MM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732021AbeL1KS2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 05:18:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34716 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732007AbeL1KS2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 05:18:28 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D8C147AEAF;
        Fri, 28 Dec 2018 10:18:27 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-97.brq.redhat.com [10.40.204.97])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A6114600C8;
        Fri, 28 Dec 2018 10:18:25 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Joe Mario <jmario@redhat.com>
Subject: [PATCH 2/2] perf c2c: Increase the HITM ratio limit for displayed cachelines
Date:   Fri, 28 Dec 2018 11:18:20 +0100
Message-Id: <20181228101820.28010-2-jolsa@kernel.org>
In-Reply-To: <20181228101820.28010-1-jolsa@kernel.org>
References: <20181228101820.28010-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Fri, 28 Dec 2018 10:18:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cachelines being reported go down to 0.05%.  hat makes for very
long output files. Raising that to 0.1%.  The user can always specify
--show-all if they want all the cachelines.

Suggested-by: Joe Mario <jmario@redhat.com>
Link: http://lkml.kernel.org/n/tip-uwxpd36jutygit56mycanwma@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-c2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 321687f8f373..30584cb44fb7 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -1878,7 +1878,7 @@ static int c2c_hists__reinit(struct c2c_hists *c2c_hists,
 	return hpp_list__parse(&c2c_hists->list, output, sort);
 }
 
-#define DISPLAY_LINE_LIMIT  0.0005
+#define DISPLAY_LINE_LIMIT  0.001
 
 static bool he__display(struct hist_entry *he, struct c2c_stats *stats)
 {
-- 
2.17.2

