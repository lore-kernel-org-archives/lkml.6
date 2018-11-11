Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2542FC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E210A223CB
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:33:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vwSp+Pu4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E210A223CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391014AbeKLIXd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:23:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:57348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404427AbeKLIXb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:23:31 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C72F223C8;
        Sun, 11 Nov 2018 22:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975613;
        bh=rFosyM6gnubDEpJ+rU3yJn4HArvGi9xb1aNNuKRdcKs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vwSp+Pu484OcC6oav0aRjCPRl/cL9bYVf/ifFrHogn/aZlA7Ww7HPKARnKh6CPWhW
         +Fe2/F2WeBvqVR6kIFYLUh/+C/iXO/oEku+WWVkr15XhcDjskSTmHcO7cuaYKpyImY
         0x2bcQCRCissVwap+ZzZDl8r/KwtrCSUD5XvXOXs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John David Anglin <dave.anglin@bell.net>,
        Helge Deller <deller@gmx.de>
Subject: [PATCH 4.9 007/141] parisc: Fix address in HPMC IVA
Date:   Sun, 11 Nov 2018 14:24:26 -0800
Message-Id: <20181111221628.725750031@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221627.853046496@linuxfoundation.org>
References: <20181111221627.853046496@linuxfoundation.org>
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

From: John David Anglin <dave.anglin@bell.net>

commit 1138b6718ff74d2a934459643e3754423d23b5e2 upstream.

Helge noticed that the address of the os_hpmc handler was not being
correctly calculated in the hpmc macro.  As a result, PDCE_CHECK would
fail to call os_hpmc:

<Cpu2> e800009802e00000  0000000000000000  CC_ERR_CHECK_HPMC
<Cpu2> 37000f7302e00000  8040004000000000  CC_ERR_CPU_CHECK_SUMMARY
<Cpu2> f600105e02e00000  fffffff0f0c00000  CC_MC_HPMC_MONARCH_SELECTED
<Cpu2> 140003b202e00000  000000000000000b  CC_ERR_HPMC_STATE_ENTRY
<Cpu2> 5600100b02e00000  00000000000001a0  CC_MC_OS_HPMC_LEN_ERR
<Cpu2> 5600106402e00000  fffffff0f0438e70  CC_MC_BR_TO_OS_HPMC_FAILED
<Cpu2> e800009802e00000  0000000000000000  CC_ERR_CHECK_HPMC
<Cpu2> 37000f7302e00000  8040004000000000  CC_ERR_CPU_CHECK_SUMMARY
<Cpu2> 4000109f02e00000  0000000000000000  CC_MC_HPMC_INITIATED
<Cpu2> 4000101902e00000  0000000000000000  CC_MC_MULTIPLE_HPMCS
<Cpu2> 030010d502e00000  0000000000000000  CC_CPU_STOP

The address problem can be seen by dumping the fault vector:

0000000040159000 <fault_vector_20>:
    40159000:   63 6f 77 73     stb r15,-2447(dp)
    40159004:   20 63 61 6e     ldil L%b747000,r3
    40159008:   20 66 6c 79     ldil L%-1c3b3000,r3
        ...
    40159020:   08 00 02 40     nop
    40159024:   20 6e 60 02     ldil L%15d000,r3
    40159028:   34 63 00 00     ldo 0(r3),r3
    4015902c:   e8 60 c0 02     bv,n r0(r3)
    40159030:   08 00 02 40     nop
    40159034:   00 00 00 00     break 0,0
    40159038:   c0 00 70 00     bb,*< r0,sar,40159840 <fault_vector_20+0x840>
    4015903c:   00 00 00 00     break 0,0

Location 40159038 should contain the physical address of os_hpmc:

000000004015d000 <os_hpmc>:
    4015d000:   08 1a 02 43     copy r26,r3
    4015d004:   01 c0 08 a4     mfctl iva,r4
    4015d008:   48 85 00 68     ldw 34(r4),r5

This patch moves the address setup into initialize_ivt to resolve the
above problem.  I tested the change by dumping the HPMC entry after setup:

0000000040209020:  8000240
0000000040209024: 206a2004
0000000040209028: 34630ac0
000000004020902c: e860c002
0000000040209030:  8000240
0000000040209034: 1bdddce6
0000000040209038:   15d000
000000004020903c:      1a0

Signed-off-by: John David Anglin <dave.anglin@bell.net>
Cc: <stable@vger.kernel.org>
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/parisc/kernel/entry.S |    2 +-
 arch/parisc/kernel/traps.c |    3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

--- a/arch/parisc/kernel/entry.S
+++ b/arch/parisc/kernel/entry.S
@@ -185,7 +185,7 @@
 	bv,n	0(%r3)
 	nop
 	.word	0		/* checksum (will be patched) */
-	.word	PA(os_hpmc)	/* address of handler */
+	.word	0		/* address of handler */
 	.word	0		/* length of handler */
 	.endm
 
--- a/arch/parisc/kernel/traps.c
+++ b/arch/parisc/kernel/traps.c
@@ -826,7 +826,8 @@ void __init initialize_ivt(const void *i
 	for (i = 0; i < 8; i++)
 	    *ivap++ = 0;
 
-	/* Compute Checksum for HPMC handler */
+	/* Setup IVA and compute checksum for HPMC handler */
+	ivap[6] = (u32)__pa(os_hpmc);
 	length = os_hpmc_size;
 	ivap[7] = length;
 


