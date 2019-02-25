Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EBBAC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CD50205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551129532;
	bh=ULhYdiKeY4HBAFsqf0Ijbr5OdEYslX0WO0Gj8O8vQ48=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=REJUsLqln2hrjUpky0uS6/wDOEP1uImKKIpBkWGknROsL9rPrfTf/ykfsrQVKnz1v
	 Om/QDfvDOiiCOeJ4417J6fXhTcYTb0WhMVQnf0Zs6RXC4vQCHz2IWs+++bPHRulgcW
	 xm2qKCIxlo/1R8ERv/vikA5mWDhSTDZXbYF9ccMo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730193AbfBYVSu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:18:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:51478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729661AbfBYVSr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:18:47 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E64B2173C;
        Mon, 25 Feb 2019 21:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129526;
        bh=ULhYdiKeY4HBAFsqf0Ijbr5OdEYslX0WO0Gj8O8vQ48=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZfQ9mpqb1snE9fL85zQ/eod34nPUhsiOQnwasY9W06IFFhFyqfxmGvwL+0bB7SICU
         QDBGBuwVXJFViHGn4wtJ40+e+OdN5kHrWK4WFZQ6ewdh6khWH1CoK3a3Q9n4bHY807
         0E2S4Xq9uwfqK+Vq2bnjXmURlj5/NL2Q1bGl9Vis=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vineet Gupta <vgupta@synopsys.com>
Subject: [PATCH 4.14 59/71] ARCv2: Enable unaligned access in early ASM code
Date:   Mon, 25 Feb 2019 22:12:01 +0100
Message-Id: <20190225195039.071788627@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195034.555044862@linuxfoundation.org>
References: <20190225195034.555044862@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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


