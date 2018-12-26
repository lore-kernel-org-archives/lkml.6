Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE4FCC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 11:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BB3921720
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 11:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545823300;
	bh=Tq8Dmchn4XrhEAHiZbWsz78SoEGRt8OCfCORqu4P0X8=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=xYtqpWvzuqxb3dvAyJabnHPbZAHZVHEjYBpIt2poyyDyqdWF7m2sebhZ1pqL2mjnV
	 etDtBKpzGVXpLsRS4faOFJkFGEhByAi+mx2d8Xq5Ktlx+LAvi9fJuXUKSuRyNNYl0i
	 GSxHD5al97DV4MeA80YwZiROdxsCynljrbHRt94E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbeLZLV1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 06:21:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47220 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726650AbeLZLV1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 06:21:27 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B4AD8811DE;
        Wed, 26 Dec 2018 11:21:26 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-92.brq.redhat.com [10.40.204.92])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E3EC01001925;
        Wed, 26 Dec 2018 11:21:22 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        =?UTF-8?q?Ond=C5=99ej=20Lyson=C4=9Bk?= <olysonek@redhat.com>
Subject: [PATCH] perf python: Do not force closing original perf descriptor in evlist.get_pollfd
Date:   Wed, 26 Dec 2018 12:21:21 +0100
Message-Id: <20181226112121.5285-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Wed, 26 Dec 2018 11:21:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ondřej reported that when compiled with python3, the python
extension regress in evlist.get_pollfd function behaviour.

The evlist.get_pollfd creates file objects from evlist's fds
and returns them in the list. The python3 version also sets
them to 'close the original descriptor' when the object die
(is closed), by passing True via 'closefd' arg in PyFile_FromFd
call.

The python's closefd doc says:
  If closefd is False, the underlying file descriptor will be kept open
  when the file is closed.

That's why following line in python3 closes all evlist fds:
  evlist.get_pollfd()

the returned list is immediately destroyed and that takes
down the original events fds.

Passing closefd as False to PyFile_FromFd to fix this.

Reported-by: Ondřej Lysoněk <olysonek@redhat.com>
Link: http://lkml.kernel.org/n/tip-ru9hmsaliew8p01kr0050mvg@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
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
2.17.2

