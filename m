Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C5AC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4C0D206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549896506;
	bh=EteUcmkwiFCfQdF0H23V1JrrB+uD5EW1qMSor6MrQWI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xFoPuRiSjkQGSG5EMpKmwKt6Yh5w4eW9KFCo0hzioyZFoHqop6PIXMMG+W1wmvfQi
	 l3ztmwoD8AY6C5DIyGeH/uEnKXgVSBvFGppdZqZsn2O3snjgrRI1xh5BnE9CMp+ps+
	 d4uAk3VBxL8UUaJGouySNlfnFIA+1D5li+KAw4tA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387680AbfBKOsZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:48:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:33650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729067AbfBKOsX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:48:23 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB4B9206BA;
        Mon, 11 Feb 2019 14:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896503;
        bh=EteUcmkwiFCfQdF0H23V1JrrB+uD5EW1qMSor6MrQWI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AKsbsr2AUWHV/2fXRDTIU4dULjiDz3gyfaIpc2xpQVoqfWafder69mGBoKUzgEbQt
         EUVoO/rq8KEvCr7/aBOptoCV9Yx71sE8XIn7fKhE3yQ9z3YQzM2huHc1UnYrP/jRB2
         LFdU4zuQ9tUiXALeXKqm2+hi9ig4QqQx49Vsno1c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
        David Gibson <david@gibson.dropbear.id.au>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 188/313] powerpc/powernv/ioda: Allocate indirect TCE levels of cached userspace addresses on demand
Date:   Mon, 11 Feb 2019 15:17:48 +0100
Message-Id: <20190211141905.823167304@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
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

[ Upstream commit bdbf649efe21173cae63b4b71db84176420f9039 ]

The powernv platform maintains 2 TCE tables for VFIO - a hardware TCE
table and a table with userspace addresses; the latter is used for
marking pages dirty when corresponging TCEs are unmapped from
the hardware table.

a68bd1267b72 ("powerpc/powernv/ioda: Allocate indirect TCE levels
on demand") enabled on-demand allocation of the hardware table,
however it missed the other table so it has still been fully allocated
at the boot time. This fixes the issue by allocating a single level,
just like we do for the hardware table.

Fixes: a68bd1267b72 ("powerpc/powernv/ioda: Allocate indirect TCE levels on demand")
Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/platforms/powernv/pci-ioda-tce.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda-tce.c b/arch/powerpc/platforms/powernv/pci-ioda-tce.c
index fe9691040f54..7639b2168755 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda-tce.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda-tce.c
@@ -299,7 +299,7 @@ long pnv_pci_ioda2_table_alloc_pages(int nid, __u64 bus_offset,
 	if (alloc_userspace_copy) {
 		offset = 0;
 		uas = pnv_pci_ioda2_table_do_alloc_pages(nid, level_shift,
-				levels, tce_table_size, &offset,
+				tmplevels, tce_table_size, &offset,
 				&total_allocated_uas);
 		if (!uas)
 			goto free_tces_exit;
-- 
2.19.1



