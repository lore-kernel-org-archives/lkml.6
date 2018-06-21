Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3094C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 12:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A834F20837
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 12:26:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A834F20837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933592AbeFUM0B (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 08:26:01 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58945 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933186AbeFUMZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 08:25:59 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5LCOm9j3880232
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 21 Jun 2018 05:24:48 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5LCOlcC3880229;
        Thu, 21 Jun 2018 05:24:47 -0700
Date:   Thu, 21 Jun 2018 05:24:47 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Kosina <tipbot@zytor.com>
Message-ID: <tip-6cb2b08ff92460290979de4be91363e5d1b6cec1@git.kernel.org>
Cc:     mlatimer@suse.com, linux-kernel@vger.kernel.org, hpa@zytor.com,
        mingo@kernel.org, jgross@suse.com, tglx@linutronix.de,
        jkosina@suse.cz, bp@suse.de
Reply-To: bp@suse.de, jkosina@suse.cz, tglx@linutronix.de,
          mingo@kernel.org, jgross@suse.com, hpa@zytor.com,
          mlatimer@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <nycvar.YFH.7.76.1806180959080.6203@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1806180959080.6203@cbobk.fhfr.pm>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/pti: Don't report XenPV as vulnerable
Git-Commit-ID: 6cb2b08ff92460290979de4be91363e5d1b6cec1
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

Commit-ID:  6cb2b08ff92460290979de4be91363e5d1b6cec1
Gitweb:     https://git.kernel.org/tip/6cb2b08ff92460290979de4be91363e5d1b6cec1
Author:     Jiri Kosina <jkosina@suse.cz>
AuthorDate: Mon, 18 Jun 2018 09:59:54 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 21 Jun 2018 14:14:52 +0200

x86/pti: Don't report XenPV as vulnerable

Xen PV domain kernel is not by design affected by meltdown as it's
enforcing split CR3 itself. Let's not report such systems as "Vulnerable"
in sysfs (we're also already forcing PTI to off in X86_HYPER_XEN_PV cases);
the security of the system ultimately depends on presence of mitigation in
the Hypervisor, which can't be easily detected from DomU; let's report
that.

Reported-and-tested-by: Mike Latimer <mlatimer@suse.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Juergen Gross <jgross@suse.com>
Cc: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/nycvar.YFH.7.76.1806180959080.6203@cbobk.fhfr.pm
[ Merge the user-visible string into a single line. ]
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/cpu/bugs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index cd0fda1fff6d..404df26b7de8 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -27,6 +27,7 @@
 #include <asm/pgtable.h>
 #include <asm/set_memory.h>
 #include <asm/intel-family.h>
+#include <asm/hypervisor.h>
 
 static void __init spectre_v2_select_mitigation(void);
 static void __init ssb_select_mitigation(void);
@@ -664,6 +665,9 @@ static ssize_t cpu_show_common(struct device *dev, struct device_attribute *attr
 		if (boot_cpu_has(X86_FEATURE_PTI))
 			return sprintf(buf, "Mitigation: PTI\n");
 
+		if (hypervisor_is_type(X86_HYPER_XEN_PV))
+			return sprintf(buf, "Unknown (XEN PV detected, hypervisor mitigation required)\n");
+
 		break;
 
 	case X86_BUG_SPECTRE_V1:
