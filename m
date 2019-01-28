Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCFF3C282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC48B2175B
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548697798;
	bh=SE5XHf8psLDSx7qAgqaDon89x3npjd+p28AjjTYIwuk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dRRyGMSd011T+q6NWWrbTdNdk2KT7HD8karlqfMLC3tqdIM1FE8raK4rVNOzLfeye
	 9TKpB697eD8qttc7BZM2ZPUUkvBbyIZVZ4SGw0NB52PST0RxiBMABz+VKhF1fxUJSX
	 f6EnS0ZVrd9AV8hiS9FwUHMCS8UrSN284FbIcR9Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbfA1Rt4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:49:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:58314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727587AbfA1Po4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:44:56 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D2142147A;
        Mon, 28 Jan 2019 15:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690296;
        bh=SE5XHf8psLDSx7qAgqaDon89x3npjd+p28AjjTYIwuk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X3dbk8dYo5g+kpABB4Y/ek7aHEmXJbyh6ilQfJNbpZzTsPy33J20rI/EgQavvDlDQ
         KkeCVtmLqsmsrnkKUkthKHlZVd8BecS5FtEFEhBvs+2leAGsv8/fXY/U4U0Zk+Kb+l
         4eQHk2WZDHiLDQAWQ+vkyZhXd1qWV0I/niu88BrI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ioana Ciornei <ioana.ciornei@nxp.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 038/304] dpaa2-ptp: defer probe when portal allocation failed
Date:   Mon, 28 Jan 2019 10:39:15 -0500
Message-Id: <20190128154341.47195-38-sashal@kernel.org>
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

From: Ioana Ciornei <ioana.ciornei@nxp.com>

[ Upstream commit 5500598abbfb5b46201b9768bd9ea873a5eeaece ]

The fsl_mc_portal_allocate can fail when the requested MC portals are
not yet probed by the fsl_mc_allocator. In this situation, the driver
should defer the probe.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/freescale/dpaa2/dpaa2-ptp.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-ptp.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-ptp.c
index 84b942b1eccc..9b150db3b510 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-ptp.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-ptp.c
@@ -140,7 +140,10 @@ static int dpaa2_ptp_probe(struct fsl_mc_device *mc_dev)
 
 	err = fsl_mc_portal_allocate(mc_dev, 0, &mc_dev->mc_io);
 	if (err) {
-		dev_err(dev, "fsl_mc_portal_allocate err %d\n", err);
+		if (err == -ENXIO)
+			err = -EPROBE_DEFER;
+		else
+			dev_err(dev, "fsl_mc_portal_allocate err %d\n", err);
 		goto err_exit;
 	}
 
-- 
2.19.1

