Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1979CC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE83E2146F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545999360;
	bh=ruSmFs0fJy6+hAhVVg4L8tgJosMMU66ZxPBvUuCGag0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=p613yHk/vTsJ3hl+/NcpenkeSD3UPc9BhbAs79zU7CaB5T6oN1LjDg+Hdn1SWCxqW
	 xenqmZ3bZP6TIm8uFoOkkvafoLU2XEJacGa627Aj/brfEKLWqEJoPNBsUKvsGj0QTn
	 pKlpr5eq8RvwujmLGJs/yNJRTc6b/5pnALuYyOcM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732580AbeL1MP7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 07:15:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:34970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732565AbeL1MPz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 07:15:55 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1AB72148E;
        Fri, 28 Dec 2018 12:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545999355;
        bh=ruSmFs0fJy6+hAhVVg4L8tgJosMMU66ZxPBvUuCGag0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oXx5eiCmy9VvR9Pv3dOHHrYD5h+1WMNpokf4+MU9O2RQJXh6+GK/o9ruR9g9CqjH7
         Bg1HhMoOjsCoaT+o8ZXvZ1BKJHTe0fgDijrL7EEqea4tTR8IyErIgphwzhkkKdgSys
         tx0dkH8pHwp0uO7hth4w4oEKUNMyg+qlY3/zaQBM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        David Ahern <dsahern@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 06/36] perf record: Synthesize features before events in pipe mode
Date:   Fri, 28 Dec 2018 12:52:22 +0100
Message-Id: <20181228113126.936348325@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181228113126.526729877@linuxfoundation.org>
References: <20181228113126.526729877@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit a2015516c5c0be932a69e1d3405c2fb03b4eacf1 ]

We need to synthesize events first, because some features works on top
of them (on report side).

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Stephane Eranian <eranian@google.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180314092205.23291-1-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/builtin-record.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index b205c1340456..5e53cafe6cf9 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -800,13 +800,10 @@ static int record__synthesize(struct record *rec, bool tail)
 		return 0;
 
 	if (file->is_pipe) {
-		err = perf_event__synthesize_features(
-			tool, session, rec->evlist, process_synthesized_event);
-		if (err < 0) {
-			pr_err("Couldn't synthesize features.\n");
-			return err;
-		}
-
+		/*
+		 * We need to synthesize events first, because some
+		 * features works on top of them (on report side).
+		 */
 		err = perf_event__synthesize_attrs(tool, session,
 						   process_synthesized_event);
 		if (err < 0) {
@@ -814,6 +811,13 @@ static int record__synthesize(struct record *rec, bool tail)
 			goto out;
 		}
 
+		err = perf_event__synthesize_features(tool, session, rec->evlist,
+						      process_synthesized_event);
+		if (err < 0) {
+			pr_err("Couldn't synthesize features.\n");
+			return err;
+		}
+
 		if (have_tracepoints(&rec->evlist->entries)) {
 			/*
 			 * FIXME err <= 0 here actually means that
-- 
2.19.1



