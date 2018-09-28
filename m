Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91694C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 00:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E22C2172C
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 00:53:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E22C2172C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728958AbeI1HOP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 03:14:15 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:52994 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726106AbeI1HOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 03:14:10 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07694427|-1;CH=blue;FP=3409973072285762938|1|1|12|0|-1|-1|-1;HT=e02c03278;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=18;RT=18;SR=0;TI=SMTPD_---.Cwkm2cI_1538095948;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.Cwkm2cI_1538095948)
          by smtp.aliyun-inc.com(10.147.44.129);
          Fri, 28 Sep 2018 08:52:29 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     akpm@linux-foundation.org, arnd@arndb.de,
        daniel.lezcano@linaro.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, jason@lakedaemon.net,
        marc.zyngier@arm.com, mark.rutland@arm.com,
        mchehab+samsung@kernel.org, peterz@infradead.org, robh@kernel.org,
        robh+dt@kernel.org, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        devicetree@vger.kernel.org, green.hu@gmail.com,
        Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V6 31/33] csky: fix compile error in linux/bug.h with SMP enabled
Date:   Fri, 28 Sep 2018 08:51:28 +0800
Message-Id: <0b20e1e62b23f9963020423e7e9c5ce833313fcc.1538058840.git.ren_guo@c-sky.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <62098e7d0a7fbdd09f44d7e23333dad258a01bd2.1538058840.git.ren_guo@c-sky.com>
References: <62098e7d0a7fbdd09f44d7e23333dad258a01bd2.1538058840.git.ren_guo@c-sky.com>
In-Reply-To: <cover.1538058840.git.ren_guo@c-sky.com>
References: <cover.1538058840.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In linux-4.19 we couldn't include linux/bug.h here when SMP enabled.
It'll cause compile error for bad include.

In file included from ./arch/csky/include/asm/bitops.h:70:0,
                 from ./include/linux/bitops.h:19,
                 from ./include/linux/kernel.h:11,
                 from ./include/asm-generic/bug.h:18,
                 from ./arch/csky/include/asm/bug.h:19,
                 from ./include/linux/bug.h:5,
                 from ./arch/csky/include/asm/cmpxchg.h:6,
                 from ./arch/csky/include/asm/atomic.h:8,
                 from ./include/linux/atomic.h:7,
                 from ./include/linux/rcupdate.h:38,
                 from ./include/linux/init_task.h:5,
                 from init/init_task.c:2:

The asm/bitops.h will lose asm/atomic.h for cycle include.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 arch/csky/include/asm/cmpxchg.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/csky/include/asm/cmpxchg.h b/arch/csky/include/asm/cmpxchg.h
index 9b63dd7..ad53006 100644
--- a/arch/csky/include/asm/cmpxchg.h
+++ b/arch/csky/include/asm/cmpxchg.h
@@ -2,9 +2,10 @@
 #define __ASM_CSKY_CMPXCHG_H
 
 #ifdef CONFIG_CPU_HAS_LDSTEX
-#include <linux/bug.h>
 #include <asm/barrier.h>
 
+extern void __bad_xchg(volatile void *ptr, int size);
+
 #define __xchg(new, ptr, size)					\
 ({								\
 	__typeof__(ptr) __ptr = (ptr);				\
@@ -25,7 +26,7 @@
 		smp_mb();					\
 		break;						\
 	default:						\
-		BUILD_BUG();					\
+		__bad_xchg(ptr, size), __ret = 0;		\
 	}							\
 	__ret;							\
 })
@@ -56,7 +57,7 @@
 		smp_mb();					\
 		break;						\
 	default:						\
-		BUILD_BUG();					\
+		__bad_xchg(ptr, size), __ret = 0;		\
 	}							\
 	__ret;							\
 })
-- 
2.7.4

