Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5052AC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 10:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17A4B2146F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 10:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545992307;
	bh=F2AZwl/RI3MNguQ8I8AnHXquPn/rnAtpolVv6JFm56M=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=bNzhB74RKmDZUUTBNF9MwLWOsxLzr2epgbIdLUyi37u51ACE2UKjK/v+dlxPXahUu
	 PxgxhAnwx3ZW9Zc/7648e8CsiHUZU7vzjthSPSbZZCBKHB9hFlZRSjG/uo1byEdrUF
	 7DTY8wTL9cqO8WFe2hevPFFLrgOb0kqhj3wWVD3s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732005AbeL1KSZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 05:18:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41282 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730509AbeL1KSZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 05:18:25 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 333F7804F8;
        Fri, 28 Dec 2018 10:18:25 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-97.brq.redhat.com [10.40.204.97])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 93790600C8;
        Fri, 28 Dec 2018 10:18:21 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Joe Mario <jmario@redhat.com>
Subject: [PATCH 1/2] perf c2c: Change the default coalesce setup
Date:   Fri, 28 Dec 2018 11:18:19 +0100
Message-Id: <20181228101820.28010-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Fri, 28 Dec 2018 10:18:25 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Joe suggested to have the coalesce default set just to 'iaddr',
because it's easier to read on the (default) c2c report run.

By removing pid from -c option, the c2c report will group all
the relevant pids under instruction address bucket. User can
always run -c pid,iaddr for more grained output on particular
pids.

Suggested-by: Joe Mario <jmario@redhat.com>
Link: http://lkml.kernel.org/n/tip-lk53c7y9fadu53spuzsn6cij@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-c2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 686fb60a8e11..321687f8f373 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -68,7 +68,7 @@ struct c2c_hist_entry {
 	struct hist_entry	he;
 };
 
-static char const *coalesce_default = "pid,iaddr";
+static char const *coalesce_default = "iaddr";
 
 struct perf_c2c {
 	struct perf_tool	tool;
-- 
2.17.2

