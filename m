Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 0k4hHJfpGFsQVgAAmS7hNA
	; Thu, 07 Jun 2018 08:20:47 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id BC51E6089E; Thu,  7 Jun 2018 08:20:47 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 3CE0E60115;
	Thu,  7 Jun 2018 08:20:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3CE0E60115
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932529AbeFGIUn (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 04:20:43 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51383 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753262AbeFGIUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 04:20:41 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w578KZUd2125997
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 7 Jun 2018 01:20:35 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w578KZwl2125994;
        Thu, 7 Jun 2018 01:20:35 -0700
Date: Thu, 7 Jun 2018 01:20:35 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From: tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-97802f3b81dc0d1da0f89c498249547d73a01164@git.kernel.org>
Cc: hpa@zytor.com, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        acme@redhat.com, mingo@kernel.org, adrian.hunter@intel.com,
        jolsa@redhat.com
Reply-To: adrian.hunter@intel.com, mingo@kernel.org, jolsa@redhat.com,
          tglx@linutronix.de, hpa@zytor.com, acme@redhat.com,
          linux-kernel@vger.kernel.org
In-Reply-To: <1528183800-21577-1-git-send-email-adrian.hunter@intel.com>
References: <1528183800-21577-1-git-send-email-adrian.hunter@intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf map: Consider PTI entry trampolines in
 rip_2objdump()
Git-Commit-ID: 97802f3b81dc0d1da0f89c498249547d73a01164
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

Commit-ID:  97802f3b81dc0d1da0f89c498249547d73a01164
Gitweb:     https://git.kernel.org/tip/97802f3b81dc0d1da0f89c498249547d73a01164
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Tue, 5 Jun 2018 10:30:00 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 6 Jun 2018 12:52:06 -0300

perf map: Consider PTI entry trampolines in rip_2objdump()

perf tools uses map__rip_2objdump() to calculate objdump virtual addresses.
map__rip_2objdump() needs to be amended to deal with PTI entry trampolines.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/1528183800-21577-1-git-send-email-adrian.hunter@intel.com
[ split from a larger patch ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/map.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 92abc8e248c5..89ac5b5dc218 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -449,6 +449,20 @@ int map__fprintf_srcline(struct map *map, u64 addr, const char *prefix,
  */
 u64 map__rip_2objdump(struct map *map, u64 rip)
 {
+	struct kmap *kmap = __map__kmap(map);
+
+	/*
+	 * vmlinux does not have program headers for PTI entry trampolines and
+	 * kcore may not either. However the trampoline object code is on the
+	 * main kernel map, so just use that instead.
+	 */
+	if (kmap && is_entry_trampoline(kmap->name) && kmap->kmaps && kmap->kmaps->machine) {
+		struct map *kernel_map = machine__kernel_map(kmap->kmaps->machine);
+
+		if (kernel_map)
+			map = kernel_map;
+	}
+
 	if (!map->dso->adjust_symbols)
 		return rip;
 
