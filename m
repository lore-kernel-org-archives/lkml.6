Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56CADC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20BDA20818
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:30:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20BDA20818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730475AbeKLFsW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:48:22 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:50366 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730404AbeKLFsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:19 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsf-0000l9-Em; Sun, 11 Nov 2018 19:58:49 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsa-0001sT-EU; Sun, 11 Nov 2018 19:58:44 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Ralf Baechle" <ralf@linux-mips.org>,
        "Markos Chandras" <markos.chandras@imgtec.com>,
        "Paul Burton" <paul.burton@imgtec.com>, linux-mips@linux-mips.org,
        "James Hogan" <james.hogan@imgtec.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.811545133@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 348/366] MIPS: asmmacro: Ensure 64-bit FP registers
 are used with MSA
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

From: Markos Chandras <markos.chandras@imgtec.com>

commit 2bd7bc254ab1f45269db6dd7957d63b713817408 upstream.

This silences warnings like the following one when building with the
latest binutils:

arch/mips/kernel/genex.S: Assembler messages:
arch/mips/kernel/genex.S:438: Warning: the `msa' extension requires 64-bit FPRs

[ralf@linux-mips.org: Markos says binutils 2.25 and some 2.24 snapshots
are affected.]

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
Reviewed-by: James Hogan <james.hogan@imgtec.com>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/9745/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/include/asm/asmmacro.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/arch/mips/include/asm/asmmacro.h
+++ b/arch/mips/include/asm/asmmacro.h
@@ -209,9 +209,13 @@
 	.endm
 
 #ifdef TOOLCHAIN_SUPPORTS_MSA
+/* preprocessor replaces the fp in ".set fp=64" with $30 otherwise */
+#undef fp
+
 	.macro	_cfcmsa	rd, cs
 	.set	push
 	.set	mips32r2
+	.set	fp=64
 	.set	msa
 	cfcmsa	\rd, $\cs
 	.set	pop
@@ -220,6 +224,7 @@
 	.macro	_ctcmsa	cd, rs
 	.set	push
 	.set	mips32r2
+	.set	fp=64
 	.set	msa
 	ctcmsa	$\cd, \rs
 	.set	pop
@@ -228,6 +233,7 @@
 	.macro	ld_d	wd, off, base
 	.set	push
 	.set	mips32r2
+	.set	fp=64
 	.set	msa
 	ld.d	$w\wd, \off(\base)
 	.set	pop
@@ -236,6 +242,7 @@
 	.macro	st_d	wd, off, base
 	.set	push
 	.set	mips32r2
+	.set	fp=64
 	.set	msa
 	st.d	$w\wd, \off(\base)
 	.set	pop
@@ -244,6 +251,7 @@
 	.macro	copy_u_w	ws, n
 	.set	push
 	.set	mips32r2
+	.set	fp=64
 	.set	msa
 	copy_u.w $1, $w\ws[\n]
 	.set	pop
@@ -252,6 +260,7 @@
 	.macro	copy_u_d	ws, n
 	.set	push
 	.set	mips64r2
+	.set	fp=64
 	.set	msa
 	copy_u.d $1, $w\ws[\n]
 	.set	pop
@@ -260,6 +269,7 @@
 	.macro	insert_w	wd, n
 	.set	push
 	.set	mips32r2
+	.set	fp=64
 	.set	msa
 	insert.w $w\wd[\n], $1
 	.set	pop
@@ -268,6 +278,7 @@
 	.macro	insert_d	wd, n
 	.set	push
 	.set	mips64r2
+	.set	fp=64
 	.set	msa
 	insert.d $w\wd[\n], $1
 	.set	pop

