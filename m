Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC63C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 222DA205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:17:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="knBsaTQv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 222DA205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730381AbeK3BWz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:22:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:44774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728439AbeK3BWy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:22:54 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88679205C9;
        Thu, 29 Nov 2018 14:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501044;
        bh=UujKH/KTcdDHbuZKSaBW3wq6gurLZGl/9UPQdOw5kOM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=knBsaTQvTr/2i4v9d1XIK1/vS9/LNc3/EQlIhaA4MVeJKE+x3AOOdPUNxsf5YC3KS
         7oL5GhfvkbTEdsszEoK3MuR/q4nlB3sAP1mClXsI5lRXzY8sERTzdaHHZuPXPe64hJ
         QSfSo4uK5CE4j9oDq2VJtho82Y8prKEu23vRTmrg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aaron Ma <aaron.ma@canonical.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 4.4 02/86] usb: xhci: fix timeout for transition from RExit to U0
Date:   Thu, 29 Nov 2018 15:11:27 +0100
Message-Id: <20181129140110.078417925@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129140109.832117862@linuxfoundation.org>
References: <20181129140109.832117862@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aaron Ma <aaron.ma@canonical.com>

commit a5baeaeabcca3244782a9b6382ebab6f8a58f583 upstream.

This definition is used by msecs_to_jiffies in milliseconds.
According to the comments, max rexit timeout should be 20ms.
Align with the comments to properly calculate the delay.

Verified on Sunrise Point-LP and Cannon Lake.

Cc: stable@vger.kernel.org
Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/host/xhci-hub.c |    4 ++--
 drivers/usb/host/xhci.h     |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/usb/host/xhci-hub.c
+++ b/drivers/usb/host/xhci-hub.c
@@ -790,7 +790,7 @@ static u32 xhci_get_port_status(struct u
 			time_left = wait_for_completion_timeout(
 					&bus_state->rexit_done[wIndex],
 					msecs_to_jiffies(
-						XHCI_MAX_REXIT_TIMEOUT));
+						XHCI_MAX_REXIT_TIMEOUT_MS));
 			spin_lock_irqsave(&xhci->lock, flags);
 
 			if (time_left) {
@@ -804,7 +804,7 @@ static u32 xhci_get_port_status(struct u
 			} else {
 				int port_status = readl(port_array[wIndex]);
 				xhci_warn(xhci, "Port resume took longer than %i msec, port status = 0x%x\n",
-						XHCI_MAX_REXIT_TIMEOUT,
+						XHCI_MAX_REXIT_TIMEOUT_MS,
 						port_status);
 				status |= USB_PORT_STAT_SUSPEND;
 				clear_bit(wIndex, &bus_state->rexit_ports);
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1490,7 +1490,7 @@ struct xhci_bus_state {
  * It can take up to 20 ms to transition from RExit to U0 on the
  * Intel Lynx Point LP xHCI host.
  */
-#define	XHCI_MAX_REXIT_TIMEOUT	(20 * 1000)
+#define	XHCI_MAX_REXIT_TIMEOUT_MS	20
 
 static inline unsigned int hcd_index(struct usb_hcd *hcd)
 {


