Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 264DDC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 14:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3BDD2085B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 14:45:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3BDD2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731072AbeKHAQA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 19:16:00 -0500
Received: from relay.sw.ru ([185.231.240.75]:60268 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726635AbeKHAP7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 19:15:59 -0500
Received: from [172.16.25.12] (helo=i7.sw.ru)
        by relay.sw.ru with esmtp (Exim 4.90_1)
        (envelope-from <aryabinin@virtuozzo.com>)
        id 1gKP54-0002vy-SE; Wed, 07 Nov 2018 17:45:19 +0300
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Olof Johansson <olof@lixom.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
Subject: [PATCH v2] ubsan: don't mark __ubsan_handle_builtin_unreachable as noreturn
Date:   Wed,  7 Nov 2018 17:45:16 +0300
Message-Id: <20181107144516.4587-1-aryabinin@virtuozzo.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <CAOesGMi-vkYPDrL2drJ70zf3_xTMWrsfPoW68TkiRJCj8uWBLg@mail.gmail.com>
References: <CAOesGMi-vkYPDrL2drJ70zf3_xTMWrsfPoW68TkiRJCj8uWBLg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

gcc-8 complains about the prototype for this function:

lib/ubsan.c:432:1: error: ignoring attribute 'noreturn' in declaration of a built-in function '__ubsan_handle_builtin_unreachable' because it conflicts with attribute 'const' [-Werror=attributes]

This is actually a GCC's bug. In GCC internals
__ubsan_handle_builtin_unreachable() declared with both 'noreturn' and
'const' attributes instead of only 'noreturn':
   https://gcc.gnu.org/bugzilla/show_bug.cgi?id=84210

Workaround this by removing the noreturn attribute.

[aryabinin: Add information about GCC bug in changelog]
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
---
 lib/ubsan.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/ubsan.c b/lib/ubsan.c
index 59fee96c29a0..e4162f59a81c 100644
--- a/lib/ubsan.c
+++ b/lib/ubsan.c
@@ -427,8 +427,7 @@ void __ubsan_handle_shift_out_of_bounds(struct shift_out_of_bounds_data *data,
 EXPORT_SYMBOL(__ubsan_handle_shift_out_of_bounds);
 
 
-void __noreturn
-__ubsan_handle_builtin_unreachable(struct unreachable_data *data)
+void __ubsan_handle_builtin_unreachable(struct unreachable_data *data)
 {
 	unsigned long flags;
 
-- 
2.18.1

