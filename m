Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A50F6C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 03:49:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EFFD21726
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 03:49:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbfAWDtd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 22:49:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54176 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726940AbfAWDtb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 22:49:31 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D65CF811AC;
        Wed, 23 Jan 2019 03:49:30 +0000 (UTC)
Received: from llong.com (ovpn-120-224.rdu2.redhat.com [10.10.120.224])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A945E5D6A6;
        Wed, 23 Jan 2019 03:49:28 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        x86@kernel.org, Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        James Morse <james.morse@arm.com>,
        SRINIVAS <srinivas.eeda@oracle.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v2 4/4] locking/qspinlock_stat: Allow QUEUED_LOCK_STAT for all archs
Date:   Tue, 22 Jan 2019 22:49:11 -0500
Message-Id: <1548215351-18896-5-git-send-email-longman@redhat.com>
In-Reply-To: <1548215351-18896-1-git-send-email-longman@redhat.com>
References: <1548215351-18896-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Wed, 23 Jan 2019 03:49:31 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The QUEUED_LOCK_STAT option to report queued spinlocks statistics was
previously allowed only on x86 architecture. Now queued spinlocks are
used in multiple architectures, we now allow QUEUED_LOCK_STAT to be
enabled for all those architectures that use queued spinlocks. This
option is listed as part of the general architecture-dependent options.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 arch/Kconfig     | 7 +++++++
 arch/x86/Kconfig | 8 --------
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 4cfb6de..c82e32f 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -885,6 +885,13 @@ config HAVE_ARCH_PREL32_RELOCATIONS
 	  architectures, and don't require runtime relocation on relocatable
 	  kernels.
 
+config QUEUED_LOCK_STAT
+	bool "Queued spinlock statistics"
+	depends on QUEUED_SPINLOCKS && DEBUG_FS
+	---help---
+	  Enable the collection of statistical data on the slowpath
+	  behavior of queued spinlocks and report them on debugfs.
+
 source "kernel/gcov/Kconfig"
 
 source "scripts/gcc-plugins/Kconfig"
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 4b4a7f3..872e681 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -784,14 +784,6 @@ config PARAVIRT_SPINLOCKS
 
 	  If you are unsure how to answer this question, answer Y.
 
-config QUEUED_LOCK_STAT
-	bool "Paravirt queued spinlock statistics"
-	depends on PARAVIRT_SPINLOCKS && DEBUG_FS
-	---help---
-	  Enable the collection of statistical data on the slowpath
-	  behavior of paravirtualized queued spinlocks and report
-	  them on debugfs.
-
 source "arch/x86/xen/Kconfig"
 
 config KVM_GUEST
-- 
1.8.3.1

