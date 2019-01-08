Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48488C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 16:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1150021019
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 16:48:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729209AbfAHQsm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 11:48:42 -0500
Received: from gateway36.websitewelcome.com ([192.185.197.22]:31098 "EHLO
        gateway36.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729164AbfAHQsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 11:48:41 -0500
X-Greylist: delayed 1294 seconds by postgrey-1.27 at vger.kernel.org; Tue, 08 Jan 2019 11:48:40 EST
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway36.websitewelcome.com (Postfix) with ESMTP id 70F01400D160F
        for <linux-kernel@vger.kernel.org>; Tue,  8 Jan 2019 09:39:08 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id guDagVH9j90onguDagzUAC; Tue, 08 Jan 2019 10:27:06 -0600
X-Authority-Reason: nr=8
Received: from [189.250.130.205] (port=53168 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gguDY-001pZ2-VQ; Tue, 08 Jan 2019 10:27:05 -0600
Date:   Tue, 8 Jan 2019 10:27:00 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] uwb: use struct_size() in kzalloc()
Message-ID: <20190108162700.GA27100@embeddedor>
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
X-Exim-ID: 1gguDY-001pZ2-VQ
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.130.205]:53168
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 22
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
 drivers/uwb/drp-ie.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/uwb/drp-ie.c b/drivers/uwb/drp-ie.c
index 1d2a939cfcf8..ed993e363472 100644
--- a/drivers/uwb/drp-ie.c
+++ b/drivers/uwb/drp-ie.c
@@ -125,9 +125,8 @@ static struct uwb_ie_drp *uwb_drp_ie_alloc(void)
 {
 	struct uwb_ie_drp *drp_ie;
 
-	drp_ie = kzalloc(sizeof(struct uwb_ie_drp) +
-			UWB_NUM_ZONES * sizeof(struct uwb_drp_alloc),
-			GFP_KERNEL);
+	drp_ie = kzalloc(struct_size(drp_ie, allocs, UWB_NUM_ZONES),
+			 GFP_KERNEL);
 	if (drp_ie)
 		drp_ie->hdr.element_id = UWB_IE_DRP;
 	return drp_ie;
-- 
2.20.1

