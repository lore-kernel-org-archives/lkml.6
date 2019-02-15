Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B168C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C9AD2192C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:33:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393303AbfBOJcy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 04:32:54 -0500
Received: from terminus.zytor.com ([198.137.202.136]:45761 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392868AbfBOJcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 04:32:41 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1F9WLYl1116732
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 15 Feb 2019 01:32:21 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1F9WLB91116727;
        Fri, 15 Feb 2019 01:32:21 -0800
Date:   Fri, 15 Feb 2019 01:32:21 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Song Liu <tipbot@zytor.com>
Message-ID: <tip-39f4a913d6d439178177cae8aa2e9a232160fd51@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, songliubraving@fb.com, hpa@zytor.com,
        jolsa@kernel.org, davidca@fb.com, acme@redhat.com,
        tglx@linutronix.de, mingo@kernel.org
Reply-To: mingo@kernel.org, tglx@linutronix.de, acme@redhat.com,
          davidca@fb.com, jolsa@kernel.org, songliubraving@fb.com,
          hpa@zytor.com, linux-kernel@vger.kernel.org
In-Reply-To: <20190204193140.719740-1-songliubraving@fb.com>
References: <20190204193140.719740-1-songliubraving@fb.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf utils: Silence "Couldn't synthesize bpf
 events" warning for EPERM
Git-Commit-ID: 39f4a913d6d439178177cae8aa2e9a232160fd51
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

Commit-ID:  39f4a913d6d439178177cae8aa2e9a232160fd51
Gitweb:     https://git.kernel.org/tip/39f4a913d6d439178177cae8aa2e9a232160fd51
Author:     Song Liu <songliubraving@fb.com>
AuthorDate: Mon, 4 Feb 2019 11:31:40 -0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 14 Feb 2019 13:31:11 -0300

perf utils: Silence "Couldn't synthesize bpf events" warning for EPERM

Synthesizing BPF events is only supported for root. Silent warning msg
when non-root user runs perf-record.

Reported-by: David Carrillo-Cisneros <davidca@fb.com>
Signed-off-by: Song Liu <songliubraving@fb.com>
Tested-by: David Carrillo-Cisneros <davidca@fb.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: kernel-team@fb.com
Link: http://lkml.kernel.org/r/20190204193140.719740-1-songliubraving@fb.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/bpf-event.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index 796ef793f4ce..62dda96b0096 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -236,8 +236,8 @@ int perf_event__synthesize_bpf_events(struct perf_tool *tool,
 			pr_debug("%s: can't get next program: %s%s",
 				 __func__, strerror(errno),
 				 errno == EINVAL ? " -- kernel too old?" : "");
-			/* don't report error on old kernel */
-			err = (errno == EINVAL) ? 0 : -1;
+			/* don't report error on old kernel or EPERM  */
+			err = (errno == EINVAL || errno == EPERM) ? 0 : -1;
 			break;
 		}
 		fd = bpf_prog_get_fd_by_id(id);
