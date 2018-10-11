Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AE38C677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E04A2085B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:46:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rtDF0jIC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E04A2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731530AbeJKXOB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:14:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:46842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726700AbeJKXOA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:14:00 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A45C2085B;
        Thu, 11 Oct 2018 15:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272774;
        bh=9Ml3iNPT1TotYWP7bTmpSA9Wsp4Gn8KUUdkNbsE5xq4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rtDF0jIClnZ0Y+AgO0zp/6Pklz+ZHOaVv4w/HZVg+40ChmVOUttDK+Y0hk74B2A6T
         SH0SHEvoIzAb8zGbGjVyljlEU9GBK1INv1ildgNoN3C3tg9o8aNFhRy5BRxtxbL9pe
         3bkI9+NstedxLr4YfViS530U2ZDCz+F5sKSwAVew=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christophe Leroy <christophe.leroy@c-s.fr>,
        Balbir Singh <bsingharora@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.14 33/45] powerpc/lib/code-patching: refactor patch_instruction()
Date:   Thu, 11 Oct 2018 17:40:00 +0200
Message-Id: <20181011152510.361835278@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011152508.885515042@linuxfoundation.org>
References: <20181011152508.885515042@linuxfoundation.org>
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

From: Christophe Leroy <christophe.leroy@c-s.fr>

commit 8cf4c05712f04a405f0dacebcca8f042b391694a upstream.

patch_instruction() uses almost the same sequence as
__patch_instruction()

This patch refactor it so that patch_instruction() uses
__patch_instruction() instead of duplicating code.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Acked-by: Balbir Singh <bsingharora@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/lib/code-patching.c |   30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

--- a/arch/powerpc/lib/code-patching.c
+++ b/arch/powerpc/lib/code-patching.c
@@ -23,19 +23,26 @@
 #include <asm/code-patching.h>
 #include <asm/setup.h>
 
-static int __patch_instruction(unsigned int *addr, unsigned int instr)
+static int __patch_instruction(unsigned int *exec_addr, unsigned int instr,
+			       unsigned int *patch_addr)
 {
 	int err;
 
-	__put_user_size(instr, addr, 4, err);
+	__put_user_size(instr, patch_addr, 4, err);
 	if (err)
 		return err;
 
-	asm ("dcbst 0, %0; sync; icbi 0,%0; sync; isync" :: "r" (addr));
+	asm ("dcbst 0, %0; sync; icbi 0,%1; sync; isync" :: "r" (patch_addr),
+							    "r" (exec_addr));
 
 	return 0;
 }
 
+static int raw_patch_instruction(unsigned int *addr, unsigned int instr)
+{
+	return __patch_instruction(addr, instr, addr);
+}
+
 #ifdef CONFIG_STRICT_KERNEL_RWX
 static DEFINE_PER_CPU(struct vm_struct *, text_poke_area);
 
@@ -138,7 +145,7 @@ static inline int unmap_patch_area(unsig
 int patch_instruction(unsigned int *addr, unsigned int instr)
 {
 	int err;
-	unsigned int *dest = NULL;
+	unsigned int *patch_addr = NULL;
 	unsigned long flags;
 	unsigned long text_poke_addr;
 	unsigned long kaddr = (unsigned long)addr;
@@ -149,7 +156,7 @@ int patch_instruction(unsigned int *addr
 	 * to allow patching. We just do the plain old patching
 	 */
 	if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
-		return __patch_instruction(addr, instr);
+		return raw_patch_instruction(addr, instr);
 
 	local_irq_save(flags);
 
@@ -159,17 +166,10 @@ int patch_instruction(unsigned int *addr
 		goto out;
 	}
 
-	dest = (unsigned int *)(text_poke_addr) +
+	patch_addr = (unsigned int *)(text_poke_addr) +
 			((kaddr & ~PAGE_MASK) / sizeof(unsigned int));
 
-	/*
-	 * We use __put_user_size so that we can handle faults while
-	 * writing to dest and return err to handle faults gracefully
-	 */
-	__put_user_size(instr, dest, 4, err);
-	if (!err)
-		asm ("dcbst 0, %0; sync; icbi 0,%0; icbi 0,%1; sync; isync"
-			::"r" (dest), "r"(addr));
+	__patch_instruction(addr, instr, patch_addr);
 
 	err = unmap_patch_area(text_poke_addr);
 	if (err)
@@ -184,7 +184,7 @@ out:
 
 int patch_instruction(unsigned int *addr, unsigned int instr)
 {
-	return __patch_instruction(addr, instr);
+	return raw_patch_instruction(addr, instr);
 }
 
 #endif /* CONFIG_STRICT_KERNEL_RWX */


