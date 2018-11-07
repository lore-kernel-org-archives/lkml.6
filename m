Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD18C46465
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0C372146E
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:02:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0C372146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731563AbeKHCdy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 21:33:54 -0500
Received: from mail.skyhub.de ([5.9.137.197]:46566 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728180AbeKHCdx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 21:33:53 -0500
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 0d0fTUa_rWSW; Wed,  7 Nov 2018 18:02:39 +0100 (CET)
Received: from zn.tnic (p200300EC2BCBE000329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bcb:e000:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 730761EC0ADD;
        Wed,  7 Nov 2018 18:02:39 +0100 (CET)
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 12/16] x86/microcode/AMD: Fix container size's type
Date:   Wed,  7 Nov 2018 18:02:14 +0100
Message-Id: <20181107170218.7596-13-bp@alien8.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181107170218.7596-1-bp@alien8.de>
References: <20181107170218.7596-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Make it size_t everywhere as this is what we get from cpio.

Based on a patch by Maciej S. Szmigiero <mail@maciej.szmigiero.name>.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/cpu/microcode/amd.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 5775dc996df3..1f9a4b41218e 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -186,8 +186,7 @@ __verify_patch_section(const u8 *buf, size_t buf_size, u32 *sh_psize, bool early
  * exceed the per-family maximum). @sh_psize is the size read from the section
  * header.
  */
-static unsigned int
-__verify_patch_size(u8 family, u32 sh_psize, unsigned int buf_size)
+static unsigned int __verify_patch_size(u8 family, u32 sh_psize, size_t buf_size)
 {
 	u32 max_size;
 
@@ -285,10 +284,10 @@ verify_patch(u8 family, const u8 *buf, size_t buf_size, u32 *patch_size, bool ea
  * Returns the amount of bytes consumed while scanning. @desc contains all the
  * data we're going to use in later stages of the application.
  */
-static ssize_t parse_container(u8 *ucode, ssize_t size, struct cont_desc *desc)
+static size_t parse_container(u8 *ucode, size_t size, struct cont_desc *desc)
 {
 	struct equiv_cpu_entry *eq;
-	ssize_t orig_size = size;
+	size_t orig_size = size;
 	u32 *hdr = (u32 *)ucode;
 	u16 eq_id;
 	u8 *buf;
@@ -366,15 +365,17 @@ static ssize_t parse_container(u8 *ucode, ssize_t size, struct cont_desc *desc)
  */
 static void scan_containers(u8 *ucode, size_t size, struct cont_desc *desc)
 {
-	ssize_t rem = size;
-
-	while (rem >= 0) {
-		ssize_t s = parse_container(ucode, rem, desc);
+	while (size >= 0) {
+		size_t s = parse_container(ucode, size, desc);
 		if (!s)
 			return;
 
-		ucode += s;
-		rem   -= s;
+		/* catch wraparound */
+		if (size >= s) {
+			ucode += s;
+			size  -= s;
+		} else
+			return;
 	}
 }
 
-- 
2.19.1

