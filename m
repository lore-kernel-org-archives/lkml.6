Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF51BC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 12:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DC58205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 12:39:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DC58205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728846AbeH3Qkz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 12:40:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47260 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728713AbeH3Qkz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 12:40:55 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 968F4804B9F4;
        Thu, 30 Aug 2018 12:38:56 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.khw.lab.eng.bos.redhat.com [10.16.186.145])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 71A3C202704E;
        Thu, 30 Aug 2018 12:38:56 +0000 (UTC)
From:   Prarit Bhargava <prarit@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Prarit Bhargava <prarit@redhat.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: [PATCH v4] console: Add console=spcr option
Date:   Thu, 30 Aug 2018 08:38:49 -0400
Message-Id: <20180830123849.26163-1-prarit@redhat.com>
In-Reply-To: <20180829155618.32359-1-prarit@redhat.com>
References: <20180829155618.32359-1-prarit@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Thu, 30 Aug 2018 12:38:56 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Thu, 30 Aug 2018 12:38:56 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'prarit@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ACPI may contain an SPCR table that defines a default system console.
On ARM if the table is present then the SPCR console is enabled by default.
On x86 the SPCR console is used if 'earlycon' (no parameters) is
specified as a kernel parameter and is used only as the early console.
To use the SPCR data as a console a user must boot with 'earlycon',
grep logs & specify a console= kernel parameter, and then reboot again.

Add 'console=spcr' that enables a firmware or hardware console, and on
x86 enable the SPCR console if 'console=spcr' is specified.

Tested on systems with and without an ACPI SPCR.  The following kernel
parameters were also tested:

console=ttyS0,115200    		works
earlycon                		works (early console only)
console=spcr            		works (full console as expected)
no console or earlycon arguments	works (no output as expected)

v2: Fix prototype.
v3: Change parameter to "spcr" and add error message to spcr init call.
v4: move spcr to x86 (really make it arch specific)

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  1 +
 arch/x86/kernel/acpi/boot.c                     | 14 ++++++++++++++
 include/linux/console.h                         |  1 +
 kernel/printk/printk.c                          |  8 ++++++++
 4 files changed, 24 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 9871e649ffef..f51a32cda90c 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -635,6 +635,7 @@
 
 		hvc<n>	Use the hypervisor console device <n>. This is for
 			both Xen and PowerPC hypervisors.
+		spcr	[X86] Enable ACPI SPCR console
 
 		If the device connected to the port is not a TTY but a braille
 		device, prepend "brl," before the device type, for instance
diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 3b20607d581b..a43a34734f02 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -1771,3 +1771,17 @@ void __init arch_reserve_mem_area(acpi_physical_address addr, size_t size)
 	e820__range_add(addr, size, E820_TYPE_ACPI);
 	e820__update_table_print();
 }
+
+int __init arch_console_setup(char *str)
+{
+	int ret;
+
+	if (strcmp("spcr", str))
+		return 1;
+
+	ret = acpi_parse_spcr(false, true);
+	if (ret)
+		pr_err(PREFIX "ERROR: SPCR console is not enabled (%d)\n", ret);
+
+	return 0;
+}
diff --git a/include/linux/console.h b/include/linux/console.h
index ec9bdb3d7bab..9bb6a79823a2 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -183,6 +183,7 @@ struct console {
 extern int braille_register_console(struct console *, int index,
 		char *console_options, char *braille_options);
 extern int braille_unregister_console(struct console *);
+int arch_console_setup(char *str);
 #ifdef CONFIG_TTY
 extern void console_sysfs_notify(void);
 #else
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 924e37fb1620..ceee021a37ec 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2097,6 +2097,11 @@ static int __init console_msg_format_setup(char *str)
 }
 __setup("console_msg_format=", console_msg_format_setup);
 
+int __init __weak arch_console_setup(char *str)
+{
+	return 1;
+}
+
 /*
  * Set up a console.  Called via do_early_param() in init/main.c
  * for each "console=" parameter in the boot command line.
@@ -2107,6 +2112,9 @@ static int __init console_setup(char *str)
 	char *s, *options, *brl_options = NULL;
 	int idx;
 
+	if (!arch_console_setup(str))
+		return 1;
+
 	if (_braille_console_setup(&str, &brl_options))
 		return 1;
 
-- 
1.8.3.1

