Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B002C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 08:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 301A02077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 08:20:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 301A02077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbeIEMtY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 08:49:24 -0400
Received: from mail.skyhub.de ([5.9.137.197]:51922 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726386AbeIEMtY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 08:49:24 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id IjpTjqH9njx2; Wed,  5 Sep 2018 10:20:02 +0200 (CEST)
Received: from zn.tnic (p200300EC2BCBB900329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bcb:b900:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 26EB91EC0181;
        Wed,  5 Sep 2018 10:20:02 +0200 (CEST)
From:   Borislav Petkov <bp@alien8.de>
To:     linux-edac <linux-edac@vger.kernel.org>
Cc:     Tony Luck <tony.luck@intel.com>,
        Yazen Ghannam <Yazen.Ghannam@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86/mce-inject: Reset struct after injection
Date:   Wed,  5 Sep 2018 10:19:54 +0200
Message-Id: <20180905081954.10391-1-bp@alien8.de>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Clear the MCE struct which is used for collecting the injection details
after injection.

Also, populate it with more details from the machine.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/cpu/mcheck/mce-inject.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/kernel/cpu/mcheck/mce-inject.c b/arch/x86/kernel/cpu/mcheck/mce-inject.c
index c805a06e14c3..1fc424c40a31 100644
--- a/arch/x86/kernel/cpu/mcheck/mce-inject.c
+++ b/arch/x86/kernel/cpu/mcheck/mce-inject.c
@@ -108,6 +108,9 @@ static void setup_inj_struct(struct mce *m)
 	memset(m, 0, sizeof(struct mce));
 
 	m->cpuvendor = boot_cpu_data.x86_vendor;
+	m->time	     = ktime_get_real_seconds();
+	m->cpuid     = cpuid_eax(1);
+	m->microcode = boot_cpu_data.microcode;
 }
 
 /* Update fake mce registers on current CPU. */
@@ -576,6 +579,9 @@ static int inj_bank_set(void *data, u64 val)
 	m->bank = val;
 	do_inject();
 
+	/* Reset injection struct */
+	setup_inj_struct(&i_mce);
+
 	return 0;
 }
 
-- 
2.17.0.582.gccdcbd54c

