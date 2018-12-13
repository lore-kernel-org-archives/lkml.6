Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61408C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E73120672
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544675546;
	bh=a92wHhcYRBcW7LlPfP0ImEYk6g0oHgxuYBumLWhQDdQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tgMV/BV6KQMh4Bl40ltHCSjj1tvZ/4emG6CFMKPmUYrWc7BtqqIUcm0kAADr29/7C
	 NswE+22izMhKybjuJLEDxHz+32Rb8OtBl/UMAz+iSky+UsyF0Xt4WI+mr80GQXBSye
	 rXSnnsusFUVBtxDPAUuvMOeiL5LFuJEZnfsIYgpQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E73120672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729070AbeLMEcZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 23:32:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:45306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729032AbeLMEcX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 23:32:23 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7F4C20873;
        Thu, 13 Dec 2018 04:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544675542;
        bh=a92wHhcYRBcW7LlPfP0ImEYk6g0oHgxuYBumLWhQDdQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zRERaA65BBDVvdungXRMjk12FRixq+zKHctouwLA0ZPfqWcx5VmHOrAacxXEs+i0o
         cBNVKiw4Hm+c2fVVSIo/Opd81pl6hqHolWWsyFT4NQoyh6gihLJvHt6cEIAuGKZXBQ
         cAEE1l8P1E0YWET2ojOiNCmwoMNuzw/mTjLltVzo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yangtao Li <tiny.windzz@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, sparclinux@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 12/34] drivers/sbus/char: add of_node_put()
Date:   Wed, 12 Dec 2018 23:31:38 -0500
Message-Id: <20181213043200.76295-12-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181213043200.76295-1-sashal@kernel.org>
References: <20181213043200.76295-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yangtao Li <tiny.windzz@gmail.com>

[ Upstream commit 6bd520ab7cf69486ea81fd3cdfd2d5a390ad1100 ]

use of_node_put() to release the refcount.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/sbus/char/envctrl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/sbus/char/envctrl.c b/drivers/sbus/char/envctrl.c
index 5609b602c54d..baa9b322520b 100644
--- a/drivers/sbus/char/envctrl.c
+++ b/drivers/sbus/char/envctrl.c
@@ -910,8 +910,10 @@ static void envctrl_init_i2c_child(struct device_node *dp,
 			for (len = 0; len < PCF8584_MAX_CHANNELS; ++len) {
 				pchild->mon_type[len] = ENVCTRL_NOMON;
 			}
+			of_node_put(root_node);
 			return;
 		}
+		of_node_put(root_node);
 	}
 
 	/* Get the monitor channels. */
-- 
2.19.1

