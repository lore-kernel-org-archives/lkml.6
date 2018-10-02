Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 160C5C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 15:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D021F2082A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 15:32:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="V+CavKvW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D021F2082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbeJBWQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 18:16:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:39616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726762AbeJBWQi (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 18:16:38 -0400
Received: from jouet.infradead.org (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7CF3B20666;
        Tue,  2 Oct 2018 15:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538494360;
        bh=RVfYwr1ijWZ/Hpg7GyFnriOGZKHrMPBRS8PtmCAgAds=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V+CavKvWTk2jxhiD3DHfia79HQMfMN/tX6mhJjNhKgJyefuWm152Ctk2lWb2V6pNr
         NKuA/TeM/8+I5U+gzYsTBreL4CG19r/I84lrK2TpAJQg0kAZbcFY6y1gBsfoIKwSM3
         0W9gqIyTygU14djQlsm1RpBaPA8mXjze2TdWPABg=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 5D2E714024D; Tue,  2 Oct 2018 12:32:36 -0300 (-03)
Date:   Tue, 2 Oct 2018 12:32:36 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Milian Wolff <milian.wolff@kdab.com>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, Jin Yao <yao.jin@linux.intel.com>,
        Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf record: use unmapped IP for inline callchain cursors
Message-ID: <20181002153236.GD3541@kernel.org>
References: <20181002073949.3297-1-milian.wolff@kdab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181002073949.3297-1-milian.wolff@kdab.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Oct 02, 2018 at 09:39:49AM +0200, Milian Wolff escreveu:
> Only use the mapped IP to find inline frames, but keep
> using the unmapped IP for the callchain cursor. This
> ensures we properly show the unmapped IP when displaying
> a frame we received via the dso__parse_addr_inlines API
> for a module which does not contain sufficient debug symbols
> to show the srcline.

So, the patch came mangled, I fixed it up, please check, I'm adding Ravi
to the CC list, so that he can check as well and retest, right Ravi?

- Arnaldo

From d9ddee9653d5676130471de9bc688fc7ec7b4fc4 Mon Sep 17 00:00:00 2001
From: Milian Wolff <milian.wolff@kdab.com>
Date: Tue, 2 Oct 2018 09:39:49 +0200
Subject: [PATCH 1/1] perf record: use unmapped IP for inline callchain cursors

Only use the mapped IP to find inline frames, but keep using the unmapped IP
for the callchain cursor. This ensures we properly show the unmapped IP when
displaying a frame we received via the dso__parse_addr_inlines API for a module
which does not contain sufficient debug symbols to show the srcline.

Before:

  $ perf record -e cycles:u --call-graph ls
  $ perf script
  ...
  ls 12853  2735.563911:      43354 cycles:u:
                     17878 __GI___tunables_init+0xffff01d1d63a0118 (/usr/lib/ld-2.28.so)
                     19ee9 _dl_sysdep_start+0xffff01d1d63a02e9 (/usr/lib/ld-2.28.so)
                      3087 _dl_start+0xffff01d1d63a0287 (/usr/lib/ld-2.28.so)
                      2007 _start+0xffff01d1d63a0007 (/usr/lib/ld-2.28.so)

After:

  $ perf script
  ...
  ls 12853  2735.563911:      43354 cycles:u:
              7f1714e46878 __GI___tunables_init+0x118 (/usr/lib/ld-2.28.so)
              7f1714e48ee9 _dl_sysdep_start+0x2e9 (/usr/lib/ld-2.28.so)
              7f1714e32087 _dl_start+0x287 (/usr/lib/ld-2.28.so)
              7f1714e31007 _start+0x7 (/usr/lib/ld-2.28.so)

For frames with sufficient debug symbols, the behavior is still sane and works
as expected in my tests.

This patch series shows that we desperately need an automated test for inline
frame resolution. I'll try to come up with something for the various
regressions in the future.

Reported-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Fixes: bfe16b0653 ("perf report: Don't crash on invalid inline debug information")
Link: http://lkml.kernel.org/r/20181002073949.3297-1-milian.wolff@kdab.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/machine.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 73a651f10a0f..111ae858cbcb 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2286,7 +2286,8 @@ static int append_inlines(struct callchain_cursor *cursor,
 	if (!symbol_conf.inline_name || !map || !sym)
 		return ret;
 
-	addr = map__rip_2objdump(map, ip);
+	addr = map__map_ip(map, ip);
+	addr = map__rip_2objdump(map, addr);
 
 	inline_node = inlines__tree_find(&map->dso->inlined_nodes, addr);
 	if (!inline_node) {
@@ -2317,6 +2318,9 @@ static int unwind_entry(struct unwind_entry *entry, void *arg)
 	if (symbol_conf.hide_unresolved && entry->sym == NULL)
 		return 0;
 
+	if (append_inlines(cursor, entry->map, entry->sym, entry->ip) == 0)
+		return 0;
+
 	/*
 	 * Convert entry->ip from a virtual address to an offset in
 	 * its corresponding binary.
@@ -2324,9 +2328,6 @@ static int unwind_entry(struct unwind_entry *entry, void *arg)
 	if (entry->map)
 		addr = map__map_ip(entry->map, entry->ip);
 
-	if (append_inlines(cursor, entry->map, entry->sym, addr) == 0)
-		return 0;
-
 	srcline = callchain_srcline(entry->map, entry->sym, addr);
 	return callchain_cursor_append(cursor, entry->ip,
 				       entry->map, entry->sym,
-- 
2.14.4

