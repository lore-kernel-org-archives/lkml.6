Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4077C282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 23:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A73D92147A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 23:34:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbfA1Xd7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 18:33:59 -0500
Received: from smtp.gentoo.org ([140.211.166.183]:57226 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726762AbfA1Xd7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 18:33:59 -0500
Received: from gentoo.cpe.tdp.com (unknown [181.67.136.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: chrisadr)
        by smtp.gentoo.org (Postfix) with ESMTPSA id D00E8335D40;
        Mon, 28 Jan 2019 23:33:51 +0000 (UTC)
From:   Christopher Diaz Riveros <chrisadr@gentoo.org>
To:     paulus@ozlabs.org, benh@kernel.crashing.org, mpe@ellerman.id.au
Cc:     Christopher Diaz Riveros <chrisadr@gentoo.org>,
        kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [patch-next] KVM: PPC: Book3S HV: Use kzalloc_node
Date:   Mon, 28 Jan 2019 18:33:09 -0500
Message-Id: <20190128233309.14447-1-chrisadr@gentoo.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes coccinelle warning:

/arch/powerpc/kvm/book3s_hv.c:5345:3-15: WARNING: kzalloc_node should be used for sibling_subcore_state, instead of kmalloc_node/memset

Signed-off-by: Christopher Diaz Riveros <chrisadr@gentoo.org>
---
 arch/powerpc/kvm/book3s_hv.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 5a066fc299e1..fc59bfa892c9 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -5342,14 +5342,11 @@ static int kvm_init_subcore_bitmap(void)
 			continue;
 
 		sibling_subcore_state =
-			kmalloc_node(sizeof(struct sibling_subcore_state),
+			kzalloc_node(sizeof(struct sibling_subcore_state),
 							GFP_KERNEL, node);
 		if (!sibling_subcore_state)
 			return -ENOMEM;
 
-		memset(sibling_subcore_state, 0,
-				sizeof(struct sibling_subcore_state));
-
 		for (j = 0; j < threads_per_core; j++) {
 			int cpu = first_cpu + j;
 
-- 
2.20.1

