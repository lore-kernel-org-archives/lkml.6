Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932444AbeD0JJ5 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 05:09:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52978 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932282AbeD0JJy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 05:09:54 -0400
X-Mailbox-Line: From dyoung@redhat.com Fri Apr 27 17:00:45 2018
Message-Id: <20180427090045.583830252@redhat.com>
User-Agent: quilt/0.65
Date: Fri, 27 Apr 2018 17:00:38 +0800
From: dyoung@redhat.com
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: bhe@redhat.com, yinghai@kernel.org, akpm@linux-foundation.org,
        dyoung@redhat.com, vgoyal@redhat.com
Subject: [PATCH 2/2] kdump: round up the total memory size to 128M for crashkernel reservation
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=kdump-crashkernel-roundup-total-mem.patch
In-Reply-To: <20180427090045.532014306@redhat.com> 
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The total memory size we get in kernel is usually slightly less than 2G with a
2G memory module machine. The main reason is bios/firmware reserve some area
it will not export all memory as usable to Linux.

2G memory X86 kvm guest test result of the total_mem value:
UEFI boot with ovmf: 0x7ef10000
Legacy boot kvm guest: 0x7ff7cc00
This is also a problem on arm64 UEFI booted system according to my test.

Thus for example crashkernel=1G-2G:128M,  if we have a 1G memory
machine, we get total size 1023M from firmware then it will not fall
into 1G-2G thus no memory reserved.  User will never know that, it is
hard to let user to know the exact total value we get in kernel

An option is to use dmi/smbios to get physical memory size, but it's not
reliable as well. According to Prarit hardware vendors sometimes screw this up.
Thus round up total size to 128M to workaround this problem.

Signed-off-by: Dave Young <dyoung@redhat.com>
---
 kernel/crash_core.c |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

--- linux-x86.orig/kernel/crash_core.c
+++ linux-x86/kernel/crash_core.c
@@ -9,6 +9,7 @@
 #include <linux/crash_core.h>
 #include <linux/utsname.h>
 #include <linux/vmalloc.h>
+#include <linux/sizes.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
@@ -41,6 +42,15 @@ static int __init parse_crashkernel_mem(
 					unsigned long long *crash_base)
 {
 	char *cur = cmdline, *tmp;
+	unsigned long long total_mem = system_ram;
+
+	/*
+	 * Firmware sometimes reserves some memory regions for it's own use.
+	 * so we get less than actual system memory size.
+	 * Workaround this by round up the total size to 128M which is
+	 * enough for most test cases.
+	 */
+	total_mem = roundup(total_mem, SZ_128M);
 
 	/* for each entry of the comma-separated list */
 	do {
@@ -85,13 +95,13 @@ static int __init parse_crashkernel_mem(
 			return -EINVAL;
 		}
 		cur = tmp;
-		if (size >= system_ram) {
+		if (size >= total_mem) {
 			pr_warn("crashkernel: invalid size\n");
 			return -EINVAL;
 		}
 
 		/* match ? */
-		if (system_ram >= start && system_ram < end) {
+		if (total_mem >= start && total_mem < end) {
 			*crash_size = size;
 			break;
 		}
