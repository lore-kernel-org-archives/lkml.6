Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DDD4C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AF3C20862
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:00:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AF3C20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbeICVVu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:21:50 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38586 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728365AbeICVVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:21:48 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 67382CFC;
        Mon,  3 Sep 2018 17:00:49 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Suzuki Poulose <suzuki.poulose@arm.com>,
        Christoffer Dall <christoffer.dall@arm.com>,
        Punit Agrawal <punit.agrawal@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH 4.4 51/80] KVM: arm/arm64: Skip updating PTE entry if no change
Date:   Mon,  3 Sep 2018 18:49:29 +0200
Message-Id: <20180903164936.189580418@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903164934.171677301@linuxfoundation.org>
References: <20180903164934.171677301@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Punit Agrawal <punit.agrawal@arm.com>

commit 976d34e2dab10ece5ea8fe7090b7692913f89084 upstream.

When there is contention on faulting in a particular page table entry
at stage 2, the break-before-make requirement of the architecture can
lead to additional refaulting due to TLB invalidation.

Avoid this by skipping a page table update if the new value of the PTE
matches the previous value.

Cc: stable@vger.kernel.org
Fixes: d5d8184d35c9 ("KVM: ARM: Memory virtualization setup")
Reviewed-by: Suzuki Poulose <suzuki.poulose@arm.com>
Acked-by: Christoffer Dall <christoffer.dall@arm.com>
Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/kvm/mmu.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -961,6 +961,10 @@ static int stage2_set_pte(struct kvm *kv
 	/* Create 2nd stage page table mapping - Level 3 */
 	old_pte = *pte;
 	if (pte_present(old_pte)) {
+		/* Skip page table update if there is no change */
+		if (pte_val(old_pte) == pte_val(*new_pte))
+			return 0;
+
 		kvm_set_pte(pte, __pte(0));
 		kvm_tlb_flush_vmid_ipa(kvm, addr);
 	} else {


