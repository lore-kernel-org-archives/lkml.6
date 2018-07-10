Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8437EC5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44E0E208E8
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:47:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44E0E208E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934292AbeGJPra (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 11:47:30 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:43450 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933506AbeGJPr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 11:47:28 -0400
Received: by mail-qk0-f194.google.com with SMTP id z74-v6so11778638qkb.10
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 08:47:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qvKdnmMAhVH86MYxmbRR/Z6n2t8Km+nu4IYAQLHJErU=;
        b=QQKRzKitq0/5lq7yFjC9ISQA0B0swb95xgReWBVzgfAoh0Dcb2p32U4RtaKl4pd6/T
         2+JTY+vGLSl6bK03RVI0tmjty5V/BjppoH0e2brVNjK6+TAPoGOgslI3HOlkW8siCmBx
         elJLfMZi+wIm5Is5VxiwF1ArHQ99A7ENmYQl/gNPpDeGJqffg7HVgYgIBPD8YpqpUYx9
         QWHZ6tPZdZ1FYAkVvN2jnUuwJ5My1LNjF1V65YJ8yVx3Fg1KLDDJnlT3w0i6ClRirqJF
         AgdtixSfm4ZZ8Z63SHD6c0g4Pjfp3ixaHbGXvFfz4eT72g90ptiDqjNc/IPKfRCQ2/9n
         2I1Q==
X-Gm-Message-State: APt69E1teSG79kZItqmHlWZj1j0V49Z78aClZbjni1JIBqvgy3quYiyt
        yXwP8e/IZtatQUpN6YZYwbsC7Q==
X-Google-Smtp-Source: AAOMgpfJFmUiW63tJyxULQn24RyWzRHHkcFp1yYSsDCAmDGWk6TodZ66S9XOujysDktiswKnm1mCgA==
X-Received: by 2002:a37:6713:: with SMTP id b19-v6mr22197251qkc.63.1531237647501;
        Tue, 10 Jul 2018 08:47:27 -0700 (PDT)
Received: from laptop.jcline.org.com (nat-pool-rdu-t.redhat.com. [66.187.233.202])
        by smtp.gmail.com with ESMTPSA id l7-v6sm13646085qtc.27.2018.07.10.08.47.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Jul 2018 08:47:26 -0700 (PDT)
From:   Jeremy Cline <jcline@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeremy Cline <jcline@redhat.com>
Subject: [PATCH] perf: Use python-config --includes rather than --cflags
Date:   Tue, 10 Jul 2018 11:46:12 -0400
Message-Id: <20180710154612.6285-1-jcline@redhat.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Builds started failing in Fedora on Python 3.7 with:

    `.gnu.debuglto_.debug_macro' referenced in section
    `.gnu.debuglto_.debug_macro' of
    util/scripting-engines/trace-event-python.o: defined in discarded
    section

In Fedora, Python 3.7 added -flto to the list of --cflags and since it
was only applied to util/scripting-engines/trace-event-python.c and
scripts/python/Perf-Trace-Util/Context.c, linking failed. It's not the
first time the addition of flags has broken builds: commit c6707fdef7e2
("perf tools: Fix up build in hardnened environments") appears to have
fixed a similar problem. "python-config --includes" provides the proper
-I flags and doesn't introduce additional CFLAGS.

Signed-off-by: Jeremy Cline <jcline@redhat.com>
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
2.17.1

