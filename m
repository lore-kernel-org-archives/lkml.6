Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60487C3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 15:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C42DA208CA
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 15:10:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dtbo.net header.i=@dtbo.net header.b="NmXJHOZd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C42DA208CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dtbo.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754262AbeGHPKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 11:10:06 -0400
Received: from mic92-4-82-224-21-170.fbx.proxad.net ([82.224.21.170]:54914
        "EHLO dtbo.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752891AbeGHPKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 11:10:05 -0400
X-Greylist: delayed 453 seconds by postgrey-1.27 at vger.kernel.org; Sun, 08 Jul 2018 11:10:04 EDT
Received: from anakin (anakin-wifi [IPv6:2a01:e35:2e01:5aa0:4639:c4ff:fe19:5162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dtbo.net (Postfix) with ESMTPSA id 4312D229B82;
        Sun,  8 Jul 2018 17:02:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dtbo.net; s=dtbo;
        t=1531062149; bh=4kuQqmsCPdNi9+dvLBGofatBTZ34qN5An6kOkan/I/w=;
        h=Date:From:To:Subject;
        b=NmXJHOZdqL6HkMuunXEJWxc1JDyBQVAbbxt8QdiSANdqxnUJcj4eDRvD+ip6sQgvm
         AgjpVLAhPFrpjJwiagyH3L45uyP6VYMvEviiVUuxivFnP8W78EdwcgdKOmrW9THSsa
         m1L9XG66D8rN9Ox0BVw0UH5D6SePfgsl0ED3rXFU=
Date:   Sun, 8 Jul 2018 17:02:20 +0200
From:   Damien =?UTF-8?B?VGjDqWJhdWx0?= <damien@dtbo.net>
To:     Matthew Garrett <mjg59@srcf.ucam.org>,
        "Pali =?UTF-8?B?Um9ow6Fy?=" <pali.rohar@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mario Limonciello <mario.limonciello@dell.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dell-laptop: Fix backlight detection
Message-ID: <20180708170220.35f40818@anakin>
User-Agent: Claws Mail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
  if (buffer->output[0] =3D=3D 0)

Which was changed to:
  ret =3D dell_send_request(...)
  if (ret)

However, dell_send_request() will return 0 if buffer->output[0] =3D=3D 0,
so we must change the check to:
  if (ret =3D=3D 0)

This issue was found on a Dell M4800 laptop, and the fix tested on it
as well.

Fixes: 549b4930f057 ("dell-smbios: Introduce dispatcher for SMM calls")
Signed-off-by: Damien Th=C3=A9bault <damien@dtbo.net>
Tested-by: Damien Th=C3=A9bault <damien@dtbo.net>
---
 drivers/platform/x86/dell-laptop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/dell-laptop.c
b/drivers/platform/x86/dell-laptop.c index f1fa8612db40..06978c14c83b
100644 --- a/drivers/platform/x86/dell-laptop.c
+++ b/drivers/platform/x86/dell-laptop.c
@@ -2185,7 +2185,7 @@ static int __init dell_init(void)
 		dell_fill_request(&buffer, token->location, 0, 0, 0);
 		ret =3D dell_send_request(&buffer,
 					CLASS_TOKEN_READ,
SELECT_TOKEN_AC);
-		if (ret)
+		if (ret =3D=3D 0)
 			max_intensity =3D buffer.output[3];
 	}
=20
--=20
2.17.1
