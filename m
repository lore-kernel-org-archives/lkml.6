Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 790C7C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35BFF2054F
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:53:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qnMWHs01"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35BFF2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbeKAIyB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:54:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:52956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727552AbeKAIGL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:06:11 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D1E72082E;
        Wed, 31 Oct 2018 23:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027161;
        bh=gyYrjgLiCJXkKVjzf2Xc6952N5UhCjlaU81NE6QViJ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qnMWHs0149XaQID+j+JWZpjqWYyY+JJohOfru9v4gGOrEc08OgOLAjRoc5MuEzAuZ
         DoLvMPK23A6UhXBx7ZIO2k5vhI4/N+jXLr3+zJR4HY+1ECyRbaWl6UDepaXM5pjiNb
         UoID4BpDPbT0d6W5BvVPpNKLTsxVNI9uUg1Nw/cg=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sanskriti Sharma <sansharm@redhat.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 020/146] perf tools: Free 'printk' string in parse_ftrace_printk()
Date:   Wed, 31 Oct 2018 19:03:35 -0400
Message-Id: <20181031230541.28822-20-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230541.28822-1-sashal@kernel.org>
References: <20181031230541.28822-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sanskriti Sharma <sansharm@redhat.com>

[ Upstream commit 9c8a182e5a73e01afd11742a2ab887bf338fdafd ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/trace-event-parse.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/trace-event-parse.c b/tools/perf/util/trace-event-parse.c
index e76214f8d596..b15a9bf1837b 100644
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
2.17.1

