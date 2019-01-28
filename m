Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 990D8C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D3AE2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548691716;
	bh=bsxIhv6WSxRd8h1ynzWvtplwQb6L1ku+lHK8qpuyVE8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Tb2mh7JN/yLYjGsTtlDrmgLRrN1WrjZh4vHwVruzGCUjLUGiSxYafwiTZesO6lec1
	 a1XbvdmlSDt5M66Zm3mfDmoGtIJDhhIbdv8s8oElqCyhcdNjdls4ItzDXFve0JBIXt
	 zdJNE/khXdmCwnSlzSIMOOlM4/h3hKxfxb9CQG50=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732425AbfA1QIf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:08:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:60518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732010AbfA1QIe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:08:34 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50B3B2147A;
        Mon, 28 Jan 2019 16:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691713;
        bh=bsxIhv6WSxRd8h1ynzWvtplwQb6L1ku+lHK8qpuyVE8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SyvH5iAYUDlGEphoBfHSQIYJC3U6ft/7Z/OBkvSxTIq5IdV3LUQL8a9qQICbBrqa+
         xyaaWr1CmVB43p1CJr4loExMhHc9fTRX1r0QKF1GSQ0YYsG/m/eufFXndI1Ocwq2uo
         DLQFIF3Lmt6Ty1nCiFOgX1BxWGO6zZxvYag1PJTc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 4.19 195/258] powerpc/perf: Fix thresholding counter data for unknown type
Date:   Mon, 28 Jan 2019 10:58:21 -0500
Message-Id: <20190128155924.51521-195-sashal@kernel.org>
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

From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>

[ Upstream commit 17cfccc91545682513541924245abb876d296063 ]

MMCRA[34:36] and MMCRA[38:44] expose the thresholding counter value.
Thresholding counter can be used to count latency cycles such as
load miss to reload. But threshold counter value is not relevant
when the sampled instruction type is unknown or reserved. Patch to
fix the thresholding counter value to zero when sampled instruction
type is unknown or reserved.

Fixes: 170a315f41c6('powerpc/perf: Support to export MMCRA[TEC*] field to userspace')
Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/perf/isa207-common.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/perf/isa207-common.c b/arch/powerpc/perf/isa207-common.c
index 177de814286f..6a2f65d3d088 100644
--- a/arch/powerpc/perf/isa207-common.c
+++ b/arch/powerpc/perf/isa207-common.c
@@ -226,8 +226,13 @@ void isa207_get_mem_weight(u64 *weight)
 	u64 mmcra = mfspr(SPRN_MMCRA);
 	u64 exp = MMCRA_THR_CTR_EXP(mmcra);
 	u64 mantissa = MMCRA_THR_CTR_MANT(mmcra);
+	u64 sier = mfspr(SPRN_SIER);
+	u64 val = (sier & ISA207_SIER_TYPE_MASK) >> ISA207_SIER_TYPE_SHIFT;
 
-	*weight = mantissa << (2 * exp);
+	if (val == 0 || val == 7)
+		*weight = 0;
+	else
+		*weight = mantissa << (2 * exp);
 }
 
 int isa207_get_constraint(u64 event, unsigned long *maskp, unsigned long *valp)
-- 
2.19.1

