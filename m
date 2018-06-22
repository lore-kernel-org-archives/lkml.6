Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D51C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 09:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34A7223FD4
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 09:56:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34A7223FD4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933664AbeFVJ4f (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 05:56:35 -0400
Received: from mail.skyhub.de ([5.9.137.197]:41270 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754626AbeFVJyc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 05:54:32 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id r1a1G7of6xPD; Fri, 22 Jun 2018 11:54:31 +0200 (CEST)
Received: from zn.tnic (p200300EC2BCF3400329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bcf:3400:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5B8911EC0236;
        Fri, 22 Jun 2018 11:54:31 +0200 (CEST)
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/7] x86/mce: Always use 64-bit timestamps
Date:   Fri, 22 Jun 2018 11:54:22 +0200
Message-Id: <20180622095428.626-2-bp@alien8.de>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c
In-Reply-To: <20180622095428.626-1-bp@alien8.de>
References: <20180622095428.626-1-bp@alien8.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The machine check timestamp uses get_seconds(), which returns an
'unsigned long' number that might overflow on 32-bit architectures (in
the distant future) and is therefore deprecated.

The normal replacement would be ktime_get_real_seconds(), but that needs
to use a sequence lock that might cause a deadlock if the MCE happens at
just the wrong moment. The __ktime_get_real_seconds() skips that lock
and is safer here, but has a miniscule risk of returning the wrong time
when we read it on a 32-bit architecture at the same time as updating
the epoch, i.e. from before y2106 overflow time to after, or vice versa.

This seems to be an acceptable risk in this particular case, and is the
same thing we do in kdb.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: linux-edac <linux-edac@vger.kernel.org>
Cc: x86-ml <x86@kernel.org>
Cc: y2038@lists.linaro.org
Link: http://lkml.kernel.org/r/20180618100759.1921750-1-arnd@arndb.de
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/cpu/mcheck/mce.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
index e4cf6ff1c2e1..b887415652ed 100644
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -123,8 +123,8 @@ void mce_setup(struct mce *m)
 {
 	memset(m, 0, sizeof(struct mce));
 	m->cpu = m->extcpu = smp_processor_id();
-	/* We hope get_seconds stays lockless */
-	m->time = get_seconds();
+	/* need the internal __ version to avoid deadlocks */
+	m->time = __ktime_get_real_seconds();
 	m->cpuvendor = boot_cpu_data.x86_vendor;
 	m->cpuid = cpuid_eax(1);
 	m->socketid = cpu_data(m->extcpu).phys_proc_id;
-- 
2.17.0.582.gccdcbd54c

