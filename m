Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA53AC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 16:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 762E62172C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 16:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fr0Az8+N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 762E62172C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbeHTTdM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 15:33:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:35504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726024AbeHTTdM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 15:33:12 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B5E321759;
        Mon, 20 Aug 2018 16:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534781816;
        bh=L3pA6q7fVdfXDZrNhwIID+9r8jPgnMGKQxk5U4ABATA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fr0Az8+NOPEBuMr8nPG5dVT2szxdWsdCvf1lnYdp2XCB9xeBfJ75XRvbXDu7D6PHR
         KOJBLm3UiMfE79OsdlEhZ/h9YsmO3HKIud4VQfpdHd085my5mh6TyYBqrWNcHgnWm5
         q+IfRfDGNyf23pmUYDWaC78Bru1CBspmeWR9+Kpc=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        David Ahern <dsahern@gmail.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 13/21] perf tools: Move the temp file processing into decompress_kmodule
Date:   Mon, 20 Aug 2018 13:15:54 -0300
Message-Id: <20180820161602.6830-14-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180820161602.6830-1-acme@kernel.org>
References: <20180820161602.6830-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

We will add a compression check in the following patch and it makes it
easier if the file processing is done in a single place. It also makes
the current code simpler.

The decompress_kmodule function now returns the fd of the uncompressed
file and the file name in the pathname arg, if it's provided.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180817094813.15086-10-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/dso.c | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 54bfe1f4762f..cbeecf683333 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -250,8 +250,10 @@ bool dso__needs_decompress(struct dso *dso)
 		dso->symtab_type == DSO_BINARY_TYPE__GUEST_KMODULE_COMP;
 }
 
-static int decompress_kmodule(struct dso *dso, const char *name, char *tmpbuf)
+static int decompress_kmodule(struct dso *dso, const char *name,
+			      char *pathname, size_t len)
 {
+	char tmpbuf[] = KMOD_DECOMP_NAME;
 	int fd = -1;
 
 	if (!dso__needs_decompress(dso))
@@ -272,34 +274,27 @@ static int decompress_kmodule(struct dso *dso, const char *name, char *tmpbuf)
 		fd = -1;
 	}
 
+	if (!pathname || (fd < 0))
+		unlink(tmpbuf);
+
+	if (pathname && (fd >= 0))
+		strncpy(pathname, tmpbuf, len);
+
 	return fd;
 }
 
 int dso__decompress_kmodule_fd(struct dso *dso, const char *name)
 {
-	char tmpbuf[] = KMOD_DECOMP_NAME;
-	int fd;
-
-	fd = decompress_kmodule(dso, name, tmpbuf);
-	unlink(tmpbuf);
-	return fd;
+	return decompress_kmodule(dso, name, NULL, 0);
 }
 
 int dso__decompress_kmodule_path(struct dso *dso, const char *name,
 				 char *pathname, size_t len)
 {
-	char tmpbuf[] = KMOD_DECOMP_NAME;
-	int fd;
-
-	fd = decompress_kmodule(dso, name, tmpbuf);
-	if (fd < 0) {
-		unlink(tmpbuf);
-		return -1;
-	}
+	int fd = decompress_kmodule(dso, name, pathname, len);
 
-	strncpy(pathname, tmpbuf, len);
 	close(fd);
-	return 0;
+	return fd >= 0 ? 0 : -1;
 }
 
 /*
-- 
2.14.4

