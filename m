Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C573C6787A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 00:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DE06214C5
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 00:55:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="epDPmOHP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DE06214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbeJIIJa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 04:09:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:42178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726911AbeJIIJ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 04:09:28 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D89A214C3;
        Tue,  9 Oct 2018 00:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539046507;
        bh=tXjBb5xPKFV8B+/KZZ5/btGmDOtOUNJnRBsj2ROM+U8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=epDPmOHPvf4bncgm9togJeYRy8cY27jZSzCnqVFmiaWO3HK08HA7O86+2dt4PBHY0
         TNuCuYCip2EOfjJUnbr3AAxsVe7g7GxyTR5Byq8WCNxQ/Ch37YUu9Lnkcpc49LRrmV
         Z8afos1vIKcz8rTXwD/9mxw8D0JNERszWEam2Dd4=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Sanskriti Sharma <sansharm@redhat.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 06/12] perf tools: Free 'printk' string in parse_ftrace_printk()
Date:   Mon,  8 Oct 2018 21:54:21 -0300
Message-Id: <20181009005427.6607-7-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181009005427.6607-1-acme@kernel.org>
References: <20181009005427.6607-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sanskriti Sharma <sansharm@redhat.com>

parse_ftrace_printk() tokenizes and parses a line, calling strdup() each
iteration.  Add code to free this temporary format string duplicate.

Fixes the following coverity complaints:

  Error: RESOURCE_LEAK (CWE-772):
  tools/perf/util/trace-event-parse.c:158: overwrite_var: Overwriting
  "printk" in "printk = strdup(fmt + 1)" leaks the storage that "printk"
  points to.

  tools/perf/util/trace-event-parse.c:162: leaked_storage: Variable
  "printk" going out of scope leaks the storage it points to.

Signed-off-by: Sanskriti Sharma <sansharm@redhat.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Joe Lawrence <joe.lawrence@redhat.com>
Link: http://lkml.kernel.org/r/1538490554-8161-4-git-send-email-sansharm@redhat.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/trace-event-parse.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/trace-event-parse.c b/tools/perf/util/trace-event-parse.c
index a4d7de1c96d1..02f97f5dd588 100644
--- a/tools/perf/util/trace-event-parse.c
+++ b/tools/perf/util/trace-event-parse.c
@@ -158,6 +158,7 @@ void parse_ftrace_printk(struct tep_handle *pevent,
 		printk = strdup(fmt+1);
 		line = strtok_r(NULL, "\n", &next);
 		tep_register_print_string(pevent, printk, addr);
+		free(printk);
 	}
 }
 
-- 
2.14.4

