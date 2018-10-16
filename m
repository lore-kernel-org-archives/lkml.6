Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F24C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDD2721477
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:16:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sl9UZ5LT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDD2721477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730272AbeJPMEr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:04:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:53858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730259AbeJPMEr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:04:47 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3AF6D21470;
        Tue, 16 Oct 2018 04:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539663383;
        bh=he57jf6gn8uz0S/95XCtxjYwip8nUBAOF/VO1ulDv3Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Sl9UZ5LTGjGga3wJ94tv6Xxzp2ooBzjsMdkuqjZ+5APELT45d09BOZufDv34R4p67
         OweVjVHpqCQau0Y5GKWRU6XhQM+L6ggneOCiV8xg+s/k5mSO/jzp/iouQ1DTodpBLf
         SnZqn5q1RTxlqC1m/I+uLBtnQSHhYb+rPkPYsoJE=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 18/25] smsc75xx: Check for Wake-on-LAN modes
Date:   Tue, 16 Oct 2018 00:15:59 -0400
Message-Id: <20181016041606.135876-18-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181016041606.135876-1-sashal@kernel.org>
References: <20181016041606.135876-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>

[ Upstream commit 9c734b2769a73eea2e9e9767c0e0bf839ff23679 ]

The driver does not check for Wake-on-LAN modes specified by an user,
but will conditionally set the device as wake-up enabled or not based on
that, which could be a very confusing user experience.

Fixes: 6c636503260d ("smsc75xx: add wol magic packet support")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/smsc75xx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/usb/smsc75xx.c b/drivers/net/usb/smsc75xx.c
index 478937418a33..1a8b9ea49144 100644
--- a/drivers/net/usb/smsc75xx.c
+++ b/drivers/net/usb/smsc75xx.c
@@ -728,6 +728,9 @@ static int smsc75xx_ethtool_set_wol(struct net_device *net,
 	struct smsc75xx_priv *pdata = (struct smsc75xx_priv *)(dev->data[0]);
 	int ret;
 
+	if (wolinfo->wolopts & ~SUPPORTED_WAKE)
+		return -EINVAL;
+
 	pdata->wolopts = wolinfo->wolopts & SUPPORTED_WAKE;
 
 	ret = device_set_wakeup_enable(&dev->udev->dev, pdata->wolopts);
-- 
2.17.1

