Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A79CC282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48BF0222B2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550061185;
	bh=4vkS98ekQdZkWqT+gMGUa/0lgB4sTig5W7UUJGpXMnU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oBXjripoQUCNs8kqoZsRef2ETv7bgUPTLJvpCfV57BjYGLx/KTNEeEBTXIuUrCuQR
	 yHQDNMhhd1z9yvCXpfz4XXGxWIVYJ/q+EXW/Vt23DaUrTeqJqenDGyPh7CspRLjxUa
	 9kv2nvU/0otw/8fQTSlFq3ySyn8wYsE0Qb57Xx5w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392105AbfBMMdD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 07:33:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50696 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392088AbfBMMc7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 07:32:59 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 89A874CE85;
        Wed, 13 Feb 2019 12:32:59 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.136])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 109E760856;
        Wed, 13 Feb 2019 12:32:57 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 06/10] perf header: Fix wrong node write in NUMA_TOPOLOGY feature
Date:   Wed, 13 Feb 2019 13:32:42 +0100
Message-Id: <20190213123246.4015-7-jolsa@kernel.org>
In-Reply-To: <20190213123246.4015-1-jolsa@kernel.org>
References: <20190213123246.4015-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Wed, 13 Feb 2019 12:32:59 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are currently passing the node index instead of the
real node number.

Link: http://lkml.kernel.org/n/tip-rbtlsr9ts23c89rki7d4s5sm@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/header.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index dec6d218c31c..7bebf9a34edd 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -881,7 +881,7 @@ static int write_numa_topology(struct feat_fd *ff,
 		if (ret < 0)
 			break;
 
-		ret = write_topo_node(ff, i);
+		ret = write_topo_node(ff, j);
 		if (ret < 0)
 			break;
 	}
-- 
2.17.2

