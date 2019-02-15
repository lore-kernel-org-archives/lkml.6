Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F408C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E53D222A1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550191628;
	bh=Ak7FcdJs/9GypGO3/vqefFY8amWrqdMTWi7oPapMsPc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VDInazpC2nuWSoQ7AleUzDxLtYMfPFcySbAyyczpaBULltAYOFH8uoTRDaMvMlGCZ
	 kbpcvaGaF8kKYWCpCCZ+Y8DROhnqafwcUdp4Ym/OScQQimEV86iM7PBAgYYMU8VzHE
	 X8nOqx6WECOMDI+OvCuBdYHUOiLkiCgrna/fTpss=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388954AbfBOArG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 19:47:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:45676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388876AbfBOArC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 19:47:02 -0500
Received: from quaco.ghostprotocols.net (unknown [189.40.103.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2438321B68;
        Fri, 15 Feb 2019 00:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550191621;
        bh=Ak7FcdJs/9GypGO3/vqefFY8amWrqdMTWi7oPapMsPc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qXOIq81qPg4rethSlHmlbj7h6uNAfz38Juk5V4/sAVf77Y4VOTnO5nU/aUbcmp2nx
         bHtsIildN0AZElsg/cJDekF2IH7nflHNIX20tT8q8w7dyHLu7fZTBeplQ+/YnNewlC
         ytiCulkh4C1jzfOrvVznLc9bcEGpHGuh7RmGgo/Y=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 17/43] tools build: Add -lrt to FEATURE_CHECK_LDFLAGS-libaio
Date:   Thu, 14 Feb 2019 21:45:13 -0300
Message-Id: <20190215004539.23571-18-acme@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215004539.23571-1-acme@kernel.org>
References: <20190215004539.23571-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Since we need it to resolve the AIO symbols, otherwise we fail with:

  $ cat /tmp/build/perf/feature/test-all.make.output
  /usr/bin/ld: /tmp/ccEqrj36.o: undefined reference to symbol 'aio_return64@@GLIBC_2.2.5'
  /usr/bin/ld: //usr/lib64/librt.so.1: error adding symbols: DSO missing from command line
  collect2: error: ld returned 1 exit status
  $

When we added the aio support in 'perf record' only the test-libaio.bin
target got the -lrt, i.e. the feature detection slow path. Fix it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Fixes: 2a07d814747b ("tools build feature: Check if libaio is available")
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.config | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index b441c88cafa1..e6360d47e73a 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -218,6 +218,8 @@ FEATURE_CHECK_LDFLAGS-libpython := $(PYTHON_EMBED_LDOPTS)
 FEATURE_CHECK_CFLAGS-libpython-version := $(PYTHON_EMBED_CCOPTS)
 FEATURE_CHECK_LDFLAGS-libpython-version := $(PYTHON_EMBED_LDOPTS)
 
+FEATURE_CHECK_LDFLAGS-libaio = -lrt
+
 CFLAGS += -fno-omit-frame-pointer
 CFLAGS += -ggdb3
 CFLAGS += -funwind-tables
-- 
2.19.1

