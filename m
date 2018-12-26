Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78459C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F10D21741
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545865024;
	bh=3Czy2PjlnymjrRkOxlN2tJetQsILPFtz8qPZkKjnUH8=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=bWyToNpX0vdalmdVRKTsZzLu71w9okHEUpkBQtQapcKJfq6IFq9W6StMBAhIj3DQX
	 Q73HcP0mA72W0Mi6huSjVcpubEkFRr6cY8avGsgSWFYTAIQ81CAJDY//UZ6bloPIke
	 X819Tmix6V3rpByc0853U0/K2XGevOdhnOflnnYg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730360AbeLZW5D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 17:57:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:57852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728997AbeLZW47 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:56:59 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F33A218A5;
        Wed, 26 Dec 2018 22:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545865019;
        bh=3Czy2PjlnymjrRkOxlN2tJetQsILPFtz8qPZkKjnUH8=;
        h=From:To:Cc:Subject:Date:From;
        b=Va6LhacFOtuWsD7UMYzcymsdA61W5Hf2uAEdRXYTlC+nBiWlllMfh9VqcKcYSjSJh
         AbU5dNLNYMrFsCIlC5jfCxPqlLUSyMDjyvrTtwjaQ2p/wj7kBqd6mg/MJ0AHv6QZZZ
         Ini4aaBYYXJQBTxD8QDZLYkMBJxGJ3uj4g2Tfqek=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Paul Mackerras <paulus@ozlabs.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 4.4 01/21] powerpc: Fix COFF zImage booting on old powermacs
Date:   Wed, 26 Dec 2018 17:54:39 -0500
Message-Id: <20181226225501.151365-1-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Mackerras <paulus@ozlabs.org>

[ Upstream commit 5564597d51c8ff5b88d95c76255e18b13b760879 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/boot/crt0.S | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/boot/crt0.S b/arch/powerpc/boot/crt0.S
index 5c2199857aa8..a3550e8f1a77 100644
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
-- 
2.19.1

