Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9751C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B147D20840
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550197871;
	bh=AG0gaGMwRJJ3a5LCdaP7mwJC0jmk9Pq8Vu4IkeJMAxA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tjQQWrTm+11hHENHiXVhLcyzaQqcaWwSGOqp3BDH/wSswQqyNUNgD9r9UJTJTJMBw
	 KSVftC4TV8FyM6Gh4IdqYLyLCZ7qcf5jkKCuGNqzlAT0ZeJbsOdupOSZhI6+/FaUou
	 6UvaBcC+Tg8+Zai0YjAenmrDhz/TIEGQj9txH4tk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731312AbfBOCbK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:31:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:52656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390400AbfBOCMj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 21:12:39 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7B1B21934;
        Fri, 15 Feb 2019 02:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550196758;
        bh=AG0gaGMwRJJ3a5LCdaP7mwJC0jmk9Pq8Vu4IkeJMAxA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lT9QpFYW8w1YeQ8Ohh+usqtU4UDpj+qSp/Pt180UJ0HBKiA4fqnWQ/NOD4Q+HdqRa
         uOu7jh6W02FA+FbkJy/glOxhl1llNo1BwNKoxbbfKZNcyvxFmYhI/AjyYYpPxPufoY
         64rtEIqMUxGjinDQ/FtIq5vt7yoosA3pa8M0i0n0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Haiyang Zhang <haiyangz@microsoft.com>,
        Sasha Levin <sashal@kernel.org>, devel@linuxdriverproject.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 47/65] hv_netvsc: Fix ethtool change hash key error
Date:   Thu, 14 Feb 2019 21:11:03 -0500
Message-Id: <20190215021121.177674-47-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215021121.177674-1-sashal@kernel.org>
References: <20190215021121.177674-1-sashal@kernel.org>
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
index 2a5209f23f29..0b05f7ebeb01 100644
--- a/drivers/net/hyperv/rndis_filter.c
+++ b/drivers/net/hyperv/rndis_filter.c
@@ -715,8 +715,8 @@ rndis_filter_set_offload_params(struct net_device *ndev,
 	return ret;
 }
 
-int rndis_filter_set_rss_param(struct rndis_device *rdev,
-			       const u8 *rss_key)
+static int rndis_set_rss_param_msg(struct rndis_device *rdev,
+				   const u8 *rss_key, u16 flag)
 {
 	struct net_device *ndev = rdev->ndev;
 	struct rndis_request *request;
@@ -745,7 +745,7 @@ int rndis_filter_set_rss_param(struct rndis_device *rdev,
 	rssp->hdr.type = NDIS_OBJECT_TYPE_RSS_PARAMETERS;
 	rssp->hdr.rev = NDIS_RECEIVE_SCALE_PARAMETERS_REVISION_2;
 	rssp->hdr.size = sizeof(struct ndis_recv_scale_param);
-	rssp->flag = 0;
+	rssp->flag = flag;
 	rssp->hashinfo = NDIS_HASH_FUNC_TOEPLITZ | NDIS_HASH_IPV4 |
 			 NDIS_HASH_TCP_IPV4 | NDIS_HASH_IPV6 |
 			 NDIS_HASH_TCP_IPV6;
@@ -770,9 +770,12 @@ int rndis_filter_set_rss_param(struct rndis_device *rdev,
 
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
@@ -783,6 +786,16 @@ int rndis_filter_set_rss_param(struct rndis_device *rdev,
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

