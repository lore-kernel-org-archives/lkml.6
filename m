Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B881AC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 01:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDFD120862
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 01:00:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDFD120862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732230AbeHBCt3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 22:49:29 -0400
Received: from gateway33.websitewelcome.com ([192.185.146.68]:26493 "EHLO
        gateway33.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729888AbeHBCt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 22:49:29 -0400
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id 6BAE446BAC
        for <linux-kernel@vger.kernel.org>; Wed,  1 Aug 2018 20:00:57 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id l1z7fENIXaSeyl1z7fnYE9; Wed, 01 Aug 2018 20:00:57 -0500
X-Authority-Reason: nr=8
Received: from [189.250.61.218] (port=43456 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1fl1z6-0022cA-Uj; Wed, 01 Aug 2018 20:00:57 -0500
Date:   Wed, 1 Aug 2018 20:00:56 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] ftrace: Use true and false for boolean values
Message-ID: <20180802010056.GA31012@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.61.218
X-Source-L: No
X-Exim-ID: 1fl1z6-0022cA-Uj
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.61.218]:43456
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return statements in functions returning bool should use true or false
instead of an integer value.

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 kernel/trace/ftrace.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index caf9cbf..21574b4 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -2927,22 +2927,22 @@ ops_references_rec(struct ftrace_ops *ops, struct dyn_ftrace *rec)
 {
 	/* If ops isn't enabled, ignore it */
 	if (!(ops->flags & FTRACE_OPS_FL_ENABLED))
-		return 0;
+		return false;
 
 	/* If ops traces all then it includes this function */
 	if (ops_traces_mod(ops))
-		return 1;
+		return true;
 
 	/* The function must be in the filter */
 	if (!ftrace_hash_empty(ops->func_hash->filter_hash) &&
 	    !__ftrace_lookup_ip(ops->func_hash->filter_hash, rec->ip))
-		return 0;
+		return false;
 
 	/* If in notrace hash, we ignore it too */
 	if (ftrace_lookup_ip(ops->func_hash->notrace_hash, rec->ip))
-		return 0;
+		return false;
 
-	return 1;
+	return true;
 }
 
 static int ftrace_update_code(struct module *mod, struct ftrace_page *new_pgs)
-- 
2.7.4

