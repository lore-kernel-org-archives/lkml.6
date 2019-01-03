Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA69C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 12:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E68F2070D
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 12:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546519740;
	bh=5drIvO2xOtSEKAf4lzHzfrt78RsBRSr0WiV0KSIXjYY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=b9V8rFha/hqKkVDW6U12FZlIK5LwHrIhPiS9lM4lfKka3KYwU2dOV4ZcJhGgSdLY9
	 Ir38o9U3gV1HjGUjl5z7Oaps4R/eDIkyqYxjADWCz5erAfKW4MqsyO13L0k/Hu1Ae8
	 1Igx23QlR42rsC4JeTxKFoFXoEedulkDkjoAWzzM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731390AbfACMqi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 07:46:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:41974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730833AbfACMqg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 07:46:36 -0500
Received: from quaco.ghostprotocols.net (unknown [187.65.17.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5CD3217D9;
        Thu,  3 Jan 2019 12:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546519595;
        bh=5drIvO2xOtSEKAf4lzHzfrt78RsBRSr0WiV0KSIXjYY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yLn6u+g+NAWJi854seeDwiSD89pCR5gUUcmGcZyKQGpD+b61G/19SoJXFnNxhTuV6
         1Gt1MfVT7JbpWJiP66eNpkfPklgPWmScoOkkZF8oxpqSBOp0x12REd7rDIuWXcKgdR
         v9d7F1190N32CJNYn3eqLJqR9LKobs2j+4WJ2DoY=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        =?UTF-8?q?Ond=C5=99ej=20Lyson=C4=9Bk?= <olysonek@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        =?UTF-8?q?Jaroslav=20=C5=A0karvada?= <jskarvad@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 06/29] perf python: Do not force closing original perf descriptor in evlist.get_pollfd()
Date:   Thu,  3 Jan 2019 09:45:46 -0300
Message-Id: <20190103124609.29672-7-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190103124609.29672-1-acme@kernel.org>
References: <20190103124609.29672-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

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
-- 
2.19.2

