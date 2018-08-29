Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3CB8C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 15:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62B8D205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 15:22:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62B8D205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729086AbeH2TUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 15:20:15 -0400
Received: from gateway34.websitewelcome.com ([192.185.148.196]:36379 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728701AbeH2TUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 15:20:15 -0400
Received: from cm15.websitewelcome.com (cm15.websitewelcome.com [100.42.49.9])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id 573C5174E7A
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 10:22:47 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id v2IPf7AohbXuJv2IjfSUbY; Wed, 29 Aug 2018 10:22:47 -0500
X-Authority-Reason: nr=8
Received: from [189.250.89.86] (port=57176 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1fv2IO-000wzK-37; Wed, 29 Aug 2018 10:22:12 -0500
Date:   Wed, 29 Aug 2018 10:22:09 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Stefan Agner <stefan@agner.ch>, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] HID: core: fix NULL pointer dereference
Message-ID: <20180829152209.GA29831@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.89.86
X-Source-L: No
X-Exim-ID: 1fv2IO-000wzK-37
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.89.86]:57176
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 5
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a NULL pointer dereference in case memory resources
for *parse* are not successfully allocated.

Fix this by adding a new goto label and make the execution
path jump to it in case vzalloc() fails.

Addresses-Coverity-ID: 1473081 ("Dereference after null check")
Fixes: b2dd9f2e5a8a ("HID: core: fix memory leak on probe")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/hid/hid-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 4548dae..5bec924 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1000,7 +1000,7 @@ int hid_open_report(struct hid_device *device)
 	parser = vzalloc(sizeof(struct hid_parser));
 	if (!parser) {
 		ret = -ENOMEM;
-		goto err;
+		goto alloc_err;
 	}
 
 	parser->device = device;
@@ -1049,6 +1049,7 @@ int hid_open_report(struct hid_device *device)
 	hid_err(device, "item fetching failed at offset %d\n", (int)(end - start));
 err:
 	kfree(parser->collection_stack);
+alloc_err:
 	vfree(parser);
 	hid_close_report(device);
 	return ret;
-- 
2.7.4

