Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28784C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECACD2089A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:09:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECACD2089A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729484AbeJBUw7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:52:59 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60708 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729012AbeJBUL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:11:26 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7208CC4D;
        Tue,  2 Oct 2018 13:28:04 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 091/228] bitfield: fix *_encode_bits()
Date:   Tue,  2 Oct 2018 06:23:08 -0700
Message-Id: <20181002132505.510087314@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132459.032960735@linuxfoundation.org>
References: <20181002132459.032960735@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johannes Berg <johannes@sipsolutions.net>

[ Upstream commit e7d4a95da86e0b048702765bbdcdc968aaf312e7 ]

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
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/bitfield.h |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

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
@@ -121,8 +121,8 @@ static __always_inline u64 field_mask(u6
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


