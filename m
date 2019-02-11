Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D8DC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C3B521B26
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549899002;
	bh=usmsxEwHND3VTQqYdDSIJzHse3Q3MqF6x6QAR4ohg3w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KOLE48ejub4hvsk41e5kDhDgNTk2K3pDaUy9ggdWNt37+EYls6yBl71umpd7oRDT7
	 yGEemnEaokXohZV7MHKYJaMNAzzAdUjuNuvLFZE9+8D2lsNKHmJf1cXo5HFaIwRgA2
	 D2ynln2/09bKNkx+q9j+Zyz2hlUCmFFAyUmaIhHE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389713AbfBKPaB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:30:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:44248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389253AbfBKO4z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:56:55 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0E76222A1;
        Mon, 11 Feb 2019 14:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549897014;
        bh=usmsxEwHND3VTQqYdDSIJzHse3Q3MqF6x6QAR4ohg3w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sL0yD0JWjYeqEmcpHoA2hBldoDFCUNkF1+vEV5hLC1S7lQF0UDECeHLBGy3SbQ39+
         8rrjx9EpmHLc+dv8WDpjumLDbIXLdHt9iVaWDVYYzmpqgCFt4AT2b3e2fLGeg7/bV0
         S2jG5V7oWSS3tAvHSYUvj4WTqs8c1GDbsDM6ZBJM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 063/205] usb: hub: delay hub autosuspend if USB3 port is still link training
Date:   Mon, 11 Feb 2019 15:17:41 +0100
Message-Id: <20190211141832.917450762@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141827.214852402@linuxfoundation.org>
References: <20190211141827.214852402@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index a073cb5be013..4a4e666a8e09 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -1110,6 +1110,16 @@ static void hub_activate(struct usb_hub *hub, enum hub_activation_type type)
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



