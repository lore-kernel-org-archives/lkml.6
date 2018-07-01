Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 181BBC6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C92C225328
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:37:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C92C225328
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031436AbeGAQhc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 12:37:32 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36232 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031403AbeGAQhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:37:19 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0A792A73;
        Sun,  1 Jul 2018 16:37:18 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Brian Woods <brian.woods@amd.com>,
        Juergen Gross <jgross@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        boris.ostrovsky@oracle.com, xen-devel@lists.xenproject.org,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.17 002/220] x86/xen: Add call of speculative_store_bypass_ht_init() to PV paths
Date:   Sun,  1 Jul 2018 18:20:26 +0200
Message-Id: <20180701160908.369313453@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160908.272447118@linuxfoundation.org>
References: <20180701160908.272447118@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

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
Cc: <stable@vger.kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: boris.ostrovsky@oracle.com
Cc: xen-devel@lists.xenproject.org
Fixes: 1f50ddb4f4189243c05926b842dc1a0332195f31 ("x86/speculation: Handle HT correctly on AMD")
Link: https://lore.kernel.org/lkml/20180621084331.21228-1-jgross@suse.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/xen/smp_pv.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/arch/x86/xen/smp_pv.c
+++ b/arch/x86/xen/smp_pv.c
@@ -32,6 +32,7 @@
 #include <xen/interface/vcpu.h>
 #include <xen/interface/xenpmu.h>
 
+#include <asm/spec-ctrl.h>
 #include <asm/xen/interface.h>
 #include <asm/xen/hypercall.h>
 
@@ -70,6 +71,8 @@ static void cpu_bringup(void)
 	cpu_data(cpu).x86_max_cores = 1;
 	set_cpu_sibling_map(cpu);
 
+	speculative_store_bypass_ht_init();
+
 	xen_setup_cpu_clockevents();
 
 	notify_cpu_starting(cpu);
@@ -250,6 +253,8 @@ static void __init xen_pv_smp_prepare_cp
 	}
 	set_cpu_sibling_map(0);
 
+	speculative_store_bypass_ht_init();
+
 	xen_pmu_init(0);
 
 	if (xen_smp_intr_init(0) || xen_smp_intr_init_pv(0))


