Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754405AbeCRRvJ (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 13:51:09 -0400
Received: from omr-a018e.mx.aol.com ([204.29.186.64]:33060 "EHLO
        omr-a018e.mx.aol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754140AbeCRRvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 13:51:07 -0400
From: Martin Vuille <jpmv27@aim.com>
To: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Martin Vuille <jpmv27@aim.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] perf unwind: Report error from dwfl_attach_state
Date: Sun, 18 Mar 2018 13:50:53 -0400
Message-Id: <20180318175053.4222-1-jpmv27@aim.com>
X-Mailer: git-send-email 2.13.6
x-aol-global-disposition: G
x-aol-sid: 3039ac1b01e25aaea70908dc
X-AOL-IP: 99.246.128.134
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In verbose level 2, errors returned by libdw are reported in most cases,
but not when calling dwfl_attach_state.

Since elfutils v 0.160 (2014), dwfl_attach_state sets the error code to
report failure cause. On failure, log the reported error.

Signed-off-by: Martin Vuille <jpmv27@aim.com>
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
2.13.6
