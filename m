Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 783A6C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 10:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 432EC206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 10:17:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 432EC206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbeKSUkO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 15:40:14 -0500
Received: from terminus.zytor.com ([198.137.202.136]:60595 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728012AbeKSUkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 15:40:13 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wAJAGuOr2524264
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 19 Nov 2018 02:16:56 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wAJAGulg2524261;
        Mon, 19 Nov 2018 02:16:56 -0800
Date:   Mon, 19 Nov 2018 02:16:56 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Borislav Petkov <tipbot@zytor.com>
Message-ID: <tip-51776fb805fe4f248f264c1783c286ae60552e9a@git.kernel.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, bp@suse.de,
        hpa@zytor.com, mingo@kernel.org
Reply-To: bp@suse.de, hpa@zytor.com, mingo@kernel.org, tglx@linutronix.de,
          linux-kernel@vger.kernel.org
In-Reply-To: <20181107170218.7596-9-bp@alien8.de>
References: <20181107170218.7596-9-bp@alien8.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/microcode] x86/microcode/AMD: Move patch family check to
 verify_patch()
Git-Commit-ID: 51776fb805fe4f248f264c1783c286ae60552e9a
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

Commit-ID:  51776fb805fe4f248f264c1783c286ae60552e9a
Gitweb:     https://git.kernel.org/tip/51776fb805fe4f248f264c1783c286ae60552e9a
Author:     Borislav Petkov <bp@suse.de>
AuthorDate: Thu, 26 Jul 2018 06:50:44 +0200
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Mon, 19 Nov 2018 10:51:05 +0100

x86/microcode/AMD: Move patch family check to verify_patch()

... where all the microcode patch verification is being concentrated.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: x86@kernel.org
Link: https://lkml.kernel.org/r/20181107170218.7596-9-bp@alien8.de
---
 arch/x86/kernel/cpu/microcode/amd.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index b4450374f4b1..be46e1fda77f 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -221,7 +221,10 @@ __verify_patch_size(u8 family, u32 sh_psize, unsigned int buf_size)
 static unsigned int
 verify_patch(u8 family, const u8 *buf, unsigned int buf_size, bool early)
 {
+	struct microcode_header_amd *mc_hdr;
 	u32 sh_psize;
+	u16 proc_id;
+	u8 patch_fam;
 
 	if (!__verify_patch_section(buf, buf_size, &sh_psize, early))
 		return 0;
@@ -243,6 +246,13 @@ verify_patch(u8 family, const u8 *buf, unsigned int buf_size, bool early)
 		return 0;
 	}
 
+	mc_hdr	= (struct microcode_header_amd *)(buf + SECTION_HDR_SIZE);
+	proc_id	= mc_hdr->processor_rev_id;
+
+	patch_fam = 0xf + (proc_id >> 12);
+	if (patch_fam != family)
+		return 0;
+
 	return __verify_patch_size(family, sh_psize, buf_size);
 }
 
@@ -718,7 +728,6 @@ static int verify_and_add_patch(u8 family, u8 *fw, unsigned int leftover)
 	struct microcode_header_amd *mc_hdr;
 	unsigned int patch_size, crnt_size;
 	struct ucode_patch *patch;
-	u8 patch_fam;
 	u16 proc_id;
 
 	patch_size = verify_patch(family, fw, leftover, false);
@@ -732,10 +741,6 @@ static int verify_and_add_patch(u8 family, u8 *fw, unsigned int leftover)
 	mc_hdr	    = (struct microcode_header_amd *)(fw + SECTION_HDR_SIZE);
 	proc_id	    = mc_hdr->processor_rev_id;
 
-	patch_fam = 0xf + (proc_id >> 12);
-	if (patch_fam != family)
-		return crnt_size;
-
 	if (mc_hdr->nb_dev_id || mc_hdr->sb_dev_id) {
 		pr_err("Patch-ID 0x%08x: chipset-specific code unsupported.\n",
 			mc_hdr->patch_id);
