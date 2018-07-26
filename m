Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68721C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 11:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15E8120685
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 11:08:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Z5/QwCe2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15E8120685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729354AbeGZMZI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 08:25:08 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:53537 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729074AbeGZMZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 08:25:07 -0400
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 9570F10C0F95;
        Thu, 26 Jul 2018 04:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1532603327; bh=ZWG07Ezt5C69b52/CtcMWRzjtnzxyoJmNpqveGyasIg=;
        h=From:To:Cc:Subject:Date:From;
        b=Z5/QwCe21g7tfuJlRRFJ3V4sUenYYXqWKGnUFVEjZIfjcWlfIUpAUxGL3/bpSalaf
         N/ZGa9XKaNxHr0mlAa6svxBMiloD0UwT9YwOcRe5szR92FXKI2p1ZJauSwRMzn+kWM
         qQ+axv/eaQCye8P2eHDFfnhrgBMUAl11IuvhKJaCNtw3tN88+1QnjrlI9aN22KPkyw
         zLLF1TNflsmyBfJ2yuFN7CRn8ZkcDm7xMUG7qtJEfi0XDxKYikE9dPAIJjPQcQre1U
         Ub25ICvDKn8d0WIZxM381eKi6Dp/YitC4+R96U5GazSZwbM0kKkvDho4KhWQWsndqO
         sy0+T1L60n9kQ==
Received: from paltsev-e7480.internal.synopsys.com (paltsev-e7480.internal.synopsys.com [10.121.8.86])
        by mailhost.synopsys.com (Postfix) with ESMTP id 0C9715249;
        Thu, 26 Jul 2018 04:08:45 -0700 (PDT)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH 1/2] ARC: setup SMP_CACHE_BYTES and cache_line_size
Date:   Thu, 26 Jul 2018 14:08:38 +0300
Message-Id: <20180726110839.1915-1-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As for today we don't setup SMP_CACHE_BYTESi and cache_line_size for
ARC, so they are set to L1_CACHE_BYTES by default. L1 line length
(L1_CACHE_BYTES) might be easily smaller than L2 line (which is
usually the case BTW). This breaks code.

For example this breaks ethernet infrastructure on HSDK/AXS103 boards
with IOC disabled:
Functions which alloc and manage sk_buff packet data area rely on
SMP_CACHE_BYTES define. In the result we can share last L2 cache
line in sk_buff linear packet data area between DMA buffer and
some useful data in other structure. So we can lose this data when
we invalidate DMA buffer.

   sk_buff linear packet data area
                |
                |
                |         skb->end        skb->tail
                V            |                |
                             V                V
----------------------------------------------.
      packet data            | <tail padding> |  <useful data in other struct>
----------------------------------------------.

---------------------.--------------------------------------------------.
     SLC line        |             SLC (L2 cache) line (128B)           |
---------------------.--------------------------------------------------.
        ^                                     ^
        |                                     |
     These cache lines will be invalidated when we invalidate skb
     linear packet data area before DMA transaction starting.

This leads to issues painful to debug as it reproduces only if
(sk_buff->end - sk_buff->tail) < SLC_LINE_SIZE and
if we have some useful data right after sk_buff->end.

Fix that by hardcode SMP_CACHE_BYTES to max line length we may have.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 arch/arc/Kconfig             | 1 +
 arch/arc/include/asm/cache.h | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index 9cf59fc60eab..ee1a38c99197 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -9,6 +9,7 @@
 config ARC
 	def_bool y
 	select ARC_TIMERS
+	select ARCH_HAS_CACHE_LINE_SIZE
 	select ARCH_HAS_SYNC_DMA_FOR_CPU
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
 	select ARCH_HAS_SG_CHAIN
diff --git a/arch/arc/include/asm/cache.h b/arch/arc/include/asm/cache.h
index 8486f328cc5d..ff7d3232764a 100644
--- a/arch/arc/include/asm/cache.h
+++ b/arch/arc/include/asm/cache.h
@@ -48,7 +48,9 @@
 })
 
 /* Largest line length for either L1 or L2 is 128 bytes */
-#define ARCH_DMA_MINALIGN      128
+#define SMP_CACHE_BYTES		128
+#define cache_line_size()	SMP_CACHE_BYTES
+#define ARCH_DMA_MINALIGN	SMP_CACHE_BYTES
 
 extern void arc_cache_init(void);
 extern char *arc_cache_mumbojumbo(int cpu_id, char *buf, int len);
-- 
2.14.4

