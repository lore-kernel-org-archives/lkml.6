Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7041C6778D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 14:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96A8720866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 14:44:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="q9ARnH5f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96A8720866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbeILTto (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 15:49:44 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38592 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbeILTto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 15:49:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=MEkFUdhatU81cd/6CNGwUOFEf7dJ6l9UqhcYhOm2uRo=; b=q9ARnH5fAdoVUFOBv1tae/ZOB
        4nIaZoWAUNOMHS7qZvfWxRUzRI/RaVI15s5RB0ck34RmwwQOtWhDoReS5k1DCUYwlDTQN4R1I/WAe
        ihJnEUexBf1XGqvISN80kUBjkn7gWyYl5DYy61IJFaHzSiW9tb6c0EntFnIZ6jZaXQLlbTc/RlvBR
        5w0j1Kg/WdA5SniktkgI/Xq0/a2PEaVQB5ay09A43ZA2xtlE1QvK9v/7g5woBmCdZ7SsTSDhhMXu0
        7XeCiZJc5wPPNlq8xdjYgeA6fV5v+x2RWD15AxlsOCjjuU7cMzDbsYnygH1ifILjPUE1U/k1Xk7v+
        9qznGS8Qg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g06Nr-0007dH-Fh; Wed, 12 Sep 2018 14:44:47 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Waiman Long <longman@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Richard Henderson <rth@twiddle.net>
Subject: [PATCH 2/2] x86: Enable named address spaces for percpu data
Date:   Wed, 12 Sep 2018 07:44:42 -0700
Message-Id: <20180912144442.29271-3-willy@infradead.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180912144442.29271-1-willy@infradead.org>
References: <20180912144442.29271-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Henderson <rth@twiddle.net>

For ease of disabling this feature, split the actual enabling into its
own patch.

Signed-off-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
 arch/x86/include/asm/percpu.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index 30a08d0d95ee..f3c5eebcbc86 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -5,9 +5,15 @@
 #ifdef CONFIG_X86_64
 #define __percpu_seg		gs
 #define __percpu_mov_op		movq
+# ifdef __SEG_GS
+#  define __percpu_addrspace	__seg_gs
+# endif
 #else
 #define __percpu_seg		fs
 #define __percpu_mov_op		movl
+# ifdef __SEG_FS
+#  define __percpu_addrspace	__seg_fs
+# endif
 #endif
 
 #ifdef __ASSEMBLY__
-- 
2.18.0

