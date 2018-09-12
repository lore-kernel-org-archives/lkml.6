Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C43FCC46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 17:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E71520880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 17:41:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E71520880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbeILWrA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 18:47:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:48074 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727346AbeILWrA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 18:47:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DAEE6ABA2;
        Wed, 12 Sep 2018 17:41:24 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        x86@kernel.org
Cc:     boris.ostrovsky@oracle.com, hpa@zytor.com, tglx@linutronix.de,
        mingo@redhat.com, Juergen Gross <jgross@suse.com>
Subject: [PATCH] x86/xen: disable cpu0 hotplug for xen pv
Date:   Wed, 12 Sep 2018 19:41:22 +0200
Message-Id: <20180912174122.24282-1-jgross@suse.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xen pv guests don't allow cpu0 hotplug, so disable it.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/kernel/topology.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/topology.c b/arch/x86/kernel/topology.c
index 12cbe2b88c0f..738bf42b0218 100644
--- a/arch/x86/kernel/topology.c
+++ b/arch/x86/kernel/topology.c
@@ -111,8 +111,10 @@ int arch_register_cpu(int num)
 	/*
 	 * Currently CPU0 is only hotpluggable on Intel platforms. Other
 	 * vendors can add hotplug support later.
+	 * Xen PV guests don't support CPU0 hotplug at all.
 	 */
-	if (c->x86_vendor != X86_VENDOR_INTEL)
+	if (c->x86_vendor != X86_VENDOR_INTEL ||
+	    boot_cpu_has(X86_FEATURE_XENPV))
 		cpu0_hotpluggable = 0;
 
 	/*
-- 
2.16.4

