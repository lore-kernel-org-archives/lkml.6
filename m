Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CAC8C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD30C20869
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:39:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD30C20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730266AbeKLG2o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:28:44 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:49564 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729995AbeKLFsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:08 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsT-0000oM-Bg; Sun, 11 Nov 2018 19:58:37 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsS-0001ZZ-RV; Sun, 11 Nov 2018 19:58:36 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "James Hogan" <james.hogan@mips.com>,
        "Fuxin Zhang" <zhangfx@lemote.com>,
        "Huacai Chen" <chenhuacai@gmail.com>,
        "Huacai Chen" <chenhc@lemote.com>, linux-mips@linux-mips.org,
        "Paul Burton" <paul.burton@mips.com>,
        "Zhangjin Wu" <wuzhangjin@gmail.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.791104820@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 156/366] MIPS: io: Add barrier after register read in
 inX()
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

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

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Patchwork: https://patchwork.linux-mips.org/patch/19516/
Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: James Hogan <james.hogan@mips.com>
Cc: linux-mips@linux-mips.org
Cc: Fuxin Zhang <zhangfx@lemote.com>
Cc: Zhangjin Wu <wuzhangjin@gmail.com>
Cc: Huacai Chen <chenhuacai@gmail.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/include/asm/io.h | 2 ++
 1 file changed, 2 insertions(+)

--- a/arch/mips/include/asm/io.h
+++ b/arch/mips/include/asm/io.h
@@ -410,6 +410,8 @@ static inline type pfx##in##bwlq##p(unsi
 	__val = *__addr;						\
 	slow;								\
 									\
+	/* prevent prefetching of coherent DMA data prematurely */	\
+	rmb();								\
 	return pfx##ioswab##bwlq(__addr, __val);			\
 }
 

