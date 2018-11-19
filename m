Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D9DBC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 10:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49AA9206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 10:14:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49AA9206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727767AbeKSUh5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 15:37:57 -0500
Received: from terminus.zytor.com ([198.137.202.136]:54005 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbeKSUh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 15:37:57 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wAJAEcBq2523806
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 19 Nov 2018 02:14:38 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wAJAEcwS2523803;
        Mon, 19 Nov 2018 02:14:38 -0800
Date:   Mon, 19 Nov 2018 02:14:38 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Borislav Petkov <tipbot@zytor.com>
Message-ID: <tip-cfffbfeb424bc274aba3b5ed4afd5891662481a8@git.kernel.org>
Cc:     hpa@zytor.com, bp@suse.de, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, thomas.lendacky@amd.com, mingo@kernel.org
Reply-To: mingo@kernel.org, tglx@linutronix.de, thomas.lendacky@amd.com,
          linux-kernel@vger.kernel.org, bp@suse.de, hpa@zytor.com
In-Reply-To: <20181107170218.7596-5-bp@alien8.de>
References: <20181107170218.7596-5-bp@alien8.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/microcode] x86/microcode/AMD: Clean up per-family patch
 size checks
Git-Commit-ID: cfffbfeb424bc274aba3b5ed4afd5891662481a8
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  cfffbfeb424bc274aba3b5ed4afd5891662481a8
Gitweb:     https://git.kernel.org/tip/cfffbfeb424bc274aba3b5ed4afd5891662481a8
Author:     Borislav Petkov <bp@suse.de>
AuthorDate: Sat, 28 Jul 2018 19:04:02 +0200
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Mon, 19 Nov 2018 10:51:00 +0100

x86/microcode/AMD: Clean up per-family patch size checks

Starting with family 0x15, the patch size verification is not needed
anymore. Thus get rid of the need to update this checking function with
each new family.

Keep the check for older families.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: x86@kernel.org
Link: https://lkml.kernel.org/r/20181107170218.7596-5-bp@alien8.de
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
 
