Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53036ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 16:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E5FF20839
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 16:07:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xd5vSLcq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E5FF20839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731529AbeGQQkY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 12:40:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:60254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729716AbeGQQkY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 12:40:24 -0400
Received: from localhost.localdomain (xdsl-188-155-58-14.adslplus.ch [188.155.58.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1785D20841;
        Tue, 17 Jul 2018 16:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531843622;
        bh=JbF86m1wvVVHwkSmHfVKvZ/jKN3TAKPOvx/K8hk49M0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xd5vSLcqrxLeb/voJjaUgLHZ9x6Bj8LXLNA3x7sxuLgCkT5R5tsIzWTxJxouzndvp
         OXJljyNioOAtADbwlowMhpWZ9xJnFt8Lo6kayI6SZVaXUCQg9LpcrUwwX8tRjfuMUl
         U5LJqywT2xbRpevwf6/kSrXS6CUKmea2C8YiOpYw=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Siva Reddy Kallam <siva.kallam@broadcom.com>,
        Prashant Sreedharan <prashant@broadcom.com>,
        Michael Chan <mchan@broadcom.com>,
        Fugang Duan <fugang.duan@nxp.com>,
        Pantelis Antoniou <pantelis.antoniou@gmail.com>,
        Vitaly Bordug <vbordug@ru.mvista.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, devel@driverdev.osuosl.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 6/6] lib: Use existing define with polynomial
Date:   Tue, 17 Jul 2018 18:05:41 +0200
Message-Id: <20180717160541.3843-7-krzk@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180717160541.3843-1-krzk@kernel.org>
References: <20180717160541.3843-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not define again the polynomial but use header with existing define.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 lib/decompress_bunzip2.c | 3 ++-
 lib/xz/xz_crc32.c        | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/decompress_bunzip2.c b/lib/decompress_bunzip2.c
index 0234361b24b8..7c4932eed748 100644
--- a/lib/decompress_bunzip2.c
+++ b/lib/decompress_bunzip2.c
@@ -51,6 +51,7 @@
 #endif /* STATIC */
 
 #include <linux/decompress/mm.h>
+#include <linux/crc32poly.h>
 
 #ifndef INT_MAX
 #define INT_MAX 0x7fffffff
@@ -654,7 +655,7 @@ static int INIT start_bunzip(struct bunzip_data **bdp, void *inbuf, long len,
 	for (i = 0; i < 256; i++) {
 		c = i << 24;
 		for (j = 8; j; j--)
-			c = c&0x80000000 ? (c << 1)^0x04c11db7 : (c << 1);
+			c = c&0x80000000 ? (c << 1)^(CRC32_POLY_BE) : (c << 1);
 		bd->crc32Table[i] = c;
 	}
 
diff --git a/lib/xz/xz_crc32.c b/lib/xz/xz_crc32.c
index 34532d14fd4c..25a5d87e2e4c 100644
--- a/lib/xz/xz_crc32.c
+++ b/lib/xz/xz_crc32.c
@@ -15,6 +15,7 @@
  * but they are bigger and use more memory for the lookup table.
  */
 
+#include <linux/crc32poly.h>
 #include "xz_private.h"
 
 /*
@@ -29,7 +30,7 @@ STATIC_RW_DATA uint32_t xz_crc32_table[256];
 
 XZ_EXTERN void xz_crc32_init(void)
 {
-	const uint32_t poly = 0xEDB88320;
+	const uint32_t poly = CRC32_POLY_LE;
 
 	uint32_t i;
 	uint32_t j;
-- 
2.14.1

