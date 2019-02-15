Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0875C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B033F21B68
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550191804;
	bh=Tlzvqd7rT0vT27LkD/x/7ZYS7d/ASpxw3AQ63kHE4jE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IyS6u2eqmV1RbbtKvjVcCMsTMdtTml6wzqWKyxAwWrQpqAZXb6H05qH+JpOoUR77S
	 1ezk32LwbwdJ927DsZ/mXaEb6uMbTwkQ7nyq3/1/oz/XrCC2p9dN8Kjc8XtqDM22hx
	 1n6Ln2S+b64EIXhtYsFvQGj9LOLpRTH0gyEjiVtE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388683AbfBOAqr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 19:46:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:45244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388636AbfBOAqo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 19:46:44 -0500
Received: from quaco.ghostprotocols.net (unknown [189.40.103.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E27FD21B68;
        Fri, 15 Feb 2019 00:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550191603;
        bh=Tlzvqd7rT0vT27LkD/x/7ZYS7d/ASpxw3AQ63kHE4jE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ygxZdcJDkIxPPKgxZaPCeO+tJ2YtxU+OkOdoqy4Sr2INxMY3+pMyAAO0iNuO+OTjL
         pyZOuHOho/mjGpO4TNW9a43P2o5GvWfu0/sEfG4NGiQIx7kwbehtyqYu2gLu2burS4
         m3hrf4ARTdgwCdOeMGl91v/azGrZn4tDO4qerPh4=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Song Liu <songliubraving@fb.com>, kernel-team@fb.com,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 12/43] perf utils: Silence "Couldn't synthesize bpf events" warning for EPERM
Date:   Thu, 14 Feb 2019 21:45:08 -0300
Message-Id: <20190215004539.23571-13-acme@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215004539.23571-1-acme@kernel.org>
References: <20190215004539.23571-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Song Liu <songliubraving@fb.com>

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
-- 
2.19.1

