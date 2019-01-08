Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5358DC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 15:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21D0521019
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 15:40:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728972AbfAHPkz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 10:40:55 -0500
Received: from gateway22.websitewelcome.com ([192.185.46.126]:11234 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728238AbfAHPkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 10:40:55 -0500
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway22.websitewelcome.com (Postfix) with ESMTP id CA40327DAF
        for <linux-kernel@vger.kernel.org>; Tue,  8 Jan 2019 09:40:51 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id gtUpgrwII2PzOgtUpgWdQM; Tue, 08 Jan 2019 09:40:51 -0600
X-Authority-Reason: nr=8
Received: from [189.250.130.205] (port=52186 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1ggtUo-001OrQ-0j; Tue, 08 Jan 2019 09:40:50 -0600
Date:   Tue, 8 Jan 2019 09:40:46 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] xhci: Use struct_size() in kzalloc()
Message-ID: <20190108154046.GA13254@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.130.205
X-Source-L: No
X-Exim-ID: 1ggtUo-001OrQ-0j
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.130.205]:52186
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 20
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One of the more common cases of allocation size calculations is finding the
size of a structure that has a zero-sized array at the end, along with memory
for some number of elements for that array. For example:

struct foo {
    int stuff;
    void *entry[];
};

instance = kzalloc(sizeof(struct foo) + sizeof(void *) * count, GFP_KERNEL);

Instead of leaving these open-coded and prone to type mistakes, we can now
use the new struct_size() helper:

instance = kzalloc(struct_size(instance, entry, count), GFP_KERNEL);

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/usb/host/xhci.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 005e65922608..7fa58c99f126 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -1455,8 +1455,7 @@ static int xhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb, gfp_t mem_flag
 	else
 		num_tds = 1;
 
-	urb_priv = kzalloc(sizeof(struct urb_priv) +
-			   num_tds * sizeof(struct xhci_td), mem_flags);
+	urb_priv = kzalloc(struct_size(urb_priv, td, num_tds), mem_flags);
 	if (!urb_priv)
 		return -ENOMEM;
 
-- 
2.20.1

