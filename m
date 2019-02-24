Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C91C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 19:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D4CD206B6
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 19:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551035293;
	bh=scbumLhSN+yEY/1O9Gv6xKzuv4zSMvw5WfMTCDfck0c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=k/wxBK1+9+ZgW7/JAjPFxz83u7YhJo6+Y+upusZ3ltizp1FLSXMu7VtGN8br1lbic
	 ytbuc7WAOdcmwX1eLMwn02K30f4R4cA1FOI1gWUNm5Bk7BFr0P0LR5RSzeCTVs+Nl7
	 3m0MPo28GY5YpT9g5EaLusLizhVdw02jpAA0wwXE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728694AbfBXTIM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 14:08:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49628 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728682AbfBXTIK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 14:08:10 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 11CB23697F;
        Sun, 24 Feb 2019 19:08:10 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-38.brq.redhat.com [10.40.204.38])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5A5476013A;
        Sun, 24 Feb 2019 19:08:06 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [PATCH 20/20] perf record: Describe perf.data directory format
Date:   Sun, 24 Feb 2019 20:06:56 +0100
Message-Id: <20190224190656.30163-21-jolsa@kernel.org>
In-Reply-To: <20190224190656.30163-1-jolsa@kernel.org>
References: <20190224190656.30163-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Sun, 24 Feb 2019 19:08:10 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding perf.data-directory-format.txt to describe the
directory data layout.

Link: http://lkml.kernel.org/n/tip-1c8u1thx63v2ldwfdas4xc5d@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../perf.data-directory-format.txt            | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 tools/perf/Documentation/perf.data-directory-format.txt

diff --git a/tools/perf/Documentation/perf.data-directory-format.txt b/tools/perf/Documentation/perf.data-directory-format.txt
new file mode 100644
index 000000000000..bbd6d31b10c8
--- /dev/null
+++ b/tools/perf/Documentation/perf.data-directory-format.txt
@@ -0,0 +1,54 @@
+perf.data directory format
+
+DISCLAIMER This is not ABI yet and is subject to possible change
+           in following versions of perf. We will remove this
+           disclaimer once the directory format soaks in.
+
+
+This document describes the on-disk perf.data format, generated
+by perf record with --dir option and consumed by the other perf
+tools.
+
+The directory perf.data is created by perf record command by
+using the --dir option:
+
+  $ perf record --dir perf bench sched messaging
+  $ ls -l perf.data
+      total 344
+      -rw-------. 1 jolsa jolsa 43864 Jan 20 22:26 data.0
+      -rw-------. 1 jolsa jolsa 30464 Jan 20 22:26 data.1
+      -rw-------. 1 jolsa jolsa 53816 Jan 20 22:26 data.2
+      -rw-------. 1 jolsa jolsa 30368 Jan 20 22:26 data.3
+      -rw-------. 1 jolsa jolsa 40088 Jan 20 22:26 data.4
+      -rw-------. 1 jolsa jolsa 42592 Jan 20 22:26 data.5
+      -rw-------. 1 jolsa jolsa 56136 Jan 20 22:26 data.6
+      -rw-------. 1 jolsa jolsa 25992 Jan 20 22:26 data.7
+      -rw-------. 1 jolsa jolsa  8832 Jan 20 22:26 header
+
+The header file keeps the standard perf.data file header,
+and the data.* files keep data.
+
+header file
+-----------
+The header file following the standard format describe in
+Documentation/perf.data-file-format doc. Including its data
+portion that is used to store manually synthesized events.
+
+data file
+---------
+The data files layout is described by HEADER_DIR_FORMAT feature.
+Currently it holds only version number (1):
+
+  HEADER_DIR_FORMAT = 24
+
+  struct {
+     uint64_t version;
+  }
+
+The current only only version value 1 means that data files:
+  - follow the 'data.*' format
+  - contain raw events data in standard perf format as read
+    from kernel (and need to be sorted)
+
+Future versions are expected to describe different data files
+layout according to special needs.
-- 
2.17.2

