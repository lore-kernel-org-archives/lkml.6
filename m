Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE339C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 21:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8F01218FE
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 21:42:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728737AbfAaVmZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 16:42:25 -0500
Received: from gateway34.websitewelcome.com ([192.185.148.200]:25749 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726233AbfAaVmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 16:42:24 -0500
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id 5B29C802E
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 15:42:23 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id pK6JgLG4b2PzOpK6JgtTKM; Thu, 31 Jan 2019 15:42:23 -0600
X-Authority-Reason: nr=8
Received: from [189.250.82.227] (port=52988 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gpK6I-001mwt-PC; Thu, 31 Jan 2019 15:42:22 -0600
Date:   Thu, 31 Jan 2019 15:42:21 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] ipc/sem.c: replace kvmalloc/memset with kvzalloc and use
 struct_size
Message-ID: <20190131214221.GA28930@embeddedor>
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
X-Source-IP: 189.250.82.227
X-Source-L: No
X-Exim-ID: 1gpK6I-001mwt-PC
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.82.227]:52988
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kvzalloc() instead of kvmalloc() and memset().

Also, make use of the struct_size() helper instead of
the open-coded version in order to avoid any potential
type mistakes.

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 ipc/sem.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/ipc/sem.c b/ipc/sem.c
index a188d1b064ea..7da4504bcc7c 100644
--- a/ipc/sem.c
+++ b/ipc/sem.c
@@ -488,18 +488,14 @@ static inline void sem_rmid(struct ipc_namespace *ns, struct sem_array *s)
 static struct sem_array *sem_alloc(size_t nsems)
 {
 	struct sem_array *sma;
-	size_t size;
 
 	if (nsems > (INT_MAX - sizeof(*sma)) / sizeof(sma->sems[0]))
 		return NULL;
 
-	size = sizeof(*sma) + nsems * sizeof(sma->sems[0]);
-	sma = kvmalloc(size, GFP_KERNEL);
+	sma = kvzalloc(struct_size(sma, sems, nsems), GFP_KERNEL);
 	if (unlikely(!sma))
 		return NULL;
 
-	memset(sma, 0, size);
-
 	return sma;
 }
 
-- 
2.20.1

