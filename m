Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4FB9C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4FBF222D9
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:01:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403960AbfBNPBd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 10:01:33 -0500
Received: from mga11.intel.com ([192.55.52.93]:61509 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393887AbfBNPBb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 10:01:31 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Feb 2019 07:01:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,369,1544515200"; 
   d="scan'208,223";a="299739594"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.164]) ([10.237.72.164])
  by orsmga005.jf.intel.com with ESMTP; 14 Feb 2019 07:01:25 -0800
Subject: Re: [RFC PATCH 0/2] Fix for the internal card reader and suspend on
 MacBooks
To:     Ivan Mironov <mironov.ivan@gmail.com>, linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Martin Liu <liumartin@google.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Jon Flatley <jflat@chromium.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Benson Leung <bleung@chromium.org>,
        Harry Pan <harry.pan@intel.com>,
        Jack Stocker <jackstocker.93@gmail.com>,
        Danilo Krummrich <danilokrummrich@dk-develop.de>,
        Samuel Sadok <samuel.sadok@bluewin.ch>
References: <20190213211323.6072-1-mironov.ivan@gmail.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Message-ID: <b85e3801-aff5-89fb-d33a-88568821d4c0@linux.intel.com>
Date:   Thu, 14 Feb 2019 17:03:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190213211323.6072-1-mironov.ivan@gmail.com>
Content-Type: multipart/mixed;
 boundary="------------B4ED0A9FF53D6336E2ACE800"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------B4ED0A9FF53D6336E2ACE800
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13.2.2019 23.13, Ivan Mironov wrote:
> Hi all,
> 
> There is a known problem on some MacBooks: internal card reader
> disappears after the first suspend/resume and all subsequent attempts
> to suspend laptop are failing.
> 
> This was reported[1][2] and even discussed in the mailing lists[3],
> without any real solution. After trying various things[4], including
> some existing quirks, I discovered that switching link state to DISABLED
> before suspend both fixes the card reader device and allows any subsequent
> suspend to succeed.
> 
> First patch adds code for this new quirk, and second patch enables this
> quirk for card reader device which is used in my macbook.
> 
> I'm not really familiar with either USB standards or kernel code to
> support them, so this patch series is RFC. I'm especially unsure with the
> "resume" part, because I implemented it by trial and error mostly.
> However, I'm using kernel with these patches and it works for me.
> 
> Also, feel free to suggest other kernel patches or existing quirks or
> quirk combinations to fix the same problem.
> 
> Oh, and by the way: I've checked schematics of various macbooks available
> on the internet. It seems that the actual chip is Genesys Logic GL3219,
> probably just with the custom ID. What I found curious, is that USB 2.0
> pins of this chip (D+ and D-) are not really connected anywhere, but
> instead shorted through the resistor. Could it be possible that this
> somehow messes up some logic inside the device, host controller or
> linux kernel?
> 

This card reader prevents second system suspend on latest kernels, see thread:
https://marc.info/?l=linux-usb&m=154816680816246&w=2

In that case the card reader fails to resume from usb3 U3 suspend state,
and ends up stuck in USB3 polling state, which now prevents suspend

Could you try a testpatch (attached) to see if it helps?

Thanks
-Mathias

--------------B4ED0A9FF53D6336E2ACE800
Content-Type: text/x-patch;
 name="0001-usb-warm-reset-USB3-ports-stuck-in-polling.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-usb-warm-reset-USB3-ports-stuck-in-polling.patch"

From 6b3b9f3d41b8ac9cf993bf4b88a20e30c99e3b7f Mon Sep 17 00:00:00 2001
From: Mathias Nyman <mathias.nyman@linux.intel.com>
Date: Thu, 14 Feb 2019 15:40:12 +0200
Subject: [PATCH] usb: warm reset USB3 ports stuck in polling

warm reset USB3 ports stuck in polling after 360ms.

In the polling state USB3 ports are link training, which should
not take longer than 360ms according to USB3 specification
tPollingLFPSTimeout value.

The card reader connected to xhci in MacBookPro is found stuck
in this state after resuming from suspend.

Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
---
 drivers/usb/core/hub.c | 36 +++++++++++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 8d4631c..448884d 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -1151,9 +1151,10 @@ static void hub_activate(struct usb_hub *hub, enum hub_activation_type type)
 		 */
 		if (hub_is_superspeed(hdev) &&
 		    ((portstatus & USB_PORT_STAT_LINK_STATE) ==
-						USB_SS_PORT_LS_POLLING))
+						USB_SS_PORT_LS_POLLING)) {
 			need_debounce_delay = true;
-
+			set_bit(port1, hub->event_bits);
+		}
 		/* Clear status-change flags; we'll debounce later */
 		if (portchange & USB_PORT_STAT_C_CONNECTION) {
 			need_debounce_delay = true;
@@ -2697,6 +2698,9 @@ static unsigned hub_is_wusb(struct usb_hub *hub)
 #define HUB_LONG_RESET_TIME	200
 #define HUB_RESET_TIMEOUT	800
 
+#define HUB_LFPS_TIME		24
+#define HUB_LFPS_TIMEOUT	360
+
 /*
  * "New scheme" enumeration causes an extra state transition to be
  * exposed to an xhci host and causes USB3 devices to receive control
@@ -2737,6 +2741,31 @@ static bool hub_port_warm_reset_required(struct usb_hub *hub, int port1,
 		|| link_state == USB_SS_PORT_LS_COMP_MOD;
 }
 
+static bool hub_port_stuck_in_polling(struct usb_hub *hub, int port1,
+				      u16 portstatus)
+{
+	u16 link_state;
+	u16 portchange;
+	int lfps_delay = 0;
+
+	if (!hub_is_superspeed(hub->hdev))
+		return false;
+
+	link_state = portstatus & USB_PORT_STAT_LINK_STATE;
+
+	while (link_state == USB_SS_PORT_LS_POLLING) {
+		msleep(HUB_LFPS_TIME);
+
+		hub_port_status(hub, port1, &portstatus, &portchange);
+		link_state = portstatus & USB_PORT_STAT_LINK_STATE;
+
+		lfps_delay += HUB_LFPS_TIME;
+		if (lfps_delay > HUB_LFPS_TIMEOUT)
+			return true;
+	}
+	return false;
+}
+
 static int hub_port_wait_reset(struct usb_hub *hub, int port1,
 			struct usb_device *udev, unsigned int delay, bool warm)
 {
@@ -5329,7 +5358,8 @@ static void port_event(struct usb_hub *hub, int port1)
 	 * Warm reset a USB3 protocol port if it's in
 	 * SS.Inactive state.
 	 */
-	if (hub_port_warm_reset_required(hub, port1, portstatus)) {
+	if (hub_port_warm_reset_required(hub, port1, portstatus) ||
+	    hub_port_stuck_in_polling(hub, port1, portstatus)) {
 		dev_dbg(&port_dev->dev, "do warm reset\n");
 		if (!udev || !(portstatus & USB_PORT_STAT_CONNECTION)
 				|| udev->state == USB_STATE_NOTATTACHED) {
-- 
2.7.4


--------------B4ED0A9FF53D6336E2ACE800--
