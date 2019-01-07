Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86676C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 563B7206BB
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546865822;
	bh=kPXaZzCDmz1vdwM226Ossvk5DbaR74xUSKEcjkMgLog=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PB2wB7QAT/SiflRGb9OXIOklTeI9EZbe61vVmkan9PBpBvXsOgEk/f0hYm13EGTX6
	 fZ0Csvx4NsfvUNUumhLcaSaJ3sLLwJFGwH2gqsLWpIVkeU9UP5wT2ieOKZxIlwIZnS
	 Y2rEbvm2WiCVLWw/Zrnf+8BdQbl6PpbrRPnXLHwc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729772AbfAGM5B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:57:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:44796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728459AbfAGM5A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:57:00 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3FE520651;
        Mon,  7 Jan 2019 12:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865818;
        bh=kPXaZzCDmz1vdwM226Ossvk5DbaR74xUSKEcjkMgLog=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A01p7wulDHazzHWTtxD5fdvZ6a3R+pRSC/S5oJUmIKTOhGaskhL6f2md1OAzCy24Y
         5pLJLAORLxoI9eIo3E2Q/gld/GPK1oj9poNgGIcD0GYq47JGdsJutalP58uMxR0r23
         DjiiI8fAARU2BpAwz0HVEzFAcecqYuRteRLjP3lM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ben Hutchings <ben@decadent.org.uk>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 4.19 103/170] perf pmu: Suppress potential format-truncation warning
Date:   Mon,  7 Jan 2019 13:32:10 +0100
Message-Id: <20190107104505.139407002@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104452.953560660@linuxfoundation.org>
References: <20190107104452.953560660@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ben Hutchings <ben@decadent.org.uk>

commit 11a64a05dc649815670b1be9fe63d205cb076401 upstream.

Depending on which functions are inlined in util/pmu.c, the snprintf()
calls in perf_pmu__parse_{scale,unit,per_pkg,snapshot}() might trigger a
warning:

  util/pmu.c: In function 'pmu_aliases':
  util/pmu.c:178:31: error: '%s' directive output may be truncated writing up to 255 bytes into a region of size between 0 and 4095 [-Werror=format-truncation=]
    snprintf(path, PATH_MAX, "%s/%s.unit", dir, name);
                               ^~

I found this when trying to build perf from Linux 3.16 with gcc 8.
However I can reproduce the problem in mainline if I force
__perf_pmu__new_alias() to be inlined.

Suppress this by using scnprintf() as has been done elsewhere in perf.

Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: stable@vger.kernel.org
Link: http://lkml.kernel.org/r/20181111184524.fux4taownc6ndbx6@decadent.org.uk
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/perf/util/pmu.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -145,7 +145,7 @@ static int perf_pmu__parse_scale(struct
 	int fd, ret = -1;
 	char path[PATH_MAX];
 
-	snprintf(path, PATH_MAX, "%s/%s.scale", dir, name);
+	scnprintf(path, PATH_MAX, "%s/%s.scale", dir, name);
 
 	fd = open(path, O_RDONLY);
 	if (fd == -1)
@@ -175,7 +175,7 @@ static int perf_pmu__parse_unit(struct p
 	ssize_t sret;
 	int fd;
 
-	snprintf(path, PATH_MAX, "%s/%s.unit", dir, name);
+	scnprintf(path, PATH_MAX, "%s/%s.unit", dir, name);
 
 	fd = open(path, O_RDONLY);
 	if (fd == -1)
@@ -205,7 +205,7 @@ perf_pmu__parse_per_pkg(struct perf_pmu_
 	char path[PATH_MAX];
 	int fd;
 
-	snprintf(path, PATH_MAX, "%s/%s.per-pkg", dir, name);
+	scnprintf(path, PATH_MAX, "%s/%s.per-pkg", dir, name);
 
 	fd = open(path, O_RDONLY);
 	if (fd == -1)
@@ -223,7 +223,7 @@ static int perf_pmu__parse_snapshot(stru
 	char path[PATH_MAX];
 	int fd;
 
-	snprintf(path, PATH_MAX, "%s/%s.snapshot", dir, name);
+	scnprintf(path, PATH_MAX, "%s/%s.snapshot", dir, name);
 
 	fd = open(path, O_RDONLY);
 	if (fd == -1)


