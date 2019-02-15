Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E90C10F04
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4479222DC
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550191735;
	bh=XE/9pISF80DVoPV6B4ofpWDeCvG2vtJsGEWfvRz5B18=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ByyAM80ULLGG9qGP3PCalyCVEDOdCmmegQ3Dn4ffrz2HSE4B2uaaukxR56PAvTMc8
	 FLZIuXBz/II6RFKYTwevlkkz5xbcylwAVch6p13N9zPG0qAWO7falSnoCwY7eWKEqS
	 3nca8ko0f86O0BmbNGCxcZcTfwWI1G+rjk1Yj9f0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389952AbfBOAsy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 19:48:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:48154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389885AbfBOAsv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 19:48:51 -0500
Received: from quaco.ghostprotocols.net (unknown [189.40.103.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6090521B68;
        Fri, 15 Feb 2019 00:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550191731;
        bh=XE/9pISF80DVoPV6B4ofpWDeCvG2vtJsGEWfvRz5B18=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eQFY+4wDVmf2rhXFKjzgzifBqLVGoErk5Yu/SS76HIgGprEhlUC+vTrrUz3Hq4Kuj
         91c0y1UMZZ/sOoHJv7Z/UFw6Wfmk0tQpTlLOBezxsCsh3fockiPZTtePzlXedda7D+
         iNS/xOhr5Dy/XdZ3b1lL5N5JRemlAylq+ZcJyYjs=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 41/43] perf header: Get rid of write_it label
Date:   Thu, 14 Feb 2019 21:45:37 -0300
Message-Id: <20190215004539.23571-42-acme@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215004539.23571-1-acme@kernel.org>
References: <20190215004539.23571-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Simplifying the code a bit.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190213123246.4015-8-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/header.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index dec6d218c31c..f1508adefc16 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1042,11 +1042,9 @@ static int write_cpuid(struct feat_fd *ff,
 	int ret;
 
 	ret = get_cpuid(buffer, sizeof(buffer));
-	if (!ret)
-		goto write_it;
+	if (ret)
+		return -1;
 
-	return -1;
-write_it:
 	return do_write_string(ff, buffer);
 }
 
-- 
2.19.1

