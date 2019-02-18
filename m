Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E94E0C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 11:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6BA820C01
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 11:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550489976;
	bh=+uH09RUwku0p/qABLzhZVQknZYm3YLcaVqlx6KVLB6s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0qDZx8zDXtfzGFP8NKYhAkDibcdFCfmLKEfxgH8VSumdBf+I1SGNbs5cM9tBqzglX
	 Nn034M90zqqpuqZC/2sXv2eyxu5DmkbApjnLNL5Ebl7Fcci3YI6cAQyMZ1l+zesbUv
	 ircEU88IUf7sqD+t/ArM6Sepv2cXAu41BhYeyL+c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730069AbfBRLje (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 06:39:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43938 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727875AbfBRLjb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 06:39:31 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4B994C0C234C;
        Mon, 18 Feb 2019 11:39:31 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C10EE5D70A;
        Mon, 18 Feb 2019 11:39:29 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 1/3] perf header: Fix wrong node write in NUMA_TOPOLOGY feature
Date:   Mon, 18 Feb 2019 12:39:25 +0100
Message-Id: <20190218113927.30841-2-jolsa@kernel.org>
In-Reply-To: <20190218113927.30841-1-jolsa@kernel.org>
References: <20190218113927.30841-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Mon, 18 Feb 2019 11:39:31 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are currently passing the node index instead of the
real node number.

Fixes: fbe96f29ce4b ("perf tools: Make perf.data more self-descriptive (v8)"
Link: http://lkml.kernel.org/n/tip-rbtlsr9ts23c89rki7d4s5sm@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/header.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 61ce197c5362..c66f26ec557a 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -879,7 +879,7 @@ static int write_numa_topology(struct feat_fd *ff,
 		if (ret < 0)
 			break;
 
-		ret = write_topo_node(ff, i);
+		ret = write_topo_node(ff, j);
 		if (ret < 0)
 			break;
 	}
-- 
2.17.2

