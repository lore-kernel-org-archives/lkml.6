Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC2CC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 449142145D
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:45:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ToSyj2VQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 449142145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729148AbeKOIuz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:50:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:34408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727434AbeKOI1P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:27:15 -0500
Received: from sasha-vm.mshome.net (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53F9222523;
        Wed, 14 Nov 2018 22:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542234132;
        bh=K8Tn4WKTk0id6EOaw22rdxn+/u+RYd23q0MY6Y6VdOk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ToSyj2VQny7zLdY85vsgXYITRYYmed6L9mSd9OlQV2sN1onaj0tOacYaL/wMkF1vp
         LhQFFsu2xMBVDYDcqsDwOCnWcNZ2Y/9BlHi+4gYP1NcYFu/y3WwSujFMxjldHbYP+r
         oNbiNvMGxvjKvIlaXfCQeTxv4QFFINKsan54o8MU=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Tristram Ha <Tristram.Ha@microchip.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 17/73] net: dsa: microchip: initialize mutex before use
Date:   Wed, 14 Nov 2018 17:21:11 -0500
Message-Id: <20181114222207.98701-17-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181114222207.98701-1-sashal@kernel.org>
References: <20181114222207.98701-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tristram Ha <Tristram.Ha@microchip.com>

[ Upstream commit 284fb78ed7572117846f8e1d1d8e3dbfd16880c2 ]

Initialize mutex before use.  Avoid kernel complaint when
CONFIG_DEBUG_LOCK_ALLOC is enabled.

Fixes: b987e98e50ab90e5 ("dsa: add DSA switch driver for Microchip KSZ9477")
Signed-off-by: Tristram Ha <Tristram.Ha@microchip.com>
Reviewed-by: Pavel Machek <pavel@ucw.cz>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/microchip/ksz_common.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 54e0ca6ed730..86b6464b4525 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -1117,11 +1117,6 @@ static int ksz_switch_init(struct ksz_device *dev)
 {
 	int i;
 
-	mutex_init(&dev->reg_mutex);
-	mutex_init(&dev->stats_mutex);
-	mutex_init(&dev->alu_mutex);
-	mutex_init(&dev->vlan_mutex);
-
 	dev->ds->ops = &ksz_switch_ops;
 
 	for (i = 0; i < ARRAY_SIZE(ksz_switch_chips); i++) {
@@ -1206,6 +1201,11 @@ int ksz_switch_register(struct ksz_device *dev)
 	if (dev->pdata)
 		dev->chip_id = dev->pdata->chip_id;
 
+	mutex_init(&dev->reg_mutex);
+	mutex_init(&dev->stats_mutex);
+	mutex_init(&dev->alu_mutex);
+	mutex_init(&dev->vlan_mutex);
+
 	if (ksz_switch_detect(dev))
 		return -EINVAL;
 
-- 
2.17.1

