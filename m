Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02FEBC46464
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C829120827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:02:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C829120827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731444AbeKHCdq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 21:33:46 -0500
Received: from mail.skyhub.de ([5.9.137.197]:46482 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731424AbeKHCdq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 21:33:46 -0500
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id OMq67RONmXyi; Wed,  7 Nov 2018 18:02:32 +0100 (CET)
Received: from zn.tnic (p200300EC2BCBE000329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bcb:e000:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 687FF1EC0291;
        Wed,  7 Nov 2018 18:02:32 +0100 (CET)
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 04/16] x86/microcode/AMD: Clean up per-family patch size checks
Date:   Wed,  7 Nov 2018 18:02:06 +0100
Message-Id: <20181107170218.7596-5-bp@alien8.de>
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

Starting with family 0x15, the patch size verification is not needed
anymore. Thus get rid of the need to update this checking function with
each new family.

Keep the check for older families.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/kernel/cpu/microcode/amd.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index f8d60cb9bb9a..bf682deb84e8 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -183,27 +183,22 @@ static unsigned int verify_patch_size(u8 family, u32 patch_size, unsigned int si
 {
 	u32 max_size;
 
+	if (family >= 0x15)
+		return min_t(u32, patch_size, size);
+
 #define F1XH_MPB_MAX_SIZE 2048
 #define F14H_MPB_MAX_SIZE 1824
-#define F15H_MPB_MAX_SIZE 4096
-#define F16H_MPB_MAX_SIZE 3458
-#define F17H_MPB_MAX_SIZE 3200
 
 	switch (family) {
+	case 0x10 ... 0x12:
+		max_size = F1XH_MPB_MAX_SIZE;
+		break;
 	case 0x14:
 		max_size = F14H_MPB_MAX_SIZE;
 		break;
-	case 0x15:
-		max_size = F15H_MPB_MAX_SIZE;
-		break;
-	case 0x16:
-		max_size = F16H_MPB_MAX_SIZE;
-		break;
-	case 0x17:
-		max_size = F17H_MPB_MAX_SIZE;
-		break;
 	default:
-		max_size = F1XH_MPB_MAX_SIZE;
+		WARN(1, "%s: WTF family: 0x%x\n", __func__, family);
+		return 0;
 		break;
 	}
 
-- 
2.19.1

