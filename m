Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE2EAC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 13:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8954F214DA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 13:57:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731466AbfBDN5H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 08:57:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:35760 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731441AbfBDN5G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 08:57:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A780BADC8;
        Mon,  4 Feb 2019 13:57:05 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>
Cc:     Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH v2 2/4] livepatch: return -ENOMEM on ptr_id() allocation failure
Date:   Mon,  4 Feb 2019 14:56:51 +0100
Message-Id: <20190204135653.31406-3-pmladek@suse.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20190204135653.31406-1-pmladek@suse.com>
References: <20190204135653.31406-1-pmladek@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joe Lawrence <joe.lawrence@redhat.com>

Fixes the following smatch warning:

  lib/livepatch/test_klp_shadow_vars.c:47 ptr_id() warn: returning -1 instead of -ENOMEM is sloppy

Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 lib/livepatch/test_klp_shadow_vars.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/livepatch/test_klp_shadow_vars.c b/lib/livepatch/test_klp_shadow_vars.c
index 02f892f941dc..f5441c193166 100644
--- a/lib/livepatch/test_klp_shadow_vars.c
+++ b/lib/livepatch/test_klp_shadow_vars.c
@@ -44,7 +44,7 @@ static int ptr_id(void *ptr)
 
 	sp = kmalloc(sizeof(*sp), GFP_ATOMIC);
 	if (!sp)
-		return -1;
+		return -ENOMEM;
 	sp->ptr = ptr;
 	sp->id = count++;
 
-- 
2.13.7

