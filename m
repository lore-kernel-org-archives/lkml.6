Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A8A8C4161B
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D223F223D1
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:27:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="i48DPhzt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D223F223D1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732019AbeKLIRp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:17:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:34236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731952AbeKLIRp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:17:45 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E93D322360;
        Sun, 11 Nov 2018 22:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975269;
        bh=95fGqiKldneHCYHMU3tuNKyIYlEyrLgmvTNwnf1W7YY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i48DPhztyvq71iAxa+KqpllIMsAInTP/qSSvDsjRY9KvG3uLkg9rddBijo0M6EHkA
         I09STETee2OpmEzmPHBjIEB8hrDFW/ZwveHLcZ2JlqfEgvDe4jA9ephdBCrGCUKKJI
         sTGKBpYsFJbhgA0uM6mCDM3+Mn1TVhKBUsiBiI8c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anshuman Gupta <anshuman.gupta@intel.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 165/361] xhci: Avoid USB autosuspend when resuming USB2 ports.
Date:   Sun, 11 Nov 2018 14:18:32 -0800
Message-Id: <20181111221643.549564876@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Anshuman Gupta <anshuman.gupta@intel.com>

[ Upstream commit 330e2d61cdd58363eb5e66b2e72f76fe3c5492e0 ]

When USB bus host controller root hub resumes from autosuspend,
it immediately tries to enter auto-suspend, but there can be a
scenario when root hub is resuming its usb2 ports, in that particular
case USB host controller auto suspend fails since it is busy
to resuming its usb2 ports.

This makes multiple failed cycles of auto-suspend until all usb2
ports of host controller root hub do not resume.

This patch uses USB core framework usb_hcd_start_port_resume,
usb_hcd_end_port_resume API's in order to  autoresume/autosuspend
root hub properly.

Signed-off-by: Anshuman Gupta <anshuman.gupta@intel.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/host/xhci-hub.c  |    5 +++++
 drivers/usb/host/xhci-ring.c |    1 +
 2 files changed, 6 insertions(+)

--- a/drivers/usb/host/xhci-hub.c
+++ b/drivers/usb/host/xhci-hub.c
@@ -900,6 +900,7 @@ static u32 xhci_get_port_status(struct u
 				set_bit(wIndex, &bus_state->resuming_ports);
 				bus_state->resume_done[wIndex] = timeout;
 				mod_timer(&hcd->rh_timer, timeout);
+				usb_hcd_start_port_resume(&hcd->self, wIndex);
 			}
 		/* Has resume been signalled for USB_RESUME_TIME yet? */
 		} else if (time_after_eq(jiffies,
@@ -940,6 +941,7 @@ static u32 xhci_get_port_status(struct u
 				clear_bit(wIndex, &bus_state->rexit_ports);
 			}
 
+			usb_hcd_end_port_resume(&hcd->self, wIndex);
 			bus_state->port_c_suspend |= 1 << wIndex;
 			bus_state->suspended_ports &= ~(1 << wIndex);
 		} else {
@@ -962,6 +964,7 @@ static u32 xhci_get_port_status(struct u
 	    (raw_port_status & PORT_PLS_MASK) != XDEV_RESUME) {
 		bus_state->resume_done[wIndex] = 0;
 		clear_bit(wIndex, &bus_state->resuming_ports);
+		usb_hcd_end_port_resume(&hcd->self, wIndex);
 	}
 
 
@@ -1337,6 +1340,7 @@ int xhci_hub_control(struct usb_hcd *hcd
 					goto error;
 
 				set_bit(wIndex, &bus_state->resuming_ports);
+				usb_hcd_start_port_resume(&hcd->self, wIndex);
 				xhci_set_link_state(xhci, ports[wIndex],
 						    XDEV_RESUME);
 				spin_unlock_irqrestore(&xhci->lock, flags);
@@ -1345,6 +1349,7 @@ int xhci_hub_control(struct usb_hcd *hcd
 				xhci_set_link_state(xhci, ports[wIndex],
 							XDEV_U0);
 				clear_bit(wIndex, &bus_state->resuming_ports);
+				usb_hcd_end_port_resume(&hcd->self, wIndex);
 			}
 			bus_state->port_c_suspend |= 1 << wIndex;
 
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -1602,6 +1602,7 @@ static void handle_port_status(struct xh
 			set_bit(HCD_FLAG_POLL_RH, &hcd->flags);
 			mod_timer(&hcd->rh_timer,
 				  bus_state->resume_done[hcd_portnum]);
+			usb_hcd_start_port_resume(&hcd->self, hcd_portnum);
 			bogus_port_status = true;
 		}
 	}


