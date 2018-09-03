Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5236C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89FD320869
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:53:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89FD320869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728610AbeICVNy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:13:54 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38000 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727679AbeICVNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:13:53 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B9720CF9;
        Mon,  3 Sep 2018 16:52:56 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        linux-snps-arc@lists.infradead.org,
        Elad Kanfi <eladkan@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Ofer Levi <oferle@mellanox.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 30/56] arc: fix build errors in arc/include/asm/delay.h
Date:   Mon,  3 Sep 2018 18:49:20 +0200
Message-Id: <20180903164925.574808541@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903164924.078355019@linuxfoundation.org>
References: <20180903164924.078355019@linuxfoundation.org>
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

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit 2423665ec53f2a29191b35382075e9834288a975 ]

Fix build errors in arch/arc/'s delay.h:
- add "extern unsigned long loops_per_jiffy;"
- add <asm-generic/types.h> for "u64"

In file included from ../drivers/infiniband/hw/cxgb3/cxio_hal.c:32:
../arch/arc/include/asm/delay.h: In function '__udelay':
../arch/arc/include/asm/delay.h:61:12: error: 'u64' undeclared (first use in this function)
  loops = ((u64) usecs * 4295 * HZ * loops_per_jiffy) >> 32;
            ^~~

In file included from ../drivers/infiniband/hw/cxgb3/cxio_hal.c:32:
../arch/arc/include/asm/delay.h: In function '__udelay':
../arch/arc/include/asm/delay.h:63:37: error: 'loops_per_jiffy' undeclared (first use in this function)
  loops = ((u64) usecs * 4295 * HZ * loops_per_jiffy) >> 32;
                                     ^~~~~~~~~~~~~~~

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Vineet Gupta <vgupta@synopsys.com>
Cc: linux-snps-arc@lists.infradead.org
Cc: Elad Kanfi <eladkan@mellanox.com>
Cc: Leon Romanovsky <leonro@mellanox.com>
Cc: Ofer Levi <oferle@mellanox.com>
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arc/include/asm/delay.h |    3 +++
 1 file changed, 3 insertions(+)

--- a/arch/arc/include/asm/delay.h
+++ b/arch/arc/include/asm/delay.h
@@ -17,8 +17,11 @@
 #ifndef __ASM_ARC_UDELAY_H
 #define __ASM_ARC_UDELAY_H
 
+#include <asm-generic/types.h>
 #include <asm/param.h>		/* HZ */
 
+extern unsigned long loops_per_jiffy;
+
 static inline void __delay(unsigned long loops)
 {
 	__asm__ __volatile__(


