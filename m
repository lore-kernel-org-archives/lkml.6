Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E8F6C31D63
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AADA217F4
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:11:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="a1TU2cKC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbfAUHLR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 02:11:17 -0500
Received: from condef-07.nifty.com ([202.248.20.72]:49348 "EHLO
        condef-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbfAUHLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 02:11:16 -0500
Received: from conuserg-08.nifty.com ([10.126.8.71])by condef-07.nifty.com with ESMTP id x0L2nbWo000684;
        Mon, 21 Jan 2019 11:49:37 +0900
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id x0L2ms5g015717;
        Mon, 21 Jan 2019 11:48:54 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com x0L2ms5g015717
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1548038934;
        bh=1ScuhqJca0uj5wxaiMhHAqTBVV8LdYPNZ4+ByDc6o4o=;
        h=From:To:Cc:Subject:Date:From;
        b=a1TU2cKCVZcTtKz1/n9K4UZk/n8nAmkXhLP04ub/O3HMTi7ZxE2cWdij4PU/K6z6T
         1jxabuQSRgJLf5skKBrcKX+zyVNvsgt+FZ46Vxl9Wa9SI/1a9cdkkwgTzGWI0sKGMb
         B8LzKnmvLyB8dqHBdUudd71KQtFyhczAL0YDLWv+H26qsTX9ST7aXr5bX+9WxTu8Sw
         2Z31p/6GTtbohBMOdRoaJVh/ROY4Sj6TMTImhlhZLBhrrrZ9rM3r11Dd96K90/oNeD
         KiQOFn2ZgzKaMliOwfs5PPEXu8dwJpTZQtRy/c7DGp3TKRjzeKxRwH4ok5c+RZdKd3
         9mzSDd22OnCFg==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Paul Burton <paul.burton@mips.com>, linux-mips@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: remove meaningless generic-(CONFIG_GENERIC_CSUM) += checksum.h
Date:   Mon, 21 Jan 2019 11:48:49 +0900
Message-Id: <1548038929-11814-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This line is weird in multiple ways.

(CONFIG_GENERIC_CSUM) might be a typo of $(CONFIG_GENERIC_CSUM).

Even if you add '$' to it, $(CONFIG_GENERIC_CSUM) is never evaluated
to 'y' because scripts/Makefile.asm-generic does not include
include/config/auto.conf. So, the asm-generic wrapper of checksum.h
is never generated.

Even if you manage to generate it, it is never included by anyone
because MIPS has the checkin header with the same file name:

  arch/mips/include/asm/checksum.h

As you see in the top Makefile, the checkin headers are included before
generated ones.

  LINUXINCLUDE    := \
                  -I$(srctree)/arch/$(SRCARCH)/include \
                  -I$(objtree)/arch/$(SRCARCH)/include/generated \
                  ...

Commit 4e0748f5beb9 ("MIPS: Use generic checksum functions for MIPS R6")
already added the asm-generic fallback code in the checkin header:

  #ifdef CONFIG_GENERIC_CSUM
  #include <asm/generic/checksum.h>
  #else
    ...
  #endif

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/mips/include/asm/Kbuild | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/mips/include/asm/Kbuild b/arch/mips/include/asm/Kbuild
index f15d5db..87b86cd 100644
--- a/arch/mips/include/asm/Kbuild
+++ b/arch/mips/include/asm/Kbuild
@@ -3,7 +3,6 @@ generated-y += syscall_table_32_o32.h
 generated-y += syscall_table_64_n32.h
 generated-y += syscall_table_64_n64.h
 generated-y += syscall_table_64_o32.h
-generic-(CONFIG_GENERIC_CSUM) += checksum.h
 generic-y += current.h
 generic-y += device.h
 generic-y += dma-contiguous.h
-- 
2.7.4

