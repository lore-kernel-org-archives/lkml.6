Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D07DCC282DA
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A74252084A
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:27:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730788AbfBCO1d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:27:33 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:55538 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730107AbfBCOUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 09:20:45 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqIdX-0006Lo-V6; Sun, 03 Feb 2019 14:20:44 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9m-0007JK-Q5; Sun, 03 Feb 2019 14:49:58 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Max Filippov" <jcmvbkbc@gmail.com>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.988113498@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 238/305] xtensa: fix coprocessor context offset
 definitions
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Max Filippov <jcmvbkbc@gmail.com>

commit 03bc996af0cc71c7f30c384d8ce7260172423b34 upstream.

Coprocessor context offsets are used by the assembly code that moves
coprocessor context between the individual fields of the
thread_info::xtregs_cp structure and coprocessor registers.
This fixes coprocessor context clobbering on flushing and reloading
during normal user code execution and user process debugging in the
presence of more than one coprocessor in the core configuration.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/xtensa/kernel/asm-offsets.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

--- a/arch/xtensa/kernel/asm-offsets.c
+++ b/arch/xtensa/kernel/asm-offsets.c
@@ -82,14 +82,14 @@ int main(void)
 	DEFINE(THREAD_SP, offsetof (struct task_struct, thread.sp));
 	DEFINE(THREAD_CPENABLE, offsetof (struct thread_info, cpenable));
 #if XTENSA_HAVE_COPROCESSORS
-	DEFINE(THREAD_XTREGS_CP0, offsetof (struct thread_info, xtregs_cp));
-	DEFINE(THREAD_XTREGS_CP1, offsetof (struct thread_info, xtregs_cp));
-	DEFINE(THREAD_XTREGS_CP2, offsetof (struct thread_info, xtregs_cp));
-	DEFINE(THREAD_XTREGS_CP3, offsetof (struct thread_info, xtregs_cp));
-	DEFINE(THREAD_XTREGS_CP4, offsetof (struct thread_info, xtregs_cp));
-	DEFINE(THREAD_XTREGS_CP5, offsetof (struct thread_info, xtregs_cp));
-	DEFINE(THREAD_XTREGS_CP6, offsetof (struct thread_info, xtregs_cp));
-	DEFINE(THREAD_XTREGS_CP7, offsetof (struct thread_info, xtregs_cp));
+	DEFINE(THREAD_XTREGS_CP0, offsetof(struct thread_info, xtregs_cp.cp0));
+	DEFINE(THREAD_XTREGS_CP1, offsetof(struct thread_info, xtregs_cp.cp1));
+	DEFINE(THREAD_XTREGS_CP2, offsetof(struct thread_info, xtregs_cp.cp2));
+	DEFINE(THREAD_XTREGS_CP3, offsetof(struct thread_info, xtregs_cp.cp3));
+	DEFINE(THREAD_XTREGS_CP4, offsetof(struct thread_info, xtregs_cp.cp4));
+	DEFINE(THREAD_XTREGS_CP5, offsetof(struct thread_info, xtregs_cp.cp5));
+	DEFINE(THREAD_XTREGS_CP6, offsetof(struct thread_info, xtregs_cp.cp6));
+	DEFINE(THREAD_XTREGS_CP7, offsetof(struct thread_info, xtregs_cp.cp7));
 #endif
 	DEFINE(THREAD_XTREGS_USER, offsetof (struct thread_info, xtregs_user));
 	DEFINE(XTREGS_USER_SIZE, sizeof(xtregs_user_t));

