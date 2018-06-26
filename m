Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E09C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 12:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29D4226869
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 12:50:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29D4226869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964938AbeFZMui (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 08:50:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55324 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934343AbeFZMuh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 08:50:37 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4405B401EF11;
        Tue, 26 Jun 2018 12:50:36 +0000 (UTC)
Received: from crecklin.bos.com (ovpn-121-147.rdu2.redhat.com [10.10.121.147])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D99792166B5D;
        Tue, 26 Jun 2018 12:50:35 +0000 (UTC)
From:   Chris von Recklinghausen <crecklin@redhat.com>
To:     keescook@chromium.org, labbott@redhat.com, pabeni@redhat.com,
        linux-mm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v2 PATCH] add param that allows bootline control of hardened usercopy
Date:   Tue, 26 Jun 2018 08:50:30 -0400
Message-Id: <1530017430-5394-1-git-send-email-crecklin@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Tue, 26 Jun 2018 12:50:36 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Tue, 26 Jun 2018 12:50:36 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'crecklin@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enabling HARDENED_USER_COPY causes measurable regressions in the
networking performances, up to 8% under UDP flood.

A generic distro may want to enable HARDENED_USER_COPY in their default
kernel config, but at the same time, such distro may want to be able to
avoid the performance penalties in with the default configuration and
disable the stricter check on a per-boot basis.

This change adds a boot parameter that to conditionally disable
HARDENED_USERCOPY at boot time.

v1->v2:
	remove CONFIG_HUC_DEFAULT_OFF
	default is now enabled, boot param disables
	move check to __check_object_size so as to not break optimization of
		__builtin_constant_p()
	include linux/atomic.h before linux/jump_label.h

Signed-off-by: Chris von Recklinghausen <crecklin@redhat.com>
---
 .../admin-guide/kernel-parameters.rst         |  1 +
 .../admin-guide/kernel-parameters.txt         |  3 +++
 include/linux/thread_info.h                   |  5 ++++
 mm/usercopy.c                                 | 27 +++++++++++++++++++
 4 files changed, 36 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.rst b/Documentation/admin-guide/kernel-parameters.rst
index b8d0bc07ed0a..87a1200a1db6 100644
--- a/Documentation/admin-guide/kernel-parameters.rst
+++ b/Documentation/admin-guide/kernel-parameters.rst
@@ -100,6 +100,7 @@ parameter is applicable::
 	FB	The frame buffer device is enabled.
 	FTRACE	Function tracing enabled.
 	GCOV	GCOV profiling is enabled.
+	HUC	Hardened usercopy is enabled
 	HW	Appropriate hardware is enabled.
 	IA-64	IA-64 architecture is enabled.
 	IMA     Integrity measurement architecture is enabled.
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index efc7aa7a0670..d14be0038aed 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -816,6 +816,9 @@
 	disable=	[IPV6]
 			See Documentation/networking/ipv6.txt.
 
+	disable_hardened_usercopy [HUC]
+			Disable hardened usercopy checks
+
 	disable_radix	[PPC]
 			Disable RADIX MMU mode on POWER9
 
diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
index 8d8821b3689a..ab24fe2d3f87 100644
--- a/include/linux/thread_info.h
+++ b/include/linux/thread_info.h
@@ -109,6 +109,11 @@ static inline int arch_within_stack_frames(const void * const stack,
 #endif
 
 #ifdef CONFIG_HARDENED_USERCOPY
+#include <linux/atomic.h>
+#include <linux/jump_label.h>
+
+DECLARE_STATIC_KEY_FALSE(bypass_usercopy_checks);
+
 extern void __check_object_size(const void *ptr, unsigned long n,
 					bool to_user);
 
diff --git a/mm/usercopy.c b/mm/usercopy.c
index e9e9325f7638..6a1265e1a54e 100644
--- a/mm/usercopy.c
+++ b/mm/usercopy.c
@@ -20,6 +20,8 @@
 #include <linux/sched/task.h>
 #include <linux/sched/task_stack.h>
 #include <linux/thread_info.h>
+#include <linux/atomic.h>
+#include <linux/jump_label.h>
 #include <asm/sections.h>
 
 /*
@@ -248,6 +250,9 @@ static inline void check_heap_object(const void *ptr, unsigned long n,
  */
 void __check_object_size(const void *ptr, unsigned long n, bool to_user)
 {
+	if (static_branch_likely(&bypass_usercopy_checks))
+		return;
+
 	/* Skip all tests if size is zero. */
 	if (!n)
 		return;
@@ -279,3 +284,25 @@ void __check_object_size(const void *ptr, unsigned long n, bool to_user)
 	check_kernel_text_object((const unsigned long)ptr, n, to_user);
 }
 EXPORT_SYMBOL(__check_object_size);
+
+DEFINE_STATIC_KEY_FALSE(bypass_usercopy_checks);
+EXPORT_SYMBOL(bypass_usercopy_checks);
+
+static bool disable_huc_atboot = false;
+
+static int __init parse_disable_usercopy(char *str)
+{
+	disable_huc_atboot = true;
+	return 1;
+}
+
+static int __init set_disable_usercopy(void)
+{
+	if (disable_huc_atboot == true)
+		static_branch_enable(&bypass_usercopy_checks);
+	return 1;
+}
+
+__setup("disable_hardened_usercopy", parse_disable_usercopy);
+
+late_initcall(set_disable_usercopy);
-- 
2.17.0

