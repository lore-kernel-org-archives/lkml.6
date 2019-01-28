Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E4EAC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FFB021927
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548691349;
	bh=Bxa89QOkNkRSADIzZ11duJ7gv7guCurt3wYLSWR4czw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XcHYRDF/utp7nwiBmhYZjJekjxpCwZXjuifdfCwfSHzACaW30SaL0/KzYSIJo/Tje
	 G8ZGqlQzCpl/HGj8mWBvbWXIE9iPlP0HnJmHMGK3UUr20V9C3f/37mThEuhEF3IaXQ
	 rRi9Nw14KtXj7XR6hFImBVdmmqfpId1Yg+VfKsb8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731227AbfA1QC1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:02:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:47736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730192AbfA1QCZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:02:25 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BED8E21919;
        Mon, 28 Jan 2019 16:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691345;
        bh=Bxa89QOkNkRSADIzZ11duJ7gv7guCurt3wYLSWR4czw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iXgAVzNAE6uBxGk6JEF5IB2SvxczOUVU+dJB5AHKs+BdSMIIAqsvECynSYOORFUVr
         uqi9Glh20cM5z/mYP2pYjszq+VCcgh+lRhVYrDijtjPQrnASPOkF+H5mrSCpMEtMST
         teW0TTxlaOs0f+d3J0vL/msLDc62iiQXPrc/d45M=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     YueHaibing <yuehaibing@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 063/258] ptp: Fix pass zero to ERR_PTR() in ptp_clock_register
Date:   Mon, 28 Jan 2019 10:56:09 -0500
Message-Id: <20190128155924.51521-63-sashal@kernel.org>
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

From: YueHaibing <yuehaibing@huawei.com>

[ Upstream commit aea0a897af9e44c258e8ab9296fad417f1bc063a ]

Fix smatch warning:

drivers/ptp/ptp_clock.c:298 ptp_clock_register() warn:
 passing zero to 'ERR_PTR'

'err' should be set while device_create_with_groups and
pps_register_source fails

Fixes: 85a66e550195 ("ptp: create "pins" together with the rest of attributes")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Acked-by: Richard Cochran <richardcochran@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ptp/ptp_clock.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index 7eacc1c4b3b1..c64903a5978f 100644
--- a/drivers/ptp/ptp_clock.c
+++ b/drivers/ptp/ptp_clock.c
@@ -253,8 +253,10 @@ struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
 	ptp->dev = device_create_with_groups(ptp_class, parent, ptp->devid,
 					     ptp, ptp->pin_attr_groups,
 					     "ptp%d", ptp->index);
-	if (IS_ERR(ptp->dev))
+	if (IS_ERR(ptp->dev)) {
+		err = PTR_ERR(ptp->dev);
 		goto no_device;
+	}
 
 	/* Register a new PPS source. */
 	if (info->pps) {
@@ -265,6 +267,7 @@ struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
 		pps.owner = info->owner;
 		ptp->pps_source = pps_register_source(&pps, PTP_PPS_DEFAULTS);
 		if (!ptp->pps_source) {
+			err = -EINVAL;
 			pr_err("failed to register pps source\n");
 			goto no_pps;
 		}
-- 
2.19.1

