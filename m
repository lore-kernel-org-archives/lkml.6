Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE197C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 789302150F
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:26:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BSrvNxHd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 789302150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbeJHWiu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 18:38:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:57508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727747AbeJHWit (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 18:38:49 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 966AC214DC;
        Mon,  8 Oct 2018 15:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539012394;
        bh=S/GkZS2+9OgY94dpp4slAN5jM+rJwrmhyUDG9RkHZ20=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BSrvNxHdBB4r5754NyBv8agWRSJhIpNWihBdDJPk9QNfedlniYb3eWm9gaMICywVD
         lWnrGefd9FFBKGXjRHoUUhxAYIBOiR8ZkzPdFkAoNeoGMWkrRr032xplF/HvsBnjd3
         mQ652GNqH9T3DgOa7ps5UMIvcRpHslBzB18YRQYw=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sven Eckelmann <sven@narfation.org>,
        Simon Wunderlich <sw@simonwunderlich.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 03/32] batman-adv: Fix segfault when writing to throughput_override
Date:   Mon,  8 Oct 2018 11:26:00 -0400
Message-Id: <20181008152629.70812-3-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181008152629.70812-1-sashal@kernel.org>
References: <20181008152629.70812-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sven Eckelmann <sven@narfation.org>

[ Upstream commit b9fd14c20871e6189f635e49b32d7789e430b3c8 ]

The per hardif sysfs file "batman_adv/throughput_override" prints the
resulting change as info text when the users writes to this file. It uses
the helper function batadv_info to add it at the same time to the kernel
ring buffer and to the batman-adv debug log (when CONFIG_BATMAN_ADV_DEBUG
is enabled).

The function batadv_info requires as first parameter the batman-adv softif
net_device. This parameter is then used to find the private buffer which
contains the debug log for this batman-adv interface. But
batadv_store_throughput_override used as first argument the slave
net_device. This slave device doesn't have the batadv_priv private data
which is access by batadv_info.

Writing to this file with CONFIG_BATMAN_ADV_DEBUG enabled can either lead
to a segfault or to memory corruption.

Fixes: 0b5ecc6811bd ("batman-adv: add throughput override attribute to hard_ifaces")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Acked-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/batman-adv/sysfs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/sysfs.c b/net/batman-adv/sysfs.c
index 0ae8b30e4eaa..ec412c5b8697 100644
--- a/net/batman-adv/sysfs.c
+++ b/net/batman-adv/sysfs.c
@@ -1078,8 +1078,9 @@ static ssize_t batadv_store_throughput_override(struct kobject *kobj,
 	if (old_tp_override == tp_override)
 		goto out;
 
-	batadv_info(net_dev, "%s: Changing from: %u.%u MBit to: %u.%u MBit\n",
-		    "throughput_override",
+	batadv_info(hard_iface->soft_iface,
+		    "%s: %s: Changing from: %u.%u MBit to: %u.%u MBit\n",
+		    "throughput_override", net_dev->name,
 		    old_tp_override / 10, old_tp_override % 10,
 		    tp_override / 10, tp_override % 10);
 
-- 
2.17.1

