Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68632C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30FB421780
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:00:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1gdsY3Tv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30FB421780
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405331AbeKTDYf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:24:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:36974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404390AbeKTDYe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:24:34 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4965D223C6;
        Mon, 19 Nov 2018 17:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542646818;
        bh=hCQOcpR5upKSkVe9pMV00me+OUNLq60hbWZ4vz637yY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1gdsY3TvVEU4diSOUMyLK5H0GFiQrKpFIWO+hz+Lmnp8jlYZC0nIZQ4Sl0q+e8L6A
         oMlxTXwUq/fEfeg/05oyyWsRAAO2IfE/E/P01EyujCvs/Fcco5JMEzwW27Yv4qR4WG
         wvLCZZCg3iXBB0lmb2E1+A9FY3+cS/tdB6x6gUAs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Joel Stanley <joel@jms.id.au>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 101/160] powerpc/boot: Ensure _zimage_start is a weak symbol
Date:   Mon, 19 Nov 2018 17:29:00 +0100
Message-Id: <20181119162640.821051288@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162630.031306128@linuxfoundation.org>
References: <20181119162630.031306128@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/boot/crt0.S |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

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


