Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7599C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96F9E20779
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:51:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96F9E20779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728326AbeICVMo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:12:44 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36390 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727648AbeICVMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:12:44 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3BD6BCEE;
        Mon,  3 Sep 2018 16:51:47 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Suzuki Poulose <suzuki.poulose@arm.com>,
        Christoffer Dall <christoffer.dall@arm.com>,
        Punit Agrawal <punit.agrawal@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH 3.18 40/56] KVM: arm/arm64: Skip updating PTE entry if no change
Date:   Mon,  3 Sep 2018 18:49:30 +0200
Message-Id: <20180903164926.049897187@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903164924.078355019@linuxfoundation.org>
References: <20180903164924.078355019@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -898,6 +898,10 @@ static int stage2_set_pte(struct kvm *kv
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


