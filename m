Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A53C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D6A72403A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:17:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="oiqCC0p6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D6A72403A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753913AbeGEQRM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 12:17:12 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:7113 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753806AbeGEQRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 12:17:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1530807541; x=1562343541;
  h=from:to:cc:subject:date:message-id;
  bh=qsGoYPO0xk7piBX0sLdQJHrqQ/Wcwd6Uh5XGclONRwo=;
  b=oiqCC0p6LkFNdj2T3mMUTi2VlpIuPbgD1/6oMpXJWsQ3YrCwX19D/cPa
   cF9aDFYkESEhX9Nac1fs0cxWZLhDhg8dPD5PAvNbyJDwnWWXKCbT5zH2a
   nB6Qu2B4gZuJ7Wp3vkQolLrzwjfd/bMt0w24X1ST/ISAE2p05sBdmMc7M
   XtenFuq1dC0lvQwp5i6SGh4xr81dBz+7W54wroyidKfvA/271nEGMZ3Mg
   efdM7S7OAVAPZC5sZeakgvyt299GLGrNyHhlCdgayMGFwXkrGp3BLb4f+
   7Fwns8D0aI5bJfYRhSFWsZn4bnAE0D8jpwCwGCxnKTCgWxzct9BkPGm2m
   Q==;
X-IronPort-AV: E=Sophos;i="5.51,313,1526313600"; 
   d="scan'208";a="180318687"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 06 Jul 2018 00:19:00 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 05 Jul 2018 09:06:11 -0700
Received: from thinkpad-bart.sdcorp.global.sandisk.com ([10.111.67.248])
  by uls-op-cesaip02.wdc.com with ESMTP; 05 Jul 2018 09:17:11 -0700
From:   Bart Van Assche <bart.vanassche@wdc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Martin Uecker <Martin.Uecker@med.uni-goettingen.de>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        stable@vger.kernel.org
Subject: [PATCH] kernel.h: Avoid that sparse complains about using sizeof(void)
Date:   Thu,  5 Jul 2018 09:17:09 -0700
Message-Id: <20180705161709.17028-1-bart.vanassche@wdc.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The macro __is_constexpr() causes sparse to report the following:

    warning: expression using sizeof(void)

Avoid this by using __builtin_constant_p() instead.

Fixes: 3c8ba0d61d04 ("kernel.h: Retain constant expression output for max()/min()")
Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Martin Uecker <Martin.Uecker@med.uni-goettingen.de>
Cc: Kees Cook <keescook@chromium.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: <stable@vger.kernel.org>
---
 include/linux/kernel.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index d23123238534..a9f0d0d48971 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -811,13 +811,19 @@ static inline void ftrace_dump(enum ftrace_dump_mode oops_dump_mode) { }
 #define __typecheck(x, y) \
 		(!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
 
+#ifndef __CHECKER__
 /*
  * This returns a constant expression while determining if an argument is
  * a constant expression, most importantly without evaluating the argument.
- * Glory to Martin Uecker <Martin.Uecker@med.uni-goettingen.de>
+ * Glory to Martin Uecker <Martin.Uecker@med.uni-goettingen.de>. However, this
+ * macro causes sparse to report the warning "expression using sizeof(void)".
+ * Hence use __builtin_constant_p() instead when using sparse.
  */
 #define __is_constexpr(x) \
 	(sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))
+#else
+#define __is_constexpr(x) __builtin_constant_p((x))
+#endif
 
 #define __no_side_effects(x, y) \
 		(__is_constexpr(x) && __is_constexpr(y))
-- 
2.18.0

