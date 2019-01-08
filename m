Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 607A9C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3130220827
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546977540;
	bh=zpKBx+Mr14lsVMT+rVCB0LfSUJmnEFxpb6RSAuLos4Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=q0/jVeDOqTIAWhun9JfSmqEt2FtuzWx6leQqwlUGC4lYoltia/+oZTMaRxrrHz/30
	 njSB8vSu5PYucaD8lTImn2U33HCPFQOfG5bYl2R+cVXd3I+Ne+Mn5NzLP7PDpQ6jlT
	 qlh4y5JRMJeTj5FbDFXSGz+QmDU7Q869p5jXbkpk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731360AbfAHT6y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:58:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:36896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730391AbfAHT31 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:29:27 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09A75217D9;
        Tue,  8 Jan 2019 19:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546975766;
        bh=zpKBx+Mr14lsVMT+rVCB0LfSUJmnEFxpb6RSAuLos4Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SpFC4CugkqmPKPAVlEurMKIGmTyJ2r/Wl4v+bpgRX7tQlS2jENpE2NwYUbFuMo5ih
         V3cqWOosPVPWv6V0bcjXF0AXRMtfx5YqwE9onIeZXi2znmuFOysoa8lnrB4XhlcTcC
         ghh6MnlWX+pflUnDAZDaiLdeAgM7kRw+LFW/0muQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Sasha Levin <sashal@kernel.org>, kvm-ppc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 4.20 108/117] KVM: PPC: Book3S HV: Apply combination of host and l1 pte rc for nested guest
Date:   Tue,  8 Jan 2019 14:26:16 -0500
Message-Id: <20190108192628.121270-108-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108192628.121270-1-sashal@kernel.org>
References: <20190108192628.121270-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

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

