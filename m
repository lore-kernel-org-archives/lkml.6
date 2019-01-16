Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D908C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 429A520859
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:18:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405341AbfAPQRt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 11:17:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:38680 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729517AbfAPQRs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 11:17:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BECC4AEB1;
        Wed, 16 Jan 2019 16:17:46 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>
Cc:     Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH 2/4] livepatch: Handle failing allocation of shadow variables in the selftest
Date:   Wed, 16 Jan 2019 17:17:18 +0100
Message-Id: <20190116161720.796-3-pmladek@suse.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20190116161720.796-1-pmladek@suse.com>
References: <20190116161720.796-1-pmladek@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not dereference pointers to the shadow variables when either
klp_shadow_alloc() or klp_shadow_get() fail.

There is no need to check the other locations explicitly. The test
would fail if any allocation fails. And the existing messages, printed
during the test, provide enough information to debug eventual problems.

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 lib/livepatch/test_klp_shadow_vars.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/livepatch/test_klp_shadow_vars.c b/lib/livepatch/test_klp_shadow_vars.c
index 02f892f941dc..55e6820430dc 100644
--- a/lib/livepatch/test_klp_shadow_vars.c
+++ b/lib/livepatch/test_klp_shadow_vars.c
@@ -162,15 +162,15 @@ static int test_klp_shadow_vars_init(void)
 	 * to expected data.
 	 */
 	ret = shadow_get(obj, id);
-	if (ret == sv1 && *sv1 == &var1)
+	if (ret && ret == sv1 && *sv1 == &var1)
 		pr_info("  got expected PTR%d -> PTR%d result\n",
 			ptr_id(sv1), ptr_id(*sv1));
 	ret = shadow_get(obj + 1, id);
-	if (ret == sv2 && *sv2 == &var2)
+	if (ret && ret == sv2 && *sv2 == &var2)
 		pr_info("  got expected PTR%d -> PTR%d result\n",
 			ptr_id(sv2), ptr_id(*sv2));
 	ret = shadow_get(obj, id + 1);
-	if (ret == sv3 && *sv3 == &var3)
+	if (ret && ret == sv3 && *sv3 == &var3)
 		pr_info("  got expected PTR%d -> PTR%d result\n",
 			ptr_id(sv3), ptr_id(*sv3));
 
@@ -180,7 +180,7 @@ static int test_klp_shadow_vars_init(void)
 	 */
 	sv4 = shadow_get_or_alloc(obj + 2, id, size, gfp_flags, shadow_ctor, &var4);
 	ret = shadow_get_or_alloc(obj + 2, id, size, gfp_flags, shadow_ctor, &var4);
-	if (ret == sv4 && *sv4 == &var4)
+	if (ret && ret == sv4 && *sv4 == &var4)
 		pr_info("  got expected PTR%d -> PTR%d result\n",
 			ptr_id(sv4), ptr_id(*sv4));
 
-- 
2.13.7

