Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4AD6C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 15:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9893420862
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 15:00:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9893420862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbeICTUg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 15:20:36 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60387 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727266AbeICTUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 15:20:36 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w83Exu8j3340305
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 3 Sep 2018 07:59:56 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w83ExuXG3340302;
        Mon, 3 Sep 2018 07:59:56 -0700
Date:   Mon, 3 Sep 2018 07:59:56 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Juergen Gross <tipbot@zytor.com>
Message-ID: <tip-c00a280a8efa4dc077596cf646bd50cbd13db3c8@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, jgross@suse.com, mingo@kernel.org,
        hpa@zytor.com, tglx@linutronix.de
Reply-To: jgross@suse.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
          hpa@zytor.com, tglx@linutronix.de
In-Reply-To: <20180828074026.820-11-jgross@suse.com>
References: <20180828074026.820-11-jgross@suse.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/paravirt] x86/paravirt: Introduce new config option
 PARAVIRT_XXL
Git-Commit-ID: c00a280a8efa4dc077596cf646bd50cbd13db3c8
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

Commit-ID:  c00a280a8efa4dc077596cf646bd50cbd13db3c8
Gitweb:     https://git.kernel.org/tip/c00a280a8efa4dc077596cf646bd50cbd13db3c8
Author:     Juergen Gross <jgross@suse.com>
AuthorDate: Tue, 28 Aug 2018 09:40:21 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 3 Sep 2018 16:50:35 +0200

x86/paravirt: Introduce new config option PARAVIRT_XXL

A large amount of paravirt ops is used by Xen PV guests only. Add a new
config option PARAVIRT_XXL which is selected by XEN_PV. Later we can
put the Xen PV only paravirt ops under the PARAVIRT_XXL umbrella.

Since irq related paravirt ops are used only by VSMP and Xen PV, let
VSMP select PARAVIRT_XXL, too, in order to enable moving the irq ops
under PARAVIRT_XXL.

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: xen-devel@lists.xenproject.org
Cc: virtualization@lists.linux-foundation.org
Cc: akataria@vmware.com
Cc: rusty@rustcorp.com.au
Cc: boris.ostrovsky@oracle.com
Cc: hpa@zytor.com
Link: https://lkml.kernel.org/r/20180828074026.820-11-jgross@suse.com

---
 arch/x86/Kconfig                   | 4 ++++
 arch/x86/boot/compressed/misc.h    | 1 +
 arch/x86/mm/mem_encrypt_identity.c | 1 +
 arch/x86/xen/Kconfig               | 1 +
 4 files changed, 7 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 1a0be022f91d..6265b84f6386 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -523,6 +523,7 @@ config X86_VSMP
 	bool "ScaleMP vSMP"
 	select HYPERVISOR_GUEST
 	select PARAVIRT
+	select PARAVIRT_XXL
 	depends on X86_64 && PCI
 	depends on X86_EXTENDED_PLATFORM
 	depends on SMP
@@ -754,6 +755,9 @@ config PARAVIRT
 	  over full virtualization.  However, when run without a hypervisor
 	  the kernel is theoretically slower and slightly larger.
 
+config PARAVIRT_XXL
+	bool
+
 config PARAVIRT_DEBUG
 	bool "paravirt-ops debugging"
 	depends on PARAVIRT && DEBUG_KERNEL
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index a423bdb42686..a1d5918765f3 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -9,6 +9,7 @@
  * paravirt and debugging variants are added.)
  */
 #undef CONFIG_PARAVIRT
+#undef CONFIG_PARAVIRT_XXL
 #undef CONFIG_PARAVIRT_SPINLOCKS
 #undef CONFIG_KASAN
 
diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index 7ae36868aed2..a19ef1a416ff 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -27,6 +27,7 @@
  * be extended when new paravirt and debugging variants are added.)
  */
 #undef CONFIG_PARAVIRT
+#undef CONFIG_PARAVIRT_XXL
 #undef CONFIG_PARAVIRT_SPINLOCKS
 
 #include <linux/kernel.h>
diff --git a/arch/x86/xen/Kconfig b/arch/x86/xen/Kconfig
index c1f98f32c45f..dd92d7bd3613 100644
--- a/arch/x86/xen/Kconfig
+++ b/arch/x86/xen/Kconfig
@@ -18,6 +18,7 @@ config XEN_PV
 	bool "Xen PV guest support"
 	default y
 	depends on XEN
+	select PARAVIRT_XXL
 	select XEN_HAVE_PVMMU
 	select XEN_HAVE_VPMU
 	help
