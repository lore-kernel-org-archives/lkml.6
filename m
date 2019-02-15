Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD44DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC48721B68
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550196855;
	bh=2yXN3e1+gtEoUfmU1oXpS/9jnk4i43S5zK1XANFn1II=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WmHaf7Pgsx5B4VXJ0yuBkOUjmVLZ2A49B9pX3mr5O9IRcItMIv2KPuImrGcbXBVC5
	 BvLOW/9RiQk/VzvMMUkQqsh9BbWlR3ykMnvy0s35I3EUYGWDHr38n2lYvkdh2BQKCD
	 PEXQ7irfnIp8YNfUhGBbQdpUU3b/9AaYCbeeJitc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405119AbfBOCOM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:14:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:54044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405050AbfBOCOJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 21:14:09 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C55220643;
        Fri, 15 Feb 2019 02:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550196848;
        bh=2yXN3e1+gtEoUfmU1oXpS/9jnk4i43S5zK1XANFn1II=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FIP3Ff82Ujgs0xXFrjqZxZIKQv3hCJEOiI2zjeqPwnKhHf91mvvuc/kVQ99+1bS0u
         oc6/NRy2hV4uw2FCVZz0Pdqz4qmukI9au3Ky5Kr2Z4fPjkcSnSTHcG/ESjmYLJsjrI
         zXy1rq5xAmALuMsr6br2ulDj81tGMhDGZmBm6bag=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Haiyang Zhang <haiyangz@microsoft.com>,
        Sasha Levin <sashal@kernel.org>, devel@linuxdriverproject.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 30/40] hv_netvsc: Fix ethtool change hash key error
Date:   Thu, 14 Feb 2019 21:13:03 -0500
Message-Id: <20190215021313.178476-30-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215021313.178476-1-sashal@kernel.org>
References: <20190215021313.178476-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Haiyang Zhang <haiyangz@microsoft.com>

[ Upstream commit b4a10c750424e01b5e37372fef0a574ebf7b56c3 ]

Hyper-V hosts require us to disable RSS before changing RSS key,
otherwise the changing request will fail. This patch fixes the
coding error.

Fixes: ff4a44199012 ("netvsc: allow get/set of RSS indirection table")
Reported-by: Wei Hu <weh@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
[sl: fix up subject line]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/hyperv/rndis_filter.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/net/hyperv/rndis_filter.c b/drivers/net/hyperv/rndis_filter.c
index 17025d46bdac..fc1d5e14d83e 100644
--- a/drivers/net/hyperv/rndis_filter.c
+++ b/drivers/net/hyperv/rndis_filter.c
@@ -711,8 +711,8 @@ rndis_filter_set_offload_params(struct net_device *ndev,
 	return ret;
 }
 
-int rndis_filter_set_rss_param(struct rndis_device *rdev,
-			       const u8 *rss_key)
+static int rndis_set_rss_param_msg(struct rndis_device *rdev,
+				   const u8 *rss_key, u16 flag)
 {
 	struct net_device *ndev = rdev->ndev;
 	struct rndis_request *request;
@@ -741,7 +741,7 @@ int rndis_filter_set_rss_param(struct rndis_device *rdev,
 	rssp->hdr.type = NDIS_OBJECT_TYPE_RSS_PARAMETERS;
 	rssp->hdr.rev = NDIS_RECEIVE_SCALE_PARAMETERS_REVISION_2;
 	rssp->hdr.size = sizeof(struct ndis_recv_scale_param);
-	rssp->flag = 0;
+	rssp->flag = flag;
 	rssp->hashinfo = NDIS_HASH_FUNC_TOEPLITZ | NDIS_HASH_IPV4 |
 			 NDIS_HASH_TCP_IPV4 | NDIS_HASH_IPV6 |
 			 NDIS_HASH_TCP_IPV6;
@@ -766,9 +766,12 @@ int rndis_filter_set_rss_param(struct rndis_device *rdev,
 
 	wait_for_completion(&request->wait_event);
 	set_complete = &request->response_msg.msg.set_complete;
-	if (set_complete->status == RNDIS_STATUS_SUCCESS)
-		memcpy(rdev->rss_key, rss_key, NETVSC_HASH_KEYLEN);
-	else {
+	if (set_complete->status == RNDIS_STATUS_SUCCESS) {
+		if (!(flag & NDIS_RSS_PARAM_FLAG_DISABLE_RSS) &&
+		    !(flag & NDIS_RSS_PARAM_FLAG_HASH_KEY_UNCHANGED))
+			memcpy(rdev->rss_key, rss_key, NETVSC_HASH_KEYLEN);
+
+	} else {
 		netdev_err(ndev, "Fail to set RSS parameters:0x%x\n",
 			   set_complete->status);
 		ret = -EINVAL;
@@ -779,6 +782,16 @@ int rndis_filter_set_rss_param(struct rndis_device *rdev,
 	return ret;
 }
 
+int rndis_filter_set_rss_param(struct rndis_device *rdev,
+			       const u8 *rss_key)
+{
+	/* Disable RSS before change */
+	rndis_set_rss_param_msg(rdev, rss_key,
+				NDIS_RSS_PARAM_FLAG_DISABLE_RSS);
+
+	return rndis_set_rss_param_msg(rdev, rss_key, 0);
+}
+
 static int rndis_filter_query_device_link_status(struct rndis_device *dev,
 						 struct netvsc_device *net_device)
 {
-- 
2.19.1

