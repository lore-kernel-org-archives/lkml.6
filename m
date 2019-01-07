Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B108BC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82AEE21873
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546865117;
	bh=YmJC1Rz6n37un4lozmeKL4IOaLoK2csD3kk0FAxjE0A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xSZVImA0D+ldvn1E/BjwzOEl/u0RcAXBnRG9iLhQB9ghYpAFpp1MFoxcpVIGeTAsp
	 2PxrGYzKXCOcVGtFqO0IidplJXsqfs3jxt4cOkU0IjntjUl/0GZt0Xd6RNq/9wf6Md
	 9J6Tp1llE6bYcK0IHHpErCx+tUuJhK1bFlS7JOHY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728837AbfAGMpQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:45:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:34330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728817AbfAGMpO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:45:14 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F96D218A1;
        Mon,  7 Jan 2019 12:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865113;
        bh=YmJC1Rz6n37un4lozmeKL4IOaLoK2csD3kk0FAxjE0A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nL4igtEIUNRoNg1DTd9jwYxJjLKONVhsG+TSVa6ZWyn51tc/LzvWNJFKAhXBYRKrv
         2Yl8rP92q9gPaI618x1T1Cq3Abe4K5j3Hp4hCxGmsEZSv7Y0eEx+pJ2GC/B6xuRzd7
         x7odE2cdijDByzcfYAQx/01xaBWHunIiOLCTvA7A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH 4.20 140/145] iommu/arm-smmu-v3: Fix big-endian CMD_SYNC writes
Date:   Mon,  7 Jan 2019 13:32:57 +0100
Message-Id: <20190107104455.495848640@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104437.308206189@linuxfoundation.org>
References: <20190107104437.308206189@linuxfoundation.org>
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

From: Robin Murphy <robin.murphy@arm.com>

commit 3cd508a8c1379427afb5e16c2e0a7c986d907853 upstream.

When we insert the sync sequence number into the CMD_SYNC.MSIData field,
we do so in CPU-native byte order, before writing out the whole command
as explicitly little-endian dwords. Thus on big-endian systems, the SMMU
will receive and write back a byteswapped version of sync_nr, which would
be perfect if it were targeting a similarly-little-endian ITS, but since
it's actually writing back to memory being polled by the CPUs, they're
going to end up seeing the wrong thing.

Since the SMMU doesn't care what the MSIData actually contains, the
minimal-overhead solution is to simply add an extra byteswap initially,
such that it then writes back the big-endian format directly.

Cc: <stable@vger.kernel.org>
Fixes: 37de98f8f1cf ("iommu/arm-smmu-v3: Use CMD_SYNC completion MSI")
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iommu/arm-smmu-v3.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -828,7 +828,13 @@ static int arm_smmu_cmdq_build_cmd(u64 *
 			cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_CS, CMDQ_SYNC_0_CS_SEV);
 		cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_MSH, ARM_SMMU_SH_ISH);
 		cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_MSIATTR, ARM_SMMU_MEMATTR_OIWB);
-		cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_MSIDATA, ent->sync.msidata);
+		/*
+		 * Commands are written little-endian, but we want the SMMU to
+		 * receive MSIData, and thus write it back to memory, in CPU
+		 * byte order, so big-endian needs an extra byteswap here.
+		 */
+		cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_MSIDATA,
+				     cpu_to_le32(ent->sync.msidata));
 		cmd[1] |= ent->sync.msiaddr & CMDQ_SYNC_1_MSIADDR_MASK;
 		break;
 	default:


