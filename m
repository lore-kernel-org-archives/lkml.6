Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57EB0C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E377218D8
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549900846;
	bh=eVSrLyBNHN/ekAFuXPZeX6v0b2Mx5XNx46IeyAT7Jfg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NtaIYwC1ghBnjEudUUKQ/Oytuo1y2F2O2Xv9A4DrqQtOlUvkV9Q3lxa5GgLH8lpLL
	 OyaiJmrsP7KJJVoS5gUBy9/VIkMQq+lBoIcwLFC+kGKkVBUzSwcFD3nYReOFC2xfk8
	 /2iFj3irlTrm3wUZ8OpReFMSpdy/dfpmMB+UMwyg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387438AbfBKQAo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 11:00:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:38480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730299AbfBKObb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:31:31 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03B1120675;
        Mon, 11 Feb 2019 14:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895491;
        bh=eVSrLyBNHN/ekAFuXPZeX6v0b2Mx5XNx46IeyAT7Jfg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JQglVNMq9SQyPhgUafl5BVmNbRo4JqZ6nQaxEaR22Ob3/qmmDwhqMJVDEG/jtBgCU
         qiLmEEBXA5ej+6Si7wiXBjITrxmgfdipAXg2xD7KdxvCm+r06m4nMOc7ZLIv76xsPK
         wmLVS3x4ZrTak+oQU8Ok4TckqvUVh0c6XzncPogA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
        David Gibson <david@gibson.dropbear.id.au>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 223/352] powerpc/powernv/ioda: Allocate indirect TCE levels of cached userspace addresses on demand
Date:   Mon, 11 Feb 2019 15:17:30 +0100
Message-Id: <20190211141901.424947442@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
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



