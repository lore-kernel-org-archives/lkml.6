Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 408ACC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 057B620855
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543042;
	bh=EQhQ/jz9GSiri87p6mOhVl8XyyJr/v8PTvooQVHCRyQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rqB84I4jfGLLlL5TOfEu+U/BN3tMrtMC9IKKgAJvDE/zx9I63i8bBxRCA4qSPe+Ht
	 EHI/lL4UPMchCFgDMU7E2PGEqc+b5ErK3Pd5zC18g0hreTl3K3uVyQEGV+R4PpJ5qc
	 HI7UCngGVqo7J8MGiwVJqQiW1I59uvaUFM+fOsHs=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 057B620855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbeLKPoA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:44:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:60458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727659AbeLKPnx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:43:53 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA8A520672;
        Tue, 11 Dec 2018 15:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543033;
        bh=EQhQ/jz9GSiri87p6mOhVl8XyyJr/v8PTvooQVHCRyQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CuP5PurrpA2NBed5Zp6kmh/PtKZuTHjRJH1/UlxlBV31ox7dzL9UGBTChXODGd7o9
         668VwvWcF3PcO+K0JxD9pZAteAqn6I55ox/jVWcwY1F3vuBoRUGyArirvp5CC/prY8
         aIpgx6nHqgfsTgts64NHDhmv6KvWemTqyPa+Cbaw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anton Blanchard <anton@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 40/54] powerpc/vdso64: Use double word compare on pointers
Date:   Tue, 11 Dec 2018 16:41:28 +0100
Message-Id: <20181211151548.329260078@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151546.010073210@linuxfoundation.org>
References: <20181211151546.010073210@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 5045ea37377ce8cca6890d32b127ad6770e6dce5 ]

__kernel_get_syscall_map() and __kernel_clock_getres() use cmpli to
check if the passed in pointer is non zero. cmpli maps to a 32 bit
compare on binutils, so we ignore the top 32 bits.

A simple test case can be created by passing in a bogus pointer with
the bottom 32 bits clear. Using a clk_id that is handled by the VDSO,
then one that is handled by the kernel shows the problem:

  printf("%d\n", clock_getres(CLOCK_REALTIME, (void *)0x100000000));
  printf("%d\n", clock_getres(CLOCK_BOOTTIME, (void *)0x100000000));

And we get:

  0
  -1

The bigger issue is if we pass a valid pointer with the bottom 32 bits
clear, in this case we will return success but won't write any data
to the pointer.

I stumbled across this issue because the LLVM integrated assembler
doesn't accept cmpli with 3 arguments. Fix this by converting them to
cmpldi.

Fixes: a7f290dad32e ("[PATCH] powerpc: Merge vdso's and add vdso support to 32 bits kernel")
Cc: stable@vger.kernel.org # v2.6.15+
Signed-off-by: Anton Blanchard <anton@samba.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kernel/vdso64/datapage.S     | 2 +-
 arch/powerpc/kernel/vdso64/gettimeofday.S | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/vdso64/datapage.S b/arch/powerpc/kernel/vdso64/datapage.S
index 79796de11737..3263ee23170d 100644
--- a/arch/powerpc/kernel/vdso64/datapage.S
+++ b/arch/powerpc/kernel/vdso64/datapage.S
@@ -57,7 +57,7 @@ V_FUNCTION_BEGIN(__kernel_get_syscall_map)
 	bl	V_LOCAL_FUNC(__get_datapage)
 	mtlr	r12
 	addi	r3,r3,CFG_SYSCALL_MAP64
-	cmpli	cr0,r4,0
+	cmpldi	cr0,r4,0
 	crclr	cr0*4+so
 	beqlr
 	li	r0,__NR_syscalls
diff --git a/arch/powerpc/kernel/vdso64/gettimeofday.S b/arch/powerpc/kernel/vdso64/gettimeofday.S
index a76b4af37ef2..382021324883 100644
--- a/arch/powerpc/kernel/vdso64/gettimeofday.S
+++ b/arch/powerpc/kernel/vdso64/gettimeofday.S
@@ -145,7 +145,7 @@ V_FUNCTION_BEGIN(__kernel_clock_getres)
 	bne	cr0,99f
 
 	li	r3,0
-	cmpli	cr0,r4,0
+	cmpldi	cr0,r4,0
 	crclr	cr0*4+so
 	beqlr
 	lis	r5,CLOCK_REALTIME_RES@h
-- 
2.19.1



