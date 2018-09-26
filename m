Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB07FC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E62E2083A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:41:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E62E2083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbeIZOxo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 10:53:44 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42065 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbeIZOxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 10:53:44 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1g55OI-0007z3-Rc; Wed, 26 Sep 2018 08:41:50 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] HID: elan: Make array buf static, shrinks object size
Date:   Wed, 26 Sep 2018 09:41:50 +0100
Message-Id: <20180926084150.17514-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Don't populate the array buf on the stack but instead make it
static. Makes the object code smaller by 43 bytes:

Before:
   text	   data	    bss	    dec	    hex	filename
   7769	   1520	      0	   9289	   2449	drivers/hid/hid-elan.o

After:
   text	   data	    bss	    dec	    hex	filename
   7662	   1584	      0	   9246	   241e	drivers/hid/hid-elan.o

(gcc version 8.2.0 x86_64)

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/hid/hid-elan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-elan.c b/drivers/hid/hid-elan.c
index 07e26c3567eb..05377eec2cb2 100644
--- a/drivers/hid/hid-elan.c
+++ b/drivers/hid/hid-elan.c
@@ -393,7 +393,7 @@ static int elan_start_multitouch(struct hid_device *hdev)
 	 * This byte sequence will enable multitouch mode and disable
 	 * mouse emulation
 	 */
-	const unsigned char buf[] = { 0x0D, 0x00, 0x03, 0x21, 0x00 };
+	static const unsigned char buf[] = { 0x0D, 0x00, 0x03, 0x21, 0x00 };
 	unsigned char *dmabuf = kmemdup(buf, sizeof(buf), GFP_KERNEL);
 
 	if (!dmabuf)
-- 
2.17.1

