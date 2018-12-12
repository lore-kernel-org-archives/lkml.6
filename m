Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B45BCC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 13:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79AD820870
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 13:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544621385;
	bh=tMMgEzgB9+N3vlrx4dMXuOuq5ZvmsZ9CNQmN6xSOjNY=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=W9xgfb56MPQMEARc0Og3z84g6Z7azI7dwWBQuV/8TMd2W7Nl6ze2JFvFcNuUt72N2
	 R8KV7ZaYID2fbgzNnLPqJQvE4+QJvEQ1d2utpirGNc6u+ydo2v0gUYoPL7v4+lYWqG
	 5xTwru4LQsHSbtOYl/elCihgid9AfsbkIVAeJ648=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79AD820870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbeLLN3o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 08:29:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56802 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727159AbeLLN3n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 08:29:43 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7EBDE3097023;
        Wed, 12 Dec 2018 13:29:43 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BAC7F60C44;
        Wed, 12 Dec 2018 13:29:41 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH] perf tools: Link libperf-jvmti.so with LDFLAGS variable
Date:   Wed, 12 Dec 2018 14:29:40 +0100
Message-Id: <20181212132940.840-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Wed, 12 Dec 2018 13:29:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So we could propagate distro flags into libperf-jvmti.so library.

Link: http://lkml.kernel.org/n/tip-kb80gm9mmzkkcw2gkytbkkbq@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/Makefile.perf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 5a90c0ef2302..6f35f4d46b0a 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -660,7 +660,7 @@ $(LIBJVMTI_IN): FORCE
 	$(Q)$(MAKE) -f $(srctree)/tools/build/Makefile.build dir=jvmti obj=jvmti
 
 $(OUTPUT)$(LIBJVMTI): $(LIBJVMTI_IN)
-	$(QUIET_LINK)$(CC) -shared -Wl,-soname -Wl,$(LIBJVMTI) -o $@ $<
+	$(QUIET_LINK)$(CC) $(LDFLAGS) -shared -Wl,-soname -Wl,$(LIBJVMTI) -o $@ $<
 endif
 
 $(patsubst perf-%,%.o,$(PROGRAMS)): $(wildcard */*.h)
-- 
2.17.2

