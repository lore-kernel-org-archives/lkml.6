Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52AF6C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 11:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 059B924C44
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 11:52:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="ANSvQ982"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 059B924C44
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753123AbeGCLwg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 07:52:36 -0400
Received: from 8bytes.org ([81.169.241.247]:45366 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752432AbeGCLwc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 07:52:32 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id B3516377; Tue,  3 Jul 2018 13:52:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=8bytes.org; s=mail-1;
        t=1530618750; bh=emMHiIe8ELL/J537Mq5YWss9u/GvpM5GH1kX7ZrNtmU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ANSvQ982tmNnm4xlSSx+MOQwWBGFc6O3GcxooOw2P2iQpUtczpLmm1f61mK1TVbed
         gs+VU0tKTUJF0Wh91gS2N1v+y/qNZcxPtRKzGAay5freTFXpOPXrb1kl9APiRiR6zA
         eHGSWtcX9zDywu9cykiMVDj2DHusGLK3BNRA1D2tVvu8gqpsfmCFA1DSwkKF8ortC2
         i8U3slN/KN3Ht8+GsIJFyhNL/F7hFzgCTWXTEWri7YKm1QopZYorNz/Nu1aQyi9F/4
         OM5fyhKt1jkGpLXSmLqnLu8VeBzkgi0ldR/av1z2MfYfQblD9bI9gnhAKZkYMcdOD/
         VClUg7Y+bpK+w==
From:   Joerg Roedel <joro@8bytes.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
Cc:     hpa@zytor.com, Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH 2/3] x86/pti: Call pti_init() after mark_readonly()
Date:   Tue,  3 Jul 2018 13:52:25 +0200
Message-Id: <1530618746-23116-3-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530618746-23116-1-git-send-email-joro@8bytes.org>
References: <1530618746-23116-1-git-send-email-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

PTI init code clones some parts of the kernel mappings to the user-space
page-table. For the kernel and user-space page-table to be consistent,
the cloning should happen when the relevant parts of the kernel
page-table are finished, which is right after mark_readonly() returns.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 init/main.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/init/main.c b/init/main.c
index 3b4ada1..0b5d0f1 100644
--- a/init/main.c
+++ b/init/main.c
@@ -524,8 +524,6 @@ static void __init mm_init(void)
 	ioremap_huge_init();
 	/* Should be run before the first non-init thread is created */
 	init_espfix_bsp();
-	/* Should be run after espfix64 is set up. */
-	pti_init();
 }
 
 asmlinkage __visible void __init start_kernel(void)
@@ -1065,6 +1063,12 @@ static int __ref kernel_init(void *unused)
 	jump_label_invalidate_initmem();
 	free_initmem();
 	mark_readonly();
+	/*
+	 * Kernel text/rodata/data sections have the right protections
+	 * now. If necessary, init PTI and clone the relevant pieces
+	 * to the user-space page-table.
+	 */
+	pti_init();
 	system_state = SYSTEM_RUNNING;
 	numa_default_policy();
 
-- 
2.7.4

