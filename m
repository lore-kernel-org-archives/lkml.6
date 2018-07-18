Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F5EECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57DFD20852
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:06:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dtbo.net header.i=@dtbo.net header.b="Lkt8oHRQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57DFD20852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dtbo.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbeGRKnM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 06:43:12 -0400
Received: from mic92-4-82-224-21-170.fbx.proxad.net ([82.224.21.170]:56344
        "EHLO dtbo.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726264AbeGRKnM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 06:43:12 -0400
Received: by dtbo.net (Postfix, from userid 1000)
        id 43DE322A0DB; Wed, 18 Jul 2018 12:06:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dtbo.net; s=dtbo;
        t=1531908361; bh=4O/mXeyWX2GFHqhUFAxCIDP7YxJAzXMJnC5gAopHu7k=;
        h=Date:From:To:Cc:Subject;
        b=Lkt8oHRQ+n+VBvLvxlb085WkHcK8rUA0KOMkU3erepNwJn03PyQrtYfbBlDvlrzxS
         3u0Y6vg4PddrH7iIxldEGIsGr1OrBew0jX3rSdhFA/iYZVbK5pdcJLvTLCeLByDnn6
         xXNuzy90I+qB+fvsnLcfGYTzcRn12S78IOqQQDes=
Date:   Wed, 18 Jul 2018 12:06:01 +0200
From:   Damien =?iso-8859-1?Q?Th=E9bault?= <damien@dtbo.net>
To:     Darren Hart <dvhart@infradead.org>
Cc:     Matthew Garrett <mjg59@srcf.ucam.org>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>,
        Andy Shevchenko <andy@infradead.org>,
        Mario Limonciello <mario.limonciello@dell.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [FIXED][PATCH] dell-laptop: Fix backlight detection
Message-ID: <20180718100601.GA30600@han>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix return code check for "max brightness" ACPI call.

The dell laptop ACPI video brightness control is not present on dell
laptops anymore, but was present in older kernel versions.

The code that checks the return value is incorrect since the SMM
refactoring.

The old code was:
  if (buffer->output[0] == 0)

Which was changed to:
  ret = dell_send_request(...)
  if (ret)

However, dell_send_request() will return 0 if buffer->output[0] == 0,
so we must change the check to:
  if (ret == 0)

This issue was found on a Dell M4800 laptop, and the fix tested on it
as well.

Fixes: 549b4930f057 ("dell-smbios: Introduce dispatcher for SMM calls")
Signed-off-by: Damien Thébault <damien@dtbo.net>
Tested-by: Damien Thébault <damien@dtbo.net>
Reviewed-by: Pali Rohár <pali.rohar@gmail.com>
Reviewed-by: Mario Limonciello <mario.limonciello@dell.com>
---
 drivers/platform/x86/dell-laptop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/dell-laptop.c b/drivers/platform/x86/dell-laptop.c
index f1fa8612db40..06978c14c83b 100644
--- a/drivers/platform/x86/dell-laptop.c
+++ b/drivers/platform/x86/dell-laptop.c
@@ -2185,7 +2185,7 @@ static int __init dell_init(void)
 		dell_fill_request(&buffer, token->location, 0, 0, 0);
 		ret = dell_send_request(&buffer,
 					CLASS_TOKEN_READ, SELECT_TOKEN_AC);
-		if (ret)
+		if (ret == 0)
 			max_intensity = buffer.output[3];
 	}
 
-- 
2.18.0

