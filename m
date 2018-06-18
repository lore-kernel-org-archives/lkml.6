Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5562AC5AE59
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 20:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D0972075E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 20:48:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D0972075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936934AbeFRUsT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 16:48:19 -0400
Received: from s3.sipsolutions.net ([144.76.63.242]:58248 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934880AbeFRUsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 16:48:18 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.91)
        (envelope-from <johannes@sipsolutions.net>)
        id 1fV14T-0003SC-C4; Mon, 18 Jun 2018 22:48:17 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v5 1/3] bitfield: fix *_encode_bits()
Date:   Mon, 18 Jun 2018 22:48:14 +0200
Message-Id: <20180618204816.30806-1-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's a bug in *_encode_bits() in using ~field_multiplier() for
the check whether or not the constant value fits into the field,
this is wrong and clearly ~field_mask() was intended. This was
triggering for me for both constant and non-constant values.

Additionally, make this case actually into an compile error.
Declaring the extern function that will never exist with just a
warning is pointless as then later we'll just get a link error.

While at it, also fix the indentation in those lines I'm touching.

Finally, as suggested by Andy Shevchenko, add some tests and for
that introduce also u8 helpers. The tests don't compile without
the fix, showing that it's necessary.

Fixes: 00b0c9b82663 ("Add primitives for manipulating bitfields both in host- and fixed-endian.")
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
---
v2: replace stray tab by space
v3: u8 helpers, tests
v4: minor cleanup (Andy)
    split into two patches (Andy)

If you don't mind, I'd like to take this through the networking
tree(s) as a fix since I have some pending code that depends on
it.
---
 include/linux/bitfield.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
index cf2588d81148..147a7bb341dd 100644
--- a/include/linux/bitfield.h
+++ b/include/linux/bitfield.h
@@ -104,7 +104,7 @@
 		(typeof(_mask))(((_reg) & (_mask)) >> __bf_shf(_mask));	\
 	})
 
-extern void __compiletime_warning("value doesn't fit into mask")
+extern void __compiletime_error("value doesn't fit into mask")
 __field_overflow(void);
 extern void __compiletime_error("bad bitfield mask")
 __bad_mask(void);
@@ -121,8 +121,8 @@ static __always_inline u64 field_mask(u64 field)
 #define ____MAKE_OP(type,base,to,from)					\
 static __always_inline __##type type##_encode_bits(base v, base field)	\
 {									\
-        if (__builtin_constant_p(v) &&	(v & ~field_multiplier(field)))	\
-			    __field_overflow();				\
+	if (__builtin_constant_p(v) && (v & ~field_mask(field)))	\
+		__field_overflow();					\
 	return to((v & field_mask(field)) * field_multiplier(field));	\
 }									\
 static __always_inline __##type type##_replace_bits(__##type old,	\
-- 
2.14.4

