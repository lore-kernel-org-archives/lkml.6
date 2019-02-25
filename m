Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FCE4C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C929420652
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551131008;
	bh=zSHqYzCpNGCjxSHHJvxfQMpe2kpxJfS+xlnROvQ0LoM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rcuYw4JwvCW3kjNudQOYrT3AE55Me0/wfcc2wYwBvT9X6Pcvs93afM/d8UPdnyFlP
	 4yeYKh4uVeoqkVj65NEqnH4Bq19l975fGymnj0bTjJQ0Z4M7+YoiivUStAZkoROYRS
	 RVN8U65cksz6E+KljCjjgNUreJhIknBCp6OvEVKs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732279AbfBYVbT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:31:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:36814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732264AbfBYVbM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:31:12 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 287A2217F5;
        Mon, 25 Feb 2019 21:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130271;
        bh=zSHqYzCpNGCjxSHHJvxfQMpe2kpxJfS+xlnROvQ0LoM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hwhL0dc/BRb4VAp2O0hFDSLcTj4pz101iA4uxF41uMmT4/m9tO7JI3yR6WTyliYIL
         VGPpcgpSKcgtevG7q/SSs31CrmVM+P4xG/PM6uTs2DV3T6oSm1m6F42LHunh1hE+/e
         cnE5d6HDhU3U0guXoPq4NZ0CSePgJ8uFmSPJYkPs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 069/183] powerpc/8xx: fix setting of pagetable for Abatron BDI debug tool.
Date:   Mon, 25 Feb 2019 22:10:42 +0100
Message-Id: <20190225195106.146133238@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195054.748060397@linuxfoundation.org>
References: <20190225195054.748060397@linuxfoundation.org>
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
index 3b67b9533c82f..438512759e827 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -927,11 +927,12 @@ start_here:
 
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



