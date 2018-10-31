Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54556ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 127522081B
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:07:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WfIPu+Ly"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 127522081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729464AbeKAIII (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:08:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:56674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729434AbeKAIIH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:08:07 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F4F820847;
        Wed, 31 Oct 2018 23:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027276;
        bh=bOb7G9T/Cpk8AAJMnHXpjrul5/JQU3tEteF4hdZIVig=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WfIPu+Ly1v2vNmIYdvcWiA0o51D6hAzEA3y4GAVCAoqGPw+ZZZBh/GC8rpOge9pVz
         9a2Iv6i3JmIPw5kP2zIsDP3v4d9k1BxpBbu/SGfbU/g7y3GhIxKFPN21GitQITMKWI
         7CAlJJBHENYVj6nNZRdojwKX1+P8ZbgxIOqRv84Y=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 002/126] net: ethernet: ti: cpsw: unsync mcast entries while switch promisc mode
Date:   Wed, 31 Oct 2018 19:05:50 -0400
Message-Id: <20181031230754.29029-2-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230754.29029-1-sashal@kernel.org>
References: <20181031230754.29029-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>

[ Upstream commit 9737cc99dd14b5b8b9d267618a6061feade8ea68 ]

After flushing all mcast entries from the table, the ones contained in
mc list of ndev are not restored when promisc mode is toggled off,
because they are considered as synched with ALE, thus, in order to
restore them after promisc mode - reset syncing info. This fix
touches only switch mode devices, including single port boards
like Beagle Bone.

Fixes: commit 5da1948969bc
("net: ethernet: ti: cpsw: fix lost of mcast packets while rx_mode update")

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/ti/cpsw.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index 3e34cb8ac1d3..b3b43ac3c9f3 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -641,6 +641,7 @@ static void cpsw_set_promiscious(struct net_device *ndev, bool enable)
 
 			/* Clear all mcast from ALE */
 			cpsw_ale_flush_multicast(ale, ALE_ALL_PORTS, -1);
+			__dev_mc_unsync(ndev, NULL);
 
 			/* Flood All Unicast Packets to Host port */
 			cpsw_ale_control_set(ale, 0, ALE_P0_UNI_FLOOD, 1);
-- 
2.17.1

