Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A1AC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A76921741
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545864763;
	bh=UUqEN3ZI1DKqLdLSVkecVmrDa1pIds4SABON0avPxIE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nKb2uVuAfN2+rCHCKOgz1RL97Ku68hRcd8GQ+Ev3O0NFlCNZYlKhbcI7ukQrZ/ztI
	 QTAh+eXplrcf+ZzYgYy9L7ULbUVlqt4hjmDZL6bO/fmN2usD3cxHt1ul/IP9JwkRFy
	 5gPD8FScfu4jtFrpignfV7DziTl8yBZsVrcif4k4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbeLZWg5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 17:36:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:36974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727918AbeLZWgx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:36:53 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C8F5218FE;
        Wed, 26 Dec 2018 22:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545863812;
        bh=UUqEN3ZI1DKqLdLSVkecVmrDa1pIds4SABON0avPxIE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rsbjYLj69pjqjNaswhmKsgweQkr7OoEesvWJomoVDUJ41Im0gV3PB30yrQcqwTY0K
         3fZQcTw92cF/+tzxW0tFAbwRzlp0sEcfEwFdls+xiPVujTCIUeYgpnZIvq3mesPM4k
         XMttLNktfc/GXHoV4PeK83M7K7NdlZ+knzL8+B34=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Hui Peng <benquike@gmail.com>,
        Mathias Payer <mathias.payer@nebelwelt.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 33/97] USB: hso: Fix OOB memory access in hso_probe/hso_get_config_data
Date:   Wed, 26 Dec 2018 17:34:53 -0500
Message-Id: <20181226223557.149329-33-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181226223557.149329-1-sashal@kernel.org>
References: <20181226223557.149329-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hui Peng <benquike@gmail.com>

[ Upstream commit 5146f95df782b0ac61abde36567e718692725c89 ]

The function hso_probe reads if_num from the USB device (as an u8) and uses
it without a length check to index an array, resulting in an OOB memory read
in hso_probe or hso_get_config_data.

Add a length check for both locations and updated hso_probe to bail on
error.

This issue has been assigned CVE-2018-19985.

Reported-by: Hui Peng <benquike@gmail.com>
Reported-by: Mathias Payer <mathias.payer@nebelwelt.net>
Signed-off-by: Hui Peng <benquike@gmail.com>
Signed-off-by: Mathias Payer <mathias.payer@nebelwelt.net>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/hso.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/net/usb/hso.c b/drivers/net/usb/hso.c
index 184c24baca15..d6916f787fce 100644
--- a/drivers/net/usb/hso.c
+++ b/drivers/net/usb/hso.c
@@ -2807,6 +2807,12 @@ static int hso_get_config_data(struct usb_interface *interface)
 		return -EIO;
 	}
 
+	/* check if we have a valid interface */
+	if (if_num > 16) {
+		kfree(config_data);
+		return -EINVAL;
+	}
+
 	switch (config_data[if_num]) {
 	case 0x0:
 		result = 0;
@@ -2877,10 +2883,18 @@ static int hso_probe(struct usb_interface *interface,
 
 	/* Get the interface/port specification from either driver_info or from
 	 * the device itself */
-	if (id->driver_info)
+	if (id->driver_info) {
+		/* if_num is controlled by the device, driver_info is a 0 terminated
+		 * array. Make sure, the access is in bounds! */
+		for (i = 0; i <= if_num; ++i)
+			if (((u32 *)(id->driver_info))[i] == 0)
+				goto exit;
 		port_spec = ((u32 *)(id->driver_info))[if_num];
-	else
+	} else {
 		port_spec = hso_get_config_data(interface);
+		if (port_spec < 0)
+			goto exit;
+	}
 
 	/* Check if we need to switch to alt interfaces prior to port
 	 * configuration */
-- 
2.19.1

