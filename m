Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F7ECC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C69120840
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550197784;
	bh=4Evbn6hvxlrLo1b2tZoyJSS9dli7UapP7ISU4LP0AGk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=O/32UewUIpPxYGuB3Gp4lOn0IBcAh9CbFD3SXGe1dHsZK9ZQWStnXTF0KXYDVbP4x
	 76CYkWgcWhMhJXQk1VVwVQRGiSRR8LnPfTkFhL2b1v2MGI4PYw9CPf/TAFSlC+aCs8
	 5iO0wR4g4CVRh/0C910n/SbmwI8itnxAOg+4wUiY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404487AbfBOCNB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:13:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:52914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388645AbfBOCM4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 21:12:56 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 468DD206BA;
        Fri, 15 Feb 2019 02:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550196776;
        bh=4Evbn6hvxlrLo1b2tZoyJSS9dli7UapP7ISU4LP0AGk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j0LoGeRciTc3Cjq04HLMwV/GTecibiEEyAn6JM+4GhU5VHSJBen3B/5z7jLx1DyPu
         qxrmN5d7KQey+G/D++jLizNsJGLFJWCkzvKOXIDjaa7/W5SrPGLS70EG1WfZ1XfoRw
         KT6mf93Ozbyyjo+axHYAafTYWXI/hp4x3KS0pBNQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Zhang Run <zhang.run@zte.com.cn>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 56/65] net: usb: asix: ax88772_bind return error when hw_reset fail
Date:   Thu, 14 Feb 2019 21:11:12 -0500
Message-Id: <20190215021121.177674-56-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215021121.177674-1-sashal@kernel.org>
References: <20190215021121.177674-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Run <zhang.run@zte.com.cn>

[ Upstream commit 6eea3527e68acc22483f4763c8682f223eb90029 ]

The ax88772_bind() should return error code immediately when the PHY
was not reset properly through ax88772a_hw_reset().
Otherwise, The asix_get_phyid() will block when get the PHY
Identifier from the PHYSID1 MII registers through asix_mdio_read()
due to the PHY isn't ready. Furthermore, it will produce a lot of
error message cause system crash.As follows:
asix 1-1:1.0 (unnamed net_device) (uninitialized): Failed to write
 reg index 0x0000: -71
asix 1-1:1.0 (unnamed net_device) (uninitialized): Failed to send
 software reset: ffffffb9
asix 1-1:1.0 (unnamed net_device) (uninitialized): Failed to write
 reg index 0x0000: -71
asix 1-1:1.0 (unnamed net_device) (uninitialized): Failed to enable
 software MII access
asix 1-1:1.0 (unnamed net_device) (uninitialized): Failed to read
 reg index 0x0000: -71
asix 1-1:1.0 (unnamed net_device) (uninitialized): Failed to write
 reg index 0x0000: -71
asix 1-1:1.0 (unnamed net_device) (uninitialized): Failed to enable
 software MII access
asix 1-1:1.0 (unnamed net_device) (uninitialized): Failed to read
 reg index 0x0000: -71
...

Signed-off-by: Zhang Run <zhang.run@zte.com.cn>
Reviewed-by: Yang Wei <yang.wei9@zte.com.cn>
Tested-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/asix_devices.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/usb/asix_devices.c b/drivers/net/usb/asix_devices.c
index b654f05b2ccd..3d93993e74da 100644
--- a/drivers/net/usb/asix_devices.c
+++ b/drivers/net/usb/asix_devices.c
@@ -739,8 +739,13 @@ static int ax88772_bind(struct usbnet *dev, struct usb_interface *intf)
 	asix_read_cmd(dev, AX_CMD_STATMNGSTS_REG, 0, 0, 1, &chipcode, 0);
 	chipcode &= AX_CHIPCODE_MASK;
 
-	(chipcode == AX_AX88772_CHIPCODE) ? ax88772_hw_reset(dev, 0) :
-					    ax88772a_hw_reset(dev, 0);
+	ret = (chipcode == AX_AX88772_CHIPCODE) ? ax88772_hw_reset(dev, 0) :
+						  ax88772a_hw_reset(dev, 0);
+
+	if (ret < 0) {
+		netdev_dbg(dev->net, "Failed to reset AX88772: %d\n", ret);
+		return ret;
+	}
 
 	/* Read PHYID register *AFTER* the PHY was reset properly */
 	phyid = asix_get_phyid(dev);
-- 
2.19.1

