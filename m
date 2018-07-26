Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0493CC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 08:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDA6B20673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 08:14:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDA6B20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729202AbeGZJai (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 05:30:38 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:52649 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728792AbeGZJai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 05:30:38 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue105 [212.227.15.145]) with ESMTPA (Nemesis) id
 0MbgoP-1fRu0p0Mj7-00J5BE; Thu, 26 Jul 2018 10:14:38 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     stable@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@arm.linux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [stable 4.4] ARM: fix put_user() for gcc-8
Date:   Thu, 26 Jul 2018 10:13:23 +0200
Message-Id: <20180726081358.3829157-2-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180726081358.3829157-1-arnd@arndb.de>
References: <20180726081358.3829157-1-arnd@arndb.de>
X-Provags-ID: V03:K1:UUgT1AMB/NxidFJr0i67FepLlIiyssylGse4dgohucyCZO4rYp8
 tV4w2Bh+tJt0J5DMm6J5D/q8RI20CHQP6arc72AHmoV6yL37lsde/AbLWA9dSHoL50R6ct4
 0of45RqLK94mdR9SECvbetKsG64DilQpZ6tCAjAmMLw3F3veTdn5gFmZtOv0k1QBOvgHA9Z
 kLJXT/QcJA+YMPDHzcmBQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:493e+/H9J0k=:265iuy3bTqrmv8jRvrsRd2
 iPmaW7fI9W3ddyKcD1HdrU6Q+VAnhmEj5GVon8jggZ1tKmjDrRR62pEUHNctUMGOYQT8PcX4x
 GesHXrKfgoiXwsU52poxRzu6Hqbt3W2aBBDyRTXmx8cLISowHfMIYx3JLMYmqGPsQqAjAbHYC
 u7jeZixOmBHALljeJSqjX9/Xf7TXtHjoLEc8PTR24XJhY8xD9LQd5cfIHDescYUTDDQHPkLwA
 BpinRrY22hEefcBoYU0sLAQ1x1bUox45Pb0N2qwLyfi2+KNrxvSf1KZg7QMJSwL6jvKQFgafD
 xrg781ng2AdlrXJoaL4mCic70PWnPkc9G3SDkTbQ8xx2NeaSbX37s1lLcud8VlzcSJvVUvisH
 K/1M7Jaot0AKtiCq4kEyzMg3aOVq1HmhUUje67ZL12tdouZHq4Hc0Qch0hHkNh+7smw01YtoV
 uJbwGch81x3VCOEnHqkif2cTxZ+lkl+YfCMLrtIgrkos2OKm3sajZzQopxbvCiZ9lY8PkvkDL
 CKoPSktCIJ7rahC8783ImN1V0fafi4hgslkurfji7JLsvZImjvPBS2LP2mF3AhSiiruD+dita
 lp7VWdRzPBp94HnBo3k802zDRvwya0I4TY/ReMfljI3PxKQSwMNEpvENNFnspfnYw6tCit3qt
 Seh+E6L3CWwfNc/MyZCEM+OjUCI1q6fZim9/26qub9N/cQnz5TrXYNQBdrAiOq8w3Eac=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
This should also apply to older kernels before 4.4, but I did not try that.
Presumably they have additional problems with modern compilers anyway.

 arch/arm/include/asm/uaccess.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/uaccess.h b/arch/arm/include/asm/uaccess.h
index 35c9db857ebe..cd8b589111ba 100644
--- a/arch/arm/include/asm/uaccess.h
+++ b/arch/arm/include/asm/uaccess.h
@@ -251,7 +251,7 @@ extern int __put_user_8(void *, unsigned long long);
 	({								\
 		unsigned long __limit = current_thread_info()->addr_limit - 1; \
 		const typeof(*(p)) __user *__tmp_p = (p);		\
-		register const typeof(*(p)) __r2 asm("r2") = (x);	\
+		register typeof(*(p)) __r2 asm("r2") = (x);	\
 		register const typeof(*(p)) __user *__p asm("r0") = __tmp_p; \
 		register unsigned long __l asm("r1") = __limit;		\
 		register int __e asm("r0");				\
-- 
2.18.0

