Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 861B3C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 23:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F8C321471
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 23:08:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ucCpO9Hr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F8C321471
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730619AbeISEnF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 00:43:05 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42083 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbeISEnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 00:43:04 -0400
Received: by mail-pf1-f193.google.com with SMTP id l9-v6so1715713pff.9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 16:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=8Y0bXWSSCROkEHayosBp2ltVkICRjdmC0LG3AIht8mE=;
        b=ucCpO9Hr6vunnYYWcNZvxT/3XR6RJgJPlI1WmJ1LT4Gzh4dzJtQ1Id+5iE74Ymy1Cn
         2p1yidyyXgC5IZZSpfBO3M+jCw+jROkmU2d/EFz1xnsiPFkq5n+iUDaABmKXNLHqF4ph
         QhNcahv7MFJwtAugq6duqO3Qhv/K4sYJ/lhHCclhzLwwuVlwPpSIeAPxdnLVLqZ30sog
         GhKRjJOe6iNQetjS+JlTdYgdifVoFkiNIPvgFzbnQbyiKcunZUcRtST00fvW0yZTmSOb
         tgVCmGINAVUggnZDNw5t/iyGdPBUW5mHtVO3T5vLufSOqTiRhK8YGXRW1+Eb8VRbzWos
         V5Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=8Y0bXWSSCROkEHayosBp2ltVkICRjdmC0LG3AIht8mE=;
        b=ByDtCf6TGJD1QubpbfDs2JNGLnGu/vlL0uPvwjltjV6PnT48a3EJb1rB77e7e9PjbD
         QlU8ITuwyAbealRbjfZGHkRmjT08/W4kY+oMSY8C22el4hgoe71/BpnQpid8xBuq0ZTb
         wI0rKrj74CghbfUBGgOBoyPO0J4dMGU+UuWisuuTQLdRv2iu8qXeV562+3XQMkWViqY+
         8HHV4MEuf1eB2CJ/FSG9vPt0XY4bG0Zui/+RagCD6wl1NzxQXCZOFPs6RF7A61xnxGxG
         Iohme8khlC/KUyxRFK1jwTddhWs5ziKPEUKkjvCSiBDDAKSbEHXriYAZ/S6bhzkodMXH
         rpbA==
X-Gm-Message-State: APzg51ATIVxr4AvneesjbjfN1DRRYmN8XUYid24/H6yfypHWfTNcAeoK
        PREEMzJv2iDYVz04LgWtTQY=
X-Google-Smtp-Source: ANB0VdZqT42Veg+06KDf7AEwOgLwQGw4nJ3fnTTWLEnzmhZTMNrh5liqYYXaHEJIaJyKCAnjBiXhmg==
X-Received: by 2002:a62:a65a:: with SMTP id t87-v6mr32754651pfe.225.1537312093491;
        Tue, 18 Sep 2018 16:08:13 -0700 (PDT)
Received: from aurora.jms.id.au ([45.124.203.19])
        by smtp.gmail.com with ESMTPSA id g11-v6sm24512769pgi.90.2018.09.18.16.08.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Sep 2018 16:08:12 -0700 (PDT)
Received: by aurora.jms.id.au (sSMTP sendmail emulation); Wed, 19 Sep 2018 08:38:05 +0930
From:   Joel Stanley <joel@jms.id.au>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Oliver O'Halloran <oohall@gmail.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] lib/xz: Fix powerpc build with KERNEL_XZ
Date:   Wed, 19 Sep 2018 08:37:56 +0930
Message-Id: <20180918230756.26035-1-joel@jms.id.au>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This partially reverts faa16bc404d72a5 ("lib: Use existing define with
polynomial").

The cleanup added a dependency on include/linux, which broke the PowerPC
boot wrapper/decompresser when KERNEL_XZ is enabled:

  BOOTCC  arch/powerpc/boot/decompress.o
 In file included from arch/powerpc/boot/../../../lib/decompress_unxz.c:233,
                 from arch/powerpc/boot/decompress.c:42:
 arch/powerpc/boot/../../../lib/xz/xz_crc32.c:18:10: fatal error:
 linux/crc32poly.h: No such file or directory
  #include <linux/crc32poly.h>
           ^~~~~~~~~~~~~~~~~~~

The powerpc decompressor is a hairy corner of the kernel. Even while building
a 64-bit kernel it needs to build a 32-bit binary and therefore avoid including
files from include/linux.

Fixes: faa16bc404d7 ("lib: Use existing define with polynomial")
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
We need to clean up the powerpc boot decompresser but that work will be
more involved than we would include in a late -rc. Please consider
merging this fix for 4.19. Thanks!

 lib/xz/xz_crc32.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/xz/xz_crc32.c b/lib/xz/xz_crc32.c
index 25a5d87e2e4c..34532d14fd4c 100644
--- a/lib/xz/xz_crc32.c
+++ b/lib/xz/xz_crc32.c
@@ -15,7 +15,6 @@
  * but they are bigger and use more memory for the lookup table.
  */
 
-#include <linux/crc32poly.h>
 #include "xz_private.h"
 
 /*
@@ -30,7 +29,7 @@ STATIC_RW_DATA uint32_t xz_crc32_table[256];
 
 XZ_EXTERN void xz_crc32_init(void)
 {
-	const uint32_t poly = CRC32_POLY_LE;
+	const uint32_t poly = 0xEDB88320;
 
 	uint32_t i;
 	uint32_t j;
-- 
2.17.1

