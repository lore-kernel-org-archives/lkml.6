Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D744C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E7CE2081B
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550500248;
	bh=X/h8T4WRmWKZJ55FqVEnOx+VaToCnT2gcqf/P5RnIv8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Bkt9cZQ7HhI88v6OIgre94cVJUU0vwDHNBwbjhEUq2ukQsEmdNjKAut4pEm8bevEO
	 8hUhLuMJfxR8QTN3vnMwTQHYm3x6mpDmV7Xckws5O0B5ADyBqz3qfBavP7oQ9OIKv7
	 AhJYz5oTHUnk9dq99OFYISZqeu+G+Xvq12rkHdyE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388349AbfBRN60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:58:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:39088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388330AbfBRN6W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:58:22 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1159D2077B;
        Mon, 18 Feb 2019 13:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498301;
        bh=X/h8T4WRmWKZJ55FqVEnOx+VaToCnT2gcqf/P5RnIv8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zz/kaTLP0Kdt9Nw2ML8aFgOKNRwnD3361fM1AUR94s1it1UBzeXExKRyK1PWFVQjv
         Q8nx/g+yCjh3GEoYJur8ZJHY5WurEO+f/d5nJx80vA0pahS9PEDupKGMHh33KQbjzn
         xBBEqpa08SJSLemvzhtY3wUZH47yn+XEvERB5kQk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Julien Thierry <julien.thierry@arm.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        "David A. Long" <dave.long@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 09/58] ARM: 8795/1: spectre-v1.1: use put_user() for __put_user()
Date:   Mon, 18 Feb 2019 14:43:30 +0100
Message-Id: <20190218133509.302032279@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133508.567416115@linuxfoundation.org>
References: <20190218133508.567416115@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

Commit e3aa6243434fd9a82e84bb79ab1abd14f2d9a5a7 upstream.

When Spectre mitigation is required, __put_user() needs to include
check_uaccess. This is already the case for put_user(), so just make
__put_user() an alias of put_user().

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: David A. Long <dave.long@linaro.org>
Reviewed-by: Julien Thierry <julien.thierry@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/include/asm/uaccess.h | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/arm/include/asm/uaccess.h b/arch/arm/include/asm/uaccess.h
index 9ae888775743..b61acd62cffb 100644
--- a/arch/arm/include/asm/uaccess.h
+++ b/arch/arm/include/asm/uaccess.h
@@ -400,6 +400,14 @@ do {									\
 	__pu_err;							\
 })
 
+#ifdef CONFIG_CPU_SPECTRE
+/*
+ * When mitigating Spectre variant 1.1, all accessors need to include
+ * verification of the address space.
+ */
+#define __put_user(x, ptr) put_user(x, ptr)
+
+#else
 #define __put_user(x, ptr)						\
 ({									\
 	long __pu_err = 0;						\
@@ -407,12 +415,6 @@ do {									\
 	__pu_err;							\
 })
 
-#define __put_user_error(x, ptr, err)					\
-({									\
-	__put_user_switch((x), (ptr), (err), __put_user_nocheck);	\
-	(void) 0;							\
-})
-
 #define __put_user_nocheck(x, __pu_ptr, __err, __size)			\
 	do {								\
 		unsigned long __pu_addr = (unsigned long)__pu_ptr;	\
@@ -492,6 +494,7 @@ do {									\
 	: "r" (x), "i" (-EFAULT)				\
 	: "cc")
 
+#endif /* !CONFIG_CPU_SPECTRE */
 
 #ifdef CONFIG_MMU
 extern unsigned long __must_check
-- 
2.19.1



