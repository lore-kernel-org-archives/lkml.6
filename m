Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A921C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 18:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64200218EA
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 18:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546626895;
	bh=WAkEcskeYt7S1Tk1TKPd77ln9R46LLl1a5oT2VjOlZc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VD3zTslH+jeGt355x3QXWler3ULhiAlBxJMX+oDXnf4NgM6K5BE7nmsrIOzE9btvQ
	 r9BocpyGuGBw86Kl7+DptlyBnhoegtWCaCu0dcNelzQWwzmP4HNr/wXwLokO7H8+0u
	 E9Wu65d4utDShXQeTC96UqYSzCOaNqoJLWei4ET4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728825AbfADSes (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 13:34:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:53628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728731AbfADSep (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 13:34:45 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB4CE218D8;
        Fri,  4 Jan 2019 18:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546626884;
        bh=WAkEcskeYt7S1Tk1TKPd77ln9R46LLl1a5oT2VjOlZc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kmo5cFCujIO8O7psEisIOM0Ar7vRqY/a0IPYuj2IpsethwuR3phih5LMooySBQijO
         KfXh3u/G3nqVzK4gP44FzKCW1PbWdekMppXPaV3alp7o+NAbH/HZhIradC7YEnsALM
         PDl+3lXHxUNcOB2KuuNsdN05ORcZ2HvF7wQ9ZEuw=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 15/16] perf python: Make sure the python binding output directory is in place
Date:   Fri,  4 Jan 2019 15:33:36 -0300
Message-Id: <20190104183337.12771-16-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190104183337.12771-1-acme@kernel.org>
References: <20190104183337.12771-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Instead of doing an unconditional mkdir, use a dummy Makefile variable
to check if the directory is there and if not, create it.

This is better than what we had and will help with other python bindings
that are in development, like one involved with python backtraces.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-iis6us2nocw3y4uuoon9osd7@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.perf | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index ff29c3372ec3..2921f829a0f4 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -524,12 +524,14 @@ $(arch_errno_name_array): $(arch_errno_tbl)
 
 all: shell_compatibility_test $(ALL_PROGRAMS) $(LANG_BINDINGS) $(OTHER_PROGRAMS)
 
+# Create python binding output directory if not already present
+_dummy := $(shell [ -d '$(OUTPUT)python' ] || mkdir -p '$(OUTPUT)python')
+
 $(OUTPUT)python/perf.so: $(PYTHON_EXT_SRCS) $(PYTHON_EXT_DEPS) $(LIBTRACEEVENT_DYNAMIC_LIST)
 	$(QUIET_GEN)LDSHARED="$(CC) -pthread -shared" \
         CFLAGS='$(CFLAGS)' LDFLAGS='$(LDFLAGS) $(LIBTRACEEVENT_DYNAMIC_LIST_LDFLAGS)' \
 	  $(PYTHON_WORD) util/setup.py \
 	  --quiet build_ext; \
-	mkdir -p $(OUTPUT)python && \
 	cp $(PYTHON_EXTBUILD_LIB)perf*.so $(OUTPUT)python/
 
 please_set_SHELL_PATH_to_a_more_modern_shell:
-- 
2.20.1

