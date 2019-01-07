Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F699C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA4402089F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546865917;
	bh=N+ocYKPM1xZJeMxI8adCcaDiSjDb9ck+USRjOrYyXGQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oZr249tKKBszuNGcSZ61YIzqJTaFUUg+bgHnrXcggKJQiWVKvp/aDIu+NScYkjwqR
	 hx+37bCGQSEWjtPmiYJRUfBcnJbRebW0pZQkHZc30SuY3oPCT/sg06KHW7BIF7J3HB
	 rDNpaWWoU5vXduNRwvIMd47ntQD3iKa0da4+Ka7I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730009AbfAGM6g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:58:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:46140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730001AbfAGM6d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:58:33 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38A0221736;
        Mon,  7 Jan 2019 12:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865912;
        bh=N+ocYKPM1xZJeMxI8adCcaDiSjDb9ck+USRjOrYyXGQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dXDt1erCSc9AVZtyyL6/E5ERsK/CYBZBoKwRCv/puERg7++yrYfXWPzLZGeGl9vcL
         sUnMF8BA6T37edE1u7slCufFQWR/t0sJYu7qUWqyroKHKOigS3unrApXYS81TTpSsz
         s9Ula+Y/TtCI50yH3LERpnT2p7JOUHAmSzXyPSN4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Huacai Chen <chenhc@lemote.com>,
        Paul Burton <paul.burton@mips.com>,
        Joshua Kinard <kumba@gentoo.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>, linux-mips@linux-mips.org
Subject: [PATCH 4.19 156/170] MIPS: Fix a R10000_LLSC_WAR logic in atomic.h
Date:   Mon,  7 Jan 2019 13:33:03 +0100
Message-Id: <20190107104511.357293208@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104452.953560660@linuxfoundation.org>
References: <20190107104452.953560660@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Huacai Chen <chenhc@lemote.com>

commit db1ce3f5d01d2d6d5714aefba0159d2cb5167a0b upstream.

Commit 4936084c2ee2 ("MIPS: Cleanup R10000_LLSC_WAR logic in atomic.h")
introduce a mistake in atomic64_fetch_##op##_relaxed(), because it
forget to delete R10000_LLSC_WAR in the if-condition. So fix it.

Fixes: 4936084c2ee2 ("MIPS: Cleanup R10000_LLSC_WAR logic in atomic.h")
Signed-off-by: Huacai Chen <chenhc@lemote.com>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: Joshua Kinard <kumba@gentoo.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Steven J . Hill <Steven.Hill@cavium.com>
Cc: Fuxin Zhang <zhangfx@lemote.com>
Cc: Zhangjin Wu <wuzhangjin@gmail.com>
Cc: linux-mips@linux-mips.org
Cc: stable@vger.kernel.org # 4.19+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/include/asm/atomic.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mips/include/asm/atomic.h
+++ b/arch/mips/include/asm/atomic.h
@@ -306,7 +306,7 @@ static __inline__ long atomic64_fetch_##
 {									      \
 	long result;							      \
 									      \
-	if (kernel_uses_llsc && R10000_LLSC_WAR) {			      \
+	if (kernel_uses_llsc) {						      \
 		long temp;						      \
 									      \
 		__asm__ __volatile__(					      \


