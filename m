Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56399C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 10:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25B22214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 10:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547115196;
	bh=GdDPc2mtBaPcpW4qgmMk3nOLrYEFqrpGiaWMDkuJZ3k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DRXcUF5OSL0eU9PWJUJabKYu9XfzMLRDS8X4KBtcUudxMZaraRU+E8Lpz46jzNhfU
	 MazKMt5V3CQCIuPJdGP25vKboK0ktUSE6EEoSlxOap8utZ7fq7zRTi41hjxp7NoxTc
	 OtMxTUhaeVzlj8E6UeVQNkzxOCGINxtOH/0PAKzA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728272AbfAJKNP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 05:13:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59008 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728225AbfAJKNL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 05:13:11 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E4F96C05D3F8;
        Thu, 10 Jan 2019 10:13:10 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.222])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6BE2827C26;
        Thu, 10 Jan 2019 10:13:09 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 4/6] perf session: Add data_size to reader object
Date:   Thu, 10 Jan 2019 11:12:59 +0100
Message-Id: <20190110101301.6196-5-jolsa@kernel.org>
In-Reply-To: <20190110101301.6196-1-jolsa@kernel.org>
References: <20190110101301.6196-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Thu, 10 Jan 2019 10:13:11 +0000 (UTC)
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
index 06379cc87f59..9f29ed743425 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1822,17 +1822,19 @@ fetch_mmaped_event(struct perf_session *session,
 
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

