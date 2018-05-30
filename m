Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753251AbeE3LUK (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:20:10 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:32780 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752569AbeE3LHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:07:07 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Thinh Nguyen" <thinhn@synopsys.com>,
        "Felipe Balbi" <felipe.balbi@linux.intel.com>,
        "Thinh Nguyen" <Thinh.Nguyen@synopsys.com>
Date: Wed, 30 May 2018 11:52:41 +0100
Message-ID: <lsq.1527677561.726218401@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 083/153] usb: dwc3: gadget: Set maxpacket size for ep0 IN
In-Reply-To: <lsq.1527677560.486731940@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.2.102-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>

commit 6180026341e852a250e1f97ebdcf71684a3c81b9 upstream.

There are 2 control endpoint structures for DWC3. However, the driver
only updates the OUT direction control endpoint structure during
ConnectDone event. DWC3 driver needs to update the endpoint max packet
size for control IN endpoint as well. If the max packet size is not
properly set, then the driver will incorrectly calculate the data
transfer size and fail to send ZLP for HS/FS 3-stage control read
transfer.

The fix is simply to update the max packet size for the ep0 IN direction
during ConnectDone event.

Fixes: 72246da40f37 ("usb: Introduce DesignWare USB3 DRD Driver")
Signed-off-by: Thinh Nguyen <thinhn@synopsys.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
[bwh: Backported to 3.2: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/usb/dwc3/gadget.c | 2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1821,6 +1821,8 @@ static void dwc3_gadget_conndone_interru
 		break;
 	}
 
+	dwc->eps[1]->endpoint.maxpacket = dwc->gadget.ep0->maxpacket;
+
 	/* Disable unneded PHY */
 	dwc3_gadget_disable_phy(dwc, dwc->gadget.speed);
 
