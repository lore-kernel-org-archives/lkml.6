Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E95C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 11:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15A2B20883
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 11:14:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbfARLOI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 06:14:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40580 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726722AbfARLOH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 06:14:07 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6FF0BA6DE0;
        Fri, 18 Jan 2019 11:14:07 +0000 (UTC)
Received: from kasong-desktop-nay-redhat-com.nay.redhat.com (unknown [10.66.128.41])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 69B37101960A;
        Fri, 18 Jan 2019 11:13:55 +0000 (UTC)
From:   Kairui Song <kasong@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, dyoung@redhat.com, bhe@redhat.com,
        kexec@lists.infradead.org, akpm@linux-foundation.org,
        robert.moore@intel.com, erik.schmauss@intel.com,
        rafael.j.wysocki@intel.com, lenb@kernel.org,
        fanc.fnst@cn.fujitsu.com, linux-acpi@vger.kernel.org,
        Kairui Song <kasong@redhat.com>
Subject: [PATCH v3 2/3] acpi: store acpi_rsdp address for later kexec usage
Date:   Fri, 18 Jan 2019 19:13:09 +0800
Message-Id: <20190118111310.29589-3-kasong@redhat.com>
In-Reply-To: <20190118111310.29589-1-kasong@redhat.com>
References: <20190118111310.29589-1-kasong@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Fri, 18 Jan 2019 11:14:07 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we have acpi_os_get_root_pointer as the universal function
to get RSDP address. But the function itself and some functions it
depends on are in .init section and make it not easy to retrieve the
RSDP value once kernel is initialized.

And for kexec, it need to retrive RSDP again if EFI is disabled, because
the second kernel will not be able get the RSDP value in such case, so
it expects either the user specify the RSDP value using kernel cmdline,
or kexec could retrive and pass the RSDP value using boot_params.

This patch stores the RSDP address when initialized is done, and
introduce an acpi_os_get_root_pointer_late for later kexec usage.

Signed-off-by: Kairui Song <kasong@redhat.com>
---
 drivers/acpi/osl.c   | 10 ++++++++++
 include/linux/acpi.h |  3 +++
 2 files changed, 13 insertions(+)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index f29e427d0d1d..6340d34d0df1 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -187,6 +187,16 @@ static int __init setup_acpi_rsdp(char *arg)
 	return kstrtoul(arg, 16, &acpi_rsdp);
 }
 early_param("acpi_rsdp", setup_acpi_rsdp);
+
+acpi_physical_address acpi_os_get_root_pointer_late(void) {
+	return acpi_rsdp;
+}
+
+static int __init acpi_store_root_pointer(void) {
+	acpi_rsdp = acpi_os_get_root_pointer();
+	return 0;
+}
+late_initcall(acpi_store_root_pointer);
 #endif
 
 acpi_physical_address __init acpi_os_get_root_pointer(void)
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 87715f20b69a..226f2572eb8e 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -892,6 +892,9 @@ static inline void arch_reserve_mem_area(acpi_physical_address addr,
 {
 }
 #endif /* CONFIG_X86 */
+#ifdef CONFIG_KEXEC
+acpi_physical_address acpi_os_get_root_pointer_late(void);
+#endif
 #else
 #define acpi_os_set_prepare_sleep(func, pm1a_ctrl, pm1b_ctrl) do { } while (0)
 #endif
-- 
2.20.1

