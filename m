Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 184D7C6778C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0E0D27BC5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:44:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="c3wOoSnH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0E0D27BC5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936304AbeF2Soy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 14:44:54 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:39117 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935054AbeF2Sow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 14:44:52 -0400
Received: by mail-pl0-f67.google.com with SMTP id s24-v6so4861077plq.6
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 11:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=HCezOq1lpuSSoWechk40inSVMKR3P0rd6UQOxjWQVgg=;
        b=c3wOoSnHvD+TE0txQaW6N02a10AYHdFUcD5C85w7Iu/eui+7ByDMZWVEj9kPDvb5pP
         MhRjip80/GpQPlJRxZk75EaSqGWRUb5qCoj2sqx4NrfYpac5lpzymLYqumgrz3dgLXBv
         J9u9gyJwNA4+zvplsfQ/q+83ARrzo5Z1IuOAI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=HCezOq1lpuSSoWechk40inSVMKR3P0rd6UQOxjWQVgg=;
        b=o66+050FyVhXJOBtXh7eiP1iXuV3OUGhlab7szH+cnG70wIgZ4FVwjrt4KDJCQG/cN
         ED9N5O/dVqfZQ+Ox3+6xOma/uA1E7oFWZpbZuKn3l0My/EqLRW+FMYcPm0zo5jMiAGo+
         OdC4ZIl8wQD4HkhXtTn+h5Z002O2dU/A4Im445uz+6cRd0NwoOdFZJVV8f/bSPjcdIL+
         oepVKafj/q+eB7DFQcGlSZdjvbM+OZG4aUWfhgd+le9JjcpEaSrYhikIBdRu+ppNVKHX
         WtaKKEO0Orj3tuUrm/lzUovM1bKLoP57Pvfro/kKOnuIDV/ZS3e2s3YgtnmVkcq+DGkl
         QohQ==
X-Gm-Message-State: APt69E3zroyttmXKDNMAK2YoUPujXakNwTw8hNW0kIPE8Dd3MDHMPQ98
        JbotwtVhJ4JIOmhYlFdMELSIyOi8MfI=
X-Google-Smtp-Source: ADUXVKLw/StZ0hJlrzoqA66wvAGzVrfmCBVWfzoroC3J9AsmbN7Bf9zi7nbLzAzrPPOYv3bSndDefQ==
X-Received: by 2002:a17:902:bcc3:: with SMTP id o3-v6mr15906079pls.336.1530297892390;
        Fri, 29 Jun 2018 11:44:52 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id v13-v6sm22494467pfa.131.2018.06.29.11.44.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Jun 2018 11:44:51 -0700 (PDT)
Date:   Fri, 29 Jun 2018 11:44:50 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Eric Anholt <eric@anholt.net>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] firmware: raspberrypi: Remove VLA usage
Message-ID: <20180629184449.GA37304@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the quest to remove all stack VLA usage from the kernel[1], this
removes the VLA in favor of a maximum size and adds a sanity check.
Existing callers of the firmware interface never need more than 24
bytes (struct gpio_set_config). This chooses 32 just to stay ahead
of future growth.

[1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/firmware/raspberrypi.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/raspberrypi.c b/drivers/firmware/raspberrypi.c
index 0602626bf72d..b80f15214b73 100644
--- a/drivers/firmware/raspberrypi.c
+++ b/drivers/firmware/raspberrypi.c
@@ -21,6 +21,8 @@
 #define MBOX_DATA28(msg)		((msg) & ~0xf)
 #define MBOX_CHAN_PROPERTY		8
 
+#define MAX_RPI_FW_PROP_BUF_SIZE	32
+
 static struct platform_device *rpi_hwmon;
 
 struct rpi_firmware {
@@ -145,11 +147,15 @@ int rpi_firmware_property(struct rpi_firmware *fw,
 	/* Single tags are very small (generally 8 bytes), so the
 	 * stack should be safe.
 	 */
-	u8 data[buf_size + sizeof(struct rpi_firmware_property_tag_header)];
+	u8 data[sizeof(struct rpi_firmware_property_tag_header) +
+		MAX_RPI_FW_PROP_BUF_SIZE];
 	struct rpi_firmware_property_tag_header *header =
 		(struct rpi_firmware_property_tag_header *)data;
 	int ret;
 
+	if (WARN_ON(buf_size > sizeof(data) - sizeof(*header)))
+		return -EINVAL;
+
 	header->tag = tag;
 	header->buf_size = buf_size;
 	header->req_resp_size = 0;
-- 
2.17.1


-- 
Kees Cook
Pixel Security
