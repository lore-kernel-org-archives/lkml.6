Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89FDAC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B7C820866
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:26:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="L2L6iUZB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B7C820866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729188AbeJPMCp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:02:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:50782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729132AbeJPMCo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:02:44 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 697762098A;
        Tue, 16 Oct 2018 04:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539663262;
        bh=k3ZfTnkMJGDLoOgZJtCBHdwamiGYVfLsTTbmg8naCXA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L2L6iUZBjEfGaRTlbDR6P2y/0ymdHGnF8nZ8CcJjbIndMW7+gQa3utusPEUWIPbnl
         i/nMmIkdAwCb2nJ6iprvqVhki6yxq/eHo+9iq3uZ8zk7NCZtEAxuV7Sd7DJ9LOJq70
         x8N0EtA/AdRgcnKQ0WQu2xtBReu0Xj8dBc+zOCh8=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Li Yang <leoyang.li@nxp.com>, Olof Johansson <olof@lixom.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 19/61] soc: fsl: qbman: qman: avoid allocating from non existing gen_pool
Date:   Tue, 16 Oct 2018 00:13:21 -0400
Message-Id: <20181016041403.135678-19-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181016041403.135678-1-sashal@kernel.org>
References: <20181016041403.135678-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

[ Upstream commit 64e9e22e68512da8df3c9a7430f07621e48db3c2 ]

If the qman driver didn't probe, calling qman_alloc_fqid_range,
qman_alloc_pool_range or qman_alloc_cgrid_range (as done in dpaa_eth) will
pass a NULL pointer to gen_pool_alloc, leading to a NULL pointer
dereference.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Reviewed-by: Roy Pledge <roy.pledge@nxp.com>
Signed-off-by: Li Yang <leoyang.li@nxp.com>
(cherry picked from commit f72487a2788aa70c3aee1d0ebd5470de9bac953a)
Signed-off-by: Olof Johansson <olof@lixom.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/fsl/qbman/qman.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/soc/fsl/qbman/qman.c b/drivers/soc/fsl/qbman/qman.c
index 0c6065dba48a..4f27e95efcdd 100644
--- a/drivers/soc/fsl/qbman/qman.c
+++ b/drivers/soc/fsl/qbman/qman.c
@@ -2699,6 +2699,9 @@ static int qman_alloc_range(struct gen_pool *p, u32 *result, u32 cnt)
 {
 	unsigned long addr;
 
+	if (!p)
+		return -ENODEV;
+
 	addr = gen_pool_alloc(p, cnt);
 	if (!addr)
 		return -ENOMEM;
-- 
2.17.1

