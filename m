Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A7EC4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 08:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2081223FA
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 08:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zCxvxS9X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2081223FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbeHJLQz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 07:16:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:34576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726997AbeHJLQz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 07:16:55 -0400
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7CE79223F0;
        Fri, 10 Aug 2018 08:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533890880;
        bh=OF7VFGUiLAyRV+e9LheNq507uJ/m0kAe6IqPnz2nJVY=;
        h=From:To:Cc:Subject:Date:From;
        b=zCxvxS9XL3xLcR4hdcYyjEDkcrqvx9W4flf1rtCrM2Iw/DxfwTyxPiHJqkqnlm11R
         t80D5tG1pSbG4ncXFyjnR3h1dhYLU4dCTQb6e8w/rFHS+ed1GJwfAWVPmyy/7lXJ1z
         7UEmX3HDd3q/xX3u/hGonW+bqcHg14Lg2HqnnzS4=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andrei Vagin <avagin@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] net: Provide stub for __netif_set_xps_queue if there is no CONFIG_XPS
Date:   Fri, 10 Aug 2018 10:47:43 +0200
Message-Id: <1533890863-32341-1-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building virtio_net driver without CONFIG_XPS fails with:

    drivers/net/virtio_net.c: In function ‘virtnet_set_affinity’:
    drivers/net/virtio_net.c:1910:3: error: implicit declaration of function ‘__netif_set_xps_queue’ [-Werror=implicit-function-declaration]
       __netif_set_xps_queue(vi->dev, mask, i, false);
       ^
Fixes: 4d99f6602cb5 ("net: allow to call netif_reset_xps_queues() under cpus_read_lock")
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 include/linux/netdevice.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 282e2e95ad5b..c38e774494a3 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3412,6 +3412,12 @@ static inline int netif_set_xps_queue(struct net_device *dev,
 {
 	return 0;
 }
+static inline int __netif_set_xps_queue(struct net_device *dev,
+					const unsigned long *mask,
+					u16 index, bool is_rxqs_map)
+{
+	return 0;
+}
 #endif
 
 /**
-- 
2.7.4

