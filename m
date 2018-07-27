Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3948C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A26222089E
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:12:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A26222089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389510AbeG0LdU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 07:33:20 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36968 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729547AbeG0LdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 07:33:20 -0400
Received: from localhost (unknown [89.188.5.116])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 04D9ACB5;
        Fri, 27 Jul 2018 10:12:06 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4.4 23/23] ARM: fix put_user() for gcc-8
Date:   Fri, 27 Jul 2018 12:09:24 +0200
Message-Id: <20180727100846.050436889@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180727100845.054377089@linuxfoundation.org>
References: <20180727100845.054377089@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

Building kernels before linux-4.7 with gcc-8 results in many build failures
when gcc triggers a check that was meant to catch broken compilers:

/tmp/ccCGMQmS.s:648: Error: .err encountered

According to the discussion in the gcc bugzilla, a local "register
asm()" variable is still supposed to be the correct way to force an
inline assembly to use a particular register, but marking it 'const'
lets the compiler do optimizations that break that, i.e the compiler is
free to treat the variable as either 'const' or 'register' in that case.

Upstream commit 9f73bd8bb445 ("ARM: uaccess: remove put_user() code
duplication") fixed this problem in linux-4.8 as part of a larger change,
but seems a little too big to be backported to 4.4.

Let's take the simplest fix and change only the one broken line in the
same way as newer kernels.

Suggested-by: Bernd Edlinger <bernd.edlinger@hotmail.de>
Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=85745
Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=86673
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/include/asm/uaccess.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm/include/asm/uaccess.h
+++ b/arch/arm/include/asm/uaccess.h
@@ -251,7 +251,7 @@ extern int __put_user_8(void *, unsigned
 	({								\
 		unsigned long __limit = current_thread_info()->addr_limit - 1; \
 		const typeof(*(p)) __user *__tmp_p = (p);		\
-		register const typeof(*(p)) __r2 asm("r2") = (x);	\
+		register typeof(*(p)) __r2 asm("r2") = (x);	\
 		register const typeof(*(p)) __user *__p asm("r0") = __tmp_p; \
 		register unsigned long __l asm("r1") = __limit;		\
 		register int __e asm("r0");				\


