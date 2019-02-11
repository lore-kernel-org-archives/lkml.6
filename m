Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 273DAC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC77C214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549895256;
	bh=lX+pqsNYJf0VlS5WT0545Q+RKspOI5ifikq2ZEsrI3s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Y7c2R4tTEzczzOYDhIUUCp/CybwHRkK4UH71pfw/mTnyir2bPSPwEBG7JfUhwYAhW
	 R69as60ggsijEJ8WBsID+UW5g1y7IjDVOOVwZiqWnMrucu847pNBw+lt0j5sZxnYXk
	 A4u8D439v46rOpZKoN41PabvhDVB9dCkQVI/bw6w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729740AbfBKO1e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:27:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:33320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729718AbfBKO1b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:27:31 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 540A320821;
        Mon, 11 Feb 2019 14:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895250;
        bh=lX+pqsNYJf0VlS5WT0545Q+RKspOI5ifikq2ZEsrI3s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IrIqrRS4zjtGy9B2fhkPjdhaoDRQe+W00jGGZue6e2te3bXfkSBTzn8EjwA7iR342
         +P/A7vRixqyWkNd5oLP1Z9iMiRjLeGn8b9YCMxvPoOQyjWyqoM2gbBeBFC6wheqMM+
         5ZnP0hKjHaKX7Hopijw8kexK5+spI4j6SctVSsi0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 113/352] usb: hub: delay hub autosuspend if USB3 port is still link training
Date:   Mon, 11 Feb 2019 15:15:40 +0100
Message-Id: <20190211141853.016181458@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

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
index f76b2e0aba9d..1d1e61e980f3 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -1112,6 +1112,16 @@ static void hub_activate(struct usb_hub *hub, enum hub_activation_type type)
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



