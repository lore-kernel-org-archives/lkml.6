Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A21ECECDFBB
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6708120882
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:53:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6708120882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388505AbeGXM7V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 08:59:21 -0400
Received: from mail.bootlin.com ([62.4.15.54]:57533 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388348AbeGXM7V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 08:59:21 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 17D69207AD; Tue, 24 Jul 2018 13:53:12 +0200 (CEST)
Received: from localhost (176.199.29.109.rev.sfr.net [109.29.199.176])
        by mail.bootlin.com (Postfix) with ESMTPSA id C84C1203EC;
        Tue, 24 Jul 2018 13:53:11 +0200 (CEST)
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     "David S . Miller" <davem@davemloft.net>
Cc:     sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marc Zyngier <marc.zyngier@arm.com>,
        Hanna Hawa <hannah@marvell.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH 2/2] sparc: use asm-generic version of msi.h
Date:   Tue, 24 Jul 2018 13:53:05 +0200
Message-Id: <20180724115305.11289-2-thomas.petazzoni@bootlin.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180724115305.11289-1-thomas.petazzoni@bootlin.com>
References: <20180724115305.11289-1-thomas.petazzoni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is necessary to be able to include <linux/msi.h> when
CONFIG_GENERIC_MSI_IRQ_DOMAIN is enabled. Without this, a build with
CONFIG_GENERIC_MSI_IRQ_DOMAIN fails with:

   In file included from drivers//ata/ahci.c:45:0:
>> include/linux/msi.h:226:10: error: unknown type name 'msi_alloc_info_t'; did you mean 'sg_alloc_fn'?
             msi_alloc_info_t *arg);
             ^~~~~~~~~~~~~~~~
             sg_alloc_fn
   include/linux/msi.h:230:9: error: unknown type name 'msi_alloc_info_t'; did you mean 'sg_alloc_fn'?
            msi_alloc_info_t *arg);
            ^~~~~~~~~~~~~~~~
            sg_alloc_fn
   include/linux/msi.h:239:12: error: unknown type name 'msi_alloc_info_t'; did you mean 'sg_alloc_fn'?
               msi_alloc_info_t *arg);
               ^~~~~~~~~~~~~~~~
               sg_alloc_fn
   include/linux/msi.h:240:22: error: unknown type name 'msi_alloc_info_t'; did you mean 'sg_alloc_fn'?
     void  (*msi_finish)(msi_alloc_info_t *arg, int retval);
                         ^~~~~~~~~~~~~~~~
                         sg_alloc_fn
   include/linux/msi.h:241:20: error: unknown type name 'msi_alloc_info_t'; did you mean 'sg_alloc_fn'?
     void  (*set_desc)(msi_alloc_info_t *arg,
                       ^~~~~~~~~~~~~~~~
                       sg_alloc_fn
   include/linux/msi.h:316:18: error: unknown type name 'msi_alloc_info_t'; did you mean 'sg_alloc_fn'?
           int nvec, msi_alloc_info_t *args);
                     ^~~~~~~~~~~~~~~~
                     sg_alloc_fn
   include/linux/msi.h:318:29: error: unknown type name 'msi_alloc_info_t'; did you mean 'sg_alloc_fn'?
            int virq, int nvec, msi_alloc_info_t *args);
                                ^~~~~~~~~~~~~~~~
                                sg_alloc_fn

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
---
 arch/sparc/include/asm/Kbuild | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sparc/include/asm/Kbuild b/arch/sparc/include/asm/Kbuild
index ac67828da201..410b263ef5c8 100644
--- a/arch/sparc/include/asm/Kbuild
+++ b/arch/sparc/include/asm/Kbuild
@@ -13,6 +13,7 @@ generic-y += local64.h
 generic-y += mcs_spinlock.h
 generic-y += mm-arch-hooks.h
 generic-y += module.h
+generic-y += msi.h
 generic-y += preempt.h
 generic-y += rwsem.h
 generic-y += serial.h
-- 
2.14.4

