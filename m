Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63804C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AE8621738
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548692507;
	bh=RgLOyiuO0ELpebnq1JYYUYM/gwtVWipyOCKAwQ5shAo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TAt9N9dQFQkoqfnHWjWrlVekBbpP8oO7sYFYUjgOXDGehWd61WvOii2XBSr0L/IYA
	 kHKjkr6iHo26wFlohb+H9PoXi2rb4kGevbuxYB+/35Xp0IivxYgiVjPEx9G+g4bmuM
	 IOGsHky3Khut2CdHOQyPiOrLk3qnomPYpJ2/EPhY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387907AbfA1QVp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:21:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:57542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732851AbfA1QVn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:21:43 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3D9A2084A;
        Mon, 28 Jan 2019 16:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692502;
        bh=RgLOyiuO0ELpebnq1JYYUYM/gwtVWipyOCKAwQ5shAo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IUQ7bYCmsvWP344Z1g61QdmjBaB2l0Plrl8TYg5FKzCeC5gWcoVIVOMKrq2sTXybp
         hRLbt8xcj3OlOMs+5lXklDYDIuBPhH6m4yU8A3yK3grpDEovrkktLG8P3C7TlI2iKM
         Q726ZXUIoMtebqsFqmy+S6bz7XkhBW42NErpVX/g=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 040/107] usb: hub: delay hub autosuspend if USB3 port is still link training
Date:   Mon, 28 Jan 2019 11:18:40 -0500
Message-Id: <20190128161947.57405-40-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128161947.57405-1-sashal@kernel.org>
References: <20190128161947.57405-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mathias Nyman <mathias.nyman@linux.intel.com>

[ Upstream commit e86108940e541febf35813402ff29fa6f4a9ac0b ]

When initializing a hub we want to give a USB3 port in link training
the same debounce delay time before autosuspening the hub as already
trained, connected enabled ports.

USB3 ports won't reach the enabled state with "current connect status" and
"connect status change" bits set until the USB3 link training finishes.

Catching the port in link training (polling) and adding the debounce delay
prevents unnecessary failed attempts to autosuspend the hub.

Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/core/hub.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 67679f619c3b..7b6919086539 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -1108,6 +1108,16 @@ static void hub_activate(struct usb_hub *hub, enum hub_activation_type type)
 						   USB_PORT_FEAT_ENABLE);
 		}
 
+		/*
+		 * Add debounce if USB3 link is in polling/link training state.
+		 * Link will automatically transition to Enabled state after
+		 * link training completes.
+		 */
+		if (hub_is_superspeed(hdev) &&
+		    ((portstatus & USB_PORT_STAT_LINK_STATE) ==
+						USB_SS_PORT_LS_POLLING))
+			need_debounce_delay = true;
+
 		/* Clear status-change flags; we'll debounce later */
 		if (portchange & USB_PORT_STAT_C_CONNECTION) {
 			need_debounce_delay = true;
-- 
2.19.1

