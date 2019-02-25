Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E8AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AC3B2146F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551129273;
	bh=75sM47vdlWTFTk8dLZ6Y1IRwIuoQ1cCzTtonNwZJQ7I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=L3zFtFZ92UNXmN3BlK2eqtY/DxWusqIwylXSvRHNwqql2/7/GKydi55C0Yd8Dlfev
	 19/rNkTdp92XEVDjettG1TgjfjzLaTWzzGldVhHQAir9i0WPCFj0dKnMdrb5JuxSr7
	 1Jo8ygjM9ipeCvwbwdisCyacnX47lWnb6AC3Xa14=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729282AbfBYVOc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:14:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:45354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729256AbfBYVO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:14:28 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4792D2147C;
        Mon, 25 Feb 2019 21:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129267;
        bh=75sM47vdlWTFTk8dLZ6Y1IRwIuoQ1cCzTtonNwZJQ7I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TCY/LGSW9LaTUWGN/A6xP2LQi1PNLQl/SI79hu9c6eg9JY1nBW1DPweM2Ia1iUgim
         TqR3wgQwUqSUHXH6mhcJ81WyWZoHaG/eCbAwjHtn8Cp96TgNBTS74uW9HoNiMID9OU
         s+Qp1jsjtYg63h/5Ekuu0OGzmjZo+TvceN09iESs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vineet Gupta <vgupta@synopsys.com>
Subject: [PATCH 4.9 39/63] ARCv2: Enable unaligned access in early ASM code
Date:   Mon, 25 Feb 2019 22:11:39 +0100
Message-Id: <20190225195038.798692545@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195035.713274200@linuxfoundation.org>
References: <20190225195035.713274200@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>

commit 252f6e8eae909bc075a1b1e3b9efb095ae4c0b56 upstream.

It is currently done in arc_init_IRQ() which might be too late
considering gcc 7.3.1 onwards (GNU 2018.03) generates unaligned
memory accesses by default

Cc: stable@vger.kernel.org #4.4+
Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
[vgupta: rewrote changelog]
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arc/kernel/head.S |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/arch/arc/kernel/head.S
+++ b/arch/arc/kernel/head.S
@@ -17,6 +17,7 @@
 #include <asm/entry.h>
 #include <asm/arcregs.h>
 #include <asm/cache.h>
+#include <asm/irqflags.h>
 
 .macro CPU_EARLY_SETUP
 
@@ -47,6 +48,15 @@
 	sr	r5, [ARC_REG_DC_CTRL]
 
 1:
+
+#ifdef CONFIG_ISA_ARCV2
+	; Unaligned access is disabled at reset, so re-enable early as
+	; gcc 7.3.1 (ARC GNU 2018.03) onwards generates unaligned access
+	; by default
+	lr	r5, [status32]
+	bset	r5, r5, STATUS_AD_BIT
+	kflag	r5
+#endif
 .endm
 
 	.section .init.text, "ax",@progbits


