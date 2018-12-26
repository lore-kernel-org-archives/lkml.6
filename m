Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E85C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 13:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 094BA218EA
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 13:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545832308;
	bh=5RbL7DIZrycBUQFuWOhLLIHsIvtIBY0bGdi71u0W8PY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iSLKsjiNZOPgMB6/0F59JHXEtV0MMZ8EG7WO+NenpnAuHEawUpgC/QSH/l30opGcQ
	 8/wQx63rIl5p6kuQZuGql1Tymox0PFWkx6tyD/5o/GC37ZfiJP91xlDps0PI+RnNC/
	 m+P8d5pyDn4hATnEdq5DvH5oPyAnznmKAbZPPZbw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbeLZNvq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 08:51:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40378 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726935AbeLZNvo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 08:51:44 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6E9AE65984;
        Wed, 26 Dec 2018 13:51:44 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-92.brq.redhat.com [10.40.204.92])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E92EA19743;
        Wed, 26 Dec 2018 13:51:41 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 3/5] perf session: Add data_size to reader object
Date:   Wed, 26 Dec 2018 14:51:30 +0100
Message-Id: <20181226135132.29330-4-jolsa@kernel.org>
In-Reply-To: <20181226135132.29330-1-jolsa@kernel.org>
References: <20181226135132.29330-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Wed, 26 Dec 2018 13:51:44 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding data_size to reader object. Keeping the data_size
variable instead of replacing it with rd.data_size as it
will be used in following patch.

Link: http://lkml.kernel.org/n/tip-5xcux9957yqsljh1cm5ngyqy@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/session.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index f5eecae982ba..40692875f196 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1815,17 +1815,19 @@ fetch_mmaped_event(struct perf_session *session,
 
 struct reader {
 	int	fd;
+	u64	data_size;
 };
 
 static int __perf_session__process_events(struct perf_session *session)
 {
 	struct reader rd = {
 		.fd		= perf_data__fd(session->data),
+		.data_size	= session->header.data_size,
 	};
 	struct ordered_events *oe = &session->ordered_events;
 	struct perf_tool *tool = session->tool;
 	u64 data_offset = session->header.data_offset;
-	u64 data_size = session->header.data_size;
+	u64 data_size = rd.data_size;
 	u64 head, page_offset, file_offset, file_pos, size;
 	int err, mmap_prot, mmap_flags, map_idx = 0;
 	size_t	mmap_size;
-- 
2.17.2

