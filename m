Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D37F6C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 19:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6338721C2A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 19:24:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6338721C2A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754315AbeFUTYs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 15:24:48 -0400
Received: from andre.telenet-ops.be ([195.130.132.53]:49552 "EHLO
        andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754137AbeFUTYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 15:24:47 -0400
Received: from ayla.of.borg ([84.194.111.163])
        by andre.telenet-ops.be with bizsmtp
        id 1XQl1y00N3XaVaC01XQlvF; Thu, 21 Jun 2018 21:24:45 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ayla.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1fW5CH-0005r3-F1; Thu, 21 Jun 2018 21:24:45 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1fW5CH-0006ME-Cp; Thu, 21 Jun 2018 21:24:45 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     uclinux-h8-devel@lists.sourceforge.jp,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] h8300: Correct signature of test_bit()
Date:   Thu, 21 Jun 2018 21:24:44 +0200
Message-Id: <20180621192444.24389-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

    mm/filemap.c: In function 'clear_bit_unlock_is_negative_byte':
    mm/filemap.c:1181:30: warning: passing argument 2 of 'test_bit' discards 'volatile' qualifier from pointer target type [-Wdiscarded-qualifiers]
      return test_bit(PG_waiters, mem);
				  ^~~
    In file included from include/linux/bitops.h:38,
		     from include/linux/kernel.h:11,
		     from include/linux/list.h:9,
		     from include/linux/wait.h:7,
		     from include/linux/wait_bit.h:8,
		     from include/linux/fs.h:6,
		     from include/linux/dax.h:5,
		     from mm/filemap.c:14:
    arch/h8300/include/asm/bitops.h:69:57: note: expected 'const long unsigned int *' but argument is of type 'volatile void *'
     static inline int test_bit(int nr, const unsigned long *addr)
					~~~~~~~~~~~~~~~~~~~~~^~~~

Make the bitmask pointed to by the "addr" parameter volatile to fix
this, like is done on other architectures.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
Exposed by commit 98473f9f3f9bd404 ("mm/filemap: fix parameters to
test_bit()").

v2:
  - Rebased.
---
 arch/h8300/include/asm/bitops.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/h8300/include/asm/bitops.h b/arch/h8300/include/asm/bitops.h
index ea0cb0cf6a8bb2ed..92285bec7b4023ef 100644
--- a/arch/h8300/include/asm/bitops.h
+++ b/arch/h8300/include/asm/bitops.h
@@ -66,7 +66,7 @@ H8300_GEN_BITOP(change_bit, "bnot")
 
 #undef H8300_GEN_BITOP
 
-static inline int test_bit(int nr, const unsigned long *addr)
+static inline int test_bit(int nr, const volatile unsigned long *addr)
 {
 	int ret = 0;
 	unsigned char *b_addr;
-- 
2.17.1

