Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0294C43610
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 10:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B12D221479
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 10:00:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B12D221479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbeKTU2b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 15:28:31 -0500
Received: from terminus.zytor.com ([198.137.202.136]:35823 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbeKTU2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 15:28:31 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wAK9xlft2935501
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 20 Nov 2018 01:59:47 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wAK9xltn2935498;
        Tue, 20 Nov 2018 01:59:47 -0800
Date:   Tue, 20 Nov 2018 01:59:47 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Juergen Gross <tipbot@zytor.com>
Message-ID: <tip-e6e094e053af75cbc164e950814d3d084fb1e698@git.kernel.org>
Cc:     tglx@linutronix.de, peterz@infradead.org,
        torvalds@linux-foundation.org, jgross@suse.com, mingo@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org
Reply-To: peterz@infradead.org, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, hpa@zytor.com, jgross@suse.com,
          mingo@kernel.org, torvalds@linux-foundation.org
In-Reply-To: <20181120072529.5489-3-jgross@suse.com>
References: <20181120072529.5489-3-jgross@suse.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/acpi, x86/boot: Take RSDP address from boot
 params if available
Git-Commit-ID: e6e094e053af75cbc164e950814d3d084fb1e698
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

Commit-ID:  e6e094e053af75cbc164e950814d3d084fb1e698
Gitweb:     https://git.kernel.org/tip/e6e094e053af75cbc164e950814d3d084fb1e698
Author:     Juergen Gross <jgross@suse.com>
AuthorDate: Tue, 20 Nov 2018 08:25:29 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 20 Nov 2018 09:43:11 +0100

x86/acpi, x86/boot: Take RSDP address from boot params if available

In case the RSDP address in struct boot_params is specified don't try
to find the table by searching, but take the address directly as set
by the boot loader.

Suggested-by: "H. Peter Anvin" <hpa@zytor.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: boris.ostrovsky@oracle.com
Cc: bp@alien8.de
Cc: daniel.kiper@oracle.com
Cc: sstabellini@kernel.org
Cc: xen-devel@lists.xenproject.org
Link: http://lkml.kernel.org/r/20181120072529.5489-3-jgross@suse.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/uapi/asm/bootparam.h | 3 ++-
 arch/x86/kernel/acpi/boot.c           | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/uapi/asm/bootparam.h b/arch/x86/include/uapi/asm/bootparam.h
index a06cbf019744..60733f137e9a 100644
--- a/arch/x86/include/uapi/asm/bootparam.h
+++ b/arch/x86/include/uapi/asm/bootparam.h
@@ -155,7 +155,8 @@ struct boot_params {
 	__u8  _pad2[4];					/* 0x054 */
 	__u64  tboot_addr;				/* 0x058 */
 	struct ist_info ist_info;			/* 0x060 */
-	__u8  _pad3[16];				/* 0x070 */
+	__u64 acpi_rsdp_addr;				/* 0x070 */
+	__u8  _pad3[8];					/* 0x078 */
 	__u8  hd0_info[16];	/* obsolete! */		/* 0x080 */
 	__u8  hd1_info[16];	/* obsolete! */		/* 0x090 */
 	struct sys_desc_table sys_desc_table; /* obsolete! */	/* 0x0a0 */
diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index fb3b1f3a5aba..06635fbca81c 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -1776,5 +1776,5 @@ void __init arch_reserve_mem_area(acpi_physical_address addr, size_t size)
 
 u64 x86_default_get_root_pointer(void)
 {
-	return 0;
+	return boot_params.acpi_rsdp_addr;
 }
