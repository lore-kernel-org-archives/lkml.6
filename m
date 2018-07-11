Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C881C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 18:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E6B620C51
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 18:35:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E6B620C51
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osadl.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389153AbeGKSl1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 14:41:27 -0400
Received: from www.osadl.org ([62.245.132.105]:49808 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387502AbeGKSl1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 14:41:27 -0400
Received: from debian01.hofrr.at (178.115.242.59.static.drei.at [178.115.242.59] (may be forged))
        by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id w6BIXR1I004645;
        Wed, 11 Jul 2018 20:33:27 +0200
From:   Nicholas Mc Guire <hofrat@osadl.org>
To:     Paul Burton <paul.burton@mips.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH] MIPS: generic: fix missing of_node_put()
Date:   Wed, 11 Jul 2018 20:32:45 +0200
Message-Id: <1531333965-7342-1-git-send-email-hofrat@osadl.org>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 of_find_compatible_node() returns a device_node pointer with refcount
incremented and must be decremented explicitly.  
 As this code is using the result only to check presence of the interrupt 
controller (!NULL) but not actually using the result otherwise the 
refcount can be decremented here immediately again.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Fixes: commit eed0eabd12ef ("MIPS: generic: Introduce generic DT-based board support")
---

Problem located with an experimental coccinelle script

Patch was compiletested with: 32r1_defconfig (implies generic_defconfig)

Patch is against 4.18-rc4 (localversion-next is next-20180711)

 arch/mips/generic/init.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/generic/init.c b/arch/mips/generic/init.c
index 07ec084..a106f81 100644
--- a/arch/mips/generic/init.c
+++ b/arch/mips/generic/init.c
@@ -203,6 +203,7 @@ void __init arch_init_irq(void)
 					    "mti,cpu-interrupt-controller");
 	if (!cpu_has_veic && !intc_node)
 		mips_cpu_irq_init();
+	of_node_put(intc_node);
 
 	irqchip_init();
 }
-- 
2.1.4

