Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD9DC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C2D3217D4
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546867139;
	bh=jFQiGcCGDOadwRFZ4F7XQORC52ORkwbUK0FmfVUNX18=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=M63/0OQMVeHl26IQzfaGML6JARjp2XI91VBFOuULQe/aagKk//C268PQpu6DRMqeS
	 JMg+zARcCfIjgKbi3MdwkphlnCTeoCwXOo0rMFASivgley5JeirRQaqZ3VscNabsEF
	 70TdwgKefH++x01DzeTazOkqHKAu5DhqiFt2IsoM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730628AbfAGNS7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:18:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:45944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729970AbfAGM6V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:58:21 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90C0321736;
        Mon,  7 Jan 2019 12:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865901;
        bh=jFQiGcCGDOadwRFZ4F7XQORC52ORkwbUK0FmfVUNX18=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2v0gCVlBs6/iihkCKd78Ku9TiT9r8jVc3Mqv1r2OfqKeIkOlexQbFp2mTLPW+SD1R
         eMCWQkfh29ifZFYKloR4stoHuRErInySlv+PDCmJNzlE1a4Voy7OjPlF9fdaenUmTP
         LHvD1Po+Ltn515c1Ta45MA2Aa8zjBqJMreuSUTdk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Hogan <jhogan@kernel.org>,
        Huacai Chen <chenhc@lemote.com>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@mips.com>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
Subject: [PATCH 4.19 152/170] MIPS: Ensure pmd_present() returns false after pmd_mknotpresent()
Date:   Mon,  7 Jan 2019 13:32:59 +0100
Message-Id: <20190107104510.918454815@linuxfoundation.org>
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

commit 92aa0718c9fa5160ad2f0e7b5bffb52f1ea1e51a upstream.

This patch is borrowed from ARM64 to ensure pmd_present() returns false
after pmd_mknotpresent(). This is needed for THP.

References: 5bb1cc0ff9a6 ("arm64: Ensure pmd_present() returns false after pmd_mknotpresent()")
Reviewed-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Huacai Chen <chenhc@lemote.com>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Patchwork: https://patchwork.linux-mips.org/patch/21135/
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: James Hogan <james.hogan@mips.com>
Cc: Steven J . Hill <Steven.Hill@cavium.com>
Cc: linux-mips@linux-mips.org
Cc: Fuxin Zhang <zhangfx@lemote.com>
Cc: Zhangjin Wu <wuzhangjin@gmail.com>
Cc: <stable@vger.kernel.org> # 3.8+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/include/asm/pgtable-64.h |    5 +++++
 1 file changed, 5 insertions(+)

--- a/arch/mips/include/asm/pgtable-64.h
+++ b/arch/mips/include/asm/pgtable-64.h
@@ -265,6 +265,11 @@ static inline int pmd_bad(pmd_t pmd)
 
 static inline int pmd_present(pmd_t pmd)
 {
+#ifdef CONFIG_MIPS_HUGE_TLB_SUPPORT
+	if (unlikely(pmd_val(pmd) & _PAGE_HUGE))
+		return pmd_val(pmd) & _PAGE_PRESENT;
+#endif
+
 	return pmd_val(pmd) != (unsigned long) invalid_pte_table;
 }
 


