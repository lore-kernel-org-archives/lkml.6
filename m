Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07218C282D8
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 12:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE67720882
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 12:48:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731046AbfA3Mra (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 07:47:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:44024 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730944AbfA3MrT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 07:47:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 11E9FB034;
        Wed, 30 Jan 2019 12:47:17 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     mingo@redhat.com
Cc:     bp@alien8.de, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v7 02/28] x86/asm/suspend: drop ENTRY from local data
Date:   Wed, 30 Jan 2019 13:46:45 +0100
Message-Id: <20190130124711.12463-3-jslaby@suse.cz>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190130124711.12463-1-jslaby@suse.cz>
References: <20190130124711.12463-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ENTRY was intended for functions and shall be paired with ENDPROC.
ENTRY also aligns symbols which creates unnecessary holes here between
data.

So drop ENTRY from saved_eip in wakeup_32 and many saved_* in wakeup_64,
as these symbols are local only.

We could use SYM_DATA_LOCAL for these symbols, but it was discouraged
earlier [1].

[1] https://lkml.org/lkml/2017/4/27/244

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Pavel Machek <pavel@ucw.cz>
Cc: Len Brown <len.brown@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: linux-pm@vger.kernel.org
---
 arch/x86/kernel/acpi/wakeup_32.S |  2 +-
 arch/x86/kernel/acpi/wakeup_64.S | 12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/acpi/wakeup_32.S b/arch/x86/kernel/acpi/wakeup_32.S
index 0c26b1b44e51..4203d4f0c68d 100644
--- a/arch/x86/kernel/acpi/wakeup_32.S
+++ b/arch/x86/kernel/acpi/wakeup_32.S
@@ -90,7 +90,7 @@ ret_point:
 .data
 ALIGN
 ENTRY(saved_magic)	.long	0
-ENTRY(saved_eip)	.long	0
+saved_eip:		.long 0
 
 # saved registers
 saved_idt:	.long	0,0
diff --git a/arch/x86/kernel/acpi/wakeup_64.S b/arch/x86/kernel/acpi/wakeup_64.S
index 50b8ed0317a3..510fa12aab73 100644
--- a/arch/x86/kernel/acpi/wakeup_64.S
+++ b/arch/x86/kernel/acpi/wakeup_64.S
@@ -125,12 +125,12 @@ ENTRY(do_suspend_lowlevel)
 ENDPROC(do_suspend_lowlevel)
 
 .data
-ENTRY(saved_rbp)	.quad	0
-ENTRY(saved_rsi)	.quad	0
-ENTRY(saved_rdi)	.quad	0
-ENTRY(saved_rbx)	.quad	0
+saved_rbp:		.quad	0
+saved_rsi:		.quad	0
+saved_rdi:		.quad	0
+saved_rbx:		.quad	0
 
-ENTRY(saved_rip)	.quad	0
-ENTRY(saved_rsp)	.quad	0
+saved_rip:		.quad	0
+saved_rsp:		.quad	0
 
 ENTRY(saved_magic)	.quad	0
-- 
2.20.1

