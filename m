Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2567C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4B502081B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549896569;
	bh=Y5Kfbjt71kl81IKVqmEnx3Z3aOJcv+cMiUTwR7NFYLM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WoXc+CYEdHuMf5a5vhJLW2a+n7QA33oWkfVoFscUVE1gPi+7+4tVZ5N1k3/IQeHwB
	 joXaDmEw8lCwCriqbZBCvLDooWN2QN7vKkX2Zfio0rTmxpveU1DqzGu6XdVgisg2PZ
	 u9UooAQ0VHZR61tPXs/Ak5WE3Jb881iKV+99lHGI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387892AbfBKOt2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:49:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:34966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733158AbfBKOtY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:49:24 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED14820700;
        Mon, 11 Feb 2019 14:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896564;
        bh=Y5Kfbjt71kl81IKVqmEnx3Z3aOJcv+cMiUTwR7NFYLM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1WekbdXwKklmP8QNy2lurFCpgn7pK5D8pLGz04QokBEwH8bZDIXoEqczWiMzfGxZa
         yU/myu16UGk2w7yClgJOooYTeRWEIg1Tgmz5s4HdaRV8Hliykt5AzlL0vzCOpA5PHi
         jH0IEHW1S6iHfPnoO7m9XvkCdkMa8ceLAnyMdbSo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 186/313] powerpc/perf: Fix thresholding counter data for unknown type
Date:   Mon, 11 Feb 2019 15:17:46 +0100
Message-Id: <20190211141905.709790095@linuxfoundation.org>
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



