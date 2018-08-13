Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 367CFC46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 09:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB4D021763
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 09:27:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB4D021763
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728957AbeHMMIm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 08:08:42 -0400
Received: from exmail.andestech.com ([59.124.169.137]:19720 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728192AbeHMMIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 08:08:42 -0400
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id w7D9PoTV066547;
        Mon, 13 Aug 2018 17:25:50 +0800 (GMT-8)
        (envelope-from zong@andestech.com)
Received: from atcsqa06.andestech.com (10.0.1.85) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Mon, 13 Aug 2018
 17:27:04 +0800
From:   Zong Li <zong@andestech.com>
To:     <green.hu@gmail.com>, <deanbo422@gmail.com>,
        <linux-kernel@vger.kernel.org>
CC:     <zongbox@gmail.com>, Zong Li <zong@andestech.com>
Subject: [PATCH 1/3] nds32: Fix get_user/put_user macro expand pointer problem
Date:   Mon, 13 Aug 2018 17:26:51 +0800
Message-ID: <ec4079952b8138e8ed7d775a56580aeec99e1c1c.1534151350.git.zong@andestech.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1534151350.git.zong@andestech.com>
References: <cover.1534151350.git.zong@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.1.85]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com w7D9PoTV066547
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pointer argument of macro need to be taken out once first, and then
use the new pointer in the macro body.

In kernel/trace/trace.c, get_user(ch, ubuf++) causes the unexpected
increment after expand the macro.

Signed-off-by: Zong Li <zong@andestech.com>
---
 arch/nds32/include/asm/uaccess.h | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/arch/nds32/include/asm/uaccess.h b/arch/nds32/include/asm/uaccess.h
index 18a009f..3f771e0 100644
--- a/arch/nds32/include/asm/uaccess.h
+++ b/arch/nds32/include/asm/uaccess.h
@@ -78,8 +78,9 @@ static inline void set_fs(mm_segment_t fs)
 #define get_user(x,p)							\
 ({									\
 	long __e = -EFAULT;						\
-	if(likely(access_ok(VERIFY_READ,  p, sizeof(*p)))) {		\
-		__e = __get_user(x,p);					\
+	const __typeof__(*(p)) __user *__p = (p);			\
+	if(likely(access_ok(VERIFY_READ, __p, sizeof(*__p)))) {		\
+		__e = __get_user(x, __p);				\
 	} else								\
 		x = 0;							\
 	__e;								\
@@ -99,10 +100,10 @@ static inline void set_fs(mm_segment_t fs)
 
 #define __get_user_err(x,ptr,err)					\
 do {									\
-	unsigned long __gu_addr = (unsigned long)(ptr);			\
+	const __typeof__(*(ptr)) __user *__gu_addr = (ptr);		\
 	unsigned long __gu_val;						\
-	__chk_user_ptr(ptr);						\
-	switch (sizeof(*(ptr))) {					\
+	__chk_user_ptr(__gu_addr);					\
+	switch (sizeof(*(__gu_addr))) {					\
 	case 1:								\
 		__get_user_asm("lbi",__gu_val,__gu_addr,err);		\
 		break;							\
@@ -119,7 +120,7 @@ do {									\
 		BUILD_BUG(); 						\
 		break;							\
 	}								\
-	(x) = (__typeof__(*(ptr)))__gu_val;				\
+	(x) = (__typeof__(*(__gu_addr)))__gu_val;			\
 } while (0)
 
 #define __get_user_asm(inst,x,addr,err)					\
@@ -169,8 +170,9 @@ do {									\
 #define put_user(x,p)							\
 ({									\
 	long __e = -EFAULT;						\
-	if(likely(access_ok(VERIFY_WRITE,  p, sizeof(*p)))) {		\
-		__e = __put_user(x,p);					\
+	__typeof__(*(p)) __user *__p = (p);				\
+	if(likely(access_ok(VERIFY_WRITE, __p, sizeof(*__p)))) {	\
+		__e = __put_user(x, __p);				\
 	}								\
 	__e;								\
 })
@@ -189,10 +191,10 @@ do {									\
 
 #define __put_user_err(x,ptr,err)					\
 do {									\
-	unsigned long __pu_addr = (unsigned long)(ptr);			\
-	__typeof__(*(ptr)) __pu_val = (x);				\
-	__chk_user_ptr(ptr);						\
-	switch (sizeof(*(ptr))) {					\
+	__typeof__(*(ptr)) __user *__pu_addr = (ptr);			\
+	__typeof__(*(__pu_addr)) __pu_val = (x);			\
+	__chk_user_ptr(__pu_addr);					\
+	switch (sizeof(*(__pu_addr))) {					\
 	case 1:								\
 		__put_user_asm("sbi",__pu_val,__pu_addr,err);		\
 		break;							\
-- 
2.7.4

