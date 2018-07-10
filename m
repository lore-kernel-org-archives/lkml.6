Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A85F5C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A3452083E
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:30:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A3452083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388127AbeGJSai (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:30:38 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45604 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733070AbeGJSag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:30:36 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id CC71EEB4;
        Tue, 10 Jul 2018 18:30:24 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Douglas Anderson <dianders@chromium.org>,
        William Wu <william.wu@rock-chips.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: [PATCH 4.9 04/52] usb: dwc2: fix the incorrect bitmaps for the ports of multi_tt hub
Date:   Tue, 10 Jul 2018 20:24:32 +0200
Message-Id: <20180710182449.581068549@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180710182449.285532226@linuxfoundation.org>
References: <20180710182449.285532226@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: William Wu <william.wu@rock-chips.com>

commit 8760675932ddb614e83702117d36ea644050c609 upstream.

The dwc2_get_ls_map() use ttport to reference into the
bitmap if we're on a multi_tt hub. But the bitmaps index
from 0 to (hub->maxchild - 1), while the ttport index from
1 to hub->maxchild. This will cause invalid memory access
when the number of ttport is hub->maxchild.

Without this patch, I can easily meet a Kernel panic issue
if connect a low-speed USB mouse with the max port of FE2.1
multi-tt hub (1a40:0201) on rk3288 platform.

Fixes: 9f9f09b048f5 ("usb: dwc2: host: Totally redo the microframe scheduler")
Cc: <stable@vger.kernel.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Acked-by: Minas Harutyunyan hminas@synopsys.com>
Signed-off-by: William Wu <william.wu@rock-chips.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/dwc2/hcd_queue.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/dwc2/hcd_queue.c
+++ b/drivers/usb/dwc2/hcd_queue.c
@@ -479,7 +479,7 @@ static unsigned long *dwc2_get_ls_map(st
 	/* Get the map and adjust if this is a multi_tt hub */
 	map = qh->dwc_tt->periodic_bitmaps;
 	if (qh->dwc_tt->usb_tt->multi)
-		map += DWC2_ELEMENTS_PER_LS_BITMAP * qh->ttport;
+		map += DWC2_ELEMENTS_PER_LS_BITMAP * (qh->ttport - 1);
 
 	return map;
 }


