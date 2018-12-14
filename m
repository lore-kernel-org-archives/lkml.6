Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 232BFC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 16:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEE94206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 16:59:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730102AbeLNQ74 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 11:59:56 -0500
Received: from www.osadl.org ([62.245.132.105]:42959 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729409AbeLNQ74 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 11:59:56 -0500
Received: from debian01.hofrr.at (178.115.242.59.static.drei.at [178.115.242.59])
        by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id wBEGxVdk014507;
        Fri, 14 Dec 2018 17:59:40 +0100
From:   Nicholas Mc Guire <hofrat@osadl.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Jessica Yu <jeyu@kernel.org>, Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>, live-patching@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH 2/2] livepatch: check kzalloc return values
Date:   Fri, 14 Dec 2018 17:56:10 +0100
Message-Id: <1544806570-21299-2-git-send-email-hofrat@osadl.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1544806570-21299-1-git-send-email-hofrat@osadl.org>
References: <1544806570-21299-1-git-send-email-hofrat@osadl.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kzalloc() return should always be checked - notably in example code
where this may be seen as reference. On failure of allocation in
livepatch_fix1_dummy_alloc() respectively dummy_alloc() previous
allocation is freed (thanks to Petr Mladek <pmladek@suse.com> for
catching this) and NULL returned.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Fixes: 439e7271dc2b ("livepatch: introduce shadow variable API")
---

Problem located with an experimental coccinelle script

Patch was compile tested with: x86_64_defconfig + FTRACE=y
FUNCTION_TRACER=y, EXPERT=y, LATENCYTOP=y, SAMPLES=y,
SAMPLE_LIVEPATCH=y

Patch is against 4.20-rc6 (localversion-next is next-20181214)
on top of 0001-livepatch-fix-non-static-warnings.patch 

 samples/livepatch/livepatch-shadow-fix1.c | 5 +++++
 samples/livepatch/livepatch-shadow-mod.c  | 4 ++++
 2 files changed, 9 insertions(+)

diff --git a/samples/livepatch/livepatch-shadow-fix1.c b/samples/livepatch/livepatch-shadow-fix1.c
index eaab10f..1974eb5 100644
--- a/samples/livepatch/livepatch-shadow-fix1.c
+++ b/samples/livepatch/livepatch-shadow-fix1.c
@@ -89,6 +89,11 @@ static __noclone struct dummy *livepatch_fix1_dummy_alloc(void)
 	 * pointer to handle resource release.
 	 */
 	leak = kzalloc(sizeof(int), GFP_KERNEL);
+	if (!leak) {
+		kfree(d);
+		return NULL;
+	}
+
 	klp_shadow_alloc(d, SV_LEAK, sizeof(leak), GFP_KERNEL,
 			 shadow_leak_ctor, leak);
 
diff --git a/samples/livepatch/livepatch-shadow-mod.c b/samples/livepatch/livepatch-shadow-mod.c
index dc69da0..b4ece36 100644
--- a/samples/livepatch/livepatch-shadow-mod.c
+++ b/samples/livepatch/livepatch-shadow-mod.c
@@ -123,6 +123,10 @@ static __noclone noinline struct dummy *dummy_alloc(void)
 
 	/* Oops, forgot to save leak! */
 	leak = kzalloc(sizeof(int), GFP_KERNEL);
+	if (!leak) {
+		kfree(d);
+		return NULL;
+	}
 
 	pr_info("%s: dummy @ %p, expires @ %lx\n",
 		__func__, d, d->jiffies_expire);
-- 
2.1.4

