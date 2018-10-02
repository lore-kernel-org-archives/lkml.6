Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 676F5C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3927B2064D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:38:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3927B2064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733010AbeJBUVb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:21:31 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36604 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387634AbeJBUUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:20:34 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5343EB4A;
        Tue,  2 Oct 2018 13:37:10 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Julien Grall <julien.grall@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 92/94] arm/arm64: smccc-1.1: Make return values unsigned long
Date:   Tue,  2 Oct 2018 06:25:46 -0700
Message-Id: <20181002132506.910597361@linuxfoundation.org>
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

[ Upstream commit 1d8f574708a3fb6f18c85486d0c5217df893c0cf ]

An unfortunate consequence of having a strong typing for the input
values to the SMC call is that it also affects the type of the
return values, limiting r0 to 32 bits and r{1,2,3} to whatever
was passed as an input.

Let's turn everything into "unsigned long", which satisfies the
requirements of both architectures, and allows for the full
range of return values.

Reported-by: Julien Grall <julien.grall@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/arm-smccc.h |   20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

--- a/include/linux/arm-smccc.h
+++ b/include/linux/arm-smccc.h
@@ -199,31 +199,31 @@ asmlinkage void __arm_smccc_hvc(unsigned
 
 #define __declare_arg_0(a0, res)					\
 	struct arm_smccc_res   *___res = res;				\
-	register u32           r0 asm("r0") = a0;			\
+	register unsigned long r0 asm("r0") = (u32)a0;			\
 	register unsigned long r1 asm("r1");				\
 	register unsigned long r2 asm("r2");				\
 	register unsigned long r3 asm("r3")
 
 #define __declare_arg_1(a0, a1, res)					\
 	struct arm_smccc_res   *___res = res;				\
-	register u32           r0 asm("r0") = a0;			\
-	register typeof(a1)    r1 asm("r1") = a1;			\
+	register unsigned long r0 asm("r0") = (u32)a0;			\
+	register unsigned long r1 asm("r1") = a1;			\
 	register unsigned long r2 asm("r2");				\
 	register unsigned long r3 asm("r3")
 
 #define __declare_arg_2(a0, a1, a2, res)				\
 	struct arm_smccc_res   *___res = res;				\
-	register u32           r0 asm("r0") = a0;			\
-	register typeof(a1)    r1 asm("r1") = a1;			\
-	register typeof(a2)    r2 asm("r2") = a2;			\
+	register unsigned long r0 asm("r0") = (u32)a0;			\
+	register unsigned long r1 asm("r1") = a1;			\
+	register unsigned long r2 asm("r2") = a2;			\
 	register unsigned long r3 asm("r3")
 
 #define __declare_arg_3(a0, a1, a2, a3, res)				\
 	struct arm_smccc_res   *___res = res;				\
-	register u32           r0 asm("r0") = a0;			\
-	register typeof(a1)    r1 asm("r1") = a1;			\
-	register typeof(a2)    r2 asm("r2") = a2;			\
-	register typeof(a3)    r3 asm("r3") = a3
+	register unsigned long r0 asm("r0") = (u32)a0;			\
+	register unsigned long r1 asm("r1") = a1;			\
+	register unsigned long r2 asm("r2") = a2;			\
+	register unsigned long r3 asm("r3") = a3
 
 #define __declare_arg_4(a0, a1, a2, a3, a4, res)			\
 	__declare_arg_3(a0, a1, a2, a3, res);				\


