Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E06C282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DECF620663
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548359168;
	bh=oUFBQwOanuiDc+NHue0kOuYlG32scomcmi/n6Jifauo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pN62CtB3bU9z6v8CQ3fhGdzXSSXfAXn9kiCJxIXU51ZsnTSYTKC+0rSmndd3bFxP/
	 INYVJUAcaxo4bDrkJJn5ELEGVXdJ/HLJ7p/jG4mZIqI1+rlweL2YBEydXVkfwzWcVV
	 QLFPpAo8T1sGmTWiwUlzsNUzawKfsERx//74bah8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387733AbfAXTqH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:46:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:45010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387648AbfAXToO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:44:14 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E72A9218D4;
        Thu, 24 Jan 2019 19:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548359053;
        bh=oUFBQwOanuiDc+NHue0kOuYlG32scomcmi/n6Jifauo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kq6yxBQuKii2ryP2ldc5oRypwA9Juhsnkv9PDU7IlmJG+XhnZWoPSwvwYBecD2cPE
         zAEDMBNodZ5IpkHZfGYzahw8YG8fTU3TnCE2L8uIMbujq/pSJA0Wfoee+fqSa7/LJG
         WhoSN3OVSVGawmnmI3qzsBCMwHJxhcBenb/QkdYQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 112/127] KVM: PPC: Book3S HV: Apply combination of host and l1 pte rc for nested guest
Date:   Thu, 24 Jan 2019 20:20:58 +0100
Message-Id: <20190124190216.737945849@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190211.984305387@linuxfoundation.org>
References: <20190124190211.984305387@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 8b23eee4e55a32a2b51a180dfd27a8d214acc7a1 ]

The shadow page table contains ptes for translations from nested guest
address to host address. Currently when creating these ptes we take the
rc bits from the pte for the L1 guest address to host address
translation. This is incorrect as we must also factor in the rc bits
from the pte for the nested guest address to L1 guest address
translation (as contained in the L1 guest partition table for the nested
guest).

By not calculating these bits correctly L1 may not have been correctly
notified when it needed to update its rc bits in the partition table it
maintains for its nested guest.

Modify the code so that the rc bits in the resultant pte for the L2->L0
translation are the 'and' of the rc bits in the L2->L1 pte and the L1->L0
pte, also accounting for whether this was a write access when setting
the dirty bit.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kvm/book3s_hv_nested.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/kvm/book3s_hv_nested.c b/arch/powerpc/kvm/book3s_hv_nested.c
index fc64535e4c00..f8176ae3a5a7 100644
--- a/arch/powerpc/kvm/book3s_hv_nested.c
+++ b/arch/powerpc/kvm/book3s_hv_nested.c
@@ -1229,6 +1229,9 @@ static long int __kvmhv_nested_page_fault(struct kvm_vcpu *vcpu,
 	perm |= gpte.may_read ? 0UL : _PAGE_READ;
 	perm |= gpte.may_write ? 0UL : _PAGE_WRITE;
 	perm |= gpte.may_execute ? 0UL : _PAGE_EXEC;
+	/* Only set accessed/dirty (rc) bits if set in host and l1 guest ptes */
+	perm |= (gpte.rc & _PAGE_ACCESSED) ? 0UL : _PAGE_ACCESSED;
+	perm |= ((gpte.rc & _PAGE_DIRTY) && writing) ? 0UL : _PAGE_DIRTY;
 	pte = __pte(pte_val(pte) & ~perm);
 
 	/* What size pte can we insert? */
-- 
2.19.1



