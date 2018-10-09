Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD43C64EB0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 05:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76ACB20841
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 05:30:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76ACB20841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbeJIMpn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 08:45:43 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58451 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbeJIMpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 08:45:43 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w995UTAe910209
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 8 Oct 2018 22:30:29 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w995UTfT910206;
        Mon, 8 Oct 2018 22:30:29 -0700
Date:   Mon, 8 Oct 2018 22:30:29 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Sanskriti Sharma <tipbot@zytor.com>
Message-ID: <tip-9c8a182e5a73e01afd11742a2ab887bf338fdafd@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, jolsa@kernel.org,
        hpa@zytor.com, acme@redhat.com, mingo@kernel.org,
        sansharm@redhat.com, joe.lawrence@redhat.com
Reply-To: hpa@zytor.com, acme@redhat.com, sansharm@redhat.com,
          mingo@kernel.org, joe.lawrence@redhat.com, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, jolsa@kernel.org
In-Reply-To: <1538490554-8161-4-git-send-email-sansharm@redhat.com>
References: <1538490554-8161-4-git-send-email-sansharm@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tools: Free 'printk' string in
 parse_ftrace_printk()
Git-Commit-ID: 9c8a182e5a73e01afd11742a2ab887bf338fdafd
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

Commit-ID:  9c8a182e5a73e01afd11742a2ab887bf338fdafd
Gitweb:     https://git.kernel.org/tip/9c8a182e5a73e01afd11742a2ab887bf338fdafd
Author:     Sanskriti Sharma <sansharm@redhat.com>
AuthorDate: Tue, 2 Oct 2018 10:29:12 -0400
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 8 Oct 2018 14:23:45 -0300

perf tools: Free 'printk' string in parse_ftrace_printk()

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
 
