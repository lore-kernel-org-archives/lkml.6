Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91055C282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 538FA20989
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548691728;
	bh=JDDUV0KKYNt7q1gDb0bK78KXVMEp4pemqksnRIQr3OE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UGmxqoTk84+FkciZEEy9B2mBkhS3vJR4GbxRTubrnbUihCnVSHtJKGVL2Y3fzn6s3
	 s8GzzvPHtLebIWgUnZneIB5noWS1J60L8v8S2oHzTR5/k+FFUcsbqB2ArX/6bHmr7e
	 4NBXSITTOfek/JZj3JkC/NzaHfJ2EiR7PrJWSBJA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731804AbfA1QIq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:08:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:60838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732461AbfA1QIo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:08:44 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A51E720989;
        Mon, 28 Jan 2019 16:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691723;
        bh=JDDUV0KKYNt7q1gDb0bK78KXVMEp4pemqksnRIQr3OE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=APs4goYU60Atqh5WP+p1GnqCxiFhOmSptjbLjJhEdpOa2XVow/aqWZgPD9/mzPLHb
         3uF928RQsAjccBbeV5AHnTB8EYGGfi8nhEuFWjto+sXgve62OpeBC/RIT8Rz3xHCZY
         a3kDS9Ntn+uq9+8Ny00eJYqC4K5eG1E1tDMfounk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alexey Kardashevskiy <aik@ozlabs.ru>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 4.19 197/258] powerpc/powernv/ioda: Allocate indirect TCE levels of cached userspace addresses on demand
Date:   Mon, 28 Jan 2019 10:58:23 -0500
Message-Id: <20190128155924.51521-197-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128155924.51521-1-sashal@kernel.org>
References: <20190128155924.51521-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexey Kardashevskiy <aik@ozlabs.ru>

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

