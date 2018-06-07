Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id +qeQAcXqGFvfBAAAmS7hNA
	; Thu, 07 Jun 2018 08:20:21 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id D9479607F7; Thu,  7 Jun 2018 08:20:20 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 4A99860115;
	Thu,  7 Jun 2018 08:20:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4A99860115
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932448AbeFGIUR (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 04:20:17 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41195 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753359AbeFGIUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 04:20:15 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w578K4d72125962
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 7 Jun 2018 01:20:04 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w578K4wB2125959;
        Thu, 7 Jun 2018 01:20:04 -0700
Date: Thu, 7 Jun 2018 01:20:04 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From: tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-f6c66d73bb8192d357bb5fb8cd5826920f811d8c@git.kernel.org>
Cc: adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
        jolsa@redhat.com, mingo@kernel.org, acme@redhat.com,
        tglx@linutronix.de, hpa@zytor.com
Reply-To: adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
          jolsa@redhat.com, mingo@kernel.org, acme@redhat.com,
          tglx@linutronix.de, hpa@zytor.com
In-Reply-To: <1528183800-21577-1-git-send-email-adrian.hunter@intel.com>
References: <1528183800-21577-1-git-send-email-adrian.hunter@intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf test code-reading: Fix perf_env setup for
 PTI entry trampolines
Git-Commit-ID: f6c66d73bb8192d357bb5fb8cd5826920f811d8c
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

Commit-ID:  f6c66d73bb8192d357bb5fb8cd5826920f811d8c
Gitweb:     https://git.kernel.org/tip/f6c66d73bb8192d357bb5fb8cd5826920f811d8c
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Tue, 5 Jun 2018 10:30:00 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 6 Jun 2018 12:52:05 -0300

perf test code-reading: Fix perf_env setup for PTI entry trampolines

The "Object code reading" test will not create maps for the PTI entry
trampolines unless the machine environment exists to show that the arch is
x86_64.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/1528183800-21577-1-git-send-email-adrian.hunter@intel.com
[ split from a larger patch ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/code-reading.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index afa4ce21ba7c..4892bd2dc33e 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -560,6 +560,7 @@ static int do_test_code_reading(bool try_kcore)
 	pid = getpid();
 
 	machine = machine__new_host();
+	machine->env = &perf_env;
 
 	ret = machine__create_kernel_maps(machine);
 	if (ret < 0) {
