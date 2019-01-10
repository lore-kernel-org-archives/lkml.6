Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D201BC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 05:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D44B21738
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 05:42:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbfAJFm0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 00:42:26 -0500
Received: from ozlabs.ru ([107.173.13.209]:51403 "EHLO ozlabs.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726016AbfAJFm0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 00:42:26 -0500
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
        by ozlabs.ru (Postfix) with ESMTP id A4F2FAE8001E;
        Thu, 10 Jan 2019 00:42:23 -0500 (EST)
From:   Alexey Kardashevskiy <aik@ozlabs.ru>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     Alexey Kardashevskiy <aik@ozlabs.ru>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH kernel] powerpc/stack_protector: Fix external modules building
Date:   Thu, 10 Jan 2019 16:42:16 +1100
Message-Id: <20190110054216.74248-1-aik@ozlabs.ru>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

c3ff2a519 "powerpc/32: add stack protector support" addes stack protector
support so now powerpc's "prepare" target depends on prepare0 (via
stack_protector_prepare target).

It works fine until we try build an external module where it fails with:
Run: 'make -j128 SYSSRC=/home/aik/p/kernel SYSOUT=/home/aik/pbuild/kernel-le-pseries/ ARCH=powerpc'
make[1]: Entering directory '/home/aik/p/kernel'
make[2]: Entering directory '/home/aik/pbuild/kernel-le-pseries'
make[2]: *** No rule to make target 'prepare0', needed by 'stack_protector_prepare'.  Stop.

The reason for that is that the main Linux Makefile defines "prepare0"
only if KBUILD_EXTMOD=="".

This hacks powerpc's Makefile to make external modules build again.

Fixes: c3ff2a519 "powerpc/32: add stack protector support"
Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---


It has been suggested that there is a better way of fixing this hence RFC.


---
 arch/powerpc/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 488c9ed..0492f62 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -419,7 +419,11 @@ archheaders:
 ifdef CONFIG_STACKPROTECTOR
 prepare: stack_protector_prepare
 
+ifeq ($(KBUILD_EXTMOD),)
 stack_protector_prepare: prepare0
+else
+stack_protector_prepare:
+endif
 ifdef CONFIG_PPC64
 	$(eval KBUILD_CFLAGS += -mstack-protector-guard-offset=$(shell awk '{if ($$2 == "PACA_CANARY") print $$3;}' include/generated/asm-offsets.h))
 else
-- 
2.17.1

