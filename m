Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B62C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10770214C1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:08:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fOUgq7nu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10770214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728606AbeLDLIU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:08:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:57540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728015AbeLDLIP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:08:15 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 545F52082D;
        Tue,  4 Dec 2018 11:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921694;
        bh=hdwzpjZ0i6swtk1v3vVeyTLBUgnuvc0/0YgyQiaOsJ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fOUgq7nu6t9rOv7XudcoQ0dQHsvIafmjPQmrnXC4cbphn0+Y7R09GMIRmArot2a0V
         2blWqU2824vOYGIvyKF5NF0k+VVREWzCHlOcwGM/HQXevgGGUtz/aIEFZRfVoTWmke
         2CoQgowm+2AIiSAqu0hEx9VTwrbyltMyGei1K4Tk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 4.9 23/50] xtensa: fix coprocessor context offset definitions
Date:   Tue,  4 Dec 2018 11:50:18 +0100
Message-Id: <20181204103715.686106006@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103714.485546262@linuxfoundation.org>
References: <20181204103714.485546262@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Max Filippov <jcmvbkbc@gmail.com>

commit 03bc996af0cc71c7f30c384d8ce7260172423b34 upstream.

Coprocessor context offsets are used by the assembly code that moves
coprocessor context between the individual fields of the
thread_info::xtregs_cp structure and coprocessor registers.
This fixes coprocessor context clobbering on flushing and reloading
during normal user code execution and user process debugging in the
presence of more than one coprocessor in the core configuration.

Cc: stable@vger.kernel.org
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/xtensa/kernel/asm-offsets.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

--- a/arch/xtensa/kernel/asm-offsets.c
+++ b/arch/xtensa/kernel/asm-offsets.c
@@ -91,14 +91,14 @@ int main(void)
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


