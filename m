Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCCDBC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D3152089E
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:11:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D3152089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389322AbeG0Lcf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 07:32:35 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36716 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730866AbeG0Lce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 07:32:34 -0400
Received: from localhost (unknown [89.188.5.116])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3F451CB7;
        Fri, 27 Jul 2018 10:11:22 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
        John Crispin <john@phrozen.org>,
        Paul Burton <paul.burton@mips.com>,
        Alban Bedel <albeu@free.fr>, James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH 4.4 01/23] MIPS: ath79: fix register address in ath79_ddr_wb_flush()
Date:   Fri, 27 Jul 2018 12:09:02 +0200
Message-Id: <20180727100845.236622331@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180727100845.054377089@linuxfoundation.org>
References: <20180727100845.054377089@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Felix Fietkau <nbd@nbd.name>

commit bc88ad2efd11f29e00a4fd60fcd1887abfe76833 upstream.

ath79_ddr_wb_flush_base has the type void __iomem *, so register offsets
need to be a multiple of 4 in order to access the intended register.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: John Crispin <john@phrozen.org>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Fixes: 24b0e3e84fbf ("MIPS: ath79: Improve the DDR controller interface")
Patchwork: https://patchwork.linux-mips.org/patch/19912/
Cc: Alban Bedel <albeu@free.fr>
Cc: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: stable@vger.kernel.org # 4.2+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/ath79/common.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mips/ath79/common.c
+++ b/arch/mips/ath79/common.c
@@ -58,7 +58,7 @@ EXPORT_SYMBOL_GPL(ath79_ddr_ctrl_init);
 
 void ath79_ddr_wb_flush(u32 reg)
 {
-	void __iomem *flush_reg = ath79_ddr_wb_flush_base + reg;
+	void __iomem *flush_reg = ath79_ddr_wb_flush_base + (reg * 4);
 
 	/* Flush the DDR write buffer. */
 	__raw_writel(0x1, flush_reg);


