Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id B6DOInzgHVueLwAAmS7hNA
	; Mon, 11 Jun 2018 02:38:20 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 7C2F2607BB; Mon, 11 Jun 2018 02:38:20 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="ijfYl2a5"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id E22E460791;
	Mon, 11 Jun 2018 02:38:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E22E460791
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753880AbeFKCiS (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Sun, 10 Jun 2018 22:38:18 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:25553 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753780AbeFKCiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 22:38:16 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id w5B2ZnvY021266;
        Mon, 11 Jun 2018 11:35:49 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w5B2ZnvY021266
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1528684550;
        bh=xb0lcFtCX2naihlW8Ce3DzOieGX1IbNq6g5kTB1Cz1E=;
        h=From:To:Cc:Subject:Date:From;
        b=ijfYl2a5gMxgSdhdxLSyymQjBZVZmI4Iy1LVlJgJL+pcW2Ow18e2diOZL5UlWMzwI
         kXyiaOip/igJfEDyQn7ziZm2Mf5lJhX6Ho2xkjHpf4PotXf3tFq89lf+G2CfLB/d9u
         NC5sHlY2zjat8uadUNMTxgGqJ/vfcLLM9YS33ql9HmlWZSpoHNIfyFPIaa8rfnQ2A3
         1To6cyT/gaMlJzDnOabF2Xv+1KtznlihpHW+Uh7sewyIVKyeyiS/amzF378eV3Q+ZO
         /WDLLcy+DczjhFak+L01+wg9ui5nm3gD+9cV3OEzG4wK9htqYWIslZn6B52nAo7Dme
         nbqKYeTYSuK7A==
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Will Deacon <will.deacon@arm.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH] linux/linkage.h: replace VMLINUX_SYMBOL_STR() with __stringify()
Date: Mon, 11 Jun 2018 11:35:26 +0900
Message-Id: <1528684526-17114-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the special case handling for Blackfin and Metag was removed by
commit 94e58e0ac312 ("export.h: remove code for prefixing symbols with
underscore"), VMLINUX_SYMBOL_STR() is now equivalent to __stringify().

Replace some remaining usages in <linux/linkage.h> to prepare for the
entire removal of VMLINUX_SYMBOL_STR().

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 include/linux/linkage.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/linkage.h b/include/linux/linkage.h
index f68db9e..d7618c4 100644
--- a/include/linux/linkage.h
+++ b/include/linux/linkage.h
@@ -24,16 +24,16 @@
 
 #ifndef cond_syscall
 #define cond_syscall(x)	asm(				\
-	".weak " VMLINUX_SYMBOL_STR(x) "\n\t"		\
-	".set  " VMLINUX_SYMBOL_STR(x) ","		\
-		 VMLINUX_SYMBOL_STR(sys_ni_syscall))
+	".weak " __stringify(x) "\n\t"			\
+	".set  " __stringify(x) ","			\
+		 __stringify(sys_ni_syscall))
 #endif
 
 #ifndef SYSCALL_ALIAS
 #define SYSCALL_ALIAS(alias, name) asm(			\
-	".globl " VMLINUX_SYMBOL_STR(alias) "\n\t"	\
-	".set   " VMLINUX_SYMBOL_STR(alias) ","		\
-		  VMLINUX_SYMBOL_STR(name))
+	".globl " __stringify(alias) "\n\t"		\
+	".set   " __stringify(alias) ","		\
+		  __stringify(name))
 #endif
 
 #define __page_aligned_data	__section(.data..page_aligned) __aligned(PAGE_SIZE)
-- 
2.7.4
