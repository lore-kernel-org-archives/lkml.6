Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B19C282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D76AE2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548696981;
	bh=bsxIhv6WSxRd8h1ynzWvtplwQb6L1ku+lHK8qpuyVE8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gp2TAQjV4oor7y72SfWk5yJFzTC9YGjwoSjlduZsObk5hhtS1pJkolrGBy3/TlbL0
	 VsWMKFiN8K3Rbf7O80tYfP8+D3cFvKx53B75FrbQsOIRlM8MMaLeTm+iFsk0B6laJz
	 MSONc9fntzQfIoI67KUiwsk1skHx9X4EtffbL0Oo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730812AbfA1RgU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:36:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:41180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729851AbfA1PzN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:55:13 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B20920989;
        Mon, 28 Jan 2019 15:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690913;
        bh=bsxIhv6WSxRd8h1ynzWvtplwQb6L1ku+lHK8qpuyVE8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R8l7CT3m4U/tH5jf1GTPxxScceK8KEYnT0O0xm7d7ElCDxjkGjJ9VchXUyIYSONHd
         JorKWm4/P5K+ByfZnNihQlNTB/tQwtUC0aAL3jetsHW6jU0GZbB4fhBFJYRVdwL3fi
         6caKeF6in/WjLUmOtTnHpy8jQAtDiOax8KXaaHcE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 4.20 233/304] powerpc/perf: Fix thresholding counter data for unknown type
Date:   Mon, 28 Jan 2019 10:42:30 -0500
Message-Id: <20190128154341.47195-233-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
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

