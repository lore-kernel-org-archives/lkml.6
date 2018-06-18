Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E8DC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 419D720864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:00:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 419D720864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933241AbeFRH75 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 03:59:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:53125 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932612AbeFRH74 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 03:59:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5AB51AE12;
        Mon, 18 Jun 2018 07:59:55 +0000 (UTC)
Date:   Mon, 18 Jun 2018 09:59:54 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Juergen Gross <jgross@suse.com>
cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@suse.de>,
        Mike Latimer <mlatimer@suse.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] x86/pti: don't report XenPV as vulnerable
In-Reply-To: <c8d238e9-2109-3fd2-01b8-37a7c5815fce@suse.com>
Message-ID: <nycvar.YFH.7.76.1806180959080.6203@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1806150025220.6203@cbobk.fhfr.pm> <a5bfcabb-827b-fbf7-9395-de9332697c25@suse.com> <nycvar.YFH.7.76.1806150801530.6203@cbobk.fhfr.pm> <ff9f4a24-6e69-cc7b-ba75-e82c9182a805@suse.com> <nycvar.YFH.7.76.1806150815440.6203@cbobk.fhfr.pm>
 <821642fe-775b-e68c-2a66-73b73c810289@suse.com> <nycvar.YFH.7.76.1806150837100.6203@cbobk.fhfr.pm> <37a18a24-7825-9e75-39a7-a66086a5e3a6@suse.com> <nycvar.YFH.7.76.1806152304400.6203@cbobk.fhfr.pm> <c8d238e9-2109-3fd2-01b8-37a7c5815fce@suse.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Kosina <jkosina@suse.cz>

Xen PV domain kernel is not by design affected by meltdown as it's 
enforcing split CR3 itself. Let's not report such systems as "Vulnerable" 
in sysfs (we're also already forcing PTI to off in X86_HYPER_XEN_PV 
cases); the security of the system ultimately depends on presence of 
mitigation in Hypervisor, which can't be easily detected from DomU; let's 
report that.

Reported-and-tested-by: Mike Latimer <mlatimer@suse.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
---

v1 -> v2: reporting "Not affected" is not really correct, as it depends on
	  the presence of mitigation in the hypervisor

 arch/x86/kernel/cpu/bugs.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index cd0fda1fff6d..57638396a254 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -27,6 +27,7 @@
 #include <asm/pgtable.h>
 #include <asm/set_memory.h>
 #include <asm/intel-family.h>
+#include <asm/hypervisor.h>
 
 static void __init spectre_v2_select_mitigation(void);
 static void __init ssb_select_mitigation(void);
@@ -664,6 +665,10 @@ static ssize_t cpu_show_common(struct device *dev, struct device_attribute *attr
 		if (boot_cpu_has(X86_FEATURE_PTI))
 			return sprintf(buf, "Mitigation: PTI\n");
 
+		if (hypervisor_is_type(X86_HYPER_XEN_PV))
+			return sprintf(buf, "Unknown (XEN PV detected, hypervisor "
+					    "mitigation required)\n");
+
 		break;
 
 	case X86_BUG_SPECTRE_V1:
-- 
2.12.3

-- 
Jiri Kosina
SUSE Labs

