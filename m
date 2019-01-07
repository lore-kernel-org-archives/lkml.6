Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F9A6C43444
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31DFE2089F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546866017;
	bh=iDxUVQ9DalKJXlyLRZHJARgVSGnCC0tif0P9vwbo2mo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=s7XIRDIXntEPX09WF+f3Fc/uRnWr+3Xdf01g9i9wVJw/uK3y8uhoBk7ajWR9dhSeu
	 cRJXOju1ApVMThGbaefhrLShRyFjUxn2zTGELhNgCTVVoGtS5v4MbyBoAE8FhOELtD
	 Vw9wsagGZb3WxgU0p+FP2eDHiDeO9xfaF24gAtCQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730421AbfAGNAQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:00:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:46836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730132AbfAGM7L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:59:11 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82BDC2089F;
        Mon,  7 Jan 2019 12:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865951;
        bh=iDxUVQ9DalKJXlyLRZHJARgVSGnCC0tif0P9vwbo2mo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wclDv/MjkI2n3XgI/jNsayR6598bo8qeKyPO7wF99HsHimWj1PmrMckS665valBhN
         T/6TNFm/2gX3D5Fc0deM1IlvFhJpCCiQehuAaWdORa/e7YVM4uscQFHv2Hb9jHDicU
         9O0lGlZQ1qotxKDx3cxTKlybHy1v/KxQ8TkxI+to=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH 4.19 167/170] iommu/arm-smmu-v3: Fix big-endian CMD_SYNC writes
Date:   Mon,  7 Jan 2019 13:33:14 +0100
Message-Id: <20190107104512.680041031@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104452.953560660@linuxfoundation.org>
References: <20190107104452.953560660@linuxfoundation.org>
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
@@ -837,7 +837,13 @@ static int arm_smmu_cmdq_build_cmd(u64 *
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


