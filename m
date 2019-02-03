Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A9CBC282DB
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24E0C21906
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:57:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbfBCNuA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 08:50:00 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:52756 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727773AbfBCNtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 08:49:42 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9T-0003tr-Dm; Sun, 03 Feb 2019 13:49:39 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9T-0006o0-QY; Sun, 03 Feb 2019 14:49:39 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Bernd Edlinger" <bernd.edlinger@hotmail.de>,
        "Arnd Bergmann" <arnd@arndb.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Johannes Pointner" <h4nn35.work@gmail.com>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.687968953@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 013/305] ARM: fix put_user() for gcc-8
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

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
Cc: Johannes Pointner <h4nn35.work@gmail.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/arm/include/asm/uaccess.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm/include/asm/uaccess.h
+++ b/arch/arm/include/asm/uaccess.h
@@ -172,7 +172,7 @@ extern int __put_user_8(void *, unsigned
 	({								\
 		unsigned long __limit = current_thread_info()->addr_limit - 1; \
 		const typeof(*(p)) __user *__tmp_p = (p);		\
-		register const typeof(*(p)) __r2 asm("r2") = (x);	\
+		register typeof(*(p)) __r2 asm("r2") = (x);	\
 		register const typeof(*(p)) __user *__p asm("r0") = __tmp_p; \
 		register unsigned long __l asm("r1") = __limit;		\
 		register int __e asm("r0");				\

