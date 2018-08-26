Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 585FAC433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 06:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D9562170B
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 06:47:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D9562170B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbeHZK3G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 06:29:06 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53792 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727765AbeHZK3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 06:29:04 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 52F3725A;
        Sun, 26 Aug 2018 06:47:29 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 42/56] ARM: pxa: irq: fix handling of ICMR registers in suspend/resume
Date:   Sun, 26 Aug 2018 08:45:03 +0200
Message-Id: <20180826064234.373894547@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180826064232.320669119@linuxfoundation.org>
References: <20180826064232.320669119@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Mack <daniel@zonque.org>

[ Upstream commit 0c1049dcb4ceec640d8bd797335bcbebdcab44d2 ]

PXA3xx platforms have 56 interrupts that are stored in two ICMR
registers. The code in pxa_irq_suspend() and pxa_irq_resume() however
does a simple division by 32 which only leads to one register being
saved at suspend and restored at resume time. The NAND interrupt
setting, for instance, is lost.

Fix this by using DIV_ROUND_UP() instead.

Signed-off-by: Daniel Mack <daniel@zonque.org>
Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/mach-pxa/irq.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/arm/mach-pxa/irq.c
+++ b/arch/arm/mach-pxa/irq.c
@@ -160,7 +160,7 @@ static int pxa_irq_suspend(void)
 {
 	int i;
 
-	for (i = 0; i < pxa_internal_irq_nr / 32; i++) {
+	for (i = 0; i < DIV_ROUND_UP(pxa_internal_irq_nr, 32); i++) {
 		void __iomem *base = irq_base(i);
 
 		saved_icmr[i] = __raw_readl(base + ICMR);
@@ -179,7 +179,7 @@ static void pxa_irq_resume(void)
 {
 	int i;
 
-	for (i = 0; i < pxa_internal_irq_nr / 32; i++) {
+	for (i = 0; i < DIV_ROUND_UP(pxa_internal_irq_nr, 32); i++) {
 		void __iomem *base = irq_base(i);
 
 		__raw_writel(saved_icmr[i], base + ICMR);


