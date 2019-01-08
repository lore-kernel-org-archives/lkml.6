Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 672C1C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C9DE20660
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546977536;
	bh=0AlTjQqK+uPi0Cm75wSlmaonb8yASqHjdCao1vhi/LM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JhC9aOszSEARQH18o9VmLPmn0UZRkU3NhaiFJElTU65Pt7UzJdXQW38lqRKRdxkTw
	 0ltDuXOPO8Eh+oslSIkMtupoxmoNDRVmvR0neDShD4Q6uPw7fvKM8aL58sMjLIdIfL
	 LIJ2bOUxT33zLuG7nzXG4xiYtW4hAb5LYPVQCqMc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732813AbfAHT6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:58:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:36836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730367AbfAHT30 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:29:26 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3ED62176F;
        Tue,  8 Jan 2019 19:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546975765;
        bh=0AlTjQqK+uPi0Cm75wSlmaonb8yASqHjdCao1vhi/LM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IVVgYwidPfnd2oh2JHC7XOj4ZVOBHfE7tlamvBln8MAVfUEuzV2xNlgYhcezup9Gg
         9CArMYa4GnSc+pNIKolhHfTRt/vNFoKxpyw9Ur+sP785UnVE6vA0PgZMOSNMxoxA4V
         D62mfjEbNxdzGO1ognbUNo8Z3xoz+4r1pZgnQkzs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Sasha Levin <sashal@kernel.org>, kvm-ppc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 4.20 107/117] KVM: PPC: Book3S HV: Align gfn to L1 page size when inserting nest-rmap entry
Date:   Tue,  8 Jan 2019 14:26:15 -0500
Message-Id: <20190108192628.121270-107-sashal@kernel.org>
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

[ Upstream commit 8400f8740651c1a3081c30b46004451c448f4d5f ]

Nested rmap entries are used to store the translation from L1 gpa to L2
gpa when entries are inserted into the shadow (nested) page tables. This
rmap list is located by indexing the rmap array in the memslot by L1
gfn. When we come to search for these entries we only know the L1 page size
(which could be PAGE_SIZE, 2M or a 1G page) and so can only select a gfn
aligned to that size. This means that when we insert the entry, so we can
find it later, we need to align the gfn we use to select the rmap list
in which to insert the entry to L1 page size as well.

By not doing this we were missing nested rmap entries when modifying L1
ptes which were for a page also passed through to an L2 guest.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kvm/book3s_hv_nested.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/kvm/book3s_hv_nested.c b/arch/powerpc/kvm/book3s_hv_nested.c
index 401d2ecbebc5..fc64535e4c00 100644
--- a/arch/powerpc/kvm/book3s_hv_nested.c
+++ b/arch/powerpc/kvm/book3s_hv_nested.c
@@ -1220,6 +1220,8 @@ static long int __kvmhv_nested_page_fault(struct kvm_vcpu *vcpu,
 			return ret;
 		shift = kvmppc_radix_level_to_shift(level);
 	}
+	/* Align gfn to the start of the page */
+	gfn = (gpa & ~((1UL << shift) - 1)) >> PAGE_SHIFT;
 
 	/* 3. Compute the pte we need to insert for nest_gpa -> host r_addr */
 
-- 
2.19.1

