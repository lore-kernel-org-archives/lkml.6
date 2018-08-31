Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC7CC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EBD72077C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:01:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EBD72077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728928AbeHaTJA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 15:09:00 -0400
Received: from gateway34.websitewelcome.com ([192.185.148.119]:37056 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727880AbeHaTJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 15:09:00 -0400
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id 4079E11EB51
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 10:01:07 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id vkuZfrvdMBcCXvkurfLfnx; Fri, 31 Aug 2018 10:01:07 -0500
X-Authority-Reason: nr=8
Received: from [189.250.90.185] (port=45212 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1fvkuY-003OEJ-PJ; Fri, 31 Aug 2018 10:00:34 -0500
Date:   Fri, 31 Aug 2018 10:00:34 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Corey Minyard <minyard@acm.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH v2] ipmi: Fix NULL pointer dereference in ssif_probe
Message-ID: <20180831150034.GA22019@embeddedor.com>
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
X-Source-IP: 189.250.90.185
X-Source-L: No
X-Exim-ID: 1fvkuY-003OEJ-PJ
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.90.185]:45212
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 5
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a potential execution path in which function ssif_info_find()
returns NULL, hence there is a NULL pointer dereference when accessing
pointer *addr_info*

Fix this by null checking *addr_info* before dereferencing it.

Addresses-Coverity-ID: 1473145 ("Explicit null dereferenced")
Fixes: e333054a91d1 ("ipmi: Fix I2C client removal in the SSIF driver")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
Changes in v2:
 - Fix typo in commit log.

 drivers/char/ipmi/ipmi_ssif.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
index 2ff3679..764d305 100644
--- a/drivers/char/ipmi/ipmi_ssif.c
+++ b/drivers/char/ipmi/ipmi_ssif.c
@@ -1641,7 +1641,9 @@ static int ssif_probe(struct i2c_client *client, const struct i2c_device_id *id)
 
  out:
 	if (rv) {
-		addr_info->client = NULL;
+		if (addr_info)
+			addr_info->client = NULL;
+
 		dev_err(&client->dev, "Unable to start IPMI SSIF: %d\n", rv);
 		kfree(ssif_info);
 	}
-- 
2.7.4

