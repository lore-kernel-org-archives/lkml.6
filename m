Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C836C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 10:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5C7120851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 10:20:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5C7120851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbeKSUnL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 15:43:11 -0500
Received: from terminus.zytor.com ([198.137.202.136]:57745 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbeKSUnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 15:43:11 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wAJAJn0Z2524820
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 19 Nov 2018 02:19:49 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wAJAJn4R2524817;
        Mon, 19 Nov 2018 02:19:49 -0800
Date:   Mon, 19 Nov 2018 02:19:49 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Maciej S. Szmigiero" <tipbot@zytor.com>
Message-ID: <tip-38673f623dfcaa03921aa5704ade176cd584c886@git.kernel.org>
Cc:     bp@suse.de, mail@maciej.szmigiero.name, mingo@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org, hpa@zytor.com
Reply-To: hpa@zytor.com, tglx@linutronix.de, linux-kernel@vger.kernel.org,
          mail@maciej.szmigiero.name, mingo@kernel.org, bp@suse.de
In-Reply-To: <20181107170218.7596-14-bp@alien8.de>
References: <20181107170218.7596-14-bp@alien8.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/microcode] x86/microcode/AMD: Check microcode container
 data in the late loader
Git-Commit-ID: 38673f623dfcaa03921aa5704ade176cd584c886
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

Commit-ID:  38673f623dfcaa03921aa5704ade176cd584c886
Gitweb:     https://git.kernel.org/tip/38673f623dfcaa03921aa5704ade176cd584c886
Author:     Maciej S. Szmigiero <mail@maciej.szmigiero.name>
AuthorDate: Thu, 13 Sep 2018 08:49:22 +0200
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Mon, 19 Nov 2018 10:55:11 +0100

x86/microcode/AMD: Check microcode container data in the late loader

Convert the late loading path to use the newly introduced microcode
container data checking functions as it was previously done for the
early loader.

[ bp: Keep header length addition in install_equiv_cpu_table() and rediff. ]

Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: x86@kernel.org
Link: https://lkml.kernel.org/r/20181107170218.7596-14-bp@alien8.de
---
 arch/x86/kernel/cpu/microcode/amd.c | 38 +++++++++++++++++--------------------
 1 file changed, 17 insertions(+), 21 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 66490ff087d9..ce6f8381641b 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -706,28 +706,27 @@ out:
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
@@ -794,13 +793,12 @@ static enum ucode_state __load_microcode_amd(u8 family, const u8 *data,
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
 
@@ -898,10 +896,8 @@ static enum ucode_state request_microcode_amd(int cpu, struct device *device,
 	}
 
 	ret = UCODE_ERROR;
-	if (*(u32 *)fw->data != UCODE_MAGIC) {
-		pr_err("invalid magic value (0x%08x)\n", *(u32 *)fw->data);
+	if (!verify_container(fw->data, fw->size, false))
 		goto fw_release;
-	}
 
 	ret = load_microcode_amd(bsp, c->x86, fw->data, fw->size);
 
