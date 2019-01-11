Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F7FDC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D55E2183F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547216287;
	bh=jnVegdIbp9FIb7dbjbp4gtO4/ZO+19X86yKJrjnL0R0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1UXSbjOdcNbfxAP43slfsP3aWwqOyj9HbXNdVc5hOqIzLYN1kAh0v8JbpQjbW7NIl
	 DRTeTgsQVrn2X1wQHLkjbZoMzHUhpHTDAQ3gC6WzgFzWK44e6KRAj2k5WGb5TxO8Kq
	 bec1gIzmo/5+tOKJdb7FoMWwXDSl4g7bkeFNWt8s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387957AbfAKOSG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:18:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:34474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729489AbfAKOSE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:18:04 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6862021783;
        Fri, 11 Jan 2019 14:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547216282;
        bh=jnVegdIbp9FIb7dbjbp4gtO4/ZO+19X86yKJrjnL0R0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wyLBy0iXnuLjVh2Bt/Wq/kV8zNRW+0w9rINxmo3uRm5dLFUVgDkbCtWqK95+WYuBX
         TUjq+3Y8TTUm74XBtIBm7QJ7Jdv0zUkUPHAiKZGEFIAS45TczDJA14VUuTQ/5+MaDv
         /YfUQl5Bu6iw6dG82vwoKIHWuJPuhxYS/NB1sFZk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ben Hutchings <ben@decadent.org.uk>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 4.4 41/88] perf pmu: Suppress potential format-truncation warning
Date:   Fri, 11 Jan 2019 15:08:10 +0100
Message-Id: <20190111131051.981733777@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131045.137499039@linuxfoundation.org>
References: <20190111131045.137499039@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -100,7 +100,7 @@ static int perf_pmu__parse_scale(struct
 	char path[PATH_MAX];
 	const char *lc;
 
-	snprintf(path, PATH_MAX, "%s/%s.scale", dir, name);
+	scnprintf(path, PATH_MAX, "%s/%s.scale", dir, name);
 
 	fd = open(path, O_RDONLY);
 	if (fd == -1)
@@ -147,7 +147,7 @@ static int perf_pmu__parse_unit(struct p
 	ssize_t sret;
 	int fd;
 
-	snprintf(path, PATH_MAX, "%s/%s.unit", dir, name);
+	scnprintf(path, PATH_MAX, "%s/%s.unit", dir, name);
 
 	fd = open(path, O_RDONLY);
 	if (fd == -1)
@@ -177,7 +177,7 @@ perf_pmu__parse_per_pkg(struct perf_pmu_
 	char path[PATH_MAX];
 	int fd;
 
-	snprintf(path, PATH_MAX, "%s/%s.per-pkg", dir, name);
+	scnprintf(path, PATH_MAX, "%s/%s.per-pkg", dir, name);
 
 	fd = open(path, O_RDONLY);
 	if (fd == -1)
@@ -195,7 +195,7 @@ static int perf_pmu__parse_snapshot(stru
 	char path[PATH_MAX];
 	int fd;
 
-	snprintf(path, PATH_MAX, "%s/%s.snapshot", dir, name);
+	scnprintf(path, PATH_MAX, "%s/%s.snapshot", dir, name);
 
 	fd = open(path, O_RDONLY);
 	if (fd == -1)


