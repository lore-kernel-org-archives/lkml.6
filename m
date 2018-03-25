Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752292AbeCYWHp (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 18:07:45 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34387 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752112AbeCYWHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 18:07:42 -0400
Date: Sun, 25 Mar 2018 15:07:27 -0700
From: tip-bot for Martin Vuille <tipbot@zytor.com>
Message-ID: <tip-555fc3b1ef4c850c635be333024dcf67bc1e7cb8@git.kernel.org>
Cc: mingo@kernel.org, jpmv27@aim.com, linux-kernel@vger.kernel.org,
        hpa@zytor.com, kim.phillips@arm.com, tglx@linutronix.de,
        acme@redhat.com
Reply-To: jpmv27@aim.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
        hpa@zytor.com, tglx@linutronix.de, acme@redhat.com,
        kim.phillips@arm.com
In-Reply-To: <20180318175053.4222-1-jpmv27@aim.com>
References: <20180318175053.4222-1-jpmv27@aim.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf unwind: Report error from dwfl_attach_state
Git-Commit-ID: 555fc3b1ef4c850c635be333024dcf67bc1e7cb8
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  555fc3b1ef4c850c635be333024dcf67bc1e7cb8
Gitweb:     https://git.kernel.org/tip/555fc3b1ef4c850c635be333024dcf67bc1e7cb8
Author:     Martin Vuille <jpmv27@aim.com>
AuthorDate: Sun, 18 Mar 2018 13:50:53 -0400
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 20 Mar 2018 13:16:09 -0300

perf unwind: Report error from dwfl_attach_state

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
