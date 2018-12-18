Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3850C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B34A6217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545170916;
	bh=rnToFWNrk7jFBtRtcS03Q3nSig796dOxdaSYH3HlVVQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=C05itplyGRayAhel6gOhmbVWMyyXWpkN0EsKnMg1HyuXCw9ahsW4ymkHhZ3G+SbXt
	 Jb52GBjoU/HLpOgjWrH0ic19+5oy1rh1hNyD2zgM3m6Cx0oD9rmytKur+E6d691Fqq
	 yP+yR6xN+Dr1An1138hyBb8OpQdA2azAGqs/zCek=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbeLRWIf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 17:08:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:36388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727675AbeLRWId (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 17:08:33 -0500
Received: from quaco.ghostprotocols.net (unknown [189.40.101.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1AAF0217D9;
        Tue, 18 Dec 2018 22:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545170913;
        bh=rnToFWNrk7jFBtRtcS03Q3nSig796dOxdaSYH3HlVVQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pyx9BNVVIAcFwyM0HJr7vtA83ewmPpd3EJ9P6ov/l4Nbu6tn6K3DOMW4fLF7FW3f1
         xqpMGdZ74YtqkznG+7uZ3GkMNkd6oR8FIzS/XqQ35aPrTJEm0OUBO0Bat61NQM+t9j
         TVvyBO/xUx3A0hQXMksdDGyT9BeM2Rh9ZsV8+YYU=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-trace-devel@vger.kernel.org, stable@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 05/63] tools lib traceevent: Fix processing of dereferenced args in bprintk events
Date:   Tue, 18 Dec 2018 19:06:35 -0300
Message-Id: <20181218220733.15839-6-acme@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181218220733.15839-1-acme@kernel.org>
References: <20181218220733.15839-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

In the case that a bprintk event has a dereferenced pointer that is
stored as a string, and there's more values to process (more args), the
arg was not updated to point to the next arg after processing the
dereferenced pointer, and it screwed up what was to be displayed.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: linux-trace-devel@vger.kernel.org
Cc: stable@vger.kernel.org
Fixes: 37db96bb49629 ("tools lib traceevent: Handle new pointer processing of bprint strings")
Link: http://lkml.kernel.org/r/20181210134522.3f71e2ca@gandalf.local.home
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/traceevent/event-parse.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
index a5ed291b8a9f..69a96e39f0ab 100644
--- a/tools/lib/traceevent/event-parse.c
+++ b/tools/lib/traceevent/event-parse.c
@@ -4973,6 +4973,7 @@ static void pretty_print(struct trace_seq *s, void *data, int size, struct tep_e
 
 				if (arg->type == TEP_PRINT_BSTRING) {
 					trace_seq_puts(s, arg->string.string);
+					arg = arg->next;
 					break;
 				}
 
-- 
2.19.2

