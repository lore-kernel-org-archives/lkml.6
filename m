Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F3FDC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 10:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D8EF20861
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 10:35:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbfAWKf4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 05:35:56 -0500
Received: from www.osadl.org ([62.245.132.105]:46635 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726804AbfAWKf4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 05:35:56 -0500
Received: from debian01.hofrr.at (178.115.242.59.static.drei.at [178.115.242.59])
        by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id x0NAZA65008775;
        Wed, 23 Jan 2019 11:35:10 +0100
From:   Nicholas Mc Guire <hofrat@osadl.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Jessica Yu <jeyu@kernel.org>, Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>, live-patching@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH] livepatch: fix size mismatch
Date:   Wed, 23 Jan 2019 11:31:16 +0100
Message-Id: <1548239476-21110-1-git-send-email-hofrat@osadl.org>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kzalloc(sizeof(int)) is called for an int object but then
passed into klp_shadow_alloc() using the size of the pointer.
This probably is not a problem as it will fit - but it should
be cleaned (after all this is reference code). 

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---

Reported by coccicheck
samples/livepatch//livepatch-shadow-fix1.c:97:30-36: ERROR: application of sizeof to pointer

Patch was compile tested with: x86_64_defconfig + FTRACE=y,
FUNCTION_TRACER=y, SAMPLES=y, LIVEPATCH=y SAMPLE_LIVEPATCH=m 

Patch is against 5.0-rc3 (localversion-next is next-20190123)

 samples/livepatch/livepatch-shadow-fix1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/livepatch/livepatch-shadow-fix1.c b/samples/livepatch/livepatch-shadow-fix1.c
index a5a5cac..643ffd5 100644
--- a/samples/livepatch/livepatch-shadow-fix1.c
+++ b/samples/livepatch/livepatch-shadow-fix1.c
@@ -94,7 +94,7 @@ struct dummy *livepatch_fix1_dummy_alloc(void)
 		return NULL;
 	}
 
-	klp_shadow_alloc(d, SV_LEAK, sizeof(leak), GFP_KERNEL,
+	klp_shadow_alloc(d, SV_LEAK, sizeof(*leak), GFP_KERNEL,
 			 shadow_leak_ctor, leak);
 
 	pr_info("%s: dummy @ %p, expires @ %lx\n",
-- 
2.1.4

