Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79DD8C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AA222175B
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548691836;
	bh=vi6LDZxk4e5mqzUo2RY6x9M5pG5g/PHTtpN2MvDMdlY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RHOo20cLo2W6q5z0p1jxEZy48oArAUJFZUH6Sq68NhB12L8eLEh+J5Gfty/TJ4Aoo
	 UDKj49J6jz+gUHqwE7d5P0PlmL1OA4zGD3529cPrwR6lbIfgbid4CxDGBsXyyowsBJ
	 43Wi9WsgRRBVo+qS2OsDiaYh87BN8iKVkDOztDqY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732831AbfA1QKe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:10:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:36612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732345AbfA1QKd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:10:33 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C48E92147A;
        Mon, 28 Jan 2019 16:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691833;
        bh=vi6LDZxk4e5mqzUo2RY6x9M5pG5g/PHTtpN2MvDMdlY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r2m4b8sxh1xBJjYo7kVNK+VZxLT8bn0dBLBrw9kueA2hzxvf6aDRbnD2dLOkRE4Zw
         Guoi07lH0MsivRifOjKjvCWkU6dk+JyuUNFRLwg5dA2mhWFy4xFZxAljdwgnxeqYCM
         hntNjP4VVZSUfo+x4klWfC/Sxoj8NbtBbmmNt204=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        =?UTF-8?q?Jaroslav=20=C5=A0karvada?= <jskarvad@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 232/258] perf python: Do not force closing original perf descriptor in evlist.get_pollfd()
Date:   Mon, 28 Jan 2019 10:58:58 -0500
Message-Id: <20190128155924.51521-232-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128155924.51521-1-sashal@kernel.org>
References: <20190128155924.51521-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

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

