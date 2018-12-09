Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2411CC65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6FCF20661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:04:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6FCF20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbeLIWEK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:04:10 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35788 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726637AbeLIVza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:55:30 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72t-0002ib-Fi; Sun, 09 Dec 2018 21:55:27 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72k-0003eZ-Jw; Sun, 09 Dec 2018 21:55:18 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Ralf Baechle" <ralf@linux-mips.org>,
        "Paul Burton" <paul.burton@mips.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.100726603@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 295/328] MIPS: memset: Fix CPU_DADDI_WORKAROUNDS
 `small_fixup' regression
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: "Maciej W. Rozycki" <macro@linux-mips.org>

commit 148b9aba99e0bbadf361747d21456e1589015f74 upstream.

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
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/lib/memset.S | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/arch/mips/lib/memset.S
+++ b/arch/mips/lib/memset.S
@@ -213,9 +213,11 @@
 	 nop
 
 .Lsmall_fixup\@:
+	.set		reorder
 	PTR_SUBU	a2, t1, a0
+	PTR_ADDIU	a2, 1
 	jr		ra
-	 PTR_ADDIU	a2, 1
+	.set		noreorder
 
 	.endm
 

