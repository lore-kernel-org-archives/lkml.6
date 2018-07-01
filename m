Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84137C6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A7A4250CE
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:17:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A7A4250CE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964828AbeGAQRi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 12:17:38 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:32826 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932954AbeGAQRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:17:34 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 8121593C;
        Sun,  1 Jul 2018 16:17:33 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Huacai Chen <chenhc@lemote.com>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <james.hogan@mips.com>, linux-mips@linux-mips.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhuacai@gmail.com>
Subject: [PATCH 4.4 059/105] MIPS: io: Add barrier after register read in inX()
Date:   Sun,  1 Jul 2018 18:02:09 +0200
Message-Id: <20180701153153.787462042@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701153149.382300170@linuxfoundation.org>
References: <20180701153149.382300170@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Huacai Chen <chenhc@lemote.com>

commit 18f3e95b90b28318ef35910d21c39908de672331 upstream.

While a barrier is present in the outX() functions before the register
write, a similar barrier is missing in the inX() functions after the
register read. This could allow memory accesses following inX() to
observe stale data.

This patch is very similar to commit a1cc7034e33d12dc1 ("MIPS: io: Add
barrier after register read in readX()"). Because war_io_reorder_wmb()
is both used by writeX() and outX(), if readX() need a barrier then so
does inX().

Cc: stable@vger.kernel.org
Signed-off-by: Huacai Chen <chenhc@lemote.com>
Patchwork: https://patchwork.linux-mips.org/patch/19516/
Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: James Hogan <james.hogan@mips.com>
Cc: linux-mips@linux-mips.org
Cc: Fuxin Zhang <zhangfx@lemote.com>
Cc: Zhangjin Wu <wuzhangjin@gmail.com>
Cc: Huacai Chen <chenhuacai@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/include/asm/io.h |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/mips/include/asm/io.h
+++ b/arch/mips/include/asm/io.h
@@ -411,6 +411,8 @@ static inline type pfx##in##bwlq##p(unsi
 	__val = *__addr;						\
 	slow;								\
 									\
+	/* prevent prefetching of coherent DMA data prematurely */	\
+	rmb();								\
 	return pfx##ioswab##bwlq(__addr, __val);			\
 }
 


