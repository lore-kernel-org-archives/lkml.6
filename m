Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59DF1C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 00:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F58920659
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 00:53:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727660AbfAOAxn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 19:53:43 -0500
Received: from a2nlsmtp01-03.prod.iad2.secureserver.net ([198.71.225.37]:42166
        "EHLO a2nlsmtp01-03.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727529AbfAOAxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 19:53:40 -0500
Received: from linuxonhyperv2.linuxonhyperv.com ([107.180.71.197])
        by : HOSTING RELAY : with ESMTP
        id jCy7gIvJiD44TjCy7gDDXp; Mon, 14 Jan 2019 17:52:39 -0700
x-originating-ip: 107.180.71.197
Received: from haiyangz by linuxonhyperv2.linuxonhyperv.com with local (Exim 4.91)
        (envelope-from <haiyangz@linuxonhyperv2.linuxonhyperv.com>)
        id 1gjCy6-0001BI-Tn; Mon, 14 Jan 2019 17:52:38 -0700
From:   Haiyang Zhang <haiyangz@linuxonhyperv.com>
To:     sashal@kernel.org
Cc:     haiyangz@microsoft.com, kys@microsoft.com, sthemmin@microsoft.com,
        olaf@aepfle.de, vkuznets@redhat.com, davem@davemloft.net,
        netdev@vger.kernel.org, devel@linuxdriverproject.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH hyperv-fixes,1/3] Fix ethtool change hash key error
Date:   Tue, 15 Jan 2019 00:51:42 +0000
Message-Id: <20190115005144.4494-2-haiyangz@linuxonhyperv.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190115005144.4494-1-haiyangz@linuxonhyperv.com>
References: <20190115005144.4494-1-haiyangz@linuxonhyperv.com>
MIME-Version: 1.0
Reply-To: haiyangz@microsoft.com
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfCyDJoy0aYhIj2ux5fF/J7D/eA4yNvzd5KngdH/m5gwzsHXDX+3N2pOkByQNc+zHOrfVbCQNejXHQMilcxSaLnr7M5y/Z8kG/4oE1UOiCnr0MQK5Wgpu
 wlm9NLeB1BKIhSDwZ0nJpGVUzRHiTgxyW+5ZQ1Oqz2Cv+ONeQlhwV8/qumsHrJwET3ELxWfHM39/aM70pCOo6nCDRJVMIFp7PDN/w4vNAz/bLyDZTTpMzVbw
 LPlEykdOYXBd9sz6O0HKX76BRcEoNgtPHyMY4E4BYYZzGoJLVdFewxaM03K41F1OIjCHi7yZ6ss2Mu/byOK0cA0gOBEHLeGpnQFpog9+MjdKMuSITvNNhOC2
 UbXrtaeiY4xZmDnqrdfW9ay42HvtA+4Il6/QX0hs4eUobKwEE2m4GInxJ+oLon5Gy3+rJhuEY+4LURjfxhChdHO17vthQuy1mxeqOIV7i/YfIwAihi7c5gYp
 GNSVPRZMet1ukM0tuyqtaBoiLBqCNahMF4XUwdDzEWSGKyjhyZDmLB02Wpg=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Haiyang Zhang <haiyangz@microsoft.com>

Hyper-V hosts require us to disable RSS before changing RSS key,
otherwise the changing request will fail. This patch fixes the
coding error.

Fixes: ff4a44199012 ("netvsc: allow get/set of RSS indirection table")
Reported-by: Wei Hu <weh@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/net/hyperv/rndis_filter.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/net/hyperv/rndis_filter.c b/drivers/net/hyperv/rndis_filter.c
index 8b537a049c1e..a4661d396e3c 100644
--- a/drivers/net/hyperv/rndis_filter.c
+++ b/drivers/net/hyperv/rndis_filter.c
@@ -774,8 +774,8 @@ rndis_filter_set_offload_params(struct net_device *ndev,
 	return ret;
 }
 
-int rndis_filter_set_rss_param(struct rndis_device *rdev,
-			       const u8 *rss_key)
+static int rndis_set_rss_param_msg(struct rndis_device *rdev,
+				   const u8 *rss_key, u16 flag)
 {
 	struct net_device *ndev = rdev->ndev;
 	struct rndis_request *request;
@@ -804,7 +804,7 @@ int rndis_filter_set_rss_param(struct rndis_device *rdev,
 	rssp->hdr.type = NDIS_OBJECT_TYPE_RSS_PARAMETERS;
 	rssp->hdr.rev = NDIS_RECEIVE_SCALE_PARAMETERS_REVISION_2;
 	rssp->hdr.size = sizeof(struct ndis_recv_scale_param);
-	rssp->flag = 0;
+	rssp->flag = flag;
 	rssp->hashinfo = NDIS_HASH_FUNC_TOEPLITZ | NDIS_HASH_IPV4 |
 			 NDIS_HASH_TCP_IPV4 | NDIS_HASH_IPV6 |
 			 NDIS_HASH_TCP_IPV6;
@@ -829,9 +829,12 @@ int rndis_filter_set_rss_param(struct rndis_device *rdev,
 
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
@@ -842,6 +845,16 @@ int rndis_filter_set_rss_param(struct rndis_device *rdev,
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

