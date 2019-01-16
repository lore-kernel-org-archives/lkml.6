Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B6EFC43612
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AE8520657
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:33:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405726AbfAPQdE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 11:33:04 -0500
Received: from bastet.se.axis.com ([195.60.68.11]:42710 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405701AbfAPQdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 11:33:02 -0500
Received: from localhost (localhost [127.0.0.1])
        by bastet.se.axis.com (Postfix) with ESMTP id 8E4521855F;
        Wed, 16 Jan 2019 17:33:00 +0100 (CET)
X-Axis-User: NO
X-Axis-NonUser: YES
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id GD1Tq1onblLJ; Wed, 16 Jan 2019 17:32:58 +0100 (CET)
Received: from boulder03.se.axis.com (boulder03.se.axis.com [10.0.8.17])
        by bastet.se.axis.com (Postfix) with ESMTPS id 3B0AF18559;
        Wed, 16 Jan 2019 17:32:58 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 256E41E079;
        Wed, 16 Jan 2019 17:32:58 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 174871E074;
        Wed, 16 Jan 2019 17:32:58 +0100 (CET)
Received: from thoth.se.axis.com (unknown [10.0.2.173])
        by boulder03.se.axis.com (Postfix) with ESMTP;
        Wed, 16 Jan 2019 17:32:58 +0100 (CET)
Received: from lnxartpec.se.axis.com (lnxartpec.se.axis.com [10.88.4.9])
        by thoth.se.axis.com (Postfix) with ESMTP id 064AE3122;
        Wed, 16 Jan 2019 17:32:58 +0100 (CET)
Received: by lnxartpec.se.axis.com (Postfix, from userid 10564)
        id 021EC80B56; Wed, 16 Jan 2019 17:32:58 +0100 (CET)
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     sudeep.dutt@intel.com, ashutosh.dixit@intel.com,
        gregkh@linuxfoundation.org, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, Vincent Whitchurch <rabinv@axis.com>
Subject: [PATCH 4/8] vop: Allow building on more systems
Date:   Wed, 16 Jan 2019 17:32:49 +0100
Message-Id: <20190116163253.23780-5-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190116163253.23780-1-vincent.whitchurch@axis.com>
References: <20190116163253.23780-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VOP_BUS does not actually depend on 32-bit X86 or PCI.  The code uses
archdata.dma_ops so it can be built on ARM too.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 drivers/misc/mic/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/mic/Kconfig b/drivers/misc/mic/Kconfig
index 227cc7443671..319ee3c90a26 100644
--- a/drivers/misc/mic/Kconfig
+++ b/drivers/misc/mic/Kconfig
@@ -38,7 +38,7 @@ comment "VOP Bus Driver"
 
 config VOP_BUS
 	tristate "VOP Bus Driver"
-	depends on 64BIT && PCI && X86 && X86_DEV_DMA_OPS
+	depends on ARM || (X86 && X86_DEV_DMA_OPS)
 	help
 	  This option is selected by any driver which registers a
 	  device or driver on the VOP Bus, such as CONFIG_INTEL_MIC_HOST
@@ -132,7 +132,7 @@ comment "VOP Driver"
 
 config VOP
 	tristate "VOP Driver"
-	depends on 64BIT && PCI && X86 && VOP_BUS
+	depends on VOP_BUS
 	select VHOST_RING
 	select VIRTIO
 	help
-- 
2.20.0

