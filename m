Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B573C10F01
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6014217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:06:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728342AbfBRTGp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 14:06:45 -0500
Received: from gateway31.websitewelcome.com ([192.185.143.51]:24488 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726380AbfBRTGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 14:06:43 -0500
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id 58B701C20E
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 13:06:42 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id voFWg9hl42qH7voFWggfj0; Mon, 18 Feb 2019 13:06:42 -0600
X-Authority-Reason: nr=8
Received: from [189.250.119.20] (port=44716 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gvoFV-000cwg-KH; Mon, 18 Feb 2019 13:06:41 -0600
Date:   Mon, 18 Feb 2019 13:06:41 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] usb: core: config: Use struct_size() in kzalloc()
Message-ID: <20190218190641.GA18000@embeddedor>
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
X-Source-IP: 189.250.119.20
X-Source-L: No
X-Exim-ID: 1gvoFV-000cwg-KH
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.119.20]:44716
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One of the more common cases of allocation size calculations is finding
the size of a structure that has a zero-sized array at the end, along
with memory for some number of elements for that array. For example:

struct foo {
    int stuff;
    struct boo entry[];
};

size = sizeof(struct foo) + count * sizeof(struct boo);
instance = kzalloc(size, GFP_KERNEL);

Instead of leaving these open-coded and prone to type mistakes, we can
now use the new struct_size() helper:

instance = kzalloc(struct_size(instance, entry, count), GFP_KERNEL);

Notice that, in this case, variable len is not necessary, hence
it is removed.

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/usb/core/config.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/core/config.c b/drivers/usb/core/config.c
index 7bb6b1bd06c8..20ff036b4c22 100644
--- a/drivers/usb/core/config.c
+++ b/drivers/usb/core/config.c
@@ -552,7 +552,7 @@ static int usb_parse_configuration(struct usb_device *dev, int cfgidx,
 	unsigned char *buffer2;
 	int size2;
 	struct usb_descriptor_header *header;
-	int len, retval;
+	int retval;
 	u8 inums[USB_MAXINTERFACES], nalts[USB_MAXINTERFACES];
 	unsigned iad_num = 0;
 
@@ -707,8 +707,8 @@ static int usb_parse_configuration(struct usb_device *dev, int cfgidx,
 			nalts[i] = j = USB_MAXALTSETTING;
 		}
 
-		len = sizeof(*intfc) + sizeof(struct usb_host_interface) * j;
-		config->intf_cache[i] = intfc = kzalloc(len, GFP_KERNEL);
+		intfc = kzalloc(struct_size(intfc, altsetting, j), GFP_KERNEL);
+		config->intf_cache[i] = intfc;
 		if (!intfc)
 			return -ENOMEM;
 		kref_init(&intfc->ref);
-- 
2.20.1

