Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C869C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 19:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 137A7253E9
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 19:45:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 137A7253E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752865AbeGBTpI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 15:45:08 -0400
Received: from anholt.net ([50.246.234.109]:59972 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752570AbeGBTpH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 15:45:07 -0400
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 299A610A1767;
        Mon,  2 Jul 2018 12:45:07 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id Dm12v_axsP6v; Mon,  2 Jul 2018 12:45:06 -0700 (PDT)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 0F17A10A0652;
        Mon,  2 Jul 2018 12:45:06 -0700 (PDT)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 68D152FE2D94; Mon,  2 Jul 2018 12:45:05 -0700 (PDT)
From:   Eric Anholt <eric@anholt.net>
To:     Kees Cook <keescook@chromium.org>,
        Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Eric Anholt <eric@anholt.net>
Subject: [PATCH] fixup! firmware: raspberrypi: Remove VLA usage
Date:   Mon,  2 Jul 2018 12:45:05 -0700
Message-Id: <20180702194505.28355-1-eric@anholt.net>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <Message-ID: <20180629184449.GA37304@beast>
References: <Message-ID: <20180629184449.GA37304@beast>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kees - with this fix to your patch, the kernel boots again (otherwise,
the FW would try to parse the uninitialized bits of stack and throw
errors).  If you're good with me squashing this in, I'll do so and
send it to -next.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 drivers/firmware/raspberrypi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/raspberrypi.c b/drivers/firmware/raspberrypi.c
index b80f15214b73..a200a2174611 100644
--- a/drivers/firmware/raspberrypi.c
+++ b/drivers/firmware/raspberrypi.c
@@ -162,7 +162,7 @@ int rpi_firmware_property(struct rpi_firmware *fw,
 	memcpy(data + sizeof(struct rpi_firmware_property_tag_header),
 	       tag_data, buf_size);
 
-	ret = rpi_firmware_property_list(fw, &data, sizeof(data));
+	ret = rpi_firmware_property_list(fw, &data, buf_size + sizeof(*header));
 	memcpy(tag_data,
 	       data + sizeof(struct rpi_firmware_property_tag_header),
 	       buf_size);
-- 
2.18.0

