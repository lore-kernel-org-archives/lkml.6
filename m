Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 739ABECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3947A20883
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:10:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2llYmEWo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3947A20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbeJYWni (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:43:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:52134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727656AbeJYWng (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:43:36 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 166052083E;
        Thu, 25 Oct 2018 14:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540476641;
        bh=LeUvGKhhM1YdziZPPkuTEsGZckdJeormlkKPNV+vZCk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2llYmEWodApQCHTfsI8SnrATeh4ajAxPq3/OjEjnXVRidt2NiV24c9WD4cNqHomHE
         68oyJVR98cGfs+kE2w1rGhRwcQqfu7hZ4isEXXBo/Or+M7f1rrnZ3kS5En1hNn4RyW
         G1G6Htd0TMA5Bt2BGyX0aLT1UuDfvtDG4rY6odDM=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Milian Wolff <milian.wolff@kdab.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 6/8] perf report: Don't try to map ip to invalid map
Date:   Thu, 25 Oct 2018 10:10:27 -0400
Message-Id: <20181025141029.213274-6-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141029.213274-1-sashal@kernel.org>
References: <20181025141029.213274-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Milian Wolff <milian.wolff@kdab.com>

[ Upstream commit ff4ce2885af8f9e8e99864d78dbeb4673f089c76 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/machine.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 22dbb6612b41..d49744dc46d7 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2272,7 +2272,7 @@ static int unwind_entry(struct unwind_entry *entry, void *arg)
 {
 	struct callchain_cursor *cursor = arg;
 	const char *srcline = NULL;
-	u64 addr;
+	u64 addr = entry->ip;
 
 	if (symbol_conf.hide_unresolved && entry->sym == NULL)
 		return 0;
@@ -2284,7 +2284,8 @@ static int unwind_entry(struct unwind_entry *entry, void *arg)
 	 * Convert entry->ip from a virtual address to an offset in
 	 * its corresponding binary.
 	 */
-	addr = map__map_ip(entry->map, entry->ip);
+	if (entry->map)
+		addr = map__map_ip(entry->map, entry->ip);
 
 	srcline = callchain_srcline(entry->map, entry->sym, addr);
 	return callchain_cursor_append(cursor, entry->ip,
-- 
2.17.1

