Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B0B5C46475
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 03:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 757EC2082E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 03:17:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="cSThd1DH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 757EC2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbeJZLw3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 07:52:29 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:38281 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725754AbeJZLw3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 07:52:29 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 27168cfd;
        Fri, 26 Oct 2018 03:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=mail; bh=zH7lmNzbcb4poiRyxY8QYeJLI
        p8=; b=cSThd1DH5EwXpjo+odukpoJ2qxeBjJgi2FmK/lSFU92gKEfVHBjUkPKIZ
        Uac0dCylJx0wVswcxAFbQ4OZObZ8Fy0BidVT4ZRbyKD0ARPxgVg7D8qYisdtAWuz
        ChG7iYPTdnm4KOd2tumo3e5NWErkvrb6iMxm7D5htHDsZm2q2HHHjYirAQ7rbojL
        WlldcTw4OFnjch44UuGeVrpSzdRaBvtiXIGzjxHO6EF9nmB4TBWLS101CEWjNcwA
        G1Fuke5YdVJzbQMZLFzEEi5npUtToFH9Nf2+2ErzWfzGVWEDXxkpEMiM9dWFgpCt
        xRbyAi7sUe+W0UYH/l2/TOM01AwKw==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 776bb1e7 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Fri, 26 Oct 2018 03:14:18 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-sparse@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH sparse] parse: shifting by full number of bits is undefined
Date:   Fri, 26 Oct 2018 05:17:00 +0200
Message-Id: <20181026031700.12310-1-Jason@zx2c4.com>
In-Reply-To: <CAHmME9oZk7Afns=W=xM=6waqvVfV+iAdAcB6731xzUUcm4P0zA@mail.gmail.com>
References: <CAHmME9oZk7Afns=W=xM=6waqvVfV+iAdAcB6731xzUUcm4P0zA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The type checker wasn't identifying upper bounds for huge unsigned
64-bit numbers, because the right shift turned into a no-op:

zx2c4@thinkpad /tmp $ cat sparse.c
enum { sparse_does_not_like_this = 0x8000000000000003ULL };
zx2c4@thinkpad /tmp $ sparse sparse.c
sparse.c:1:36: warning: cast truncates bits from constant value (8000000000000003 becomes 3)

This works around the issue by detecting when we're going to shift by
the size of the variable and treat that as always zero.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 parse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/parse.c b/parse.c
index 02a55a7..02d0615 100644
--- a/parse.c
+++ b/parse.c
@@ -788,7 +788,7 @@ static int type_is_ok(struct symbol *type, Num *upper, Num *lower)
 
 	if (!is_unsigned)
 		shift--;
-	if (upper->x == 0 && upper->y >> shift)
+	if (upper->x == 0 && (shift < (sizeof(upper->y) << 3)) && upper->y >> shift)
 		return 0;
 	if (lower->x == 0 || (!is_unsigned && (~lower->y >> shift) == 0))
 		return 1;
-- 
2.19.1

