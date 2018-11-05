Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2EBEC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 19:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2F4320685
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 19:31:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2F4320685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387878AbeKFEwG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 23:52:06 -0500
Received: from mga18.intel.com ([134.134.136.126]:16737 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728945AbeKFEwG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 23:52:06 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Nov 2018 11:30:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,469,1534834800"; 
   d="scan'208";a="89641431"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.154])
  by orsmga008.jf.intel.com with ESMTP; 05 Nov 2018 11:30:55 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Oded Gabbay <oded.gabbay@amd.com>
Subject: [PATCH] mm/mmu_notifier: rename mmu_notifier_synchronize() to <...>_barrier()
Date:   Mon,  5 Nov 2018 11:29:55 -0800
Message-Id: <20181105192955.26305-1-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

...and update its comment to explicitly reference its association with
mmu_notifier_call_srcu().

Contrary to its name, mmu_notifier_synchronize() does not synchronize
the notifier's SRCU instance, but rather waits for RCU callbacks to
finished, i.e. it invokes rcu_barrier().  The RCU documentation is
quite clear on this matter, explicitly calling out that rcu_barrier()
does not imply synchronize_rcu().  The misnomer could lean an unwary
developer to incorrectly assume that mmu_notifier_synchronize() can
be used in conjunction with mmu_notifier_unregister_no_release() to
implement a variation of mmu_notifier_unregister() that synchronizes
SRCU without invoking ->release.  A Documentation-allergic and hasty
developer could be further confused by the fact that rcu_barrier() is
indeed a pass-through to synchronize_rcu()... in tiny SRCU.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 mm/mmu_notifier.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
index 5119ff846769..46ebea6483bf 100644
--- a/mm/mmu_notifier.c
+++ b/mm/mmu_notifier.c
@@ -35,12 +35,12 @@ void mmu_notifier_call_srcu(struct rcu_head *rcu,
 }
 EXPORT_SYMBOL_GPL(mmu_notifier_call_srcu);
 
-void mmu_notifier_synchronize(void)
+void mmu_notifier_barrier(void)
 {
-	/* Wait for any running method to finish. */
+	/* Wait for any running RCU callbacks (see above) to finish. */
 	srcu_barrier(&srcu);
 }
-EXPORT_SYMBOL_GPL(mmu_notifier_synchronize);
+EXPORT_SYMBOL_GPL(mmu_notifier_barrier);
 
 /*
  * This function can't run concurrently against mmu_notifier_register
-- 
2.19.1

