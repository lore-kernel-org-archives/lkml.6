Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752906AbeCXUDB (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 16:03:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:36692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752681AbeCXUC6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 16:02:58 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AB4D2183B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Martin Vuille <jpmv27@aim.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 01/44] perf unwind: Report error from dwfl_attach_state
Date: Sat, 24 Mar 2018 17:01:28 -0300
Message-Id: <20180324200211.21326-2-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180324200211.21326-1-acme@kernel.org>
References: <20180324200211.21326-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Vuille <jpmv27@aim.com>

In verbose level 2, errors returned by libdw are reported in most cases,
but not when calling dwfl_attach_state.

Since elfutils v 0.160 (2014), dwfl_attach_state sets the error code to
report failure cause. On failure, log the reported error.

Signed-off-by: Martin Vuille <jpmv27@aim.com>
Reviewed-by: Kim Phillips <kim.phillips@arm.com>
Link: http://lkml.kernel.org/r/20180318175053.4222-1-jpmv27@aim.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/unwind-libdw.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libdw.c
index 8e969f28cc59..7bdd239c795c 100644
--- a/tools/perf/util/unwind-libdw.c
+++ b/tools/perf/util/unwind-libdw.c
@@ -236,7 +236,8 @@ int unwind__get_entries(unwind_entry_cb_t cb, void *arg,
 	if (err)
 		goto out;
 
-	if (!dwfl_attach_state(ui->dwfl, EM_NONE, thread->tid, &callbacks, ui))
+	err = !dwfl_attach_state(ui->dwfl, EM_NONE, thread->tid, &callbacks, ui);
+	if (err)
 		goto out;
 
 	err = dwfl_getthread_frames(ui->dwfl, thread->tid, frame_callback, ui);
-- 
2.14.3
