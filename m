Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF980C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79B7420878
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:45:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79B7420878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osadl.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932501AbeGIIpz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 04:45:55 -0400
Received: from www.osadl.org ([62.245.132.105]:51984 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932231AbeGIIpx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 04:45:53 -0400
Received: from debian01.hofrr.at (178.115.242.59.static.drei.at [178.115.242.59] (may be forged))
        by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id w698hQVG027720;
        Mon, 9 Jul 2018 10:43:26 +0200
From:   Nicholas Mc Guire <hofrat@osadl.org>
To:     Michal Simek <monstr@monstr.eu>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH] microblaze: warn if of_iomap() failed
Date:   Mon,  9 Jul 2018 10:42:44 +0200
Message-Id: <1531125764-25816-1-git-send-email-hofrat@osadl.org>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_iomap() can return NULL. The function is void thus error propagation
is not possible but at least a WARN_ON() seems warranted here as a silent
failure might lead to a hard to understand system state.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---

Problem located with experimental coccinelle script

Probably this should be a BUG_ON() as this is such a low level fault that
continuing operations probably makes little sense.

Patch was compiletested with: mmu_defconfig (implies CONFIG_PCI_XILINX=y)

Patch is against 4.18-rc3 (localversion-next is next-20180709)

 arch/microblaze/pci/xilinx_pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/microblaze/pci/xilinx_pci.c b/arch/microblaze/pci/xilinx_pci.c
index 14c7da5f..7fa72ff 100644
--- a/arch/microblaze/pci/xilinx_pci.c
+++ b/arch/microblaze/pci/xilinx_pci.c
@@ -157,6 +157,7 @@ void __init xilinx_pci_init(void)
 
 	/* Set the max bus number to 255, and bus/subbus no's to 0 */
 	pci_reg = of_iomap(pci_node, 0);
+	WARN_ON(!pci_reg);
 	out_be32(pci_reg + XPLB_PCI_BUS, 0x000000ff);
 	iounmap(pci_reg);
 
-- 
2.1.4

