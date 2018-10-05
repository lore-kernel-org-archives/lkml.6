Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E862DC65BA7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6ED82147D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:20:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6ED82147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730086AbeJEXTv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 19:19:51 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53515 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727798AbeJEXTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:19:50 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w95GK3eM3206431
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 5 Oct 2018 09:20:03 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w95GK3IY3206428;
        Fri, 5 Oct 2018 09:20:03 -0700
Date:   Fri, 5 Oct 2018 09:20:03 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Milian Wolff <tipbot@zytor.com>
Message-ID: <tip-ff4ce2885af8f9e8e99864d78dbeb4673f089c76@git.kernel.org>
Cc:     milian.wolff@kdab.com, jolsa@kernel.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, yao.jin@linux.intel.com,
        tglx@linutronix.de, acme@redhat.com, hpa@zytor.com,
        sandipan@linux.ibm.com, namhyung@kernel.org
Reply-To: linux-kernel@vger.kernel.org, mingo@kernel.org, jolsa@kernel.org,
          milian.wolff@kdab.com, yao.jin@linux.intel.com,
          tglx@linutronix.de, hpa@zytor.com, acme@redhat.com,
          namhyung@kernel.org, sandipan@linux.ibm.com
In-Reply-To: <20180926135207.30263-1-milian.wolff@kdab.com>
References: <20180926135207.30263-1-milian.wolff@kdab.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf report: Don't try to map ip to invalid map
Git-Commit-ID: ff4ce2885af8f9e8e99864d78dbeb4673f089c76
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

Commit-ID:  ff4ce2885af8f9e8e99864d78dbeb4673f089c76
Gitweb:     https://git.kernel.org/tip/ff4ce2885af8f9e8e99864d78dbeb4673f089c76
Author:     Milian Wolff <milian.wolff@kdab.com>
AuthorDate: Wed, 26 Sep 2018 15:52:05 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 27 Sep 2018 16:05:43 -0300

perf report: Don't try to map ip to invalid map

Fixes a crash when the report encounters an address that could not be
associated with an mmaped region:

  #0  0x00005555557bdc4a in callchain_srcline (ip=<error reading variable: Cannot access memory at address 0x38>, sym=0x0, map=0x0) at util/machine.c:2329
  #1  unwind_entry (entry=entry@entry=0x7fffffff9180, arg=arg@entry=0x7ffff5642498) at util/machine.c:2329
  #2  0x00005555558370af in entry (arg=0x7ffff5642498, cb=0x5555557bdb50 <unwind_entry>, thread=<optimized out>, ip=18446744073709551615) at util/unwind-libunwind-local.c:586
  #3  get_entries (ui=ui@entry=0x7fffffff9620, cb=0x5555557bdb50 <unwind_entry>, arg=0x7ffff5642498, max_stack=<optimized out>) at util/unwind-libunwind-local.c:703
  #4  0x0000555555837192 in _unwind__get_entries (cb=<optimized out>, arg=<optimized out>, thread=<optimized out>, data=<optimized out>, max_stack=<optimized out>) at util/unwind-libunwind-local.c:725
  #5  0x00005555557c310f in thread__resolve_callchain_unwind (max_stack=127, sample=0x7fffffff9830, evsel=0x555555c7b3b0, cursor=0x7ffff5642498, thread=0x555555c7f6f0) at util/machine.c:2351
  #6  thread__resolve_callchain (thread=0x555555c7f6f0, cursor=0x7ffff5642498, evsel=0x555555c7b3b0, sample=0x7fffffff9830, parent=0x7fffffff97b8, root_al=0x7fffffff9750, max_stack=127) at util/machine.c:2378
  #7  0x00005555557ba4ee in sample__resolve_callchain (sample=<optimized out>, cursor=<optimized out>, parent=parent@entry=0x7fffffff97b8, evsel=<optimized out>, al=al@entry=0x7fffffff9750,
      max_stack=<optimized out>) at util/callchain.c:1085

Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
Tested-by: Sandipan Das <sandipan@linux.ibm.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Fixes: 2a9d5050dc84 ("perf script: Show correct offsets for DWARF-based unwinding")
Link: http://lkml.kernel.org/r/20180926135207.30263-1-milian.wolff@kdab.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/machine.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index c4acd2001db0..0cb4f8bf3ca7 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2312,7 +2312,7 @@ static int unwind_entry(struct unwind_entry *entry, void *arg)
 {
 	struct callchain_cursor *cursor = arg;
 	const char *srcline = NULL;
-	u64 addr;
+	u64 addr = entry->ip;
 
 	if (symbol_conf.hide_unresolved && entry->sym == NULL)
 		return 0;
@@ -2324,7 +2324,8 @@ static int unwind_entry(struct unwind_entry *entry, void *arg)
 	 * Convert entry->ip from a virtual address to an offset in
 	 * its corresponding binary.
 	 */
-	addr = map__map_ip(entry->map, entry->ip);
+	if (entry->map)
+		addr = map__map_ip(entry->map, entry->ip);
 
 	srcline = callchain_srcline(entry->map, entry->sym, addr);
 	return callchain_cursor_append(cursor, entry->ip,
