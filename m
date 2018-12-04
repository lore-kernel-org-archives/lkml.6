Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 467C4C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 10:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E5AD214DA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 10:56:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nNiu2XRg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E5AD214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbeLDK4B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 05:56:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:38956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726375AbeLDKz6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 05:55:58 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3DF6E2087F;
        Tue,  4 Dec 2018 10:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543920957;
        bh=GnPGxlq0bohOk/uBWtueFswHlXVlH7+9W0aX9+xLWY4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nNiu2XRgIwljCWHsE6xQyHEvkUof3/6UR8M0MsQUmIWJryYOk5vlSyKLZA85bfu1E
         bl9ITnEd7+XQ0gpHbD8iVFexPAu/rkm+irzwcajrytBLLLVln9SB3A1yR9hwRjjrBf
         6bzuH10hER9y72Ff5jkaRQs5+VxKVRUMJziHeT5w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 025/139] net: phy: add workaround for issue where PHY driver doesnt bind to the device
Date:   Tue,  4 Dec 2018 11:48:26 +0100
Message-Id: <20181204103651.010514817@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103649.950154335@linuxfoundation.org>
References: <20181204103649.950154335@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Heiner Kallweit <hkallweit1@gmail.com>

[ Upstream commit c85ddecae6e5e82ca3ae6f20c63f1d865e2ff5ea ]

After switching the r8169 driver to use phylib some user reported that
their network is broken. This was caused by the genphy PHY driver being
used instead of the dedicated PHY driver for the RTL8211B. Users
reported that loading the Realtek PHY driver module upfront fixes the
issue. See also this mail thread:
https://marc.info/?t=154279781800003&r=1&w=2
The issue is quite weird and the root cause seems to be somewhere in
the base driver core. The patch works around the issue and may be
removed once the actual issue is fixed.

The Fixes tag refers to the first reported occurrence of the issue.
The issue itself may have been existing much longer and it may affect
users of other network chips as well. Users typically will recognize
this issue only if their PHY stops working when being used with the
genphy driver.

Fixes: f1e911d5d0df ("r8169: add basic phylib support")
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/phy/phy_device.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1930,6 +1930,14 @@ int phy_driver_register(struct phy_drive
 	new_driver->mdiodrv.driver.remove = phy_remove;
 	new_driver->mdiodrv.driver.owner = owner;
 
+	/* The following works around an issue where the PHY driver doesn't bind
+	 * to the device, resulting in the genphy driver being used instead of
+	 * the dedicated driver. The root cause of the issue isn't known yet
+	 * and seems to be in the base driver core. Once this is fixed we may
+	 * remove this workaround.
+	 */
+	new_driver->mdiodrv.driver.probe_type = PROBE_FORCE_SYNCHRONOUS;
+
 	retval = driver_register(&new_driver->mdiodrv.driver);
 	if (retval) {
 		pr_err("%s: Error %d in registering driver\n",


