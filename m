Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD8DFC43610
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85493213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:24:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MhnBcyNQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85493213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732704AbeK3BaH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:30:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:56970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732673AbeK3BaG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:30:06 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74099205C9;
        Thu, 29 Nov 2018 14:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501474;
        bh=GfPguvMM3Zl6U31oLZ5lCRKW5fDktYLDicEXV03ATOc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MhnBcyNQ9BiTs0b+cAzC9Zz1Pp7A7Nx6B2I42FHtnMKNXnueToUm/2mI4+9ri3t+p
         tFfw4VswjvXbuwiQhnjrUfxKJzwlZPZGsY9hd7Ge/cQhDH3TAnQcB5Bjp0yPj4iDPq
         hWqIkpiVtXzFhWTZXMQhq161m38FY0xgvtWE2el0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
        Stephen Warren <swarren@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        Stefan Agner <stefan@agner.ch>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH 4.14 005/100] ARM: trusted_foundations: do not use naked function
Date:   Thu, 29 Nov 2018 15:11:35 +0100
Message-Id: <20181129140059.340598377@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129140058.768942700@linuxfoundation.org>
References: <20181129140058.768942700@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefan Agner <stefan@agner.ch>

(commit 4ea7bdc6b5b33427bbd3f41c333e21c1825462a3 upstream)

As documented in GCC naked functions should only use basic ASM
syntax. The extended ASM or mixture of basic ASM and "C" code is
not guaranteed. Currently this works because it was hard coded
to follow and check GCC behavior for arguments and register
placement.

Furthermore with clang using parameters in Extended asm in a
naked function is not supported:
  arch/arm/firmware/trusted_foundations.c:47:10: error: parameter
          references not allowed in naked functions
                : "r" (type), "r" (arg1), "r" (arg2)
                       ^

Use a regular function to be more portable. This aligns also with
the other SMC call implementations e.g. in qcom_scm-32.c and
bcm_kona_smc.c.

Cc: Dmitry Osipenko <digetx@gmail.com>
Cc: Stephen Warren <swarren@nvidia.com>
Cc: Thierry Reding <treding@nvidia.com>
Signed-off-by: Stefan Agner <stefan@agner.ch>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/firmware/trusted_foundations.c |   14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

--- a/arch/arm/firmware/trusted_foundations.c
+++ b/arch/arm/firmware/trusted_foundations.c
@@ -31,21 +31,25 @@
 
 static unsigned long cpu_boot_addr;
 
-static void __naked tf_generic_smc(u32 type, u32 arg1, u32 arg2)
+static void tf_generic_smc(u32 type, u32 arg1, u32 arg2)
 {
+	register u32 r0 asm("r0") = type;
+	register u32 r1 asm("r1") = arg1;
+	register u32 r2 asm("r2") = arg2;
+
 	asm volatile(
 		".arch_extension	sec\n\t"
-		"stmfd	sp!, {r4 - r11, lr}\n\t"
+		"stmfd	sp!, {r4 - r11}\n\t"
 		__asmeq("%0", "r0")
 		__asmeq("%1", "r1")
 		__asmeq("%2", "r2")
 		"mov	r3, #0\n\t"
 		"mov	r4, #0\n\t"
 		"smc	#0\n\t"
-		"ldmfd	sp!, {r4 - r11, pc}"
+		"ldmfd	sp!, {r4 - r11}\n\t"
 		:
-		: "r" (type), "r" (arg1), "r" (arg2)
-		: "memory");
+		: "r" (r0), "r" (r1), "r" (r2)
+		: "memory", "r3", "r12", "lr");
 }
 
 static int tf_set_cpu_boot_addr(int cpu, unsigned long boot_addr)


