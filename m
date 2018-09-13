Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F5C1ECDFCE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 17:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9045521525
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 16:00:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9045521525
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728563AbeIMVKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 17:10:32 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:55123 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbeIMVKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 17:10:32 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.145]) with ESMTPA (Nemesis) id
 1McYTD-1fQJkC26tp-00cuhz; Thu, 13 Sep 2018 18:00:17 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>
Cc:     y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC] parisc64: change __kernel_suseconds_t to match glibc
Date:   Thu, 13 Sep 2018 17:59:50 +0200
Message-Id: <20180913160010.905798-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:vWNPlqFzuf2u7GS8XexfshPCl2Aw1/8WG3vOemmAVO5grvJWPAZ
 rOasN7CWlRjHw21rU07Re9RJqxwYGkU5HZAC/ajupO1tJK95/rFfo5iyPMZl/LYnbpaZf5M
 1G751IEtGrIfmkQHjEHdJPo/OCNQrN2kw4ItlKhWZaINABoF4ktZULUCfa3gL22cL4L9O+X
 C9fNgfij8riugHvhIQjsQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0VxYlGW9D90=:AUh88BfkOuy2D7g3vEqtR0
 /ztA/EdH980MSJ4AP93ojRQ8d3cEXVWkw5vWp1QtJosjA26pocehqBookFLjqL2rN6RBRhsDC
 7/ZaJIKQrNwclOzFvt5Af3eGSv2Uhi6JRqiV11vI6DSx8a93ohPpyuHIyrAuImKnErE6gQRss
 GLYCEpoLblGIgmVL5CPQArhfcs/NyNRRT28HXvi7zTr9H6opxmTDUtwqlnaEVMGUG8rtz0hPY
 a2M5MjwfCxmKZf3kVuratFLoVNZahhOfQlTbaeZcd521lrLk7bj9kdDXzxrgpNZTCvzCpib0w
 g6Gs5yY10bDavTcszEsg+5G9UxxK22wtEGB4oRaqkqvwVlWB7dr7tRXCzgWQHR3eINhD7EIQb
 att4oh/5imnZXLlwgQTQCW5Xh/2UKho53AUMd65POW1yC10/hpI1qfL+odft6cNWZMa9N6GnH
 64jlfJuDCw8IcYGUCaMjQWVkyNfmAl0v/Ycc2VN4ZIRAUg1iypDddl2teWnoPgtzI6uhcO9lf
 AauxF1XOQb+nQU6ygH3z5FBcfZTVNmXgW9EtZvGV2frrQTo5SLXQG58FIqAIIt0qAA7QEnc7o
 R5wt5Vb4ytYEkkZlEjm4Shr8MFKtDEFHS6xG6pH4y01pPuLrzIng9PNE0K/Vk9PTcju2GLxR0
 Yx0Mtx/HR5sFhUct9qf0sn/tbYpVYnJMW4BUvORV+f0tN9N0G0NvczQuiBLaeOfRg+0E=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are only two 64-bit architecture ports that have a 32-bit
suseconds_t: sparc64 and parisc64. I've encountered a number of problems
with this, while trying to get a proper 64-bit time_t working on 32-bit
architectures. Having a 32-bit suseconds_t combined with a 64-bit time_t
means that we get extra padding in data structures that may leak kernel
stack data to user space, and it breaks all code that assumes that
timespec and timeval have the same layout.

While we can't change sparc64, it seems that glibc on parisc64 has always
set suseconds_t to 'long', and the current version would give incorrect
results for gettimeofday() and many other interfaces: timestamps passed
from user space into the kernel result in tv_usec being always zero
(the lower bits contain the intended value but are ignored) while data
passed from the kernel to user space contains either zeroes or random
data in tv_usec.

Based on that, it seems best to change the user API in the kernel in
an incompatible way to match what glibc expects.

Note that the distros I could find (gentoo and debian) all just
have 32-bit user space, which does not suffer from this problem.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/parisc/include/uapi/asm/posix_types.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/parisc/include/uapi/asm/posix_types.h b/arch/parisc/include/uapi/asm/posix_types.h
index 2785632c85e7..8dce56f5dcee 100644
--- a/arch/parisc/include/uapi/asm/posix_types.h
+++ b/arch/parisc/include/uapi/asm/posix_types.h
@@ -16,9 +16,6 @@ typedef unsigned short		__kernel_mode_t;
 typedef unsigned short		__kernel_ipc_pid_t;
 #define __kernel_ipc_pid_t __kernel_ipc_pid_t
 
-typedef int			__kernel_suseconds_t;
-#define __kernel_suseconds_t __kernel_suseconds_t
-
 typedef long long		__kernel_off64_t;
 typedef unsigned long long	__kernel_ino64_t;
 
-- 
2.18.0

