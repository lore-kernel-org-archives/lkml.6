Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2970050-1519654106-2-4796250278766513390
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519654105; b=fOzGv5aoX/09Rs2us24MNqvcpB7oKYOIg1zA1a1WlEu/SJD
    S1k1yKF4A4sq/M4Y1ulpyyurs8dSpuZtZ0vt2RtO6BebTDYWcf26/5tE44zxrKmh
    mGEdvDxPnNcHBTWIhsa28JXdwcIcsynoxUOR8xj0cSbMkW57uOcfAbcfbi954LPX
    YqonzgLlqj3XE2prIWJxqKgYDqFGKxpVuof0wzqoGSPEJU6Z0yzGMiHV7mmn5CHI
    I3FgsW2dSe1Kuh2jP03i9ag1tQADgW6Tw2lcP5IRVuBIBA11x2a5RfrpVUxRAuBT
    HwW+tJGh+3aU/ODy/BtghpLu65vlaKflu5GqRBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1519654105; bh=AF3g3Pl2cKVxDr43dIpnIfz9c8
    b9bREUijfxrFBM0AY=; b=BqP4pHpkdkm/uHmYd5M++fiDYeW6ESpyQKcBWnTsc9
    USA7fK0EFE7RznxrTF9nXQ8bnxVZPyMdIAoaTqCQKFz6JWELqN9lMgEpQQ18gBkJ
    TsZnOMo5SX3OBlT4g9xEw7SZJ0KO3beU/nxNtz2Mrfv4L+XfdPiZ+Quu2xDr0p7e
    j7VuIiTVEQhJ7DTl9nCKZ5zNQtkvL5+TSYtYITuq4ednKumF2h1y+PE3htRc+pSY
    ES9uiQdj1Zx0g6nsSaPex9BW/a/smmzYGS0vJIBiB/+n8SHYnM8YlJD9mhohMrm0
    sMVxTXT0RnMTGjid1qggTDSEQbM2ZCAlMFCP/XKZy9bQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752063AbeBZOIW (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 09:08:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:46453 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751825AbeBZOIW (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 26 Feb 2018 09:08:22 -0500
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        x86@kernel.org
Cc: boris.ostrovsky@oracle.com, hpa@zytor.com, tglx@linutronix.de,
        mingo@redhat.com, jbeulich@suse.com,
        Juergen Gross <jgross@suse.com>, stable@vger.kernel.org
Subject: [PATCH] x86/xen: zero MSR_IA32_SPEC_CTRL before suspend
Date: Mon, 26 Feb 2018 15:08:18 +0100
Message-Id: <20180226140818.4849-1-jgross@suse.com>
X-Mailer: git-send-email 2.13.6
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Older Xen versions (4.5 and before) might have problems migrating pv
guests with MSR_IA32_SPEC_CTRL having a non-zero value. So before
suspending zero that MSR and restore it after being resumed.

Cc: stable@vger.kernel.org
Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/xen/suspend.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/x86/xen/suspend.c b/arch/x86/xen/suspend.c
index d9f96cc5d743..1d83152c761b 100644
--- a/arch/x86/xen/suspend.c
+++ b/arch/x86/xen/suspend.c
@@ -1,12 +1,15 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/types.h>
 #include <linux/tick.h>
+#include <linux/percpu-defs.h>
 
 #include <xen/xen.h>
 #include <xen/interface/xen.h>
 #include <xen/grant_table.h>
 #include <xen/events.h>
 
+#include <asm/cpufeatures.h>
+#include <asm/msr-index.h>
 #include <asm/xen/hypercall.h>
 #include <asm/xen/page.h>
 #include <asm/fixmap.h>
@@ -15,6 +18,8 @@
 #include "mmu.h"
 #include "pmu.h"
 
+static DEFINE_PER_CPU(u64, spec_ctrl);
+
 void xen_arch_pre_suspend(void)
 {
 	xen_save_time_memory_area();
@@ -35,6 +40,9 @@ void xen_arch_post_suspend(int cancelled)
 
 static void xen_vcpu_notify_restore(void *data)
 {
+	if (xen_pv_domain() && boot_cpu_has(X86_FEATURE_SPEC_CTRL))
+		wrmsrl(MSR_IA32_SPEC_CTRL, this_cpu_read(spec_ctrl));
+
 	/* Boot processor notified via generic timekeeping_resume() */
 	if (smp_processor_id() == 0)
 		return;
@@ -44,7 +52,15 @@ static void xen_vcpu_notify_restore(void *data)
 
 static void xen_vcpu_notify_suspend(void *data)
 {
+	u64 tmp;
+
 	tick_suspend_local();
+
+	if (xen_pv_domain() && boot_cpu_has(X86_FEATURE_SPEC_CTRL)) {
+		rdmsrl(MSR_IA32_SPEC_CTRL, tmp);
+		this_cpu_write(spec_ctrl, tmp);
+		wrmsrl(MSR_IA32_SPEC_CTRL, 0);
+	}
 }
 
 void xen_arch_resume(void)
-- 
2.13.6
