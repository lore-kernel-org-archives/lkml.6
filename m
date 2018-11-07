Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83253C46464
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45AD02146D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:02:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45AD02146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731580AbeKHCdz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 21:33:55 -0500
Received: from mail.skyhub.de ([5.9.137.197]:46638 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728180AbeKHCdz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 21:33:55 -0500
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id F-F_6045cQq9; Wed,  7 Nov 2018 18:02:40 +0100 (CET)
Received: from zn.tnic (p200300EC2BCBE000329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bcb:e000:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6BC981EC0AC9;
        Wed,  7 Nov 2018 18:02:40 +0100 (CET)
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 13/16] x86/microcode/AMD: Check microcode container data in the late loader
Date:   Wed,  7 Nov 2018 18:02:15 +0100
Message-Id: <20181107170218.7596-14-bp@alien8.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181107170218.7596-1-bp@alien8.de>
References: <20181107170218.7596-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>

Convert the late loading path to use the newly introduced microcode
container data checking functions as it was previously done for the
early loader.

Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
[ Keep header length addition in install_equiv_cpu_table() and rediff. ]
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/cpu/microcode/amd.c | 38 +++++++++++++----------------
 1 file changed, 17 insertions(+), 21 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 1f9a4b41218e..5d822ed295b5 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -705,28 +705,27 @@ static enum ucode_state apply_microcode_amd(int cpu)
 	return ret;
 }
 
-static int install_equiv_cpu_table(const u8 *buf)
+static size_t install_equiv_cpu_table(const u8 *buf, size_t buf_size)
 {
-	unsigned int *ibuf = (unsigned int *)buf;
-	unsigned int type = ibuf[1];
-	unsigned int size = ibuf[2];
+	u32 equiv_tbl_len;
+	const u32 *hdr;
 
-	if (type != UCODE_EQUIV_CPU_TABLE_TYPE || !size) {
-		pr_err("empty section/"
-		       "invalid type field in container file section header\n");
-		return -EINVAL;
-	}
+	if (!verify_equivalence_table(buf, buf_size, false))
+		return 0;
 
-	equiv_cpu_table = vmalloc(size);
+	hdr = (const u32 *)buf;
+	equiv_tbl_len = hdr[2];
+
+	equiv_cpu_table = vmalloc(equiv_tbl_len);
 	if (!equiv_cpu_table) {
 		pr_err("failed to allocate equivalent CPU table\n");
-		return -ENOMEM;
+		return 0;
 	}
 
-	memcpy(equiv_cpu_table, buf + CONTAINER_HDR_SZ, size);
+	memcpy(equiv_cpu_table, buf + CONTAINER_HDR_SZ, equiv_tbl_len);
 
 	/* add header length */
-	return size + CONTAINER_HDR_SZ;
+	return equiv_tbl_len + CONTAINER_HDR_SZ;
 }
 
 static void free_equiv_cpu_table(void)
@@ -793,13 +792,12 @@ static enum ucode_state __load_microcode_amd(u8 family, const u8 *data,
 					     size_t size)
 {
 	u8 *fw = (u8 *)data;
-	int offset;
+	size_t offset;
 
-	offset = install_equiv_cpu_table(data);
-	if (offset < 0) {
-		pr_err("failed to create equivalent cpu table\n");
+	offset = install_equiv_cpu_table(data, size);
+	if (!offset)
 		return UCODE_ERROR;
-	}
+
 	fw   += offset;
 	size -= offset;
 
@@ -897,10 +895,8 @@ static enum ucode_state request_microcode_amd(int cpu, struct device *device,
 	}
 
 	ret = UCODE_ERROR;
-	if (*(u32 *)fw->data != UCODE_MAGIC) {
-		pr_err("invalid magic value (0x%08x)\n", *(u32 *)fw->data);
+	if (!verify_container(fw->data, fw->size, false))
 		goto fw_release;
-	}
 
 	ret = load_microcode_amd(bsp, c->x86, fw->data, fw->size);
 
-- 
2.19.1

