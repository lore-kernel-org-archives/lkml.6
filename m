Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E605C07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5686220854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:07:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5686220854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732264AbeIMTQq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:16:46 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35682 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729096AbeIMTQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:16:45 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id BC5D6D39;
        Thu, 13 Sep 2018 14:07:04 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jan Beulich <jbeulich@suse.com>,
        Jason Andryuk <jandryuk@gmail.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: [PATCH 4.18 191/197] x86/pae: use 64 bit atomic xchg function in native_ptep_get_and_clear
Date:   Thu, 13 Sep 2018 15:32:20 +0200
Message-Id: <20180913131849.200843577@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131841.568116777@linuxfoundation.org>
References: <20180913131841.568116777@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Juergen Gross <jgross@suse.com>

commit b2d7a075a1ccef2fb321d595802190c8e9b39004 upstream.

Using only 32-bit writes for the pte will result in an intermediate
L1TF vulnerable PTE. When running as a Xen PV guest this will at once
switch the guest to shadow mode resulting in a loss of performance.

Use arch_atomic64_xchg() instead which will perform the requested
operation atomically with all 64 bits.

Some performance considerations according to:

https://software.intel.com/sites/default/files/managed/ad/dc/Intel-Xeon-Scalable-Processor-throughput-latency.pdf

The main number should be the latency, as there is no tight loop around
native_ptep_get_and_clear().

"lock cmpxchg8b" has a latency of 20 cycles, while "lock xchg" (with a
memory operand) isn't mentioned in that document. "lock xadd" (with xadd
having 3 cycles less latency than xchg) has a latency of 11, so we can
assume a latency of 14 for "lock xchg".

Signed-off-by: Juergen Gross <jgross@suse.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Jan Beulich <jbeulich@suse.com>
Tested-by: Jason Andryuk <jandryuk@gmail.com>
Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/include/asm/pgtable-3level.h |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

--- a/arch/x86/include/asm/pgtable-3level.h
+++ b/arch/x86/include/asm/pgtable-3level.h
@@ -2,6 +2,8 @@
 #ifndef _ASM_X86_PGTABLE_3LEVEL_H
 #define _ASM_X86_PGTABLE_3LEVEL_H
 
+#include <asm/atomic64_32.h>
+
 /*
  * Intel Physical Address Extension (PAE) Mode - three-level page
  * tables on PPro+ CPUs.
@@ -147,10 +149,7 @@ static inline pte_t native_ptep_get_and_
 {
 	pte_t res;
 
-	/* xchg acts as a barrier before the setting of the high bits */
-	res.pte_low = xchg(&ptep->pte_low, 0);
-	res.pte_high = ptep->pte_high;
-	ptep->pte_high = 0;
+	res.pte = (pteval_t)arch_atomic64_xchg((atomic64_t *)ptep, 0);
 
 	return res;
 }


