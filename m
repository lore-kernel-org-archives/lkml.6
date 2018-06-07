Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 39IaKCrqGFv+WAAAmS7hNA
	; Thu, 07 Jun 2018 08:18:15 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id F16B36089E; Thu,  7 Jun 2018 08:18:14 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 66A8D60115;
	Thu,  7 Jun 2018 08:18:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 66A8D60115
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932515AbeFGISL (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 04:18:11 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54731 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752575AbeFGISJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 04:18:09 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w578I0652125640
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 7 Jun 2018 01:18:00 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w578I0sH2125637;
        Thu, 7 Jun 2018 01:18:00 -0700
Date: Thu, 7 Jun 2018 01:18:00 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From: tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-aef4feace285f27c8ed35830a5d575bec7f3e90a@git.kernel.org>
Cc: acme@redhat.com, linux-kernel@vger.kernel.org, hpa@zytor.com,
        adrian.hunter@intel.com, tglx@linutronix.de, jolsa@redhat.com,
        mingo@kernel.org, wangnan0@huawei.com
Reply-To: mingo@kernel.org, jolsa@redhat.com, wangnan0@huawei.com,
          acme@redhat.com, tglx@linutronix.de, adrian.hunter@intel.com,
          hpa@zytor.com, linux-kernel@vger.kernel.org
In-Reply-To: <1528117014-30032-3-git-send-email-adrian.hunter@intel.com>
References: <1528117014-30032-3-git-send-email-adrian.hunter@intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf tools: Fix symbol and object code resolution
 for vdso32 and vdsox32
Git-Commit-ID: aef4feace285f27c8ed35830a5d575bec7f3e90a
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

Commit-ID:  aef4feace285f27c8ed35830a5d575bec7f3e90a
Gitweb:     https://git.kernel.org/tip/aef4feace285f27c8ed35830a5d575bec7f3e90a
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Mon, 4 Jun 2018 15:56:54 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 6 Jun 2018 12:52:04 -0300

perf tools: Fix symbol and object code resolution for vdso32 and vdsox32

Fix __kmod_path__parse() so that perf tools does not treat vdso32 and
vdsox32 as kernel modules and fail to find the object.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Wang Nan <wangnan0@huawei.com>
Cc: stable@vger.kernel.org
Fixes: 1f121b03d058 ("perf tools: Deal with kernel module names in '[]' correctly")
Link: http://lkml.kernel.org/r/1528117014-30032-3-git-send-email-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/dso.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index cdfc2e5f55f5..51cf82cf1882 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -354,6 +354,8 @@ int __kmod_path__parse(struct kmod_path *m, const char *path,
 		if ((strncmp(name, "[kernel.kallsyms]", 17) == 0) ||
 		    (strncmp(name, "[guest.kernel.kallsyms", 22) == 0) ||
 		    (strncmp(name, "[vdso]", 6) == 0) ||
+		    (strncmp(name, "[vdso32]", 8) == 0) ||
+		    (strncmp(name, "[vdsox32]", 9) == 0) ||
 		    (strncmp(name, "[vsyscall]", 10) == 0)) {
 			m->kmod = false;
 
