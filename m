Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68AD5C7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D51520876
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:47:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D51520876
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729721AbeJNX3G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:29:06 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37294 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728125AbeJNX3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:29:05 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiM3-0004cp-Ag; Sun, 14 Oct 2018 16:30:55 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLR-0000Ji-Uo; Sun, 14 Oct 2018 16:30:17 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, hpa@zytor.com,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Li RongQing" <lirongqing@baidu.com>, jgross@suse.com,
        "Dou Liyang" <douly.fnst@cn.fujitsu.com>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.111236195@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 130/366] x86/apic: Fix signedness bug in APIC ID
 validity checks
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Li RongQing <lirongqing@baidu.com>

commit a774635db5c430cbf21fa5d2f2df3d23aaa8e782 upstream.

The APIC ID as parsed from ACPI MADT is validity checked with the
apic->apic_id_valid() callback, which depends on the selected APIC type.

For non X2APIC types APIC IDs >= 0xFF are invalid, but values > 0x7FFFFFFF
are detected as valid. This happens because the 'apicid' argument of the
apic_id_valid() callback is type 'int'. So the resulting comparison

   apicid < 0xFF

evaluates to true for all unsigned int values > 0x7FFFFFFF which are handed
to default_apic_id_valid(). As a consequence, invalid APIC IDs in !X2APIC
mode are considered valid and accounted as possible CPUs.

Change the apicid argument type of the apic_id_valid() callback to u32 so
the evaluation is unsigned and returns the correct result.

[ tglx: Massaged changelog ]

Signed-off-by: Li RongQing <lirongqing@baidu.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: jgross@suse.com
Cc: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: hpa@zytor.com
Link: https://lkml.kernel.org/r/1523322966-10296-1-git-send-email-lirongqing@baidu.com
[bwh: Backported to 3.16:
 - Drop change to xen_id_always_valid()
 - Adjust filenames, context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -288,7 +288,7 @@ struct apic {
 
 	int (*probe)(void);
 	int (*acpi_madt_oem_check)(char *oem_id, char *oem_table_id);
-	int (*apic_id_valid)(int apicid);
+	int (*apic_id_valid)(u32 apicid);
 	int (*apic_id_registered)(void);
 
 	u32 irq_delivery_mode;
@@ -547,7 +547,7 @@ static inline unsigned int read_apic_id(
 	return apic->get_apic_id(reg);
 }
 
-static inline int default_apic_id_valid(int apicid)
+static inline int default_apic_id_valid(u32 apicid)
 {
 	return (apicid < 255);
 }
--- a/arch/x86/include/asm/x2apic.h
+++ b/arch/x86/include/asm/x2apic.h
@@ -9,7 +9,7 @@
 #include <asm/ipi.h>
 #include <linux/cpumask.h>
 
-static int x2apic_apic_id_valid(int apicid)
+static int x2apic_apic_id_valid(u32 apicid)
 {
 	return 1;
 }
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -215,7 +215,7 @@ static int __init
 acpi_parse_x2apic(struct acpi_subtable_header *header, const unsigned long end)
 {
 	struct acpi_madt_local_x2apic *processor = NULL;
-	int apic_id;
+	u32 apic_id;
 	u8 enabled;
 
 	processor = (struct acpi_madt_local_x2apic *)header;
@@ -235,10 +235,13 @@ acpi_parse_x2apic(struct acpi_subtable_h
 	 * to not preallocating memory for all NR_CPUS
 	 * when we use CPU hotplug.
 	 */
-	if (!apic->apic_id_valid(apic_id) && enabled)
-		printk(KERN_WARNING PREFIX "x2apic entry ignored\n");
-	else
-		acpi_register_lapic(apic_id, enabled);
+	if (!apic->apic_id_valid(apic_id)) {
+		if (enabled)
+			pr_warn(PREFIX "x2apic entry ignored\n");
+		return 0;
+	}
+
+	acpi_register_lapic(apic_id, enabled);
 #else
 	printk(KERN_WARNING PREFIX "x2apic entry ignored\n");
 #endif
--- a/arch/x86/kernel/apic/apic_numachip.c
+++ b/arch/x86/kernel/apic/apic_numachip.c
@@ -58,7 +58,7 @@ static unsigned int read_xapic_id(void)
 	return get_apic_id(apic_read(APIC_ID));
 }
 
-static int numachip_apic_id_valid(int apicid)
+static int numachip_apic_id_valid(u32 apicid)
 {
 	/* Trust what bootloader passes in MADT */
 	return 1;
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -272,7 +272,7 @@ static void uv_send_IPI_all(int vector)
 	uv_send_IPI_mask(cpu_online_mask, vector);
 }
 
-static int uv_apic_id_valid(int apicid)
+static int uv_apic_id_valid(u32 apicid)
 {
 	return 1;
 }

