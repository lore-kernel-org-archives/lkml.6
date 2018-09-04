Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73AA2C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28A072077C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:47:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28A072077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbeIDUMw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 16:12:52 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37446 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbeIDUMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 16:12:52 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fxDXn-0001RV-Q3; Tue, 04 Sep 2018 15:47:07 +0000
From:   Colin King <colin.king@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christian Gromm <christian.gromm@microchip.com>,
        George Edward Bulmer <gebulmer@googlemail.com>,
        devel@driverdev.osuosl.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: most: net: make array 'broadcast' static, shrinks object size
Date:   Tue,  4 Sep 2018 16:47:07 +0100
Message-Id: <20180904154707.27452-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Don't populate the array 'broadcast' on the stack but instead make it
static. Makes the object code smaller by 53 bytes:

Before:
   text	   data	    bss	    dec	    hex	filename
  10511	   1521	    448	  12480	   30c0	drivers/staging/most/net/net.o

After:
   text	   data	    bss	    dec	    hex	filename
  10394	   1585	    448	  12427	   308b	drivers/staging/most/net/net.o

(gcc version 8.2.0 x86_64)

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/staging/most/net/net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/most/net/net.c b/drivers/staging/most/net/net.c
index 30d816b7e165..e20584b1b112 100644
--- a/drivers/staging/most/net/net.c
+++ b/drivers/staging/most/net/net.c
@@ -75,7 +75,7 @@ static struct core_component comp;
 static int skb_to_mamac(const struct sk_buff *skb, struct mbo *mbo)
 {
 	u8 *buff = mbo->virt_address;
-	const u8 broadcast[] = { 0x03, 0xFF };
+	static const u8 broadcast[] = { 0x03, 0xFF };
 	const u8 *dest_addr = skb->data + 4;
 	const u8 *eth_type = skb->data + 12;
 	unsigned int payload_len = skb->len - ETH_HLEN;
-- 
2.17.1

