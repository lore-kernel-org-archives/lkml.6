Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE26C282DA
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 492182073D
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:30:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731066AbfBCOae (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:30:34 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:55326 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729708AbfBCOUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 09:20:14 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqId1-0006EN-23; Sun, 03 Feb 2019 14:20:11 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9m-0007J0-Iw; Sun, 03 Feb 2019 14:49:58 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Paul Mackerras" <paulus@ozlabs.org>,
        "Michael Ellerman" <mpe@ellerman.id.au>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.196244542@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 236/305] powerpc: Fix COFF zImage booting on old
 powermacs
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Mackerras <paulus@ozlabs.org>

commit 5564597d51c8ff5b88d95c76255e18b13b760879 upstream.

Commit 6975a783d7b4 ("powerpc/boot: Allow building the zImage wrapper
as a relocatable ET_DYN", 2011-04-12) changed the procedure descriptor
at the start of crt0.S to have a hard-coded start address of 0x500000
rather than a reference to _zimage_start, presumably because having
a reference to a symbol introduced a relocation which is awkward to
handle in a position-independent executable.  Unfortunately, what is
at 0x500000 in the COFF image is not the first instruction, but the
procedure descriptor itself, that is, a word containing 0x500000,
which is not a valid instruction.  Hence, booting a COFF zImage
results in a "DEFAULT CATCH!, code=FFF00700" message from Open
Firmware.

This fixes the problem by (a) putting the procedure descriptor in the
data section and (b) adding a branch to _zimage_start as the first
instruction in the program.

Fixes: 6975a783d7b4 ("powerpc/boot: Allow building the zImage wrapper as a relocatable ET_DYN")
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/powerpc/boot/crt0.S | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/arch/powerpc/boot/crt0.S
+++ b/arch/powerpc/boot/crt0.S
@@ -15,7 +15,7 @@
 RELA = 7
 RELACOUNT = 0x6ffffff9
 
-	.text
+	.data
 	/* A procedure descriptor used when booting this as a COFF file.
 	 * When making COFF, this comes first in the link and we're
 	 * linked at 0x500000.
@@ -23,6 +23,8 @@ RELACOUNT = 0x6ffffff9
 	.globl	_zimage_start_opd
 _zimage_start_opd:
 	.long	0x500000, 0, 0, 0
+	.text
+	b	_zimage_start
 
 #ifdef __powerpc64__
 .balign 8

