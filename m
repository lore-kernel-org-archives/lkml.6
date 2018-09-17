Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF5EECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EFB62146F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:07:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EFB62146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731562AbeIREhP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:37:15 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49802 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727344AbeIREhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:37:15 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 124B3C49;
        Mon, 17 Sep 2018 23:07:44 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Mackerras <paulus@ozlabs.org>
Subject: [PATCH 4.18 023/158] KVM: PPC: Book3S HV: Use correct pagesize in kvm_unmap_radix()
Date:   Tue, 18 Sep 2018 00:40:53 +0200
Message-Id: <20180917211711.981110657@linuxfoundation.org>
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

From: Paul Mackerras <paulus@ozlabs.org>

commit c066fafc595eef5ae3c83ae3a8305956b8c3ef15 upstream.

Since commit e641a317830b ("KVM: PPC: Book3S HV: Unify dirty page map
between HPT and radix", 2017-10-26), kvm_unmap_radix() computes the
number of PAGE_SIZEd pages being unmapped and passes it to
kvmppc_update_dirty_map(), which expects to be passed the page size
instead.  Consequently it will only mark one system page dirty even
when a large page (for example a THP page) is being unmapped.  The
consequence of this is that part of the THP page might not get copied
during live migration, resulting in memory corruption for the guest.

This fixes it by computing and passing the page size in kvm_unmap_radix().

Cc: stable@vger.kernel.org # v4.15+
Fixes: e641a317830b (KVM: PPC: Book3S HV: Unify dirty page map between HPT and radix)
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/kvm/book3s_64_mmu_radix.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/arch/powerpc/kvm/book3s_64_mmu_radix.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_radix.c
@@ -738,10 +738,10 @@ int kvm_unmap_radix(struct kvm *kvm, str
 					      gpa, shift);
 		kvmppc_radix_tlbie_page(kvm, gpa, shift);
 		if ((old & _PAGE_DIRTY) && memslot->dirty_bitmap) {
-			unsigned long npages = 1;
+			unsigned long psize = PAGE_SIZE;
 			if (shift)
-				npages = 1ul << (shift - PAGE_SHIFT);
-			kvmppc_update_dirty_map(memslot, gfn, npages);
+				psize = 1ul << shift;
+			kvmppc_update_dirty_map(memslot, gfn, psize);
 		}
 	}
 	return 0;				


