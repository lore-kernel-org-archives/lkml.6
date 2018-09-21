Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C74ECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 06:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7255521479
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 06:22:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7255521479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389476AbeIUMJU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 08:09:20 -0400
Received: from mga02.intel.com ([134.134.136.20]:42211 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389203AbeIUMJT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 08:09:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Sep 2018 23:21:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,283,1534834800"; 
   d="scan'208";a="74799045"
Received: from chenyu-desktop.sh.intel.com ([10.239.160.116])
  by orsmga007.jf.intel.com with ESMTP; 20 Sep 2018 23:21:55 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Zhimin Gu <kookoo.gu@intel.com>, Chen Yu <yu.c.chen@intel.com>,
        x86@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 12/12][v4] x86-32, hibernate: Adjust in_suspend after resumed on 32bit system
Date:   Fri, 21 Sep 2018 14:28:41 +0800
Message-Id: <78ca6c538d10eb04bc15d576833d8d6131e29bf4.1537448058.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1537448058.git.yu.c.chen@intel.com>
References: <cover.1537448058.git.yu.c.chen@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhimin Gu <kookoo.gu@intel.com>

Update the in_suspend variable to reflect the actual hibernation
status. Back-port from 64bit system.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Signed-off-by: Zhimin Gu <kookoo.gu@intel.com>
Acked-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 arch/x86/power/hibernate_asm_32.S | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/power/hibernate_asm_32.S b/arch/x86/power/hibernate_asm_32.S
index 01f653fae7bd..6fe383002125 100644
--- a/arch/x86/power/hibernate_asm_32.S
+++ b/arch/x86/power/hibernate_asm_32.S
@@ -103,5 +103,8 @@ ENTRY(restore_registers)
 
 	xorl	%eax, %eax
 
+	/* tell the hibernation core that we've just restored the memory */
+	movl	%eax, in_suspend
+
 	ret
 ENDPROC(restore_registers)
-- 
2.17.1

