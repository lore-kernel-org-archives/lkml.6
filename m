Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE4DC4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EE19218A8
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:56:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EE19218A8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbeHRPDg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 11:03:36 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48547 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbeHRPDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 11:03:36 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w7IBtkNC1291277
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 18 Aug 2018 04:55:47 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w7IBtkme1291274;
        Sat, 18 Aug 2018 04:55:46 -0700
Date:   Sat, 18 Aug 2018 04:55:46 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Benno Evers <tipbot@zytor.com>
Message-ID: <tip-3f4417d693b43fa240ac8bde4487f67745ca23d8@git.kernel.org>
Cc:     namhyung@kernel.org, mingo@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        kjlx@templeofstupid.com, tglx@linutronix.de, acme@redhat.com,
        bevers@mesosphere.com, jolsa@redhat.com,
        alexander.shishkin@linux.intel.com
Reply-To: acme@redhat.com, tglx@linutronix.de, kjlx@templeofstupid.com,
          alexander.shishkin@linux.intel.com, jolsa@redhat.com,
          bevers@mesosphere.com, mingo@kernel.org, namhyung@kernel.org,
          peterz@infradead.org, linux-kernel@vger.kernel.org, hpa@zytor.com
In-Reply-To: <20180810133614.9925-1-bevers@mesosphere.com>
References: <20180810133614.9925-1-bevers@mesosphere.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf tools: Check for null when copying nsinfo.
Git-Commit-ID: 3f4417d693b43fa240ac8bde4487f67745ca23d8
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  3f4417d693b43fa240ac8bde4487f67745ca23d8
Gitweb:     https://git.kernel.org/tip/3f4417d693b43fa240ac8bde4487f67745ca23d8
Author:     Benno Evers <bevers@mesosphere.com>
AuthorDate: Fri, 10 Aug 2018 15:36:13 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 13 Aug 2018 15:39:09 -0300

perf tools: Check for null when copying nsinfo.

The argument to nsinfo__copy() was assumed to be valid, but some code paths
exist that will lead to NULL being passed.

In particular, running 'perf script -D' on a perf.data file containing an
PERF_RECORD_MMAP event associating the '[vdso]' dso with pid 0 earlier in
the event stream will lead to a segfault.

Since all calling code is already checking for a non-null return value,
just return NULL for this case as well.

Signed-off-by: Benno Evers <bevers@mesosphere.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Krister Johansen <kjlx@templeofstupid.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180810133614.9925-1-bevers@mesosphere.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/namespaces.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/namespaces.c b/tools/perf/util/namespaces.c
index 5be021701f34..cf8bd123cf73 100644
--- a/tools/perf/util/namespaces.c
+++ b/tools/perf/util/namespaces.c
@@ -139,6 +139,9 @@ struct nsinfo *nsinfo__copy(struct nsinfo *nsi)
 {
 	struct nsinfo *nnsi;
 
+	if (nsi == NULL)
+		return NULL;
+
 	nnsi = calloc(1, sizeof(*nnsi));
 	if (nnsi != NULL) {
 		nnsi->pid = nsi->pid;
