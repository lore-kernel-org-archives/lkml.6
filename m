Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68DC5C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 14:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23DE9208FE
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 14:11:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23DE9208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391595AbeHPRKI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 13:10:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53626 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390887AbeHPRKI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 13:10:08 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 436214023351;
        Thu, 16 Aug 2018 14:11:14 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.khw.lab.eng.bos.redhat.com [10.16.186.145])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 533132166BA0;
        Thu, 16 Aug 2018 14:11:11 +0000 (UTC)
From:   Prarit Bhargava <prarit@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Prarit Bhargava <prarit@redhat.com>,
        Mark Salter <msalter@redhat.com>, Al Stone <ahs3@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        x86@kernel.org, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org
Subject: [PATCH] console: Add console=auto option
Date:   Thu, 16 Aug 2018 10:10:55 -0400
Message-Id: <20180816141055.451-1-prarit@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 16 Aug 2018 14:11:14 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 16 Aug 2018 14:11:14 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'prarit@redhat.com' RCPT:''
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

Add 'console=auto' that enables a firmware or hardware console, and on
x86 enable the SPCR console if 'console=auto' is specified.

Tested on systems with and without an ACPI SPCR.  The following kernel
parameters were also tested:

console=ttyS0,115200    		works
earlycon                		works (early console only)
console=auto            		works (full console as expected)
no console or earlycon arguments	works (no output as expected)

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
Cc: Mark Salter <msalter@redhat.com>
Cc: Al Stone <ahs3@redhat.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <len.brown@intel.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: x86@kernel.org
Cc: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-pm@vger.kernel.org
---
 Documentation/admin-guide/kernel-parameters.txt |  1 +
 arch/x86/kernel/acpi/boot.c                     |  5 +++++
 include/linux/console.h                         |  1 +
 kernel/printk/printk.c                          | 10 ++++++++++
 4 files changed, 17 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index a32f2a126791..dd057224f33b 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -635,6 +635,7 @@
 
 		hvc<n>	Use the hypervisor console device <n>. This is for
 			both Xen and PowerPC hypervisors.
+		auto	[X86] Enable ACPI SPCR console
 
 		If the device connected to the port is not a TTY but a braille
 		device, prepend "brl," before the device type, for instance
diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 3b20607d581b..fb2616ba3b21 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -1771,3 +1771,8 @@ void __init arch_reserve_mem_area(acpi_physical_address addr, size_t size)
 	e820__range_add(addr, size, E820_TYPE_ACPI);
 	e820__update_table_print();
 }
+
+void __init arch_console_setup(void)
+{
+	acpi_parse_spcr(false, true);
+}
diff --git a/include/linux/console.h b/include/linux/console.h
index dfd6b0e97855..b802f62289a9 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -181,6 +181,7 @@ extern int is_console_locked(void);
 extern int braille_register_console(struct console *, int index,
 		char *console_options, char *braille_options);
 extern int braille_unregister_console(struct console *);
+int arch_console_setup(void);
 #ifdef CONFIG_TTY
 extern void console_sysfs_notify(void);
 #else
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 247808333ba4..b74eba44183e 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2078,6 +2078,11 @@ static int __init console_msg_format_setup(char *str)
 }
 __setup("console_msg_format=", console_msg_format_setup);
 
+int __init __weak arch_console_setup(void)
+{
+	return 0;
+}
+
 /*
  * Set up a console.  Called via do_early_param() in init/main.c
  * for each "console=" parameter in the boot command line.
@@ -2088,6 +2093,11 @@ static int __init console_setup(char *str)
 	char *s, *options, *brl_options = NULL;
 	int idx;
 
+	if (!strcmp(str, "auto")) {
+		arch_console_setup();
+		return 1;
+	}
+
 	if (_braille_console_setup(&str, &brl_options))
 		return 1;
 
-- 
2.14.4

