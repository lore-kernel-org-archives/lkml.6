Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E60DAC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB6F521902
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545863885;
	bh=VTLAqJOaD43ZSkCeE5iDEgcm5jC13L+GSBaF6zPWC5s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CXqZ/TznrsVYY6n/Dbd1I3y+rJRmBhyf3Lo6J2H978pA/SiV6T/oMuQRD6eVbB6jA
	 d2Mlx20D3QaiFXn2J8fBCdBzpDS8+hPhXxaw2Gaue6Jb1AC1yQNd71+iAXGMQ+1SHm
	 fldZfxr1Owk3paKEJrTjCAvfT6ipMujzGFIIUxVw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728644AbeLZWiF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 17:38:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:38210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728610AbeLZWiC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:38:02 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDEB8218EA;
        Wed, 26 Dec 2018 22:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545863881;
        bh=VTLAqJOaD43ZSkCeE5iDEgcm5jC13L+GSBaF6zPWC5s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gUFRNykbIssc3q2a1J2S4Q+jIh4QDpETPQhQy0msRb0rYGxeTm2bEJrqyABcCrjLM
         +4W5LsbgF4D3CuEhzCTkAMDrZuKWytfi/KFWszprfGcXiKVDTmd0Y8gYThlT+KdYU/
         f4wCm5qHGtWSY0r9jhSp2lMGlC9KKtrO5u7kM6Gg=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 71/97] net: stmmac: Fix an error code in probe()
Date:   Wed, 26 Dec 2018 17:35:31 -0500
Message-Id: <20181226223557.149329-71-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181226223557.149329-1-sashal@kernel.org>
References: <20181226223557.149329-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit b26322d2ac6c1c1087af73856531bb836f6963ca ]

The function should return an error if create_singlethread_workqueue()
fails.

Fixes: 34877a15f787 ("net: stmmac: Rework and fix TX Timeout code")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 99ea5c4ce29c..2103b865726a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4247,6 +4247,7 @@ int stmmac_dvr_probe(struct device *device,
 	priv->wq = create_singlethread_workqueue("stmmac_wq");
 	if (!priv->wq) {
 		dev_err(priv->device, "failed to create workqueue\n");
+		ret = -ENOMEM;
 		goto error_wq;
 	}
 
-- 
2.19.1

