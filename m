Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB290C07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA4F220881
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:45:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA4F220881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730112AbeIMSyh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:54:37 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60654 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728239AbeIMSyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:54:36 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E2BF0D19;
        Thu, 13 Sep 2018 13:45:03 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 053/115] powerpc/uaccess: Enable get_user(u64, *p) on 32-bit
Date:   Thu, 13 Sep 2018 15:31:13 +0200
Message-Id: <20180913131826.947176586@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131823.327472833@linuxfoundation.org>
References: <20180913131823.327472833@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Ellerman <mpe@ellerman.id.au>

[ Upstream commit f7a6947cd49b7ff4e03f1b4f7e7b223003d752ca ]

Currently if you build a 32-bit powerpc kernel and use get_user() to
load a u64 value it will fail to build with eg:

  kernel/rseq.o: In function `rseq_get_rseq_cs':
  kernel/rseq.c:123: undefined reference to `__get_user_bad'

This is hitting the check in __get_user_size() that makes sure the
size we're copying doesn't exceed the size of the destination:

  #define __get_user_size(x, ptr, size, retval)
  do {
  	retval = 0;
  	__chk_user_ptr(ptr);
  	if (size > sizeof(x))
  		(x) = __get_user_bad();

Which doesn't immediately make sense because the size of the
destination is u64, but it's not really, because __get_user_check()
etc. internally create an unsigned long and copy into that:

  #define __get_user_check(x, ptr, size)
  ({
  	long __gu_err = -EFAULT;
  	unsigned long  __gu_val = 0;

The problem being that on 32-bit unsigned long is not big enough to
hold a u64. We can fix this with a trick from hpa in the x86 code, we
statically check the type of x and set the type of __gu_val to either
unsigned long or unsigned long long.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/include/asm/uaccess.h |   13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -223,10 +223,17 @@ do {								\
 	}							\
 } while (0)
 
+/*
+ * This is a type: either unsigned long, if the argument fits into
+ * that type, or otherwise unsigned long long.
+ */
+#define __long_type(x) \
+	__typeof__(__builtin_choose_expr(sizeof(x) > sizeof(0UL), 0ULL, 0UL))
+
 #define __get_user_nocheck(x, ptr, size)			\
 ({								\
 	long __gu_err;						\
-	unsigned long __gu_val;					\
+	__long_type(*(ptr)) __gu_val;				\
 	const __typeof__(*(ptr)) __user *__gu_addr = (ptr);	\
 	__chk_user_ptr(ptr);					\
 	if (!is_kernel_addr((unsigned long)__gu_addr))		\
@@ -239,7 +246,7 @@ do {								\
 #define __get_user_check(x, ptr, size)					\
 ({									\
 	long __gu_err = -EFAULT;					\
-	unsigned long  __gu_val = 0;					\
+	__long_type(*(ptr)) __gu_val = 0;				\
 	const __typeof__(*(ptr)) __user *__gu_addr = (ptr);		\
 	might_fault();							\
 	if (access_ok(VERIFY_READ, __gu_addr, (size)))			\
@@ -251,7 +258,7 @@ do {								\
 #define __get_user_nosleep(x, ptr, size)			\
 ({								\
 	long __gu_err;						\
-	unsigned long __gu_val;					\
+	__long_type(*(ptr)) __gu_val;				\
 	const __typeof__(*(ptr)) __user *__gu_addr = (ptr);	\
 	__chk_user_ptr(ptr);					\
 	__get_user_size(__gu_val, __gu_addr, (size), __gu_err);	\


