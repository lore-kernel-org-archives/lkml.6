Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C13CEECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 806FB2081B
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:09:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pK91eIdu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 806FB2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730286AbeKAIJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:09:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:58812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730258AbeKAIJK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:09:10 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A4E620843;
        Wed, 31 Oct 2018 23:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027339;
        bh=nkSmmovo6/yQbry6bShh7TLl9TeQZJKvIEsdS4rF2IQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pK91eIdulw8rVKtVvxoHD5NUn3TdDik98fltjw2h+GTSwndqtnw1ycM9vZUEpUW6a
         LIhkMqOWzEQSWxgRWKT2zDrvYzZxZdwkXZ0Q8wlY7JuX5gGnI+uf+7c8p1thzdlrA+
         HUmj7gQidqMLVOkuQErHsvvW0xpveOQk+dK+mxYI=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Martin Willi <martin@strongswan.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 070/126] ath10k: schedule hardware restart if WMI command times out
Date:   Wed, 31 Oct 2018 19:06:58 -0400
Message-Id: <20181031230754.29029-70-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230754.29029-1-sashal@kernel.org>
References: <20181031230754.29029-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Willi <martin@strongswan.org>

[ Upstream commit a9911937e7d332761e8c4fcbc7ba0426bdc3956f ]

When running in AP mode, ath10k sometimes suffers from TX credit
starvation. The issue is hard to reproduce and shows up once in a
few days, but has been repeatedly seen with QCA9882 and a large
range of firmwares, including 10.2.4.70.67.

Once the module is in this state, TX credits are never replenished,
which results in "SWBA overrun" errors, as no beacons can be sent.
Even worse, WMI commands run in a timeout while holding the conf
mutex for three seconds each, making any further operations slow
and the whole system unresponsive.

The firmware/driver never recovers from that state automatically,
and triggering TX flush or warm restarts won't work over WMI. So
issue a hardware restart if a WMI command times out due to missing
TX credits. This implies a connectivity outage of about 1.4s in AP
mode, but brings back the interface and the whole system to a usable
state. WMI command timeouts have not been seen in absent of this
specific issue, so taking such drastic actions seems legitimate.

Signed-off-by: Martin Willi <martin@strongswan.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath10k/wmi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/ath/ath10k/wmi.c b/drivers/net/wireless/ath/ath10k/wmi.c
index 2319f79b34f0..e6d23b6895bd 100644
--- a/drivers/net/wireless/ath/ath10k/wmi.c
+++ b/drivers/net/wireless/ath/ath10k/wmi.c
@@ -1869,6 +1869,12 @@ int ath10k_wmi_cmd_send(struct ath10k *ar, struct sk_buff *skb, u32 cmd_id)
 	if (ret)
 		dev_kfree_skb_any(skb);
 
+	if (ret == -EAGAIN) {
+		ath10k_warn(ar, "wmi command %d timeout, restarting hardware\n",
+			    cmd_id);
+		queue_work(ar->workqueue, &ar->restart_work);
+	}
+
 	return ret;
 }
 
-- 
2.17.1

