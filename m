Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F061BC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5F0E2086C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:23:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5F0E2086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729157AbeICVoy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:44:54 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45416 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728282AbeICVox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:44:53 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1F910D0A;
        Mon,  3 Sep 2018 17:23:46 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 060/165] ARC: dma [non-IOC] setup SMP_CACHE_BYTES and cache_line_size
Date:   Mon,  3 Sep 2018 18:55:46 +0200
Message-Id: <20180903165658.137971239@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903165655.003605184@linuxfoundation.org>
References: <20180903165655.003605184@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>

[ Upstream commit eb2777397fd83a4a7eaa26984d09d3babb845d2a ]

As for today we don't setup SMP_CACHE_BYTES and cache_line_size for
ARC, so they are set to L1_CACHE_BYTES by default. L1 line length
(L1_CACHE_BYTES) might be easily smaller than L2 line (which is
usually the case BTW). This breaks code.

For example this breaks ethernet infrastructure on HSDK/AXS103 boards
with IOC disabled, involving manual cache flushes
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
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>

Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arc/Kconfig             |    3 +++
 arch/arc/include/asm/cache.h |    4 +++-
 2 files changed, 6 insertions(+), 1 deletion(-)

--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -45,6 +45,9 @@ config ARC
 	select HAVE_KERNEL_GZIP
 	select HAVE_KERNEL_LZMA
 
+config ARCH_HAS_CACHE_LINE_SIZE
+	def_bool y
+
 config MIGHT_HAVE_PCI
 	bool
 
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


