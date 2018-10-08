Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52BFCC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 20:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D5EA20C0A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 20:29:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D5EA20C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbeJIDmf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 23:42:35 -0400
Received: from mail.skyhub.de ([5.9.137.197]:43482 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726393AbeJIDmf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 23:42:35 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 68LKr6AIjkKU; Mon,  8 Oct 2018 22:29:03 +0200 (CEST)
Received: from zn.tnic (p200300EC2BCA7500329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bca:7500:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1357F1EC00EA;
        Mon,  8 Oct 2018 22:29:03 +0200 (CEST)
From:   Borislav Petkov <bp@alien8.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH] kernel/panic: Do not append newline to the stack protector panic string
Date:   Mon,  8 Oct 2018 22:29:01 +0200
Message-Id: <20181008202901.7894-1-bp@alien8.de>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec057f
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

... because panic() itself already does this. Otherwise you have
line-broken trailer:

  [    1.836965] ---[ end Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: pgd_alloc+0x29e/0x2a0
  [    1.836965]  ]---

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
---
 kernel/panic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/panic.c b/kernel/panic.c
index 8b2e002d52eb..837a94b7024d 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -631,7 +631,7 @@ device_initcall(register_warn_debugfs);
  */
 __visible void __stack_chk_fail(void)
 {
-	panic("stack-protector: Kernel stack is corrupted in: %pB\n",
+	panic("stack-protector: Kernel stack is corrupted in: %pB",
 		__builtin_return_address(0));
 }
 EXPORT_SYMBOL(__stack_chk_fail);
-- 
2.19.0.271.gfe8321ec057f

