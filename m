Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE657ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AFAE2146F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:07:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AFAE2146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731550AbeIREhM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:37:12 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49798 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727344AbeIREhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:37:11 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6FB6BC49;
        Mon, 17 Sep 2018 23:07:41 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mike Galbraith <efault@gmx.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Christoffer Dall <christoffer.dall@arm.com>
Subject: [PATCH 4.18 022/158] KVM: arm/arm64: Clean dcache to PoC when changing PTE due to CoW
Date:   Tue, 18 Sep 2018 00:40:52 +0200
Message-Id: <20180917211711.933433665@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917211710.383360696@linuxfoundation.org>
References: <20180917211710.383360696@linuxfoundation.org>
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

From: Marc Zyngier <marc.zyngier@arm.com>

commit 694556d54f354d3fe43bb2e61fd6103cca2638a4 upstream.

When triggering a CoW, we unmap the RO page via an MMU notifier
(invalidate_range_start), and then populate the new PTE using another
one (change_pte). In the meantime, we'll have copied the old page
into the new one.

The problem is that the data for the new page is sitting in the
cache, and should the guest have an uncached mapping to that page
(or its MMU off), following accesses will bypass the cache.

In a way, this is similar to what happens on a translation fault:
We need to clean the page to the PoC before mapping it. So let's just
do that.

This fixes a KVM unit test regression observed on a HiSilicon platform,
and subsequently reproduced on Seattle.

Fixes: a9c0e12ebee5 ("KVM: arm/arm64: Only clean the dcache on translation fault")
Cc: stable@vger.kernel.org # v4.16+
Reported-by: Mike Galbraith <efault@gmx.de>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 virt/kvm/arm/mmu.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- a/virt/kvm/arm/mmu.c
+++ b/virt/kvm/arm/mmu.c
@@ -1831,13 +1831,20 @@ static int kvm_set_spte_handler(struct k
 void kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte)
 {
 	unsigned long end = hva + PAGE_SIZE;
+	kvm_pfn_t pfn = pte_pfn(pte);
 	pte_t stage2_pte;
 
 	if (!kvm->arch.pgd)
 		return;
 
 	trace_kvm_set_spte_hva(hva);
-	stage2_pte = pfn_pte(pte_pfn(pte), PAGE_S2);
+
+	/*
+	 * We've moved a page around, probably through CoW, so let's treat it
+	 * just like a translation fault and clean the cache to the PoC.
+	 */
+	clean_dcache_guest_page(pfn, PAGE_SIZE);
+	stage2_pte = pfn_pte(pfn, PAGE_S2);
 	handle_hva_to_gpa(kvm, hva, end, &kvm_set_spte_handler, &stage2_pte);
 }
 


