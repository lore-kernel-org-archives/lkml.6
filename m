Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B048FC32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 14:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7700F2082E
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 14:02:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XN4m8VJx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7700F2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731648AbeKDXR2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 18:17:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:46858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730941AbeKDXIR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 18:08:17 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 247D120869;
        Sun,  4 Nov 2018 13:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541339593;
        bh=M+nlvSSWJ6LODF+My80H6Ek0nsvcQgbQobsSHZ3QULs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XN4m8VJxfqJL9aTy//G86LiZ9DVqINJrXXIaSjOvMe7mlpdz6K4veWMFQhUTmJFHm
         x0nfkW8LB88CfIRdeNj5Lz0099MVyEEzfoas1uoL40qbeMBks/dY42aCNSMbk7SFjl
         jOIUAKhl1+sS4qOcLVRlDmP1QmcW2kRCbiUrHwX8=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Joel Stanley <joel@jms.id.au>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 32/45] powerpc/boot: Ensure _zimage_start is a weak symbol
Date:   Sun,  4 Nov 2018 08:52:27 -0500
Message-Id: <20181104135240.88431-32-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181104135240.88431-1-sashal@kernel.org>
References: <20181104135240.88431-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joel Stanley <joel@jms.id.au>

[ Upstream commit ee9d21b3b3583712029a0db65a4b7c081d08d3b3 ]

When building with clang crt0's _zimage_start is not marked weak, which
breaks the build when linking the kernel image:

 $ objdump -t arch/powerpc/boot/crt0.o |grep _zimage_start$
 0000000000000058 g       .text  0000000000000000 _zimage_start

 ld: arch/powerpc/boot/wrapper.a(crt0.o): in function '_zimage_start':
 (.text+0x58): multiple definition of '_zimage_start';
 arch/powerpc/boot/pseries-head.o:(.text+0x0): first defined here

Clang requires the .weak directive to appear after the symbol is
declared. The binutils manual says:

 This directive sets the weak attribute on the comma separated list of
 symbol names. If the symbols do not already exist, they will be
 created.

So it appears this is different with clang. The only reference I could
see for this was an OpenBSD mailing list post[1].

Changing it to be after the declaration fixes building with Clang, and
still works with GCC.

 $ objdump -t arch/powerpc/boot/crt0.o |grep _zimage_start$
 0000000000000058  w      .text	0000000000000000 _zimage_start

Reported to clang as https://bugs.llvm.org/show_bug.cgi?id=38921

[1] https://groups.google.com/forum/#!topic/fa.openbsd.tech/PAgKKen2YCY

Signed-off-by: Joel Stanley <joel@jms.id.au>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/boot/crt0.S | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/boot/crt0.S b/arch/powerpc/boot/crt0.S
index dcf2f15e6797..32dfe6d083f3 100644
--- a/arch/powerpc/boot/crt0.S
+++ b/arch/powerpc/boot/crt0.S
@@ -47,8 +47,10 @@ p_end:		.long	_end
 p_pstack:	.long	_platform_stack_top
 #endif
 
-	.weak	_zimage_start
 	.globl	_zimage_start
+	/* Clang appears to require the .weak directive to be after the symbol
+	 * is defined. See https://bugs.llvm.org/show_bug.cgi?id=38921  */
+	.weak	_zimage_start
 _zimage_start:
 	.globl	_zimage_start_lib
 _zimage_start_lib:
-- 
2.17.1

