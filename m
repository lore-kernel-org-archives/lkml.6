Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB87C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 13:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E9E52070C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 13:13:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730935AbfACNNL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 08:13:11 -0500
Received: from terminus.zytor.com ([198.137.202.136]:51947 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729765AbfACNNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 08:13:10 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x03DD1Eu1384081
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 3 Jan 2019 05:13:01 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x03DD1A41384078;
        Thu, 3 Jan 2019 05:13:01 -0800
Date:   Thu, 3 Jan 2019 05:13:01 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-a389aece97938966616ce0336466b98b0351ef10@git.kernel.org>
Cc:     alexander.shishkin@linux.intel.com, olysonek@redhat.com,
        jskarvad@redhat.com, peterz@infradead.org, namhyung@kernel.org,
        acme@redhat.com, tglx@linutronix.de, jolsa@kernel.org,
        hpa@zytor.com, mingo@kernel.org, linux-kernel@vger.kernel.org
Reply-To: linux-kernel@vger.kernel.org, jolsa@kernel.org,
          tglx@linutronix.de, hpa@zytor.com, mingo@kernel.org,
          namhyung@kernel.org, peterz@infradead.org, acme@redhat.com,
          alexander.shishkin@linux.intel.com, olysonek@redhat.com,
          jskarvad@redhat.com
In-Reply-To: <20181226112121.5285-1-jolsa@kernel.org>
References: <20181226112121.5285-1-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf python: Do not force closing original perf
 descriptor in evlist.get_pollfd()
Git-Commit-ID: a389aece97938966616ce0336466b98b0351ef10
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

Commit-ID:  a389aece97938966616ce0336466b98b0351ef10
Gitweb:     https://git.kernel.org/tip/a389aece97938966616ce0336466b98b0351ef10
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Wed, 26 Dec 2018 12:21:21 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 28 Dec 2018 16:33:02 -0300

perf python: Do not force closing original perf descriptor in evlist.get_pollfd()

Ondřej reported that when compiled with python3, the python extension
regresses in evlist.get_pollfd function behaviour.

The evlist.get_pollfd function creates file objects from evlist's fds
and returns them in a list. The python3 version also sets them to 'close
the original descriptor' when the object dies (is closed), by passing
True via the 'closefd' arg in the PyFile_FromFd call.

The python's closefd doc says:

  If closefd is False, the underlying file descriptor will be kept open
  when the file is closed.

That's why the following line in python3 closes all evlist fds:

  evlist.get_pollfd()

the returned list is immediately destroyed and that takes down the
original events fds.

Passing closefd as False to PyFile_FromFd to fix this.

Reported-by: Ondřej Lysoněk <olysonek@redhat.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jaroslav Škarvada <jskarvad@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Fixes: 66dfdff03d19 ("perf tools: Add Python 3 support")
Link: http://lkml.kernel.org/r/20181226112121.5285-1-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/python.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 47628e85c5eb..dda0ac978b1e 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -939,7 +939,8 @@ static PyObject *pyrf_evlist__get_pollfd(struct pyrf_evlist *pevlist,
 
 		file = PyFile_FromFile(fp, "perf", "r", NULL);
 #else
-		file = PyFile_FromFd(evlist->pollfd.entries[i].fd, "perf", "r", -1, NULL, NULL, NULL, 1);
+		file = PyFile_FromFd(evlist->pollfd.entries[i].fd, "perf", "r", -1,
+				     NULL, NULL, NULL, 0);
 #endif
 		if (file == NULL)
 			goto free_list;
