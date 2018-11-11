Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD7BDC04EB9
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85D67224E0
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:31:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="D95Ftji7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85D67224E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389757AbeKLIVf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:21:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:49106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389723AbeKLIVe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:21:34 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E971208A3;
        Sun, 11 Nov 2018 22:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975497;
        bh=72Aa9dooQctvQ518Nre3xmsnUS0exeXxwjIVwfehJn4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D95Ftji7DpbQodDzRC+sicMEfl43y1JLxOq5zjPYI766op0wZYr2hauEooipsOxCE
         sk5YERZQypNmXCFcePwZT8D5+9kyRd2Fp+AJKljPz6bHwim7Bx1FOAe4P38a947c3j
         G80Q7rIz2td6dFbjQhc0jlxYLbKsMJ1jjbCHWCWA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Maciej W. Rozycki" <macro@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.18 275/350] MIPS: memset: Fix CPU_DADDI_WORKAROUNDS `small_fixup regression
Date:   Sun, 11 Nov 2018 14:22:19 -0800
Message-Id: <20181111221719.538633340@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maciej W. Rozycki <macro@linux-mips.org>

commit 2f7619ae90bf78cf576b5e72087aab0435266fdb upstream.

Fix a commit 8a8158c85e1e ("MIPS: memset.S: EVA & fault support for
small_memset") regression and remove assembly warnings:

arch/mips/lib/memset.S: Assembler messages:
arch/mips/lib/memset.S:243: Warning: Macro instruction expanded into multiple instructions in a branch delay slot

triggering with the CPU_DADDI_WORKAROUNDS option set and this code:

	PTR_SUBU	a2, t1, a0
	jr		ra
	 PTR_ADDIU	a2, 1

This is because with that option in place the DADDIU instruction, which
the PTR_ADDIU CPP macro expands to, becomes a GAS macro, which in turn
expands to an LI/DADDU (or actually ADDIU/DADDU) sequence:

 13c:	01a4302f 	dsubu	a2,t1,a0
 140:	03e00008 	jr	ra
 144:	24010001 	li	at,1
 148:	00c1302d 	daddu	a2,a2,at
	...

Correct this by switching off the `noreorder' assembly mode and letting
GAS schedule this jump's delay slot, as there is nothing special about
it that would require manual scheduling.  With this change in place
correct code is produced:

 13c:	01a4302f 	dsubu	a2,t1,a0
 140:	24010001 	li	at,1
 144:	03e00008 	jr	ra
 148:	00c1302d 	daddu	a2,a2,at
	...

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Fixes: 8a8158c85e1e ("MIPS: memset.S: EVA & fault support for small_memset")
Patchwork: https://patchwork.linux-mips.org/patch/20833/
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: stable@vger.kernel.org # 4.17+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/lib/memset.S |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/arch/mips/lib/memset.S
+++ b/arch/mips/lib/memset.S
@@ -262,9 +262,11 @@
 	 nop
 
 .Lsmall_fixup\@:
+	.set		reorder
 	PTR_SUBU	a2, t1, a0
+	PTR_ADDIU	a2, 1
 	jr		ra
-	 PTR_ADDIU	a2, 1
+	.set		noreorder
 
 	.endm
 


