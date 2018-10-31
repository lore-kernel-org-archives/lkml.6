Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD0DC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7158320847
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:31:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vzn+A6XO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7158320847
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730904AbeKAIbz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:31:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:59752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728346AbeKAIJl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:09:41 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A1CC2064C;
        Wed, 31 Oct 2018 23:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027369;
        bh=8U4Lgbfnxg+PsYi902po+28p7zoOPABUZfMaUyFt3WA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vzn+A6XOV2/l5uw75yzMP8lJ3tJwicMIhM6wMr87XeoB1xCDjLyoC1c2AW8b9lrjK
         bK88eziTN0LH8PT/okVMehavZC3czUV6PgHN3QLnN51ULS80OIgbfW89spiqrEQBj6
         bZRAJZg5Y0jgU0B5eFf7Ssf9/V4G5Fi5MdC/9jyU=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Anshuman Gupta <anshuman.gupta@intel.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 105/126] xhci: Avoid USB autosuspend when resuming USB2 ports.
Date:   Wed, 31 Oct 2018 19:07:33 -0400
Message-Id: <20181031230754.29029-105-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230754.29029-1-sashal@kernel.org>
References: <20181031230754.29029-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 drivers/usb/host/xhci-hub.c  | 5 +++++
 drivers/usb/host/xhci-ring.c | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
index a4b95d019f84..1f7eeee2ebca 100644
--- a/drivers/usb/host/xhci-hub.c
+++ b/drivers/usb/host/xhci-hub.c
@@ -900,6 +900,7 @@ static u32 xhci_get_port_status(struct usb_hcd *hcd,
 				set_bit(wIndex, &bus_state->resuming_ports);
 				bus_state->resume_done[wIndex] = timeout;
 				mod_timer(&hcd->rh_timer, timeout);
+				usb_hcd_start_port_resume(&hcd->self, wIndex);
 			}
 		/* Has resume been signalled for USB_RESUME_TIME yet? */
 		} else if (time_after_eq(jiffies,
@@ -940,6 +941,7 @@ static u32 xhci_get_port_status(struct usb_hcd *hcd,
 				clear_bit(wIndex, &bus_state->rexit_ports);
 			}
 
+			usb_hcd_end_port_resume(&hcd->self, wIndex);
 			bus_state->port_c_suspend |= 1 << wIndex;
 			bus_state->suspended_ports &= ~(1 << wIndex);
 		} else {
@@ -962,6 +964,7 @@ static u32 xhci_get_port_status(struct usb_hcd *hcd,
 	    (raw_port_status & PORT_PLS_MASK) != XDEV_RESUME) {
 		bus_state->resume_done[wIndex] = 0;
 		clear_bit(wIndex, &bus_state->resuming_ports);
+		usb_hcd_end_port_resume(&hcd->self, wIndex);
 	}
 
 
@@ -1337,6 +1340,7 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 					goto error;
 
 				set_bit(wIndex, &bus_state->resuming_ports);
+				usb_hcd_start_port_resume(&hcd->self, wIndex);
 				xhci_set_link_state(xhci, ports[wIndex],
 						    XDEV_RESUME);
 				spin_unlock_irqrestore(&xhci->lock, flags);
@@ -1345,6 +1349,7 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 				xhci_set_link_state(xhci, ports[wIndex],
 							XDEV_U0);
 				clear_bit(wIndex, &bus_state->resuming_ports);
+				usb_hcd_end_port_resume(&hcd->self, wIndex);
 			}
 			bus_state->port_c_suspend |= 1 << wIndex;
 
diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index f0a99aa0ac58..cd4659703647 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -1602,6 +1602,7 @@ static void handle_port_status(struct xhci_hcd *xhci,
 			set_bit(HCD_FLAG_POLL_RH, &hcd->flags);
 			mod_timer(&hcd->rh_timer,
 				  bus_state->resume_done[hcd_portnum]);
+			usb_hcd_start_port_resume(&hcd->self, hcd_portnum);
 			bogus_port_status = true;
 		}
 	}
-- 
2.17.1

