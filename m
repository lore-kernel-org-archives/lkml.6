Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF1B7C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 11:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C893F218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 11:00:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730021AbfBALAz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 06:00:55 -0500
Received: from terminus.zytor.com ([198.137.202.136]:46961 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbfBALAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 06:00:54 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x11B0YDK3281371
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 1 Feb 2019 03:00:34 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x11B0YB43281368;
        Fri, 1 Feb 2019 03:00:34 -0800
Date:   Fri, 1 Feb 2019 03:00:34 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Chao Fan <tipbot@zytor.com>
Message-ID: <tip-93a209aaaad495d7d0bc9b6186a4495934f70402@git.kernel.org>
Cc:     mingo@kernel.org, fanc.fnst@cn.fujitsu.com, mingo@redhat.com,
        tglx@linutronix.de, x86@kernel.org, keescook@chromium.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org, bp@suse.de
Reply-To: mingo@kernel.org, fanc.fnst@cn.fujitsu.com, tglx@linutronix.de,
          mingo@redhat.com, x86@kernel.org, keescook@chromium.org,
          hpa@zytor.com, linux-kernel@vger.kernel.org, bp@suse.de
In-Reply-To: <20190123110850.12433-5-fanc.fnst@cn.fujitsu.com>
References: <20190123110850.12433-5-fanc.fnst@cn.fujitsu.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/boot] x86/boot: Search for RSDP in memory
Git-Commit-ID: 93a209aaaad495d7d0bc9b6186a4495934f70402
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

Commit-ID:  93a209aaaad495d7d0bc9b6186a4495934f70402
Gitweb:     https://git.kernel.org/tip/93a209aaaad495d7d0bc9b6186a4495934f70402
Author:     Chao Fan <fanc.fnst@cn.fujitsu.com>
AuthorDate: Wed, 23 Jan 2019 19:08:47 +0800
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Fri, 1 Feb 2019 11:52:55 +0100

x86/boot: Search for RSDP in memory

Scan memory (EBDA) for the RSDP and verify RSDP by signature and
checksum.

 [ bp:
   - Trim commit message.
   - Simplify bios_get_rsdp_addr() and cleanup mad casting.
 ]

Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: bhe@redhat.com
Cc: caoj.fnst@cn.fujitsu.com
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: indou.takao@jp.fujitsu.com
Cc: Ingo Molnar <mingo@redhat.com>
Cc: kasong@redhat.com
Cc: Kees Cook <keescook@chromium.org>
Cc: msys.mizuma@gmail.com
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190123110850.12433-5-fanc.fnst@cn.fujitsu.com
---
 arch/x86/boot/compressed/acpi.c | 77 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
index 5559fde1c0fe..66bda1b5cf94 100644
--- a/arch/x86/boot/compressed/acpi.c
+++ b/arch/x86/boot/compressed/acpi.c
@@ -107,3 +107,80 @@ static acpi_physical_address efi_get_rsdp_addr(void)
 #endif
 	return rsdp_addr;
 }
+
+static u8 compute_checksum(u8 *buffer, u32 length)
+{
+	u8 *end = buffer + length;
+	u8 sum = 0;
+
+	while (buffer < end)
+		sum += *(buffer++);
+
+	return sum;
+}
+
+/* Search a block of memory for the RSDP signature. */
+static u8 *scan_mem_for_rsdp(u8 *start, u32 length)
+{
+	struct acpi_table_rsdp *rsdp;
+	u8 *address, *end;
+
+	end = start + length;
+
+	/* Search from given start address for the requested length */
+	for (address = start; address < end; address += ACPI_RSDP_SCAN_STEP) {
+		/*
+		 * Both RSDP signature and checksum must be correct.
+		 * Note: Sometimes there exists more than one RSDP in memory;
+		 * the valid RSDP has a valid checksum, all others have an
+		 * invalid checksum.
+		 */
+		rsdp = (struct acpi_table_rsdp *)address;
+
+		/* BAD Signature */
+		if (!ACPI_VALIDATE_RSDP_SIG(rsdp->signature))
+			continue;
+
+		/* Check the standard checksum */
+		if (compute_checksum((u8 *)rsdp, ACPI_RSDP_CHECKSUM_LENGTH))
+			continue;
+
+		/* Check extended checksum if table version >= 2 */
+		if ((rsdp->revision >= 2) &&
+		    (compute_checksum((u8 *)rsdp, ACPI_RSDP_XCHECKSUM_LENGTH)))
+			continue;
+
+		/* Signature and checksum valid, we have found a real RSDP */
+		return address;
+	}
+	return NULL;
+}
+
+/* Search RSDP address in EBDA. */
+static acpi_physical_address bios_get_rsdp_addr(void)
+{
+	unsigned long address;
+	u8 *rsdp;
+
+	/* Get the location of the Extended BIOS Data Area (EBDA) */
+	address = *(u16 *)ACPI_EBDA_PTR_LOCATION;
+	address <<= 4;
+
+	/*
+	 * Search EBDA paragraphs (EBDA is required to be a minimum of
+	 * 1K length)
+	 */
+	if (address > 0x400) {
+		rsdp = scan_mem_for_rsdp((u8 *)address, ACPI_EBDA_WINDOW_SIZE);
+		if (rsdp)
+			return (acpi_physical_address)(unsigned long)rsdp;
+	}
+
+	/* Search upper memory: 16-byte boundaries in E0000h-FFFFFh */
+	rsdp = scan_mem_for_rsdp((u8 *) ACPI_HI_RSDP_WINDOW_BASE,
+					ACPI_HI_RSDP_WINDOW_SIZE);
+	if (rsdp)
+		return (acpi_physical_address)(unsigned long)rsdp;
+
+	return 0;
+}
