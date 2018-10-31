Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D2CECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D8F320664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:45:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SG9h+E7T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D8F320664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728990AbeKAIqP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:46:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:55074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728813AbeKAIHV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:07:21 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A48720830;
        Wed, 31 Oct 2018 23:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027231;
        bh=7ndQ0liK/ZwWE3jGzI/qgSNUSapHwibkmlzajcTlSTs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SG9h+E7TT2LPTwKj0CTjb0jLnT5OrMYo2SX1q9ZhPwyKGSN5UmPkqQ56QbmSOllwD
         d530VX1nHIgxYjKg3cBRSlkF6SH7OIZ1Ht6YqJXSQXeVKhsmeiuO2KouN0y204gOEf
         lHOEpq4+ks8IsVKTBoHM4mm5Cp4qSZITMcpNSuig=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 098/146] RDMA/cm: Respect returned status of cm_init_av_by_path
Date:   Wed, 31 Oct 2018 19:04:53 -0400
Message-Id: <20181031230541.28822-98-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230541.28822-1-sashal@kernel.org>
References: <20181031230541.28822-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

[ Upstream commit e54b6a3bcd1ec972b25a164bdf495d9e7120b107 ]

Add missing check for failure of cm_init_av_by_path

Fixes: e1444b5a163e ("IB/cm: Fix automatic path migration support")
Reported-by: Slava Shwartsman <slavash@mellanox.com>
Reviewed-by: Parav Pandit <parav@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/core/cm.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 6e39c27dca8e..4c533275d1f2 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -3292,8 +3292,11 @@ static int cm_lap_handler(struct cm_work *work)
 	if (ret)
 		goto unlock;
 
-	cm_init_av_by_path(param->alternate_path, NULL, &cm_id_priv->alt_av,
-			   cm_id_priv);
+	ret = cm_init_av_by_path(param->alternate_path, NULL,
+				 &cm_id_priv->alt_av, cm_id_priv);
+	if (ret)
+		goto unlock;
+
 	cm_id_priv->id.lap_state = IB_CM_LAP_RCVD;
 	cm_id_priv->tid = lap_msg->hdr.tid;
 	ret = atomic_inc_and_test(&cm_id_priv->work_count);
-- 
2.17.1

