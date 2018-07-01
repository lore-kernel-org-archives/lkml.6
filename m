Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C6CC6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 448B6241F3
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:38:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 448B6241F3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031627AbeGAQio (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 12:38:44 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36750 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031121AbeGAQig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:38:36 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 936D6A73;
        Sun,  1 Jul 2018 16:38:35 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Neuling <mikey@neuling.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.17 048/220] powerpc/ptrace: Fix enforcement of DAWR constraints
Date:   Sun,  1 Jul 2018 18:21:12 +0200
Message-Id: <20180701160910.326023106@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160908.272447118@linuxfoundation.org>
References: <20180701160908.272447118@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Neuling <mikey@neuling.org>

commit cd6ef7eebf171bfcba7dc2df719c2a4958775040 upstream.

Back when we first introduced the DAWR, in commit 4ae7ebe9522a
("powerpc: Change hardware breakpoint to allow longer ranges"), we
screwed up the constraint making it a 1024 byte boundary rather than a
512. This makes the check overly permissive. Fortunately GDB is the
only real user and it always did they right thing, so we never
noticed.

This fixes the constraint to 512 bytes.

Fixes: 4ae7ebe9522a ("powerpc: Change hardware breakpoint to allow longer ranges")
Cc: stable@vger.kernel.org # v3.9+
Signed-off-by: Michael Neuling <mikey@neuling.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/kernel/hw_breakpoint.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/powerpc/kernel/hw_breakpoint.c
+++ b/arch/powerpc/kernel/hw_breakpoint.c
@@ -178,8 +178,8 @@ int arch_validate_hwbkpt_settings(struct
 	if (cpu_has_feature(CPU_FTR_DAWR)) {
 		length_max = 512 ; /* 64 doublewords */
 		/* DAWR region can't cross 512 boundary */
-		if ((bp->attr.bp_addr >> 10) != 
-		    ((bp->attr.bp_addr + bp->attr.bp_len - 1) >> 10))
+		if ((bp->attr.bp_addr >> 9) !=
+		    ((bp->attr.bp_addr + bp->attr.bp_len - 1) >> 9))
 			return -EINVAL;
 	}
 	if (info->len >


