Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08035C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 21:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9837216F9
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 21:39:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9837216F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729719AbeHOA2O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 20:28:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:52148 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728196AbeHOA2O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 20:28:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E9583ADB1;
        Tue, 14 Aug 2018 21:39:05 +0000 (UTC)
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
Cc:     "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, stable@vger.kernel.org
Subject: [PATCH] x86/smp: fix non-SMP broken build due to redefinition of apic_id_is_primary_thread
Date:   Tue, 14 Aug 2018 23:38:57 +0200
Message-Id: <20180814213857.18779-1-vbabka@suse.cz>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function has an inline "return false;" definition with CONFIG_SMP=n but the
"real" definition is also visible leading to "redefinition of
‘apic_id_is_primary_thread’" compiler error. Guard it with #ifdef CONFIG_SMP

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Fixes: 6a4d2657e048 ("x86/smp: Provide topology_is_primary_thread()")
Cc: stable@vger.kernel.org
---
 arch/x86/kernel/apic/apic.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 87ff6235bbfe..84132eddb5a8 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -2193,6 +2193,7 @@ static int cpuid_to_apicid[] = {
 	[0 ... NR_CPUS - 1] = -1,
 };
 
+#ifdef CONFIG_SMP
 /**
  * apic_id_is_primary_thread - Check whether APIC ID belongs to a primary thread
  * @id:	APIC ID to check
@@ -2207,6 +2208,7 @@ bool apic_id_is_primary_thread(unsigned int apicid)
 	mask = (1U << (fls(smp_num_siblings) - 1)) - 1;
 	return !(apicid & mask);
 }
+#endif
 
 /*
  * Should use this API to allocate logical CPU IDs to keep nr_logical_cpuids
-- 
2.18.0

