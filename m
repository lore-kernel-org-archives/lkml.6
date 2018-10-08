Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91841C677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 588AA204FD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:48:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="m5SaWmQV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 588AA204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731736AbeJICBx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:01:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:51020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726991AbeJICBw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:01:52 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 477C2204FD;
        Mon,  8 Oct 2018 18:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024524;
        bh=M/BlrZN7jZBMbRQPa4sEW7xwiFdSpS4tCj+aadDLulQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m5SaWmQVD1wTuUazTD/sZcshiFswgaN1g+Y4+Je53WsdHujleHSa8E/s52zlkernw
         scH+uObMFXkHX/FvGOOKfKDcd+PrlR0clfyL0l0eBQlVmBecd3mhpDtdGOuLsBGiVO
         OlheXozJ8YU+wnnYjvtg3+p6hudjd18NKscwkqEY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zong Li <zong@andestech.com>,
        Greentime Hu <greentime@andestech.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 069/168] nds32: Fix get_user/put_user macro expand pointer problem
Date:   Mon,  8 Oct 2018 20:30:49 +0200
Message-Id: <20181008175622.686667495@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175620.043587728@linuxfoundation.org>
References: <20181008175620.043587728@linuxfoundation.org>
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

From: Zong Li <zong@andestech.com>

[ Upstream commit 6cce95a6c7d288ac2126eee4b95df448b9015b84 ]

The pointer argument of macro need to be taken out once first, and then
use the new pointer in the macro body.

In kernel/trace/trace.c, get_user(ch, ubuf++) causes the unexpected
increment after expand the macro.

Signed-off-by: Zong Li <zong@andestech.com>
Acked-by: Greentime Hu <greentime@andestech.com>
Signed-off-by: Greentime Hu <greentime@andestech.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/nds32/include/asm/uaccess.h |   26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

--- a/arch/nds32/include/asm/uaccess.h
+++ b/arch/nds32/include/asm/uaccess.h
@@ -78,8 +78,9 @@ static inline void set_fs(mm_segment_t f
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
@@ -99,10 +100,10 @@ static inline void set_fs(mm_segment_t f
 
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


