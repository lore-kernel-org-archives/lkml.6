Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B31DBECDFB1
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 10:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DEE5208DB
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 10:21:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DEE5208DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osadl.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbeGOKn4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 06:43:56 -0400
Received: from www.osadl.org ([62.245.132.105]:37325 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726060AbeGOKn4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 06:43:56 -0400
Received: from debian01.hofrr.at (178.115.242.59.static.drei.at [178.115.242.59] (may be forged))
        by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id w6FAJBaI004985;
        Sun, 15 Jul 2018 12:19:12 +0200
From:   Nicholas Mc Guire <hofrat@osadl.org>
To:     Michael Turquette <mturquette@baylibre.com>
Cc:     Stephen Boyd <sboyd@kernel.org>, Kees Cook <keescook@chromium.org>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH 1/2] drivers: clk: st: warn on iomap failure
Date:   Sun, 15 Jul 2018 12:18:23 +0200
Message-Id: <1531649904-6072-1-git-send-email-hofrat@osadl.org>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 While the return value of clkgen_get_register_base() is being checked
at the call site, there is no indication of failure cause thus making
diagnosis of the issues hard. The WARN_ON() allows to determine the
cause of failure.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---

Problem found by an experimental coccinelle script

Patch was compile tested with: multi_v7_defconfig (implies
CONFIG_ARCH_STI=y)

Patch is against 4.18-rc4 (localversion-next is next-20180713)

 drivers/clk/st/clkgen-pll.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/st/clkgen-pll.c b/drivers/clk/st/clkgen-pll.c
index cbb5184..aeb30ab 100644
--- a/drivers/clk/st/clkgen-pll.c
+++ b/drivers/clk/st/clkgen-pll.c
@@ -647,6 +647,7 @@ static void __iomem * __init clkgen_get_register_base(
 		return NULL;
 
 	reg = of_iomap(pnode, 0);
+	WARN_ON(!reg);
 
 	of_node_put(pnode);
 	return reg;
-- 
2.1.4

