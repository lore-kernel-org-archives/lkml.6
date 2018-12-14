Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3722C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 495272080F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:27:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730858AbeLNU1w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 15:27:52 -0500
Received: from terminus.zytor.com ([198.137.202.136]:59525 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730832AbeLNU1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 15:27:52 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBEKRjWn1453642
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 14 Dec 2018 12:27:45 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBEKRjBS1453638;
        Fri, 14 Dec 2018 12:27:45 -0800
Date:   Fri, 14 Dec 2018 12:27:45 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-932d0166b1dbc2a631ac718615efc4917412ecf3@git.kernel.org>
Cc:     jolsa@redhat.com, adrian.hunter@intel.com, tglx@linutronix.de,
        hpa@zytor.com, acme@redhat.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org
Reply-To: acme@redhat.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
          adrian.hunter@intel.com, hpa@zytor.com, tglx@linutronix.de,
          jolsa@redhat.com
In-Reply-To: <b7c5b4e5-9497-10e5-fd43-5f3e4a0fe51d@intel.com>
References: <b7c5b4e5-9497-10e5-fd43-5f3e4a0fe51d@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf intel-pt: Fix error with config term "pt=0"
Git-Commit-ID: 932d0166b1dbc2a631ac718615efc4917412ecf3
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

Commit-ID:  932d0166b1dbc2a631ac718615efc4917412ecf3
Gitweb:     https://git.kernel.org/tip/932d0166b1dbc2a631ac718615efc4917412ecf3
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Mon, 26 Nov 2018 14:12:52 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 29 Nov 2018 20:42:49 -0300

perf intel-pt: Fix error with config term "pt=0"

Users should never use 'pt=0', but if they do it may give a meaningless
error:

	$ perf record -e intel_pt/pt=0/u uname
	Error:
	The sys_perf_event_open() syscall returned with 22 (Invalid argument) for
	event (intel_pt/pt=0/u).

Fix that by forcing 'pt=1'.

Committer testing:

  # perf record -e intel_pt/pt=0/u uname
  Error:
  The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (intel_pt/pt=0/u).
  /bin/dmesg | grep -i perf may provide additional information.

  # perf record -e intel_pt/pt=0/u uname
  pt=0 doesn't make sense, forcing pt=1
  Linux
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.020 MB perf.data ]
  #

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/b7c5b4e5-9497-10e5-fd43-5f3e4a0fe51d@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/x86/util/intel-pt.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index db0ba8caf5a2..ba8ecaf52200 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -524,10 +524,21 @@ static int intel_pt_validate_config(struct perf_pmu *intel_pt_pmu,
 				    struct perf_evsel *evsel)
 {
 	int err;
+	char c;
 
 	if (!evsel)
 		return 0;
 
+	/*
+	 * If supported, force pass-through config term (pt=1) even if user
+	 * sets pt=0, which avoids senseless kernel errors.
+	 */
+	if (perf_pmu__scan_file(intel_pt_pmu, "format/pt", "%c", &c) == 1 &&
+	    !(evsel->attr.config & 1)) {
+		pr_warning("pt=0 doesn't make sense, forcing pt=1\n");
+		evsel->attr.config |= 1;
+	}
+
 	err = intel_pt_val_config_term(intel_pt_pmu, "caps/cycle_thresholds",
 				       "cyc_thresh", "caps/psb_cyc",
 				       evsel->attr.config);
