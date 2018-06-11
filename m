Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 871FAC5CFF0
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 17:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D0D8208B0
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 17:50:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RZEb4+3j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D0D8208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934023AbeFKRt7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 13:49:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:35418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933851AbeFKRtG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 13:49:06 -0400
Received: from jouet.infradead.org (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4023E208B5;
        Mon, 11 Jun 2018 17:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528739346;
        bh=vC0iTR38MDoB7tlS2AZJ9BZv4XtRO4lcBRGcC0bE1p0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RZEb4+3jpUIDfMYBMWUB6Z3WaJZBaricgNbCDnUhq4V1Jr/jw9K2ZSrZ7k/9i0hc4
         Fu/X+wEH3UVmQ1Z45HAbO5T+YPgJw9YHage8eYGVET/t7IEB762kuXg4rLTNStizmc
         V0vd/x1uUJ5z7d/BCu+J1FpURxflLeuEjPsXy0v8=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 11/12] perf c2c: Keep struct hist_entry at the end of struct c2c_hist_entry
Date:   Mon, 11 Jun 2018 14:48:09 -0300
Message-Id: <20180611174810.14815-12-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180611174810.14815-1-acme@kernel.org>
References: <20180611174810.14815-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@redhat.com>

Exactly as the comment just before 'struct c2c_hist_entry" says, i.e.
the last entry in struct hist_entry is a zero length array, that when
allocating space for hist_entry gets extra space if callchains are in
use, which, if hist_entry is not at the end of c2c_hist_entry, the
members after it gets corrupted when callchains get added to the rb
trees collecting them, etc.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Reported-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jin Yao <yao.jin@linux.intel.com>
Fixes: 7f834c2e84bb ("perf c2c report: Display node for cacheline address")
Link: http://lkml.kernel.org/n/tip-bh0ke4fh2ygpj3yowna7o1di@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-c2c.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 307b3594525f..6a8738f7ead3 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -56,16 +56,16 @@ struct c2c_hist_entry {
 
 	struct compute_stats	 cstats;
 
+	unsigned long		 paddr;
+	unsigned long		 paddr_cnt;
+	bool			 paddr_zero;
+	char			*nodestr;
+
 	/*
 	 * must be at the end,
 	 * because of its callchain dynamic entry
 	 */
 	struct hist_entry	he;
-
-	unsigned long		 paddr;
-	unsigned long		 paddr_cnt;
-	bool			 paddr_zero;
-	char			*nodestr;
 };
 
 static char const *coalesce_default = "pid,iaddr";
-- 
2.14.3

