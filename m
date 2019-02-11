Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A26E3C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B572222A7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549899488;
	bh=ZSbhBf8iDsfFGRLNa/kLtO56mlm5xWBFIHQohH9A1UE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vz1+pSKOwaJ2OpeMShjXU72xoSEVNAmenaxfbtzjFCBFK4yjmqc6JhTrsI83vskLw
	 FKpS2SQ+tZUmt+w7AHhzUS8MAnAVcyL86ApFWNe5jTJBpYJeRRHpJZZFoKR0OJvFhF
	 kG9VGFUTutjWgSEOlrJgLhKU/Prs8sokUH1Rvcho=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388129AbfBKOuj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:50:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:36544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732475AbfBKOuh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:50:37 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6BBE20700;
        Mon, 11 Feb 2019 14:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896637;
        bh=ZSbhBf8iDsfFGRLNa/kLtO56mlm5xWBFIHQohH9A1UE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u7r5pmfIbVacI+RIRhz1ORYWRLDyIHy5SCjKL+2c91A2YG7iglwFw8Wj9SnJSGlfU
         XSnApoMskA68HKU/J3SPxbjPKxTitmdnzlzRlRoAbjhBrCefl1eE1TvHc7LqotyaYP
         I/w9UfyOvERkZcBYNVErD/So6hRLq7os21KXRXCY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Ond=C5=99ej=20Lyson=C4=9Bk?= <olysonek@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        =?UTF-8?q?Jaroslav=20=C5=A0karvada?= <jskarvad@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 223/313] perf python: Do not force closing original perf descriptor in evlist.get_pollfd()
Date:   Mon, 11 Feb 2019 15:18:23 +0100
Message-Id: <20190211141908.165056045@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
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

[ Upstream commit a389aece97938966616ce0336466b98b0351ef10 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/python.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index ce501ba14b08..69f5f6142dcf 100644
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
2.19.1



