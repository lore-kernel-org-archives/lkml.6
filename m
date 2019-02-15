Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D6A8C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11F5D222C9
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550191570;
	bh=sAIxCpdE/fBclKe7EWnnZg+XMA9lo5WpgqS/a7OlR64=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IdUukee14u70BNdpd1i5e6LVoibOfdsMhNMHLRt0cZKY7BKSyVJaWSr7brUT9xrmJ
	 A0C3WrjVDsoppYBa0YWgE0fKqOXcfuHqU+BKvmP4uxro6Z497Qxwb2qg+BQYwQtqqN
	 jA8fvilKCX8fAfwEUOTzUmankCZwSVSkTPA8LAPg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730335AbfBOAqD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 19:46:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:44052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730296AbfBOAp7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 19:45:59 -0500
Received: from quaco.ghostprotocols.net (unknown [189.40.103.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DB8B21B68;
        Fri, 15 Feb 2019 00:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550191559;
        bh=sAIxCpdE/fBclKe7EWnnZg+XMA9lo5WpgqS/a7OlR64=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d3VbzEm/tcLeMndtEOzHImtxIngHZIrxnNcVL0ePWBE27wTZnYELfoB/0jNGkMxnG
         v57O53PjE2I1m9EE7NMwOzLxCO1yz/E0Z+JM06lytqmJXyR5JHovIJsQSbbnEHARfo
         UFSpt2SG7f1hr0OZ4LGv0cW3WzO2HRAR3ieRpl3o=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Suzuki K Poulouse <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 02/43] perf cs-etm: Add proper header file for symbols
Date:   Thu, 14 Feb 2019 21:44:58 -0300
Message-Id: <20190215004539.23571-3-acme@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215004539.23571-1-acme@kernel.org>
References: <20190215004539.23571-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mathieu Poirier <mathieu.poirier@linaro.org>

After 'commit e22c1c751140 ("perf thread: Don't include symbol.h,
symbol_conf.h is enough")'

Compilation of the perf tools is broken when using the functionality
provided by the openCSD library:

[...]

...                       timerfd: [ on  ]
...                  sched_getcpu: [ on  ]
...                           sdt: [ OFF ]
...                         setns: [ on  ]
...                    libopencsd: [ on  ]

[...]

  CC       util/arm-spe.o
  CC       util/arm-spe-pkt-decoder.o
  CC       util/s390-cpumsf.o
  CC       util/cs-etm.o
  CC       util/parse-branch-options.o
util/cs-etm.c: In function ‘cs_etm__mem_access’:
util/cs-etm.c:297:24: error: storage size of ‘al’ isn’t known
  struct  addr_location al;

And rightly so since file cs-etm.c doesn't include symbol.h, something
that is rectified in this patch.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Suzuki K Poulouse <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/20190208223543.31836-1-mathieu.poirier@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 8b3f882d6e2f..0b11d653cfbe 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -25,6 +25,7 @@
 #include "machine.h"
 #include "map.h"
 #include "perf.h"
+#include "symbol.h"
 #include "thread.h"
 #include "thread_map.h"
 #include "thread-stack.h"
-- 
2.19.1

