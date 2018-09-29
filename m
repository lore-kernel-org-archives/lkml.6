Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC0DC64EAD
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D26F2087A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:52:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D26F2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728854AbeI3EWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 00:22:43 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:52016 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728743AbeI3ESe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 00:18:34 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N6E-0000Gy-1t; Sat, 29 Sep 2018 22:48:30 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N5w-0006ss-SC; Sat, 29 Sep 2018 22:48:12 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, xen-devel@lists.xenproject.org,
        "Juergen Gross" <jgross@suse.com>,
        "Brian Woods" <brian.woods@amd.com>,
        "Thomas Gleixner" <tglx@linutronix.de>, boris.ostrovsky@oracle.com,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Ingo Molnar" <mingo@kernel.org>
Date:   Sat, 29 Sep 2018 22:43:07 +0100
Message-ID: <lsq.1538257387.813871123@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 050/131] x86/xen: Add call of speculative_store_bypass_ht_init()
 to PV paths
In-Reply-To: <lsq.1538257386.330095874@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.59-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Juergen Gross <jgross@suse.com>

commit 74899d92e66663dc7671a8017b3146dcd4735f3b upstream.

Commit:

  1f50ddb4f418 ("x86/speculation: Handle HT correctly on AMD")

... added speculative_store_bypass_ht_init() to the per-CPU initialization sequence.

speculative_store_bypass_ht_init() needs to be called on each CPU for
PV guests, too.

Reported-by: Brian Woods <brian.woods@amd.com>
Tested-by: Brian Woods <brian.woods@amd.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: boris.ostrovsky@oracle.com
Cc: xen-devel@lists.xenproject.org
Fixes: 1f50ddb4f4189243c05926b842dc1a0332195f31 ("x86/speculation: Handle HT correctly on AMD")
Link: https://lore.kernel.org/lkml/20180621084331.21228-1-jgross@suse.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
[bwh: Backported to 3.16: adjust filename, context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/xen/smp_pv.c | 5 +++++
 1 file changed, 5 insertions(+)

--- a/arch/x86/xen/smp.c
+++ b/arch/x86/xen/smp.c
@@ -27,6 +27,7 @@
 #include <xen/interface/xen.h>
 #include <xen/interface/vcpu.h>
 
+#include <asm/spec-ctrl.h>
 #include <asm/xen/interface.h>
 #include <asm/xen/hypercall.h>
 
@@ -83,6 +84,8 @@ static void cpu_bringup(void)
 	cpu_data(cpu).x86_max_cores = 1;
 	set_cpu_sibling_map(cpu);
 
+	speculative_store_bypass_ht_init();
+
 	xen_setup_cpu_clockevents();
 
 	notify_cpu_starting(cpu);
@@ -334,6 +337,8 @@ static void __init xen_smp_prepare_cpus(
 	}
 	set_cpu_sibling_map(0);
 
+	speculative_store_bypass_ht_init();
+
 	if (xen_smp_intr_init(0))
 		BUG();
 

