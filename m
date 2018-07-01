Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC94C6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBF5A2517D
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:25:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBF5A2517D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753585AbeGAQZi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 12:25:38 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33700 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753514AbeGAQZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:25:35 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0FF7EACD;
        Sun,  1 Jul 2018 16:25:34 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 4.9 032/101] arm64: mm: Ensure writes to swapper are ordered wrt subsequent cache maintenance
Date:   Sun,  1 Jul 2018 18:21:18 +0200
Message-Id: <20180701160758.445886785@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160757.138608453@linuxfoundation.org>
References: <20180701160757.138608453@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Will Deacon <will.deacon@arm.com>

commit 71c8fc0c96abf8e53e74ed4d891d671e585f9076 upstream.

When rewriting swapper using nG mappings, we must performance cache
maintenance around each page table access in order to avoid coherency
problems with the host's cacheable alias under KVM. To ensure correct
ordering of the maintenance with respect to Device memory accesses made
with the Stage-1 MMU disabled, DMBs need to be added between the
maintenance and the corresponding memory access.

This patch adds a missing DMB between writing a new page table entry and
performing a clean+invalidate on the same line.

Fixes: f992b4dfd58b ("arm64: kpti: Add ->enable callback to remap swapper using nG mappings")
Cc: <stable@vger.kernel.org> # 4.16.x-
Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/mm/proc.S |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -186,8 +186,9 @@ ENDPROC(idmap_cpu_replace_ttbr1)
 
 	.macro __idmap_kpti_put_pgtable_ent_ng, type
 	orr	\type, \type, #PTE_NG		// Same bit for blocks and pages
-	str	\type, [cur_\()\type\()p]	// Update the entry and ensure it
-	dc	civac, cur_\()\type\()p		// is visible to all CPUs.
+	str	\type, [cur_\()\type\()p]	// Update the entry and ensure
+	dmb	sy				// that it is visible to all
+	dc	civac, cur_\()\type\()p		// CPUs.
 	.endm
 
 /*


