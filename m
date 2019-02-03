Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B93C4151A
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D079D21927
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729540AbfBCOUJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:20:09 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:55270 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729284AbfBCOUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 09:20:03 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqIcs-00064o-AO; Sun, 03 Feb 2019 14:20:02 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9m-0007IO-4h; Sun, 03 Feb 2019 14:49:58 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Felipe Balbi" <felipe.balbi@linux.intel.com>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.106280006@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 232/305] Revert "usb: dwc3: gadget: skip Set/Clear
 Halt when invalid"
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Felipe Balbi <felipe.balbi@linux.intel.com>

commit 38317f5c0f2faae5110854f36edad810f841d62f upstream.

This reverts commit ffb80fc672c3a7b6afd0cefcb1524fb99917b2f3.

Turns out that commit is wrong. Host controllers are allowed to use
Clear Feature HALT as means to sync data toggle between host and
periperal.

Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/usb/dwc3/gadget.c | 5 -----
 1 file changed, 5 deletions(-)

--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1346,9 +1346,6 @@ int __dwc3_gadget_ep_set_halt(struct dwc
 	memset(&params, 0x00, sizeof(params));
 
 	if (value) {
-		if (dep->flags & DWC3_EP_STALL)
-			return 0;
-
 		if (!protocol && ((dep->direction && dep->flags & DWC3_EP_BUSY) ||
 				(!list_empty(&dep->req_queued) ||
 				 !list_empty(&dep->request_list)))) {
@@ -1365,9 +1362,6 @@ int __dwc3_gadget_ep_set_halt(struct dwc
 		else
 			dep->flags |= DWC3_EP_STALL;
 	} else {
-		if (!(dep->flags & DWC3_EP_STALL))
-			return 0;
-
 		ret = dwc3_send_gadget_ep_cmd(dwc, dep->number,
 			DWC3_DEPCMD_CLEARSTALL, &params);
 		if (ret)

