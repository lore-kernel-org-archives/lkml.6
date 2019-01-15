Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B8F2C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 04:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02BAC20859
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 04:34:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbfAOEeO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 23:34:14 -0500
Received: from gateway22.websitewelcome.com ([192.185.47.168]:22793 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726769AbfAOEeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 23:34:14 -0500
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway22.websitewelcome.com (Postfix) with ESMTP id 5600BB138
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 22:34:13 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id jGQXgPnMM2qH7jGQXg3VCO; Mon, 14 Jan 2019 22:34:13 -0600
X-Authority-Reason: nr=8
Received: from [189.250.130.205] (port=38662 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gjGQW-004D4K-6f; Mon, 14 Jan 2019 22:34:12 -0600
Date:   Mon, 14 Jan 2019 22:34:08 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] tracing: Replace kzalloc with kcalloc
Message-ID: <20190115043408.GA23456@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.130.205
X-Source-L: No
X-Exim-ID: 1gjGQW-004D4K-6f
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.130.205]:38662
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace kzalloc() function with its 2-factor argument form, kcalloc().

This patch replaces cases of:

	kzalloc(a * b, gfp)

with:
	kcalloc(a * b, gfp)

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 kernel/trace/trace_probe.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 9962cb5da8ac..57f0cbaf9c58 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -429,7 +429,7 @@ static int traceprobe_parse_probe_arg_body(char *arg, ssize_t *size,
 			 parg->count);
 	}
 
-	code = tmp = kzalloc(sizeof(*code) * FETCH_INSN_MAX, GFP_KERNEL);
+	code = tmp = kcalloc(FETCH_INSN_MAX, sizeof(*code), GFP_KERNEL);
 	if (!code)
 		return -ENOMEM;
 	code[FETCH_INSN_MAX - 1].op = FETCH_OP_END;
@@ -501,7 +501,7 @@ static int traceprobe_parse_probe_arg_body(char *arg, ssize_t *size,
 	code->op = FETCH_OP_END;
 
 	/* Shrink down the code buffer */
-	parg->code = kzalloc(sizeof(*code) * (code - tmp + 1), GFP_KERNEL);
+	parg->code = kcalloc(code - tmp + 1, sizeof(*code), GFP_KERNEL);
 	if (!parg->code)
 		ret = -ENOMEM;
 	else
-- 
2.20.1

