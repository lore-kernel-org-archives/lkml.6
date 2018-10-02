Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9986DC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 659C4206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:29:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 659C4206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728231AbeJBVNZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 17:13:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42602 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726118AbeJBVNY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 17:13:24 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E1FCD307CF58
        for <linux-kernel@vger.kernel.org>; Tue,  2 Oct 2018 14:29:44 +0000 (UTC)
Received: from sansharm.bos.com (dhcp-17-34.bos.redhat.com [10.18.17.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 552C55C21A;
        Tue,  2 Oct 2018 14:29:44 +0000 (UTC)
From:   Sanskriti Sharma <sansharm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Joe Lawrence <joe.lawrence@redhat.com>
Subject: [PATCH 3/5] perf tools: free 'printk' string in parse_ftrace_printk()
Date:   Tue,  2 Oct 2018 10:29:12 -0400
Message-Id: <1538490554-8161-4-git-send-email-sansharm@redhat.com>
In-Reply-To: <1538490554-8161-1-git-send-email-sansharm@redhat.com>
References: <1538490554-8161-1-git-send-email-sansharm@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Tue, 02 Oct 2018 14:29:44 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 tools/perf/util/trace-event-parse.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/trace-event-parse.c b/tools/perf/util/trace-event-parse.c
index e76214f..b15a9bf 100644
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
1.8.3.1

