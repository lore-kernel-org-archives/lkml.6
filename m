Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA8EC43610
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 07:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7114A20C01
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 07:25:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7114A20C01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732758AbeKTRxN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 12:53:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:44254 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731756AbeKTRxM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 12:53:12 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6CE32B082;
        Tue, 20 Nov 2018 07:25:32 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        x86@kernel.org
Cc:     boris.ostrovsky@oracle.com, sstabellini@kernel.org, hpa@zytor.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        daniel.kiper@oracle.com, Juergen Gross <jgross@suse.com>
Subject: [PATCH 2/2] x86/acpi, x86/boot: Take RSDP address from boot params if available
Date:   Tue, 20 Nov 2018 08:25:29 +0100
Message-Id: <20181120072529.5489-3-jgross@suse.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20181120072529.5489-1-jgross@suse.com>
References: <20181120072529.5489-1-jgross@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case the RSDP address in struct boot_params is specified don't try
to find the table by searching, but take the address directly as set
by the boot loader.

Signed-off-by: Juergen Gross <jgross@suse.com>
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
-- 
2.16.4

