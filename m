Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E85C7113E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 18:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C842A2145D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 18:55:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="ZFnueuwB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C842A2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbeJPCle (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 22:41:34 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:35686 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbeJPCle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 22:41:34 -0400
Received: from trochilidae.toradex.int (unknown [IPv6:2a02:169:3460::525])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 2B0EA5C00FA;
        Mon, 15 Oct 2018 20:55:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1539629703;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=v0fHTt3nx5QEcGs+tsS9EXt8FcC7/j/oNaBqs6q7BmE=;
        b=ZFnueuwBAjAysXnEpBCDjwrw84js9TFW/5RIN5cOyggmMKWb4C0Znh/YWJfaeJs9tAec/p
        NvEUOJvFJ27MtsRdnep7S6/2PpGJr+kkh5sQWrO7Hc9zVRb1SPIHjV67vW3To3Thy0cewY
        CRMTRe0MDkspB6CqQyBbkSe3lTfo2Ko=
From:   Stefan Agner <stefan@agner.ch>
To:     linux@armlinux.org.uk, arnd@arndb.de
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        joe@perches.com, Stefan Agner <stefan@agner.ch>
Subject: [PATCH v2] ARM: error out if compiling ARMv6 using Clang before 8.0
Date:   Mon, 15 Oct 2018 20:55:00 +0200
Message-Id: <20181015185500.679-1-stefan@agner.ch>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel passes the ArmV6K architecture to the compiler when
using the multi platform selection and enabling ARMv6. Clang
older than version 8.0 emit assembly with an non-existing CPU,
which then makes the GNU assembler fail. Warn users when
compiling ARMv6 using Clang before 8.0.

Suggested-by: Russell King <linux@armlinux.org.uk>
Signed-off-by: Stefan Agner <stefan@agner.ch>
Link: https://github.com/ClangBuiltLinux/linux/issues/55
---
 include/linux/compiler-clang.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
index b1ce500fe8b3..9df8713bef38 100644
--- a/include/linux/compiler-clang.h
+++ b/include/linux/compiler-clang.h
@@ -3,6 +3,10 @@
 #error "Please don't include <linux/compiler-clang.h> directly, include <linux/compiler.h> instead."
 #endif
 
+#if defined(CONFIG_ARCH_MULTI_V6) && CONFIG_CLANG_VERSION < 80000
+#error "Sorry, your compiler is too old - please upgrade it."
+#endif
+
 /* Some compiler specific definitions are overwritten here
  * for Clang compiler
  */
-- 
2.19.1

