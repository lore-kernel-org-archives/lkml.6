Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 278ECC004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7BC92064D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:38:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7BC92064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732745AbeJBUVW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:21:22 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36626 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387654AbeJBUUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:20:37 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 52D3AB4B;
        Tue,  2 Oct 2018 13:37:12 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Julien Grall <julien.grall@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 93/94] arm/arm64: smccc-1.1: Handle function result as parameters
Date:   Tue,  2 Oct 2018 06:25:47 -0700
Message-Id: <20181002132506.973530269@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132500.494838053@linuxfoundation.org>
References: <20181002132500.494838053@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marc Zyngier <marc.zyngier@arm.com>

[ Upstream commit 755a8bf5579d22eb5636685c516d8dede799e27b ]

If someone has the silly idea to write something along those lines:

	extern u64 foo(void);

	void bar(struct arm_smccc_res *res)
	{
		arm_smccc_1_1_smc(0xbad, foo(), res);
	}

they are in for a surprise, as this gets compiled as:

	0000000000000588 <bar>:
	 588:   a9be7bfd        stp     x29, x30, [sp, #-32]!
	 58c:   910003fd        mov     x29, sp
	 590:   f9000bf3        str     x19, [sp, #16]
	 594:   aa0003f3        mov     x19, x0
	 598:   aa1e03e0        mov     x0, x30
	 59c:   94000000        bl      0 <_mcount>
	 5a0:   94000000        bl      0 <foo>
	 5a4:   aa0003e1        mov     x1, x0
	 5a8:   d4000003        smc     #0x0
	 5ac:   b4000073        cbz     x19, 5b8 <bar+0x30>
	 5b0:   a9000660        stp     x0, x1, [x19]
	 5b4:   a9010e62        stp     x2, x3, [x19, #16]
	 5b8:   f9400bf3        ldr     x19, [sp, #16]
	 5bc:   a8c27bfd        ldp     x29, x30, [sp], #32
	 5c0:   d65f03c0        ret
	 5c4:   d503201f        nop

The call to foo "overwrites" the x0 register for the return value,
and we end up calling the wrong secure service.

A solution is to evaluate all the parameters before assigning
anything to specific registers, leading to the expected result:

	0000000000000588 <bar>:
	 588:   a9be7bfd        stp     x29, x30, [sp, #-32]!
	 58c:   910003fd        mov     x29, sp
	 590:   f9000bf3        str     x19, [sp, #16]
	 594:   aa0003f3        mov     x19, x0
	 598:   aa1e03e0        mov     x0, x30
	 59c:   94000000        bl      0 <_mcount>
	 5a0:   94000000        bl      0 <foo>
	 5a4:   aa0003e1        mov     x1, x0
	 5a8:   d28175a0        mov     x0, #0xbad
	 5ac:   d4000003        smc     #0x0
	 5b0:   b4000073        cbz     x19, 5bc <bar+0x34>
	 5b4:   a9000660        stp     x0, x1, [x19]
	 5b8:   a9010e62        stp     x2, x3, [x19, #16]
	 5bc:   f9400bf3        ldr     x19, [sp, #16]
	 5c0:   a8c27bfd        ldp     x29, x30, [sp], #32
	 5c4:   d65f03c0        ret

Reported-by: Julien Grall <julien.grall@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/arm-smccc.h |   30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

--- a/include/linux/arm-smccc.h
+++ b/include/linux/arm-smccc.h
@@ -205,41 +205,51 @@ asmlinkage void __arm_smccc_hvc(unsigned
 	register unsigned long r3 asm("r3")
 
 #define __declare_arg_1(a0, a1, res)					\
+	typeof(a1) __a1 = a1;						\
 	struct arm_smccc_res   *___res = res;				\
 	register unsigned long r0 asm("r0") = (u32)a0;			\
-	register unsigned long r1 asm("r1") = a1;			\
+	register unsigned long r1 asm("r1") = __a1;			\
 	register unsigned long r2 asm("r2");				\
 	register unsigned long r3 asm("r3")
 
 #define __declare_arg_2(a0, a1, a2, res)				\
+	typeof(a1) __a1 = a1;						\
+	typeof(a2) __a2 = a2;						\
 	struct arm_smccc_res   *___res = res;				\
 	register unsigned long r0 asm("r0") = (u32)a0;			\
-	register unsigned long r1 asm("r1") = a1;			\
-	register unsigned long r2 asm("r2") = a2;			\
+	register unsigned long r1 asm("r1") = __a1;			\
+	register unsigned long r2 asm("r2") = __a2;			\
 	register unsigned long r3 asm("r3")
 
 #define __declare_arg_3(a0, a1, a2, a3, res)				\
+	typeof(a1) __a1 = a1;						\
+	typeof(a2) __a2 = a2;						\
+	typeof(a3) __a3 = a3;						\
 	struct arm_smccc_res   *___res = res;				\
 	register unsigned long r0 asm("r0") = (u32)a0;			\
-	register unsigned long r1 asm("r1") = a1;			\
-	register unsigned long r2 asm("r2") = a2;			\
-	register unsigned long r3 asm("r3") = a3
+	register unsigned long r1 asm("r1") = __a1;			\
+	register unsigned long r2 asm("r2") = __a2;			\
+	register unsigned long r3 asm("r3") = __a3
 
 #define __declare_arg_4(a0, a1, a2, a3, a4, res)			\
+	typeof(a4) __a4 = a4;						\
 	__declare_arg_3(a0, a1, a2, a3, res);				\
-	register typeof(a4) r4 asm("r4") = a4
+	register unsigned long r4 asm("r4") = __a4
 
 #define __declare_arg_5(a0, a1, a2, a3, a4, a5, res)			\
+	typeof(a5) __a5 = a5;						\
 	__declare_arg_4(a0, a1, a2, a3, a4, res);			\
-	register typeof(a5) r5 asm("r5") = a5
+	register unsigned long r5 asm("r5") = __a5
 
 #define __declare_arg_6(a0, a1, a2, a3, a4, a5, a6, res)		\
+	typeof(a6) __a6 = a6;						\
 	__declare_arg_5(a0, a1, a2, a3, a4, a5, res);			\
-	register typeof(a6) r6 asm("r6") = a6
+	register unsigned long r6 asm("r6") = __a6
 
 #define __declare_arg_7(a0, a1, a2, a3, a4, a5, a6, a7, res)		\
+	typeof(a7) __a7 = a7;						\
 	__declare_arg_6(a0, a1, a2, a3, a4, a5, a6, res);		\
-	register typeof(a7) r7 asm("r7") = a7
+	register unsigned long r7 asm("r7") = __a7
 
 #define ___declare_args(count, ...) __declare_arg_ ## count(__VA_ARGS__)
 #define __declare_args(count, ...)  ___declare_args(count, __VA_ARGS__)


