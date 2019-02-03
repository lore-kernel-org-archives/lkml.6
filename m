Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB2CC282D7
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 01:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE0672083B
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 01:11:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="zLD8dHZK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbfBCBLT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 20:11:19 -0500
Received: from conuserg-12.nifty.com ([210.131.2.79]:37810 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726746AbfBCBLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 20:11:19 -0500
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp [218.220.227.105]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id x131Ahu6007227;
        Sun, 3 Feb 2019 10:10:44 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com x131Ahu6007227
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1549156244;
        bh=YhxrONbowvqBYAORlK0I14mrTzN2FLYU3WhqlvfQPnc=;
        h=From:To:Cc:Subject:Date:From;
        b=zLD8dHZKpvu8iwQr8XfWi8KSbsAC1s9Hb2GszakkCzw5KYZruKpt/cY+FAOursJei
         NUUWq7U+DZfadzyG7New43I/Ilrll8U47Cv2cHgo/ap+WysIkVw92JkOIN+APOUa6r
         Rcb0ySBPRQO6eFlHjtfuamoNiQYb5F8ey97BdTQlpKA3v9n49Qiq65asYA+ZQygoHX
         I9YUq69WBIH983PIKpg1nbeIfUrT0XnMC7r4z/lIseZ+foNMnYFoe6V4y7uNXGJcnZ
         49OQz3Tz0Uzrnd3l5xTgeGQ+KMtnKW6oruiF2NMnpagJpDdgSJc1aMWgrx1w78l24l
         q3VaRheuh3EzQ==
X-Nifty-SrcIP: [218.220.227.105]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Zhang Yanmin <yanmin.zhang@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] linux/kernel.h: use 'short' to define USHRT_MAX, SHRT_MAX, SHRT_MIN
Date:   Sun,  3 Feb 2019 10:10:41 +0900
Message-Id: <1549156242-20806-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit log of 44f564a4bf6a ("ipc: add definitions of USHORT_MAX
and others") did not explain why it used (s16) and (u16) instead of
(short) and (unsigned short).

Let's use (short) and (unsigned short), which is more sensible, and
more consistent with the other MAX/MIN defines.

As you see in include/uapi/asm-generic/int-ll64.h, s16/u16 are
typedef'ed as signed/unsigned short. So, this commit does not have
a functional change.

Remove the unneeded parentheses around ~0U while we are here.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Zhang Yanmin <yanmin.zhang@intel.com>
---

Changes in v2:
  - Remove unneeded parentheses

 include/linux/kernel.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 8f0e68e..afc19d9 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -16,9 +16,9 @@
 #include <asm/byteorder.h>
 #include <uapi/linux/kernel.h>
 
-#define USHRT_MAX	((u16)(~0U))
-#define SHRT_MAX	((s16)(USHRT_MAX>>1))
-#define SHRT_MIN	((s16)(-SHRT_MAX - 1))
+#define USHRT_MAX	((unsigned short)~0U)
+#define SHRT_MAX	((short)(USHRT_MAX>>1))
+#define SHRT_MIN	((short)(-SHRT_MAX - 1))
 #define INT_MAX		((int)(~0U>>1))
 #define INT_MIN		(-INT_MAX - 1)
 #define UINT_MAX	(~0U)
-- 
2.7.4

