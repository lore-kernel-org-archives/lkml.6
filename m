Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E628DC6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DF862513A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:29:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DF862513A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965849AbeGAQ3c (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 12:29:32 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34500 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753494AbeGAQ3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:29:25 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9594CACD;
        Sun,  1 Jul 2018 16:29:24 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 4.14 011/157] signal/xtensa: Consistenly use SIGBUS in do_unaligned_user
Date:   Sun,  1 Jul 2018 18:21:23 +0200
Message-Id: <20180701160852.846759288@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160852.287307684@linuxfoundation.org>
References: <20180701160852.287307684@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric W. Biederman <ebiederm@xmission.com>

commit 7de712ccc096b81d23cc0a941cd9b8cb3956605d upstream.

While working on changing this code to use force_sig_fault I
discovered that do_unaliged_user is sets si_signo to SIGBUS and passes
SIGSEGV to force_sig_info.  Which is just b0rked.

The code is reporting a SIGBUS error so replace the SIGSEGV with SIGBUS.

Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: linux-xtensa@linux-xtensa.org
Cc: stable@vger.kernel.org
Acked-by: Max Filippov <jcmvbkbc@gmail.com>
Fixes: 5a0015d62668 ("[PATCH] xtensa: Architecture support for Tensilica Xtensa Part 3")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/xtensa/kernel/traps.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/xtensa/kernel/traps.c
+++ b/arch/xtensa/kernel/traps.c
@@ -336,7 +336,7 @@ do_unaligned_user (struct pt_regs *regs)
 	info.si_errno = 0;
 	info.si_code = BUS_ADRALN;
 	info.si_addr = (void *) regs->excvaddr;
-	force_sig_info(SIGSEGV, &info, current);
+	force_sig_info(SIGBUS, &info, current);
 
 }
 #endif


