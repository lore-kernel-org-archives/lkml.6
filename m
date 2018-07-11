Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B138C1B0E3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 20:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28D862146F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 20:45:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="u2DHjkDj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28D862146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389938AbeGKUv3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 16:51:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:38082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389657AbeGKUv2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 16:51:28 -0400
Received: from jouet.localdomain (unknown [71.46.56.59])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3EC521473;
        Wed, 11 Jul 2018 20:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531341922;
        bh=TNxPB2Ydo/aL+obTYCAnN8whinXjIjX51S8JkA38gsc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u2DHjkDj7YODlCPVgABdvV43QUFDqZVa2I78VQa5AnucALB1z0U0yaAjKWLMtZ4to
         DB3u3Fr0bQh9GCx896eFA6qhEuC05lyczaoP1w2qveRAWqmR5HhyE2Zedg9QWyeYPX
         kpkfX3oYn0x+2nbjE/sN7VnnN0Jr2kFlay2GyL7U=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Jeremy Cline <jcline@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 14/14] perf tools: Use python-config --includes rather than --cflags
Date:   Wed, 11 Jul 2018 16:43:05 -0400
Message-Id: <20180711204305.12924-15-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180711204305.12924-1-acme@kernel.org>
References: <20180711204305.12924-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeremy Cline <jcline@redhat.com>

Builds started failing in Fedora on Python 3.7 with:

    `.gnu.debuglto_.debug_macro' referenced in section
    `.gnu.debuglto_.debug_macro' of
    util/scripting-engines/trace-event-python.o: defined in discarded
    section

In Fedora, Python 3.7 added -flto to the list of --cflags and since it
was only applied to util/scripting-engines/trace-event-python.c and
scripts/python/Perf-Trace-Util/Context.c, linking failed.

It's not the first time the addition of flags has broken builds: commit
c6707fdef7e2 ("perf tools: Fix up build in hardnened environments")
appears to have fixed a similar problem. "python-config --includes"
provides the proper -I flags and doesn't introduce additional CFLAGS.

Signed-off-by: Jeremy Cline <jcline@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180710154612.6285-1-jcline@redhat.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.config | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index b5ac356ba323..f5a3b402589e 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -207,8 +207,7 @@ ifdef PYTHON_CONFIG
   PYTHON_EMBED_LDOPTS := $(shell $(PYTHON_CONFIG_SQ) --ldflags 2>/dev/null)
   PYTHON_EMBED_LDFLAGS := $(call strip-libs,$(PYTHON_EMBED_LDOPTS))
   PYTHON_EMBED_LIBADD := $(call grep-libs,$(PYTHON_EMBED_LDOPTS)) -lutil
-  PYTHON_EMBED_CCOPTS := $(shell $(PYTHON_CONFIG_SQ) --cflags 2>/dev/null)
-  PYTHON_EMBED_CCOPTS := $(filter-out -specs=%,$(PYTHON_EMBED_CCOPTS))
+  PYTHON_EMBED_CCOPTS := $(shell $(PYTHON_CONFIG_SQ) --includes 2>/dev/null)
   FLAGS_PYTHON_EMBED := $(PYTHON_EMBED_CCOPTS) $(PYTHON_EMBED_LDOPTS)
 endif
 
-- 
2.14.4

