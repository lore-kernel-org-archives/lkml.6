Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 314B1C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA792222C9
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550025508;
	bh=8KbKkTtGVpj7XQj+rMMhi+AEp0Y5WGBpMuL5NYrW6O4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VrP2wwHG1iJMp5PHztWK3d7/yOBD8OdgV1Pf0jjkcDuFy6n6/KevSRvjvGVaam7sY
	 WoQa2JyD4NyRt9/kShR2R0KAFdkApn53qo9P+dF2HQZbdwJximGpOrBx8tQ2OwV1bC
	 j7WwHOpdedWrVOQfRqO0WsHeJjb40nRa9KrXRtXc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732704AbfBMCi0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:38:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:41776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730629AbfBMCiQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:38:16 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6CD8206B6;
        Wed, 13 Feb 2019 02:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025495;
        bh=8KbKkTtGVpj7XQj+rMMhi+AEp0Y5WGBpMuL5NYrW6O4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m2UI/OOJXUKuXnC3Bg4U2JVKlQlALKWFpdIDjKFxP22nmlowW5il5ywLmhvhCsT0O
         SKTWez6Ybn2FxVHWNDUKIY8jj4nREgfSVL1H2tePXe2s6hp2ki+iYd2Ipv/F+1sP/v
         9AmptlnODtDgEvyBX0svN4XTBw48sEnjxUNM+pDo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 4.19 43/83] powerpc/8xx: fix setting of pagetable for Abatron BDI debug tool.
Date:   Tue, 12 Feb 2019 21:36:21 -0500
Message-Id: <20190213023701.20286-43-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213023701.20286-1-sashal@kernel.org>
References: <20190213023701.20286-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe Leroy <christophe.leroy@c-s.fr>

[ Upstream commit fb0bdec51a4901b7dd088de0a1e365e1b9f5cd21 ]

Commit 8c8c10b90d88 ("powerpc/8xx: fix handling of early NULL pointer
dereference") moved the loading of r6 earlier in the code. As some
functions are called inbetween, r6 needs to be loaded again with the
address of swapper_pg_dir in order to set PTE pointers for
the Abatron BDI.

Fixes: 8c8c10b90d88 ("powerpc/8xx: fix handling of early NULL pointer dereference")
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kernel/head_8xx.S | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 81d4574d1f37..9fd2ff28b8ff 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -919,11 +919,12 @@ start_here:
 
 	/* set up the PTE pointers for the Abatron bdiGDB.
 	*/
-	tovirt(r6,r6)
 	lis	r5, abatron_pteptrs@h
 	ori	r5, r5, abatron_pteptrs@l
 	stw	r5, 0xf0(0)	/* Must match your Abatron config file */
 	tophys(r5,r5)
+	lis	r6, swapper_pg_dir@h
+	ori	r6, r6, swapper_pg_dir@l
 	stw	r6, 0(r5)
 
 /* Now turn on the MMU for real! */
-- 
2.19.1

