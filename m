Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47C7CC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0780C2070B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549479269;
	bh=Lt6tuamc08R0SRYVYSzi00tOGRhF/zz241y1go101ok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xRWs0qm9blZcs9ZLtA4kTltohLxx7MrtIasM0B9ZqNS9XYbHx+UBbIU1gm7P435VY
	 aaFXp87Ppk/YbZgvNaDp0iiiBSJIFymexhAWOV9FCQoVXWwEaToGy22iVurf4fSmuR
	 Q9spRFXGhXHtlFsHY3IXoVE6fmYIXk+OhkQmKFpo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbfBFSy1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 13:54:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:44190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727259AbfBFStx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 13:49:53 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.41.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A804D2083B;
        Wed,  6 Feb 2019 18:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549478992;
        bh=Lt6tuamc08R0SRYVYSzi00tOGRhF/zz241y1go101ok=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LgoahHT31+RU68SZIKtm6DrZKlEMM0dp+LhEogo1lptImaJqMFZMji1Wmk/3QQNzV
         i6Muk/J1pyJo4kMdy0h3iBsUhTs2SiO7Heda34gHTjtfvXlzm8Qd9MxSLa4uwKs3A9
         X4gze+WlBjHp++qgMgxMoBfmYDETHUo6qdKYT+R0=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 14/53] perf hist: Remove the needless callchain.h include from hist.h
Date:   Wed,  6 Feb 2019 15:48:24 -0300
Message-Id: <20190206184903.24054-15-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190206184903.24054-1-acme@kernel.org>
References: <20190206184903.24054-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Nothing that is provided by callchain.h is used there, just things that
should've be directly included in hist.h, such as rbtree.h and a
map_symbol forward declaration.

Remove it so that we reduce the headers dependency tree.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-zivvqfx93w5zzur7hr7h0nlh@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/hist.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 38a72eb81427..6b872079ead5 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -2,9 +2,9 @@
 #ifndef __PERF_HIST_H
 #define __PERF_HIST_H
 
+#include <linux/rbtree.h>
 #include <linux/types.h>
 #include <pthread.h>
-#include "callchain.h"
 #include "evsel.h"
 #include "header.h"
 #include "color.h"
@@ -13,6 +13,7 @@
 struct hist_entry;
 struct hist_entry_ops;
 struct addr_location;
+struct map_symbol;
 struct mem_info;
 struct branch_info;
 struct symbol;
-- 
2.20.1

