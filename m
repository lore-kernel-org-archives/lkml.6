Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D32C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DAF720866
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:32:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZFCkM7sQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DAF720866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728319AbeJPMBc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:01:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:48646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728271AbeJPMBb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:01:31 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 839A8208E4;
        Tue, 16 Oct 2018 04:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539663189;
        bh=sSY47dT0ODJOFMAFRlvSQs98RvR4ZCjNDh6CA7FCijU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZFCkM7sQZ3OyTb/0BlM+C5zc8xNQPi7y47gLS+g/19JhLZ8hHwZS9ssESxXyk3SMv
         4cCsIBhSFF/pDBocAW5gUp2GjzS7yu04R57HFf73FO/TrPEP47azAHOROnl73nMieh
         xSyrGOTedZWn7EiXC/NK9fFkwrxdhq813KJu5b/M=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 051/100] r8152: Check for supported Wake-on-LAN Modes
Date:   Tue, 16 Oct 2018 00:11:32 -0400
Message-Id: <20181016041221.135528-51-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181016041221.135528-1-sashal@kernel.org>
References: <20181016041221.135528-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>

[ Upstream commit f2750df1548bd8a2b060eb609fc43ca82811af4c ]

The driver does not check for Wake-on-LAN modes specified by an user,
but will conditionally set the device as wake-up enabled or not based on
that, which could be a very confusing user experience.

Fixes: 21ff2e8976b1 ("r8152: support WOL")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/r8152.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 1b07bb5e110d..9a55d75f7f10 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -4503,6 +4503,9 @@ static int rtl8152_set_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
 	if (!rtl_can_wakeup(tp))
 		return -EOPNOTSUPP;
 
+	if (wol->wolopts & ~WAKE_ANY)
+		return -EINVAL;
+
 	ret = usb_autopm_get_interface(tp->intf);
 	if (ret < 0)
 		goto out_set_wol;
-- 
2.17.1

