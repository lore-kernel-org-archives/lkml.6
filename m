Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F4FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49C5A21848
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551129767;
	bh=mm51dNfXc9+z2V3WwpGtWscmNmR5yCGvNtvUvNlFQZk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bVfZ8nxWlxx5h0+Z4QVxdzVFHNfEMYNxrM65jztsKA/FPVvBkFza4iQMJy5McetIL
	 Bp0GohhJ1iZYMQeUicI5lxqvDkEkcb2GU9SflSaAPW3IPPQtMgpgK6AqMmctI0U/wr
	 eKkC3RgD5B3mYKI1pJWTN6q21D/bda9ZVcE9nDaY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730959AbfBYVWp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:22:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:56982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730940AbfBYVWm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:22:42 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74BBC21848;
        Mon, 25 Feb 2019 21:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129762;
        bh=mm51dNfXc9+z2V3WwpGtWscmNmR5yCGvNtvUvNlFQZk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ncw4Z1iVIBo98AsKwKU1gYHCAHhcC7UZdW9t3RfiTsQpFdWxlVM40CcdnBdr1RKka
         ULTrugGqJUBI3OFRgRGQUyGKZ5DK8l9DA4Ck9+cUIw00eX+ignKFEDvnWAhZ+5dTr8
         7ubQ7ZmfC93GNK7ATMU/26e17vUZwDO18TvbN/4c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 058/152] powerpc/8xx: fix setting of pagetable for Abatron BDI debug tool.
Date:   Mon, 25 Feb 2019 22:10:50 +0100
Message-Id: <20190225195047.506694877@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195043.645958524@linuxfoundation.org>
References: <20190225195043.645958524@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
index 81d4574d1f377..9fd2ff28b8ff2 100644
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



