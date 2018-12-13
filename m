Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 984F6C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 11:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 530462086D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 11:14:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 530462086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osadl.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728690AbeLMLN7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 06:13:59 -0500
Received: from www.osadl.org ([62.245.132.105]:36251 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727647AbeLMLN6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 06:13:58 -0500
Received: from debian01.hofrr.at (178.115.242.59.static.drei.at [178.115.242.59])
        by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id wBDBD6ZF021460;
        Thu, 13 Dec 2018 12:13:06 +0100
From:   Nicholas Mc Guire <hofrat@osadl.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Jessica Yu <jeyu@kernel.org>, Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>, live-patching@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH 1/2] livepatch: handle kzalloc failure
Date:   Thu, 13 Dec 2018 12:09:49 +0100
Message-Id: <1544699390-15673-1-git-send-email-hofrat@osadl.org>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kzalloc() return should always be checked - notably in example code
where this may be seen as reference. On failure of allocation
livepatch_fix1_dummy_alloc() should return NULL.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---

Problem was located with an experimental coccinelle script

Patch was compile tested with: x86_64_defconfig + FTRACE=y
FUNCTION_TRACER=y, EXPERT=y, LATENCYTOP=y, SAMPLES=y, SAMPLE_LIVEPATCH=y
(with some unrelated sparse warnings on symbols not being static)

Patch is against 4.20-rc6 (localversion-next is next-20181213)

 samples/livepatch/livepatch-shadow-fix1.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/samples/livepatch/livepatch-shadow-fix1.c b/samples/livepatch/livepatch-shadow-fix1.c
index 49b1355..a0e8f04 100644
--- a/samples/livepatch/livepatch-shadow-fix1.c
+++ b/samples/livepatch/livepatch-shadow-fix1.c
@@ -89,6 +89,9 @@ struct dummy *livepatch_fix1_dummy_alloc(void)
 	 * pointer to handle resource release.
 	 */
 	leak = kzalloc(sizeof(int), GFP_KERNEL);
+	if (!leak)
+		return NULL;
+
 	klp_shadow_alloc(d, SV_LEAK, sizeof(leak), GFP_KERNEL,
 			 shadow_leak_ctor, leak);
 
-- 
2.1.4

