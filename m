Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7028BC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 10:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39C8820851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 10:18:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39C8820851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbeKSUmB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 15:42:01 -0500
Received: from terminus.zytor.com ([198.137.202.136]:42321 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727718AbeKSUmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 15:42:01 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wAJAIgG52524695
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 19 Nov 2018 02:18:42 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wAJAIfVC2524692;
        Mon, 19 Nov 2018 02:18:41 -0800
Date:   Mon, 19 Nov 2018 02:18:41 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Borislav Petkov <tipbot@zytor.com>
Message-ID: <tip-c45e80358cb3c61eaf6f5d35af86c6a874935bd0@git.kernel.org>
Cc:     hpa@zytor.com, mail@maciej.szmigiero.name, mingo@kernel.org,
        bp@suse.de, tglx@linutronix.de, linux-kernel@vger.kernel.org
Reply-To: tglx@linutronix.de, linux-kernel@vger.kernel.org, hpa@zytor.com,
          mail@maciej.szmigiero.name, mingo@kernel.org, bp@suse.de
In-Reply-To: <20181107170218.7596-12-bp@alien8.de>
References: <20181107170218.7596-12-bp@alien8.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/microcode] x86/microcode/AMD: Convert early parser to the
 new verification routines
Git-Commit-ID: c45e80358cb3c61eaf6f5d35af86c6a874935bd0
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

Commit-ID:  c45e80358cb3c61eaf6f5d35af86c6a874935bd0
Gitweb:     https://git.kernel.org/tip/c45e80358cb3c61eaf6f5d35af86c6a874935bd0
Author:     Borislav Petkov <bp@suse.de>
AuthorDate: Wed, 12 Sep 2018 18:33:34 +0200
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Mon, 19 Nov 2018 10:51:06 +0100

x86/microcode/AMD: Convert early parser to the new verification routines

Now that they have the required functionality, use them to verify the
equivalence table and each patch, thus making parse_container() more
readable.

Originally-by: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: x86@kernel.org
Link: https://lkml.kernel.org/r/20181107170218.7596-12-bp@alien8.de
---
 arch/x86/kernel/cpu/microcode/amd.c | 46 +++++++++++++++++++------------------
 1 file changed, 24 insertions(+), 22 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 79216cfb9f72..5775dc996df3 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -293,17 +293,18 @@ static ssize_t parse_container(u8 *ucode, ssize_t size, struct cont_desc *desc)
 	u16 eq_id;
 	u8 *buf;
 
-	/* Am I looking at an equivalence table header? */
-	if (hdr[0] != UCODE_MAGIC ||
-	    hdr[1] != UCODE_EQUIV_CPU_TABLE_TYPE ||
-	    hdr[2] == 0)
-		return CONTAINER_HDR_SZ;
+	if (!verify_equivalence_table(ucode, size, true))
+		return 0;
 
 	buf = ucode;
 
 	eq = (struct equiv_cpu_entry *)(buf + CONTAINER_HDR_SZ);
 
-	/* Find the equivalence ID of our CPU in this table: */
+	/*
+	 * Find the equivalence ID of our CPU in this table. Even if this table
+	 * doesn't contain a patch for the CPU, scan through the whole container
+	 * so that it can be skipped in case there are other containers appended.
+	 */
 	eq_id = find_equiv_id(eq, desc->cpuid_1_eax);
 
 	buf  += hdr[2] + CONTAINER_HDR_SZ;
@@ -316,29 +317,29 @@ static ssize_t parse_container(u8 *ucode, ssize_t size, struct cont_desc *desc)
 	while (size > 0) {
 		struct microcode_amd *mc;
 		u32 patch_size;
+		int ret;
 
-		hdr = (u32 *)buf;
-
-		if (hdr[0] != UCODE_UCODE_TYPE)
-			break;
-
-		/* Sanity-check patch size. */
-		patch_size = hdr[1];
-		if (patch_size > PATCH_MAX_SIZE)
-			break;
-
-		/* Skip patch section header: */
-		buf  += SECTION_HDR_SIZE;
-		size -= SECTION_HDR_SIZE;
+		ret = verify_patch(x86_family(desc->cpuid_1_eax), buf, size, &patch_size, true);
+		if (ret < 0) {
+			/*
+			 * Patch verification failed, skip to the next
+			 * container, if there's one:
+			 */
+			goto out;
+		} else if (ret > 0) {
+			goto skip;
+		}
 
-		mc = (struct microcode_amd *)buf;
+		mc = (struct microcode_amd *)(buf + SECTION_HDR_SIZE);
 		if (eq_id == mc->hdr.processor_rev_id) {
 			desc->psize = patch_size;
 			desc->mc = mc;
 		}
 
-		buf  += patch_size;
-		size -= patch_size;
+skip:
+		/* Skip patch section header too: */
+		buf  += patch_size + SECTION_HDR_SIZE;
+		size -= patch_size + SECTION_HDR_SIZE;
 	}
 
 	/*
@@ -355,6 +356,7 @@ static ssize_t parse_container(u8 *ucode, ssize_t size, struct cont_desc *desc)
 		return 0;
 	}
 
+out:
 	return orig_size - size;
 }
 
