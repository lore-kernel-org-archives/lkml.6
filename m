Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E57C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 01:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF60E21734
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 01:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550712369;
	bh=IkrYyRUzVh3KH8OpInb3S0zghH/LRltVDpwEGySiSrY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=B2JJZhJ9gtmBmJxE+A8fEwVneTVGomxQNIpErQ+66DjGCIOkmE2QXHTsOyCWtRLGD
	 VASXZf11z3be+NSXP7RNYEN/NkE77lvna3akg2nw2cOqBEn7R/AO/pbi+JMceY69Hb
	 PK+Le9rzjlQ1AWxsyBf0k8MbsUp+SuEHocpvTJgE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbfBUB0H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 20:26:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:59026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726746AbfBUB0G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 20:26:06 -0500
Received: from quaco.ghostprotocols.net (unknown [189.40.102.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55773214AF;
        Thu, 21 Feb 2019 01:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550712366;
        bh=IkrYyRUzVh3KH8OpInb3S0zghH/LRltVDpwEGySiSrY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W7qj8hkt+pD8SB4CJNA6VRJf34pEBDT3IUlSIcak27PtF+b+gOtCYUym7rRdt4S2a
         B5RdQouUGiAN6i+/sobGm1u1piH+vdqFNcKgBh/PT1UjBAYk8s+yGBWMfpDnmmL/0X
         RdHBqHPZ+u2K9i2++RoFP5y31PcHY9dZqqfUI3yY=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 02/17] perf header: Fix wrong node write in NUMA_TOPOLOGY feature
Date:   Wed, 20 Feb 2019 22:25:34 -0300
Message-Id: <20190221012549.4069-3-acme@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190221012549.4069-1-acme@kernel.org>
References: <20190221012549.4069-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

We are currently passing the node index instead of the real node number.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Fixes: fbe96f29ce4b ("perf tools: Make perf.data more self-descriptive (v8)"
Link: http://lkml.kernel.org/r/20190219095815.15931-2-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
2.19.1

