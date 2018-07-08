Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 464FAC3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 08:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED820208B0
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 08:38:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED820208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osadl.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932307AbeGHIiQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 04:38:16 -0400
Received: from www.osadl.org ([62.245.132.105]:44086 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932082AbeGHIiP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 04:38:15 -0400
Received: from debian01.hofrr.at (178.115.242.59.static.drei.at [178.115.242.59] (may be forged))
        by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id w688XYPe029791;
        Sun, 8 Jul 2018 10:33:35 +0200
From:   Nicholas Mc Guire <hofrat@osadl.org>
To:     Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH] ARM: imx: flag failure of of_iomap
Date:   Sun,  8 Jul 2018 10:32:54 +0200
Message-Id: <1531038774-24657-1-git-send-email-hofrat@osadl.org>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 imx_set_aips is assuming that the address returned from of_iomap is
valid which it probably is in the normal case - as the call site
is void error propagation is not possible but never the less at least
a WARN_ON() seems warranted here.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Fixes: commit e57e4ab5fc2e ("ARM: i.MX: allow disabling supervisor protect via DT")
---

Problem found by experimental coccinelle script

Patch was compiletested with: multi_v7_defconfig

Patch is against 4.18-rc3 (localversion-next is next-20180706)

 arch/arm/mach-imx/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-imx/cpu.c b/arch/arm/mach-imx/cpu.c
index 32969f3..c6b1bf9 100644
--- a/arch/arm/mach-imx/cpu.c
+++ b/arch/arm/mach-imx/cpu.c
@@ -68,6 +68,7 @@ void __init imx_aips_allow_unprivileged_access(
 
 	for_each_compatible_node(np, NULL, compat) {
 		aips_base_addr = of_iomap(np, 0);
+		WARN_ON(!aips_base_addr);
 		imx_set_aips(aips_base_addr);
 	}
 }
-- 
2.1.4

