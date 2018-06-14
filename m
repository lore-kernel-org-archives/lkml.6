Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 5AAFAC5CFC0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 22:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E7F5208D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 22:32:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E7F5208D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965071AbeFNWck (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 18:32:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:44828 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964907AbeFNWci (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 18:32:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7DD1AAC1D;
        Thu, 14 Jun 2018 22:32:37 +0000 (UTC)
Date:   Fri, 15 Jun 2018 00:32:36 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@suse.de>
cc:     Mike Latimer <mlatimer@suse.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86/pti: don't report XenPV as vulnerable
Message-ID: <nycvar.YFH.7.76.1806150025220.6203@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Kosina <jkosina@suse.cz>

Xen PV domain is not by design affected by meltdown as it's enforcing 
split CR3 itself. Let's not report such systems as "Vulnerable" in sysfs 
(we're also already forcing PTI to off in X86_HYPER_XEN_PV cases)

Reported-and-tested-by: Mike Latimer <mlatimer@suse.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
---

I originally wanted to just not set X86_BUG_CPU_MELTDOWN in 
cpu_set_bug_bits() in the first place, but that has two issues:

- cpu_set_bug_bits() gets invoked from early_identify_cpu() before 
  init_hypervisor_platform() had a chance to run, and therefore the
  hypervisor type check doesn't work there

- it'd actually be inaccurate; the CPU *does* have the bug at the end
  of the day (so it's properly kept being reported in cpuinfo), it's
  "just a setup matter" that we don't need any addtional mitigation to
  be applied by the kernel

So let's not overcomplicate it.

 arch/x86/kernel/cpu/bugs.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -26,6 +26,7 @@
 #include <asm/pgtable.h>
 #include <asm/set_memory.h>
 #include <asm/intel-family.h>
+#include <asm/hypervisor.h>
 
 static void __init spectre_v2_select_mitigation(void);
 static void __init ssb_select_mitigation(void);
@@ -685,6 +686,9 @@ static ssize_t cpu_show_common(struct de
 		if (boot_cpu_has(X86_FEATURE_PTI))
 			return sprintf(buf, "Mitigation: PTI\n");
 
+		if (hypervisor_is_type(X86_HYPER_XEN_PV))
+			return sprintf(buf, "Not affected\n");
+
 		break;
 
 	case X86_BUG_SPECTRE_V1:

-- 
Jiri Kosina
SUSE Labs

