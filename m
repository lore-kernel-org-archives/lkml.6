Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04148C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 15:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B909920657
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 15:57:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B909920657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbeKCBE4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 21:04:56 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:46769 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726700AbeKCBE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 21:04:56 -0400
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MEFCF-1gQYJg1s9d-00AD8f; Fri, 02 Nov 2018 16:57:13 +0100
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MEFCF-1gQYJg1s9d-00AD8f; Fri, 02 Nov 2018 16:57:13 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Changbin Du <changbin.du@gmail.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        "Levin, Alexander (Sasha Levin)" <alexander.levin@verizon.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] copy_{to,from}_user(): fix compile-time sanity checks with gcc -Og
Date:   Fri,  2 Nov 2018 16:56:58 +0100
Message-Id: <20181102155710.2299475-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:X+qVvBb/GzVwHU4DkPImdxvpq9fq/2URLIt0PbJ2CcEgtbtM1Pw
 mV8YFLzx95+HCpvZ2xZTrbo8c9Uj0QCancrFnk1SwmDVootXzosRAWyIOOdTG9OCu9ffdp+
 epWOLpUuN6IidNTa4RMB4/7F/4ausEYhsZ48Sbe8K5/tZGDI6fioty7GoOjBtqEpkGnnTXV
 wRL1Ge0MbDBIXRDuGqm4g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:exWrVnSCmUE=:owrhYdF4wLavopmMG2oplp
 fRiupg9zSBp825elD5AYIIKJkEXN5mBju4BqcwEUTdr3VZ/+xX9697i+m/ydCFJZoK2oCaPue
 rXMqQxz/ZCKCcy3bDv2E+GwVrHGKKbfer0o5RayGttd76ecwraLhf6lczF/JLvhSZWLq99EVB
 0kMarh5EKFUOG61zclvXbXPp+Of542lO9F1Nyu3J0LHqDQjoIQZD4zmqak6ft7j7ucEZpUcja
 WzA9W+Rj871w0FTTozedmE5ZpNxT/3K85pamfcvRWRheKQzfTlv+f0QvZG7eg3hlSvOVXT1rM
 uTwGmtmY1IyYWyZQQwn3DX0GPim5vXWzJKSIuiLsQI9UskP617UvQ6lfoD338AYjRhJRc2qOT
 37Giwn7DTPwQ+rKVt3WfOZ2zRz6iKuxvMdnXkv/KFIC0sm1ImU3dlRl8Ofn00HuKKEbd0+x+i
 kVx4fvwqTO7kN5hYiHUHeXdA1bw74doNACyT/LSCHO5kz927A6jtLz9pDooDfIMBpGrGjGgF3
 EeA+iOnsgsitXVh8MZJIxOHut/liMPkcA1F1LNAMqIDEdZUsbpEz6BPo0VlNLgi4WhkA7JYSb
 mRGx9cGfiBT1LbdPIuTPu8NPQ6vrSsTriGmKEqF0mv3/z87L7h4FC9wMHCvGwV0R2WSVuvxhk
 kDLHLYLs54qGB5+a9HnBbrJQb1xBz7GRJHj5MTZudzNLu/ZijV9HhbVD2b4TaO4q5m8Y=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_CC_OPTIMIZE_FOR_DEBUGGING is set, we get countless warnings
like

In function 'check_copy_size',
    inlined from 'copy_from_user' at include/linux/uaccess.h:146:6,
    inlined from '__copy_siginfo_from_user' at kernel/signal.c:3032:6:
include/linux/thread_info.h:147:4: error: call to '__bad_copy_to' declared with attribute error: copy destination size is too small

It seems that constant propagation doesn't work well enough to make
this code reliable, so turn it off for that configuration.

Cc: Changbin Du<changbin.du@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/thread_info.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
index 8d8821b3689a..762f379bdf5d 100644
--- a/include/linux/thread_info.h
+++ b/include/linux/thread_info.h
@@ -138,6 +138,11 @@ static __always_inline bool
 check_copy_size(const void *addr, size_t bytes, bool is_source)
 {
 	int sz = __compiletime_object_size(addr);
+
+	/* constant propagation doesn't work well with -Og */
+	if (IS_ENABLED(CONFIG_CC_OPTIMIZE_FOR_DEBUGGING))
+		return true;
+
 	if (unlikely(sz >= 0 && sz < bytes)) {
 		if (!__builtin_constant_p(bytes))
 			copy_overflow(sz, bytes);
-- 
2.18.0

