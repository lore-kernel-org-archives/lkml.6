Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41BF6C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 10:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB2CD206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 10:13:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB2CD206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbeKSUgv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 15:36:51 -0500
Received: from terminus.zytor.com ([198.137.202.136]:34179 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbeKSUgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 15:36:50 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wAJADVsO2523716
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 19 Nov 2018 02:13:31 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wAJADVeR2523713;
        Mon, 19 Nov 2018 02:13:31 -0800
Date:   Mon, 19 Nov 2018 02:13:31 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Maciej S. Szmigiero" <tipbot@zytor.com>
Message-ID: <tip-f4ff25916c1186912e1b53c25861c8abc9f15687@git.kernel.org>
Cc:     mail@maciej.szmigiero.name, linux-kernel@vger.kernel.org,
        hpa@zytor.com, x86@kernel.org, tglx@linutronix.de, bp@suse.de,
        mingo@kernel.org
Reply-To: tglx@linutronix.de, mingo@kernel.org, bp@suse.de, hpa@zytor.com,
          linux-kernel@vger.kernel.org, mail@maciej.szmigiero.name,
          x86@kernel.org
In-Reply-To: <3014e96c82cd90761b4601bd2cfe59c4119e46a7.1529424596.git.mail@maciej.szmigiero.name>
References: <3014e96c82cd90761b4601bd2cfe59c4119e46a7.1529424596.git.mail@maciej.szmigiero.name>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/microcode] x86/microcode/AMD: Add microcode container
 verification
Git-Commit-ID: f4ff25916c1186912e1b53c25861c8abc9f15687
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

Commit-ID:  f4ff25916c1186912e1b53c25861c8abc9f15687
Gitweb:     https://git.kernel.org/tip/f4ff25916c1186912e1b53c25861c8abc9f15687
Author:     Maciej S. Szmigiero <mail@maciej.szmigiero.name>
AuthorDate: Tue, 19 Jun 2018 20:47:32 +0200
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Mon, 19 Nov 2018 10:45:03 +0100

x86/microcode/AMD: Add microcode container verification

Add container and patch verification functions to the AMD microcode
update driver.

These functions check whether a passed buffer contains the relevant
structure, whether it isn't truncated and (for actual microcode patches)
whether the size of a patch is not too large for a particular CPU family.
By adding these checks as separate functions the actual microcode loading
code won't get interspersed with a lot of checks and so will be more
readable.

 [ bp: Make all pr_err() calls into pr_debug() and drop the
   verify_patch() bits. ]

Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: x86-ml <x86@kernel.org>
Link: http://lkml.kernel.org/r/3014e96c82cd90761b4601bd2cfe59c4119e46a7.1529424596.git.mail@maciej.szmigiero.name
---
 arch/x86/kernel/cpu/microcode/amd.c | 101 ++++++++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index b44c9029860c..36aeb01b3ae8 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -73,6 +73,107 @@ static u16 find_equiv_id(struct equiv_cpu_entry *equiv_table, u32 sig)
 	return 0;
 }
 
+/*
+ * Check whether there is a valid microcode container file at the beginning
+ * of @buf of size @buf_size. Set @early to use this function in the early path.
+ */
+static bool verify_container(const u8 *buf, size_t buf_size, bool early)
+{
+	u32 cont_magic;
+
+	if (buf_size <= CONTAINER_HDR_SZ) {
+		if (!early)
+			pr_debug("Truncated microcode container header.\n");
+
+		return false;
+	}
+
+	cont_magic = *(const u32 *)buf;
+	if (cont_magic != UCODE_MAGIC) {
+		if (!early)
+			pr_debug("Invalid magic value (0x%08x).\n", cont_magic);
+
+		return false;
+	}
+
+	return true;
+}
+
+/*
+ * Check whether there is a valid, non-truncated CPU equivalence table at the
+ * beginning of @buf of size @buf_size. Set @early to use this function in the
+ * early path.
+ */
+static bool verify_equivalence_table(const u8 *buf, size_t buf_size, bool early)
+{
+	const u32 *hdr = (const u32 *)buf;
+	u32 cont_type, equiv_tbl_len;
+
+	if (!verify_container(buf, buf_size, early))
+		return false;
+
+	cont_type = hdr[1];
+	if (cont_type != UCODE_EQUIV_CPU_TABLE_TYPE) {
+		if (!early)
+			pr_debug("Wrong microcode container equivalence table type: %u.\n",
+			       cont_type);
+
+		return false;
+	}
+
+	buf_size -= CONTAINER_HDR_SZ;
+
+	equiv_tbl_len = hdr[2];
+	if (equiv_tbl_len < sizeof(struct equiv_cpu_entry) ||
+	    buf_size < equiv_tbl_len) {
+		if (!early)
+			pr_debug("Truncated equivalence table.\n");
+
+		return false;
+	}
+
+	return true;
+}
+
+/*
+ * Check whether there is a valid, non-truncated microcode patch section at the
+ * beginning of @buf of size @buf_size. Set @early to use this function in the
+ * early path.
+ */
+static bool verify_patch_section(const u8 *buf, size_t buf_size, bool early)
+{
+	const u32 *hdr;
+	u32 patch_type, patch_size;
+
+	if (buf_size < SECTION_HDR_SIZE) {
+		if (!early)
+			pr_debug("Truncated patch section.\n");
+
+		return false;
+	}
+
+	hdr = (const u32 *)buf;
+	patch_type = hdr[0];
+	patch_size = hdr[1];
+
+	if (patch_type != UCODE_UCODE_TYPE) {
+		if (!early)
+			pr_debug("Invalid type field (0x%x) in container file section header.\n",
+				patch_type);
+
+		return false;
+	}
+
+	if (patch_size < sizeof(struct microcode_header_amd)) {
+		if (!early)
+			pr_debug("Patch of size %u too short.\n", patch_size);
+
+		return false;
+	}
+
+	return true;
+}
+
 /*
  * This scans the ucode blob for the proper container as we can have multiple
  * containers glued together. Returns the equivalence ID from the equivalence
