Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBDC7C6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A172523FE7
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:47:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A172523FE7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932833AbeGFFrd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 01:47:33 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58556 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932265AbeGFFra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 01:47:30 -0400
Received: from localhost (D57D388D.static.ziggozakelijk.nl [213.125.56.141])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E0C35B14;
        Fri,  6 Jul 2018 05:47:29 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Douglas Anderson <dianders@chromium.org>,
        William Wu <william.wu@rock-chips.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: [PATCH 4.17 04/46] usb: dwc2: fix the incorrect bitmaps for the ports of multi_tt hub
Date:   Fri,  6 Jul 2018 07:46:25 +0200
Message-Id: <20180706054524.825002981@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180706054524.595521988@linuxfoundation.org>
References: <20180706054524.595521988@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

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
@@ -383,7 +383,7 @@ static unsigned long *dwc2_get_ls_map(st
 	/* Get the map and adjust if this is a multi_tt hub */
 	map = qh->dwc_tt->periodic_bitmaps;
 	if (qh->dwc_tt->usb_tt->multi)
-		map += DWC2_ELEMENTS_PER_LS_BITMAP * qh->ttport;
+		map += DWC2_ELEMENTS_PER_LS_BITMAP * (qh->ttport - 1);
 
 	return map;
 }


