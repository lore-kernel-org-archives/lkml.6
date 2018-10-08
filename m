Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F096C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBCF4204FD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:52:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AJXA5JhP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBCF4204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732469AbeJICFO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:05:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:55272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730284AbeJICFN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:05:13 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 460492087D;
        Mon,  8 Oct 2018 18:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024725;
        bh=XPRZPEF2xlfQdyHU+bDrm9g5FAW5Tyk98ELUpGagq3M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AJXA5JhPbMbNQGbRbz3BfIkR0CALVr+HkAmeMrhj8oepMqZ975xj8cIbcCuFmH8Mk
         uzvhQRHbHJ9QyLh+z8+bWPE1qv8CpDAs2SQChCoADnkpiNst0yO0xJNcMv7oohdE3Z
         pfYnE+NOnlSHdItXpCUxYjUEiT6tDWwavg3ISAZ8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 133/168] arm64: jump_label.h: use asm_volatile_goto macro instead of "asm goto"
Date:   Mon,  8 Oct 2018 20:31:53 +0200
Message-Id: <20181008175625.102317570@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175620.043587728@linuxfoundation.org>
References: <20181008175620.043587728@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>

[ Upstream commit 13aceef06adfaf93d52e01e28a8bc8a0ad471d83 ]

All other uses of "asm goto" go through asm_volatile_goto, which avoids
a miscompile when using GCC < 4.8.2. Replace our open-coded "asm goto"
statements with the asm_volatile_goto macro to avoid issues with older
toolchains.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/include/asm/jump_label.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/arm64/include/asm/jump_label.h
+++ b/arch/arm64/include/asm/jump_label.h
@@ -28,7 +28,7 @@
 
 static __always_inline bool arch_static_branch(struct static_key *key, bool branch)
 {
-	asm goto("1: nop\n\t"
+	asm_volatile_goto("1: nop\n\t"
 		 ".pushsection __jump_table,  \"aw\"\n\t"
 		 ".align 3\n\t"
 		 ".quad 1b, %l[l_yes], %c0\n\t"
@@ -42,7 +42,7 @@ l_yes:
 
 static __always_inline bool arch_static_branch_jump(struct static_key *key, bool branch)
 {
-	asm goto("1: b %l[l_yes]\n\t"
+	asm_volatile_goto("1: b %l[l_yes]\n\t"
 		 ".pushsection __jump_table,  \"aw\"\n\t"
 		 ".align 3\n\t"
 		 ".quad 1b, %l[l_yes], %c0\n\t"


