Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F393C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43CFD2243E
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:39:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HDB4rtx0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43CFD2243E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388132AbeKOI3O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:29:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:36044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388058AbeKOI3N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:29:13 -0500
Received: from sasha-vm.mshome.net (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C844822526;
        Wed, 14 Nov 2018 22:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542234248;
        bh=dKo2Dj+7eUG48qJtzB+Aw4ovMrhODtUJwYGXy3b2wsM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HDB4rtx06j0sz1cjG3xBIWmU22TCx7ZJXQtJmlKihx2WSul+Olibjlj9OKtOoxbaV
         rxQ0RnQXT3BtZZi80QZkZjfG4H9tuaRtSxdB1ipmlT9vkQqThtnvOkx38H/U+hf8Pj
         CCOCo5TR38N+oQ6ovPA6cVGl9SQg9fNgXCSpVmWk=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Tristram Ha <Tristram.Ha@microchip.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.18 12/59] net: dsa: microchip: initialize mutex before use
Date:   Wed, 14 Nov 2018 17:22:44 -0500
Message-Id: <20181114222335.99339-12-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181114222335.99339-1-sashal@kernel.org>
References: <20181114222335.99339-1-sashal@kernel.org>
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
index 7210c49b7922..c3103bdb6cf6 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -1108,11 +1108,6 @@ static int ksz_switch_init(struct ksz_device *dev)
 {
 	int i;
 
-	mutex_init(&dev->reg_mutex);
-	mutex_init(&dev->stats_mutex);
-	mutex_init(&dev->alu_mutex);
-	mutex_init(&dev->vlan_mutex);
-
 	dev->ds->ops = &ksz_switch_ops;
 
 	for (i = 0; i < ARRAY_SIZE(ksz_switch_chips); i++) {
@@ -1197,6 +1192,11 @@ int ksz_switch_register(struct ksz_device *dev)
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

